page 50420 "Withholding Lists"
{
    Caption = 'Payment List';
    CardPageID = "Withholding Cards";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Payment Header";
    SourceTableView = WHERE("Payment Type" = CONST("Cheque Payment"),
                            Posted = CONST(false),
                            Status = FILTER(Open),
                            "W/VAT" = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the document number';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the date when the journals will be posted.';
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    Caption = 'Reference No';
                }
                field("Payee Name"; Rec."Payee Name")
                {
                    ToolTip = 'Specifies the vendor or employee being paid';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the total amount to be paid to the vendor';
                }
                field("WithHolding Tax Amount"; Rec."WithHolding Tax Amount")
                {
                    ToolTip = 'Specifies the amount of withholding tax being withheld in this payment';
                }
                field("Withholding VAT Amount"; Rec."Withholding VAT Amount")
                {
                    ToolTip = 'Specifies the amount of withholding vat being withheld in this payment';
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ToolTip = 'Specifies the net amount of payment after withholding tax and withholding vat.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the payment approval status,open/pending approval/released/rejected';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the user who did the payment ';
                }
            }
        }
        area(factboxes)
        {
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = Advanced;
                ToolTip = 'Approvals FactBox';
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Advanced;
                ShowFilter = false;
                ToolTip = 'Incoming Document Attachment FactBox';
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                ToolTip = 'Workflow Status';
                Visible = ShowWorkflowStatus;
            }
            systempart(Control38; Links)
            {
                ToolTip = 'Record Links';
                Visible = false;
            }
            systempart(Control37; Notes)
            {
                ToolTip = 'Notes';
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
                Visible = false;

                trigger OnAction()
                begin
                    UserSetup.Reset;
                    UserSetup.SetRange(UserSetup."User ID", UserId);
                    if UserSetup."Approval Administrator" then begin

                    end else begin

                    end;
                end;
            }
            action("Cancel ")
            {
                Caption = 'Cancel';
                Image = CancelledEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Cancel Document';
                Visible = false;

                trigger OnAction()
                begin
                    if (Rec.Status = Rec.Status::Open) or (Rec.Status = Rec.Status::Approved) then begin
                        Rec.TestField("Reason for Cancellation");
                        if Confirm('Are you sure you want to cancel?', true) then begin
                            Rec."Cancelled By" := UserId;
                            Rec."Date Cancelled" := Today;
                            Rec."Time Cancelled" := Time;
                            Rec.Status := Rec.Status::Cancelled;
                            Rec.Modify;
                            Message('Cancelled Successfully');
                        end;
                    end;
                end;
            }
            group(RequestApproval)
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
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ",Payment,Receipt,Imprest,"Imprest Surrender","Funds Refund","Purchase Requisition";
                    begin
                        //WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RECORDID,DATABASE::"Payment Header",DocType::Payment,"No.");
                        // ApprovalsMgmt.ShowPaymentHeaderApprovalEntries(Rec);
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
                        FundsManagement.CheckPaymentMandatoryFields(Rec, false);

                        // if ApprovalsMgmt.CheckPaymentApprovalsWorkflowEnabled(Rec) then
                        //   ApprovalsMgmt.OnCancelPaymentHeaderApprovalRequest(Rec);
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
                        // ApprovalsMgmt.OnCancelPaymentHeaderApprovalRequest(Rec);
                        // WorkflowWebhookMgt.FindAndCancel(RecordId);
                    end;
                }
            }
            group(Posting)
            {
                Caption = 'Posting';
                Visible = false;
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
                        FundsManagement.CheckPaymentMandatoryFields(Rec, false);
                        if FundsUserSetup.Get(UserId) then begin
                            FundsUserSetup.TestField("Payment Journal Template");
                            FundsUserSetup.TestField("Payment Journal Batch");
                            JTemplate := FundsUserSetup."Payment Journal Template";
                            JBatch := FundsUserSetup."Payment Journal Batch";
                            FundsManagement.PostPayment(Rec, JTemplate, JBatch, true);
                        end else begin
                            Error(Txt_001, UserId);
                        end;
                    end;
                }
                action("Post Payment")
                {
                    Caption = 'Post Payment';
                    Image = Payment;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*FundsManagement.CheckPaymentMandatoryFields(Rec,TRUE);
                        IF FundsUserSetup.GET(USERID) THEN BEGIN
                          FundsUserSetup.TESTFIELD(FundsUserSetup."Payment Journal Template");
                          FundsUserSetup.TESTFIELD(FundsUserSetup."Payment Journal Batch");
                          JTemplate:=FundsUserSetup."Payment Journal Template";JBatch:=FundsUserSetup."Payment Journal Batch";
                          IF "Loan Disbursement Type" = "Loan Disbursement Type"::" " THEN
                           FundsManagement.PostPayment(Rec,JTemplate,JBatch,FALSE);
                          IF "Loan Disbursement Type" = "Loan Disbursement Type"::"Investment Loan" THEN
                           FundsManagement.GetEmployeeuserID(Rec,JTemplate,JBatch,FALSE);
                          IF "Loan Disbursement Type" = "Loan Disbursement Type"::Equity THEN
                           FundsManagement.PostBoardAllowance(Rec,JTemplate,JBatch,FALSE);
                         IF "Loan Disbursement Type" = "Loan Disbursement Type"::"Staff Loan" THEN
                          FundsManagement.PostHRLoanPayment(Rec,JTemplate,JBatch,FALSE);
                        END ELSE BEGIN
                          ERROR(Txt_001,USERID);
                        END;
                        */

                    end;
                }
                action("Post and Print Payment")
                {
                    Caption = 'Post and Print Payment';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*FundsManagement.CheckPaymentMandatoryFields(Rec,TRUE);
                        "DocNo.":="No.";
                        IF FundsUserSetup.GET(USERID) THEN BEGIN
                          FundsUserSetup.TESTFIELD(FundsUserSetup."Payment Journal Template");
                          FundsUserSetup.TESTFIELD(FundsUserSetup."Payment Journal Batch");
                          JTemplate:=FundsUserSetup."Payment Journal Template";JBatch:=FundsUserSetup."Payment Journal Batch";
                          IF "Loan No." = '' THEN
                           FundsManagement.PostPayment(Rec,JTemplate,JBatch,FALSE)
                          ELSE
                           FundsManagement.GetEmployeeuserID(Rec,JTemplate,JBatch,FALSE);
                          COMMIT;
                          PaymentHeader.RESET;
                          PaymentHeader.SETRANGE(PaymentHeader."No.","DocNo.");
                          IF PaymentHeader.FINDFIRST THEN BEGIN
                            REPORT.RUNMODAL(REPORT::"Payment Voucher",TRUE,FALSE,PaymentHeader);
                          END;
                        END ELSE BEGIN
                          ERROR(Txt_001,USERID);
                        END;
                        */

                    end;
                }
            }
            group("Report")
            {
                Caption = 'Report';
                action("Print Withholding")
                {
                    Caption = 'Print Withholding';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ToolTip = 'Prepare to print the document. A report request window where you can specify what to include on the print-out.';

                    trigger OnAction()
                    begin
                        PaymentHeader.Reset;
                        PaymentHeader.SetRange(PaymentHeader."No.", Rec."No.");
                        if PaymentHeader.FindFirst then begin
                            REPORT.RunModal(REPORT::"Casual Payment Report", true, false, PaymentHeader);
                        end;
                    end;
                }
                action("Print Cheque")
                {
                    Caption = 'Print Cheque';
                    Image = Check;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ToolTip = 'Print Bank Cheque for this Payment';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);
                        Rec.TestField("Cheque Type", Rec."Cheque Type"::"Computer Cheque");

                        PaymentHeader.Reset;
                        PaymentHeader.SetRange(PaymentHeader."No.", Rec."No.");
                        if PaymentHeader.FindFirst then
                            REPORT.Run(REPORT::"Cheque Print", true, true, PaymentHeader);
                    end;
                }
            }
            group(IncomingDocument)
            {
                Caption = 'Incoming Document';
                Image = Documents;
                action(IncomingDocCard)
                {
                    ApplicationArea = Suite;
                    Caption = 'View Incoming Document';
                    Enabled = HasIncomingDocument;
                    Image = ViewOrder;
                    ToolTip = 'View any incoming document records and file attachments that exist for the entry or document, for example for auditing purposes';

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        IncomingDocument.ShowCardFromEntryNo(Rec."Incoming Document Entry No.");
                    end;
                }
                action(SelectIncomingDoc)
                {
                    AccessByPermission = TableData "Incoming Document" = R;
                    ApplicationArea = Suite;
                    Caption = 'Select Incoming Document';
                    Image = SelectLineToApply;
                    ToolTip = 'Select an incoming document record and file attachment that you want to link to the entry or document.';

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        Rec.Validate("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument(Rec."Incoming Document Entry No.", Rec.RecordId));
                    end;
                }
                action(IncomingDocAttachFile)
                {
                    ApplicationArea = Suite;
                    Caption = 'Create Incoming Document from File';
                    Ellipsis = true;
                    Enabled = CreateIncomingDocumentEnabled;
                    Image = Attach;
                    ToolTip = 'Create an incoming document from a file that you select from the disk. The file will be attached to the incoming document record.';

                    trigger OnAction()
                    var
                        IncomingDocumentAttachment: Record "Incoming Document Attachment";
                    begin
                        IncomingDocumentAttachment.NewAttachmentFromPaymentDocument(Rec);
                    end;
                }
                action(RemoveIncomingDoc)
                {
                    ApplicationArea = Suite;
                    Caption = 'Remove Incoming Document';
                    Enabled = HasIncomingDocument;
                    Image = RemoveLine;
                    ToolTip = 'Remove any incoming document records and file attachments.';

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        if IncomingDocument.Get(Rec."Incoming Document Entry No.") then
                            IncomingDocument.RemoveLinkToRelatedRecord;
                        Rec."Incoming Document Entry No." := 0;
                        Rec.Modify(true);
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

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."W/VAT" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        PaymentHeader.Reset;
        PaymentHeader.SetRange("User ID", UserId);
        PaymentHeader.SetRange(Status, PaymentHeader.Status::Open);
        PaymentHeader.SetRange("Payment Type", PaymentHeader."Payment Type"::"Cheque Payment");
        if PaymentHeader.FindFirst then begin
            // ERROR(Txt_002);
        end;

        Rec."Payment Type" := Rec."Payment Type"::"Cheque Payment";
    end;

    trigger OnOpenPage()
    begin
        //SETRANGE("User ID",USERID);
    end;

    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        UserSetup: Record "User Setup";
        FundsManagement: Codeunit "Funds Management";
        FundsUserSetup: Record "Funds User Setup";
        PaymentHeader: Record "Payment Header";
        JTemplate: Code[10];
        JBatch: Code[10];
        "DocNo.": Code[20];
        Txt_001: Label 'User Account %1 is not Setup for Payments Posting, Contact the System Administrator';
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
        Txt_002: Label 'There is an open payment document under your name, use it before you create a new one';

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

