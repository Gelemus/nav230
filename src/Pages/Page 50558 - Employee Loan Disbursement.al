page 50558 "Employee Loan Disbursement"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Employee Loan Disbursement";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Disbursement Date"; Rec."Disbursement Date")
                {
                }
                field("Disbursement Type"; Rec."Disbursement Type")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Editable = true;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Loan No."; Rec."Loan No.")
                {
                }
                field("Loan Product Code"; Rec."Loan Product Code")
                {
                }
                field("Loan Product Description"; Rec."Loan Product Description")
                {
                }
                field("Applied Amount"; Rec."Applied Amount")
                {
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                }
                field("Disbursed Amount"; Rec."Disbursed Amount")
                {
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                }
                field("Amount to Disburse"; Rec."Amount to Disburse")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Payee; Rec.Payee)
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                }
            }
            group("Payment Details")
            {
                Caption = 'Payment Details';
                field("Payment Voucher Created"; Rec."Payment Voucher Created")
                {
                }
                field("Payment Voucher No"; Rec."Payment Voucher No")
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("Posted By"; Rec."Posted By")
                {
                }
                field("Date Posted"; Rec."Date Posted")
                {
                }
                field("Time Posted"; Rec."Time Posted")
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
                        Rec.TestField("Payment Voucher Created", false);

                        //create PV
                        "HRLoanMgmt.".CreatePaymentVoucher(Rec."No.");
                        CurrPage.Close;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable(false);
    end;

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

