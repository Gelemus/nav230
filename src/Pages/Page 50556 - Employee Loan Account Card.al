page 50556 "Employee Loan Account Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Employee Loan Accounts";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Employee Age"; Rec."Employee Age")
                {
                }
                field("Retirement Date"; Rec."Retirement Date")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Date Created"; Rec."Date Created")
                {
                }
                field("Time Created"; Rec."Time Created")
                {
                }
            }
            group("Loan Information")
            {
                field("Loan Product Code"; Rec."Loan Product Code")
                {
                }
                field("Loan Product Description"; Rec."Loan Product Description")
                {
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                }
                field("Account Balance"; Rec."Account Balance")
                {
                }
                field("Applied Amount"; Rec."Applied Amount")
                {
                }
                field("Entitled Amount"; Rec."Entitled Amount")
                {
                }
                field("Disbursed Amount"; Rec."Disbursed Amount")
                {
                }
                field("Repayment Start Date"; Rec."Repayment Start Date")
                {
                }
                field("Repayment Period"; Rec."Repayment Period")
                {
                }
                field("Repayment End Date"; Rec."Repayment End Date")
                {
                }
                field("Repayment Amount"; Rec."Repayment Amount")
                {
                }
                field("No. of Installments"; Rec."No. of Installments")
                {
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    Editable = true;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Generate Loan Schedule")
            {
                Image = Agreement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    "HRLoanMgt.".GenerateLoanAmortizationSchedule(Rec."No.");
                    Commit;

                    EmployeeLoanAccounts.Reset;
                    EmployeeLoanAccounts.SetRange(EmployeeLoanAccounts."No.", Rec."No.");
                    if EmployeeLoanAccounts.FindFirst then begin
                        REPORT.Run(REPORT::"Employee Loan Schedule", true, false, EmployeeLoanAccounts);
                    end;
                end;
            }
            action("Print Statement")
            {
                Caption = 'Print Statement';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    EmployeeLoanAccounts.Reset;
                    EmployeeLoanAccounts.SetRange("No.", Rec."No.");
                    if EmployeeLoanAccounts.FindFirst then
                        REPORT.Run(REPORT::"Employee Loan Statement", true, true, EmployeeLoanAccounts);
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

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
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

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        Rec.TestField(Status, Rec.Status::"Pending Approval");
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec.Status = Rec.Status::Open then begin
            IsOpen := true;
            IsPendingApproval := false;
        end;
        if Rec.Status = Rec.Status::"Pending Approval" then begin
            IsOpen := false;
            IsPendingApproval := true;
        end;
    end;

    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::Approved then
            CurrPage.Editable(false);
    end;

    var
        "HRLoanMgt.": Codeunit "HR Loan Management";
        EmployeeLoanAccounts: Record "Employee Loan Accounts";
        PageEditable: Boolean;
        ActionsVisible: Boolean;
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
}

