page 50557 "Employee Loan Disbursements"
{
    CardPageID = "Employee Loan Disbursement";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Employee Loan Disbursement";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Disbursement Date"; Rec."Disbursement Date")
                {
                }
                field("Loan No."; Rec."Loan No.")
                {
                }
                field("Loan Product Description"; Rec."Loan Product Description")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Amount to Disburse"; Rec."Amount to Disburse")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Payment Voucher Created"; Rec."Payment Voucher Created")
                {
                }
                field("Payment Voucher No"; Rec."Payment Voucher No")
                {
                }
            }
        }
    }

    actions
    {
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
                        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        if ApprovalsMgmt.IsHRLoanDisbursementApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendHRLoanDisbursementForApproval(Rec);

                        CurrPage.Close;
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
                        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        Rec.TestField(Status, Rec.Status::"Pending Approval");

                        ApprovalsMgmt.OnCancelHRLoanDisbursementApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }
            }
            group(Disbursement)
            {
                action("Create Payment Voucher")
                {
                    Image = CreateForm;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Released);
                        //TESTFIELD("Payment Voucher Created",FALSE);

                        //create PV
                        "HRLoanMgmt.".CreatePaymentVoucher(Rec."No.");
                    end;
                }
            }
        }
    }

    var
        "HRLoanMgmt.": Codeunit "HR Loan Management";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
}

