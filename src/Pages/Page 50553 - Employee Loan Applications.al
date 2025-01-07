page 50553 "Employee Loan Applications"
{
    CardPageID = "Employee Loan Application";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Employee Loan Applications";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Loan Product Code"; Rec."Loan Product Code")
                {
                }
                field("Applied Amount"; Rec."Applied Amount")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Account Created"; Rec."Account Created")
                {
                }
                field("Loan Account No"; Rec."Loan Account No")
                {
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                }
                field("Approval User ID"; Rec."Approval User ID")
                {
                    Editable = false;
                }
                field("Loan Schedule Base Amount"; Rec."Loan Schedule Base Amount")
                {
                }
                field("Date Created"; Rec."Date Created")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Submit)
            {
                Image = SendToMultiple;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //check if submitted
                    if Rec.Submitted then
                        Error(Text_0010);
                    //end check

                    //Check required documents
                    Rec.TestField("Applied Amount");
                    HRLoanMgt.CheckLoanApplicationRequiredDocuments(Rec);
                    //End Check required documents

                    //send to HR
                    if Confirm(Text_0001) = false then exit;
                    LoansUserSetup.Reset;
                    LoansUserSetup.SetRange("HR Manager", true);
                    if LoansUserSetup.FindFirst then begin
                        Rec."Approval User ID" := LoansUserSetup."User ID";
                        Rec.Modify;

                        UserSetup.Reset;
                        UserSetup.Get(LoansUserSetup."User ID");
                        //email to HR
                        HRLoanMgt.CreateLoanNotificationEmailHR(Rec, UserSetup."E-Mail");
                    end;

                    //Email to applicant
                    Employee.Reset;
                    Employee.Get(Rec."Employee No.");
                    HRLoanMgt.CreateLoanNotificationEmployee(Rec, Employee."Company E-Mail");
                    //End Email to applicant

                    Rec.Status := Rec.Status::Submitted;
                    Rec.Submitted := true;
                    Rec.Modify;
                    Message(Text_0004);
                end;
            }
            action("Loan Application Documents")
            {
                Image = Documents;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Loan Application Documents";
                RunPageLink = "Application No." = FIELD("No.");
            }
            action("Generate Loan Schedule")
            {
                Image = Agreement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    HRLoanMgt.GetInterestAmounts(Rec."No.", Rec."Repayment Start Date");
                    Commit;

                    EmployeeLoanApplications.Reset;
                    EmployeeLoanApplications.SetRange(EmployeeLoanApplications."No.", Rec."No.");
                    if EmployeeLoanApplications.FindFirst then begin
                        REPORT.Run(REPORT::"Employee App. Loan Schedule", true, false, EmployeeLoanApplications);
                    end;
                end;
            }
            action("Create Account")
            {
                Image = CreateForm;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    Rec.TestField("Account Created", false);
                    if Confirm(Text_0006) = false then exit;

                    EmployeeLoanProducts.Reset;
                    EmployeeLoanProducts.Get(Rec."Loan Product Code");

                    //Check required documents
                    Rec.TestField("Applied Amount");
                    HRLoanMgt.CheckLoanAccountCreationRequiredDocuments(Rec);
                    //End Check required documents

                    EmployeeLoanAccounts.Init;
                    EmployeeLoanAccounts."No." := EmployeeLoanProducts."Product Account Identifier" + '-' + CopyStr(Rec."Employee No.", 5, 6) + '-' + "NoSeriesMgt.".GetNextNo(EmployeeLoanProducts."Account No. Series", 0D, true);
                    EmployeeLoanAccounts.TransferFields(Rec, false);
                    if EmployeeLoanAccounts.Insert then begin
                        Rec."Account Created" := true;
                        Rec."Loan Account No" := EmployeeLoanAccounts."No.";
                        Rec.Modify;
                    end;

                    //create customer account
                    HRLoanMgt.CreateCustomerAccount(Rec);

                    Message(Text_0005, EmployeeLoanAccounts."No.", Rec."No.");
                end;
            }
        }
        area(processing)
        {
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Request approval of the document.';
                    Visible = IsOpen;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
                    begin
                        //test recommendation
                        Rec.TestField(Status, Rec.Status::Submitted);
                        if (Rec."Approval Recommendation" = Rec."Approval Recommendation"::"Approve Loan") then begin
                            Error(Text_0003);
                        end;

                        //Check required documents
                        Rec.TestField("Applied Amount");
                        HRLoanMgt.CheckLoanApprovalRequiredDocuments(Rec);
                        //End Check required documents

                        if ApprovalsMgmt.IsHRLoanApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendHRLoanForApproval(Rec);

                        EmployeeLoanApplications.Reset;
                        EmployeeLoanApplications.SetRange("No.", Rec."No.");
                        EmployeeLoanApplications.SetRange(Status, EmployeeLoanApplications.Status::"Pending Approval");
                        if EmployeeLoanApplications.FindFirst then begin
                            //send email
                            LoansUserSetup.Reset;
                            LoansUserSetup.SetRange("Executive Director", true);
                            if LoansUserSetup.FindFirst then begin
                                //Send Notifications
                                UserSetup.Reset;
                                UserSetup.SetRange("User ID", LoansUserSetup."User ID");
                                if UserSetup.FindFirst then
                                    //Email to ED
                                    HRLoanMgt.CreateLoanNotificationEmailED(Rec, UserSetup."E-Mail");
                                //End Email to ED
                            end;
                        end;

                        LoansUserSetup.Reset;
                        LoansUserSetup.SetRange("Executive Director", true);
                        if LoansUserSetup.FindFirst then begin
                            Rec."Approval User ID" := LoansUserSetup."User ID";
                        end;
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';
                    Visible = IsOpen;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalsMgmt.OnCancelHRLoanApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        if Rec.Status = Rec.Status::Submitted then begin
            IsOpen := true;
        end;
        if Rec.Status = Rec.Status::"Pending Approval" then begin
            IsOpen := false;
        end;
    end;

    var
        "NoSeriesMgt.": Codeunit NoSeriesManagement;
        Employee: Record Employee;
        HRLoanMgt: Codeunit "HR Loan Management";
        EmployeeLoanAccounts: Record "Employee Loan Accounts";
        LoanProductDocs: Record "Employee Loan Product Document";
        LoanAppDocuments: Record "Loan Application Documents";
        UserSetup: Record "User Setup";
        EmployeeLoanProducts: Record "Employee Loan Products";
        EmployeeLoanProducts2: Record "Employee Loan Products";
        LoansUserSetup: Record "Employee Loans User Setup";
        EmployeeLoanApplications: Record "Employee Loan Applications";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
        IsPendingApproval: Boolean;
        IsOpen: Boolean;
        EmployeeName: Text;
        HRManager: Text;
        Text_0001: Label 'Submit the Loan application to HR Department?';
        Text_0002: Label 'The application was successfully submitted to HR Department.';
        Text_0003: Label 'Approval recommendation cannot be empty.';
        Text_0004: Label 'Loan Successfully submitted to the HR Department';
        Text_0010: Label 'Document already submitted';
        Text_0005: Label 'Loan Account No. %1 has been created successfully for application no. %2';
        Text_0006: Label 'A loan account will be created, continue?';
}

