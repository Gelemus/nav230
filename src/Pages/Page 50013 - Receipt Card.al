page 50013 "Receipt Card"
{
    PageType = Card;
    SourceTable = "Receipt Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Payment Mode"; Rec."Payment Mode")
                {
                }
                field("Receipt Types"; Rec."Receipt Types")
                {
                }
                field("Account No."; Rec."Account No.")
                {
                    Caption = 'Bank/G/L Account No.';
                    ToolTip = 'Specifies the field name';
                }
                field("Account Name"; Rec."Account Name")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Receipt Type"; Rec."Receipt Type")
                {

                    trigger OnValidate()
                    begin
                        if (Rec."Receipt Type" = Rec."Receipt Type"::"Investment Loan") or (Rec."Receipt Type" = Rec."Receipt Type"::Equity) then
                            InvestmentDetailsVisible := true;
                    end;
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Amount Received"; Rec."Amount Received")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Amount Received(LCY)"; Rec."Amount Received(LCY)")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Received From"; Rec."Received From")
                {
                    ToolTip = 'Specifies the field name';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the field name';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the field name';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the field name';
                }
            }
            part(Control23; "Receipt Line")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
        area(factboxes)
        {
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = Advanced;
                Visible = false;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Advanced;
                ShowFilter = false;
                Visible = false;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(Control15; Links)
            {
                Visible = false;
            }
            systempart(Control14; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ReOpen)
            {
                Caption = 'ReOpen';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';
            }
            action("Suggest Lines")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    //InvstReceiptApplication.InsertRecoveryPriorities();

                    if Rec."Investment Account No." <> '' then begin
                        //InvstReceiptApplication.SuggestInvestmentLoanRepaymentsDefined("No.","Amount Received","Investment Account No.");
                    end else begin
                        //InvstReceiptApplication.SuggestInvestmentLoanRepaymentsUnDefined("No.","Amount Received");
                    end;
                end;
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Visible = false;
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                        // WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId,DATABASE::"Receipt Header","Document Type","No.");
                    end;
                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
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
                        FundsManagement.CheckReceiptMandatoryFields(Rec, false);

                        // if ApprovalsMgmt.IsReceiptApprovalsWorkflowEnabled(Rec) then
                        //   ApprovalsMgmt.OnSendReceiptHeaderForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
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
                        // ApprovalsMgmt.OnCancelReceiptHeaderApprovalRequest(Rec);
                        // WorkflowWebhookMgt.FindAndCancel(RecordId);
                    end;
                }
            }
            group(Posting)
            {
                Caption = 'Posting';
                action("Preview Posting")
                {
                    Caption = 'Preview Posting';
                    Image = PreviewChecks;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                    trigger OnAction()
                    begin
                        FundsManagement.CheckReceiptMandatoryFields(Rec, true);
                        if FundsUserSetup.Get(UserId) then begin
                            FundsUserSetup.TestField("Receipt Journal Template");
                            FundsUserSetup.TestField("Receipt Journal Batch");
                            JTemplate := FundsUserSetup."Receipt Journal Template";
                            JBatch := FundsUserSetup."Receipt Journal Batch";
                            FundsManagement.PostReceipt(Rec, JTemplate, JBatch, true);
                        end else begin
                            Error(UserAccountNotSetup, UserId);
                        end;
                    end;
                }
                action("Post and Print Receipt")
                {
                    Caption = 'Post and Print Receipt';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';

                    trigger OnAction()
                    begin
                        FundsManagement.CheckReceiptMandatoryFields(Rec, true);

                        //Allocate loan Repayments
                        if Rec."Receipt Type" = Rec."Receipt Type"::"Investment Loan" then begin
                            Rec.TestField("Client No.");
                        end;

                        "DocNo." := Rec."No.";
                        if FundsUserSetup.Get(UserId) then begin
                            FundsUserSetup.TestField("Receipt Journal Template");
                            FundsUserSetup.TestField("Receipt Journal Batch");
                            JTemplate := FundsUserSetup."Receipt Journal Template";
                            JBatch := FundsUserSetup."Receipt Journal Batch";
                            FundsManagement.PostReceipt(Rec, JTemplate, JBatch, false);
                            Commit;
                            ReceiptHeader.Reset;
                            ReceiptHeader.SetRange(ReceiptHeader."No.", "DocNo.");
                            if ReceiptHeader.FindFirst then begin
                                REPORT.RunModal(REPORT::"Receipt Header", true, false, ReceiptHeader);
                            end;
                        end else begin
                            Error(UserAccountNotSetup, UserId);
                        end;

                        CurrPage.Close;
                    end;
                }
                action("Print Receipt")
                {
                    Caption = 'Print Receipt';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ToolTip = 'Prepare to print the document. A report request window where you can specify what to include on the print-out.';

                    trigger OnAction()
                    begin
                        ReceiptHeader.Reset;
                        ReceiptHeader.SetRange(ReceiptHeader."No.", Rec."No.");
                        if ReceiptHeader.FindFirst then begin
                            REPORT.RunModal(REPORT::"Receipt Header", true, false, ReceiptHeader);
                        end;
                    end;
                }
                action("Post Receipt")
                {
                    Caption = 'Post Receipt';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';

                    trigger OnAction()
                    begin
                        FundsManagement.CheckReceiptMandatoryFields(Rec, true);

                        "DocNo." := Rec."No.";

                        if FundsUserSetup.Get(UserId) then begin
                            if Rec."Payment Mode" = Rec."Payment Mode"::Cheque then begin
                                //insert to cheque buffer
                                Rec."Posted to Cheque Buffer" := true;
                                Rec.Modify;
                                CurrPage.Close;
                            end else begin
                                FundsUserSetup.TestField("Receipt Journal Template");
                                FundsUserSetup.TestField("Receipt Journal Batch");
                                JTemplate := FundsUserSetup."Receipt Journal Template";
                                JBatch := FundsUserSetup."Receipt Journal Batch";
                                FundsManagement.PostReceipt(Rec, JTemplate, JBatch, false);
                                Commit;
                            end;
                        end else begin
                            Error(UserAccountNotSetup, UserId);
                        end;

                        CurrPage.Close;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(Rec.RecordId);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RecordId);
    end;

    trigger OnAfterGetRecord()
    begin
        if (Rec."Receipt Type" <> Rec."Receipt Type"::"Investment Loan") or (Rec."Receipt Type" <> Rec."Receipt Type"::Equity) then
            InvestmentDetailsVisible := false else
            InvestmentDetailsVisible := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Type" := Rec."Document Type"::Receipt;
        Rec.Reset;
        Rec.SetRange("User ID", UserId);
        Rec.SetRange(Rec.Status, Rec.Status::Open);
        if Rec.FindFirst then begin
            Error(Txt_002);
        end;
    end;

    trigger OnOpenPage()
    begin
        if (Rec."Posted to Cheque Buffer" = true) and (Rec."Payment Mode" = Rec."Payment Mode"::Cheque) then
            CurrPage.Editable(false);
    end;

    var
        UserAccountNotSetup: Label 'User Account %1 is not Setup for Receipt Posting, Contact the System Administrator';
        FundsManagement: Codeunit "Funds Management";
        FundsUserSetup: Record "Funds User Setup";
        JTemplate: Code[10];
        JBatch: Code[10];
        "DocNo.": Code[20];
        ReceiptHeader: Record "Receipt Header";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
        InvestmentDetailsVisible: Boolean;
        Txt_002: Label 'There is an open imprest document under your name, use it before you create a new one';

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabled := (not HasIncomingDocument) and (Rec."No." <> '');

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;
}

