page 50555 "Employee Loan Accounts"
{
    CardPageID = "Employee Loan Account Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Employee Loan Accounts";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'Loan Account No';
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
                field(Status; Rec.Status)
                {
                }
                field("Applied Amount"; Rec."Applied Amount")
                {
                }
                field("Loan Product Description"; Rec."Loan Product Description")
                {
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                }
                field("No. of Installments"; Rec."No. of Installments")
                {
                }
                field("Repayment Amount"; Rec."Repayment Amount")
                {
                }
                field("Disbursed Amount"; Rec."Disbursed Amount")
                {
                }
                field("Account Balance"; Rec."Account Balance")
                {
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
                    "HRLoanMgt.".GetPaidPrinciple(Rec."No.");
                    Commit;

                    EmployeeLoanAccounts.Reset;
                    EmployeeLoanAccounts.SetRange(EmployeeLoanAccounts."No.", Rec."No.");
                    if EmployeeLoanAccounts.FindFirst then begin
                        REPORT.Run(REPORT::"Employee Loan Schedule", true, false, EmployeeLoanAccounts);
                    end;
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
        }
    }

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

