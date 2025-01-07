page 50423 "Approved Withholding Cards"
{
    DeleteAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Payment Header";
    SourceTableView = WHERE("Payment Type" = CONST("Cheque Payment"),
                            Posted = CONST(false),
                            Status = CONST(Approved),
                            "W/VAT" = CONST(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the document number';

                    trigger OnAssistEdit()
                    begin
                        Rec.AssistEdit;
                    end;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the date when the document was created';
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    Caption = 'Reference No';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ShowMandatory = true;
                    ToolTip = 'Specifies the date when the journals will be posted.';
                }
                field("Payee Name"; Rec."Payee Name")
                {
                    Editable = PageEditable;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the field name';
                }
                field(Description; Rec.Description)
                {
                    Editable = PageEditable;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the field name';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("WithHolding Tax Amount"; Rec."WithHolding Tax Amount")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Withholding VAT Amount"; Rec."Withholding VAT Amount")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ShowMandatory = true;
                    ToolTip = 'Specifies the field name';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the field name';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the field name';
                }
            }
            part(Control35; "Withholding Lines")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
        area(factboxes)
        {
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = Advanced;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Advanced;
                ShowFilter = false;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(Control43; Links)
            {
                Visible = false;
            }
            systempart(Control42; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
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
                        // WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"Payment Header", DocType::Payment, "No.");
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
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        FundsManagement.CheckPaymentMandatoryFields(Rec, false);

                        // if ApprovalsMgmt.CheckPaymentApprovalsWorkflowEnabled(Rec) then
                        //     ApprovalsMgmt.OnSendPaymentHeaderForApproval(Rec);

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
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        // ApprovalsMgmt.OnCancelPaymentHeaderApprovalRequest(Rec);
                        // WorkflowWebhookMgt.FindAndCancel(RecordId);
                    end;
                }
                action(ReOpen)
                {
                    Caption = 'ReOpen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);
                        UserSetup.Reset;
                        UserSetup.SetRange(UserSetup."User ID", UserId);
                        if UserSetup.FindFirst then begin
                            if UserSetup."Reopen Documents" then
                                FundsApprovalManager.ReOpenPaymentHeader(Rec);
                            Message(Txt_003);
                            CurrPage.Close;
                        end;
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
                        //FundsManagement.CheckPaymentMandatoryFields(Rec,FALSE);
                        if FundsUserSetup.Get(UserId) then begin
                            FundsUserSetup.TestField("Payment Journal Template");
                            FundsUserSetup.TestField("Payment Journal Batch");
                            JTemplate := FundsUserSetup."Payment Journal Template";
                            JBatch := FundsUserSetup."Payment Journal Batch";
                            FundsManagement.PostWithholding(Rec, JTemplate, JBatch, true);
                        end else begin
                            Error(Txt_001, UserId);
                        end;
                    end;
                }
                action("Post Withholding")
                {
                    Caption = 'Post Withholding';
                    Image = Payment;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction()
                    begin
                        //FundsManagement.CheckWithholdingMandatoryFields(Rec,TRUE);

                        //Check if  Reference Number has been used
                        PaymentHeader.Reset;
                        PaymentHeader.SetRange(PaymentHeader."Reference No.", Rec."Reference No.");
                        //PaymentHeader.SETRANGE(PaymentHeader."Bank Account No.","Bank Account No.");
                        PaymentHeader.SetFilter(PaymentHeader."Reference No.", '<>%1', '');
                        if PaymentHeader.FindFirst then begin
                            if PaymentHeader."Reference No." = Rec."Reference No." then
                                Error(ErrorUsedReferenceNumber, PaymentHeader."No.");
                        end;

                        if FundsUserSetup.Get(UserId) then begin
                            FundsManagement.PostWithholding(Rec, 'Payments', 'EMWANGI', false);
                        end;
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
                        FundsManagement.CheckPaymentMandatoryFields(Rec, true);
                        "DocNo." := Rec."No.";
                        if FundsUserSetup.Get(UserId) then begin
                            FundsUserSetup.TestField(FundsUserSetup."Payment Journal Template");
                            FundsUserSetup.TestField(FundsUserSetup."Payment Journal Batch");
                            JTemplate := FundsUserSetup."Payment Journal Template";
                            JBatch := FundsUserSetup."Payment Journal Batch";
                            if Rec."Loan No." = '' then
                                FundsManagement.PostPayment(Rec, JTemplate, JBatch, false);
                            /*ELSE
                             FundsManagement.PostInvestmentLoanPayment(Rec,JTemplate,JBatch,FALSE);*/
                            Commit;
                            PaymentHeader.Reset;
                            PaymentHeader.SetRange(PaymentHeader."No.", "DocNo.");
                            if PaymentHeader.FindFirst then begin
                                REPORT.RunModal(REPORT::"Payment Voucher II", true, false, PaymentHeader);
                            end;
                        end else begin
                            Error(Txt_001, UserId);
                        end;

                    end;
                }
                action("Post Payment Line By Line")
                {
                    Caption = 'Post Payment Line By Line';
                    Image = PaymentJournal;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';
                    Visible = false;

                    trigger OnAction()
                    begin
                        FundsManagement.CheckPaymentMandatoryFields(Rec, true);
                        if FundsUserSetup.Get(UserId) then begin
                            FundsUserSetup.TestField(FundsUserSetup."Payment Journal Template");
                            FundsUserSetup.TestField(FundsUserSetup."Payment Journal Batch");
                            JTemplate := FundsUserSetup."Payment Journal Template";
                            JBatch := FundsUserSetup."Payment Journal Batch";
                            FundsManagement.PostPaymentLineByLine(Rec, JTemplate, JBatch, false);
                        end else begin
                            Error(Txt_001, UserId);
                        end;
                    end;
                }
                action("Import Payment Lines")
                {
                    Caption = 'Import Payment Lines';
                    Image = Import;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    ToolTip = 'Import Payment Lines';
                    Visible = false;

                    trigger OnAction()
                    begin
                        if FundsUserSetup.Get(UserId) then begin
                            FundsUserSetup.TestField(FundsUserSetup."Payment Journal Template");
                            FundsUserSetup.TestField(FundsUserSetup."Payment Journal Batch");

                            PaymentLineImportBuffer.Reset;
                            PaymentLineImportBuffer.SetRange(PaymentLineImportBuffer."User ID", UserId);
                            if PaymentLineImportBuffer.FindSet then begin
                                PaymentLineImportBuffer.DeleteAll;
                            end;
                            Commit;

                            //XMLPORT.Run(XMLPORT::XMLport52136960);
                            Commit;

                            PaymentLineImportBuffer.Reset;
                            PaymentLineImportBuffer.SetRange(PaymentLineImportBuffer."User ID", UserId);
                            if PaymentLineImportBuffer.FindSet then begin
                                repeat
                                    PaymentLine.Init;
                                    PaymentLine."Line No." := 0;
                                    PaymentLine."Document No." := Rec."No.";
                                    PaymentLine."Payment Code" := PaymentLineImportBuffer."Payment Code";
                                    PaymentLine.Validate("Payment Code");
                                    /*FundsTransactionCodes.RESET;
                                    FundsTransactionCodes.SETRANGE(FundsTransactionCodes."Transaction Code",PaymentLineImportBuffer."Payment Code");
                                    IF FundsTransactionCodes.FINDFIRST THEN BEGIN
                                      PaymentLine."Account Type":=FundsTransactionCodes."Account Type";
                                      PaymentLine."Posting Group":=FundsTransactionCodes."Posting Group";
                                      PaymentLine."Payment Code Description":=FundsTransactionCodes.Description;
                                      //Employee Transaction Type
                                      PaymentLine."Employee Transaction Type":=FundsTransactionCodes."Employee Transaction Type";
                                    END;
                                    */
                                    PaymentLine."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                                    PaymentLine."Account No." := PaymentLineImportBuffer."Account No.";
                                    PaymentLine.Validate("Account No.");
                                    PaymentLine.Description := PaymentLineImportBuffer.Description;
                                    PaymentLine."Reference No." := PaymentLineImportBuffer."Reference No.";
                                    PaymentLine."Total Amount" := PaymentLineImportBuffer."Total Amount";
                                    PaymentLine.Validate("Total Amount");
                                    PaymentLine.Insert;
                                until PaymentLineImportBuffer.Next = 0;
                            end;
                        end else begin
                            Error(Txt_001, UserId);
                        end;
                        PaymentLineImportBuffer.Reset;
                        PaymentLineImportBuffer.SetRange(PaymentLineImportBuffer."User ID", UserId);
                        if PaymentLineImportBuffer.FindSet then begin
                            PaymentLineImportBuffer.DeleteAll;
                        end;

                    end;
                }
            }
            group(Reversal)
            {
                Caption = 'Reversal';
                Image = "Action";
                Visible = false;
                action("Reverse Payment")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reverse Payment';
                    Ellipsis = true;
                    Image = ReverseRegister;
                    Scope = Repeater;
                    ToolTip = 'Reverse a posted payment.';

                    trigger OnAction()
                    var
                        ReversalEntry: Record "Reversal Entry";
                        "TransactionNo.": Integer;
                        "G/LEntry": Record "G/L Entry";
                        CustLedgerEntry: Record "Cust. Ledger Entry";
                        VendorLedgerEntry: Record "Vendor Ledger Entry";
                    begin
                        Clear(ReversalEntry);
                        if Rec.Reversed then
                            ReversalEntry.AlreadyReversedDocument(PaymentTxt, Rec."No.");

                        //Get transaction no.
                        BankAccountLedgerEntry.Reset;
                        BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Document No.", Rec."No.");
                        BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry.Reversed, false);
                        if BankAccountLedgerEntry.FindFirst then begin
                            ReversalEntry.ReverseTransaction(BankAccountLedgerEntry."Transaction No.");
                        end;

                        Commit;

                        //Update the document
                        BankAccountLedgerEntry.Reset;
                        BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Document No.", Rec."No.");
                        BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry.Reversed, true);
                        if BankAccountLedgerEntry.FindLast then begin
                            Rec.Status := Rec.Status::Reversed;
                            Rec.Reversed := true;
                            Rec."Reversal Date" := Today;
                            Rec."Reversal Time" := Time;
                            Rec."Reversed By" := UserId;
                            Rec.Modify;
                        end;
                    end;
                }
            }
            group("Report")
            {
                Caption = 'Report';
                action("Print Petty Cash Payment")
                {
                    Caption = 'Print Petty Cash Payment';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        PaymentHeader.Reset;
                        PaymentHeader.SetRange(PaymentHeader."No.", Rec."No.");
                        if PaymentHeader.FindFirst then begin
                            REPORT.RunModal(REPORT::"Payment Voucher II", true, false, PaymentHeader);
                        end;
                    end;
                }
                action("Print Withholding")
                {
                    Caption = 'Print Withholding';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

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
                        //TESTFIELD(Status,Status::Approved);
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

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        /*PaymentHeader.RESET;
        PaymentHeader.SETRANGE("User ID",USERID);
        PaymentHeader.SETRANGE(Status,PaymentHeader.Status::Open);
        PaymentHeader.SETRANGE("Payment Type",PaymentHeader."Payment Type"::"Cheque Payment");
        IF PaymentHeader.FINDFIRST THEN BEGIN
          ERROR(Txt_002);
        END;
        */
        Rec."Payment Type" := Rec."Payment Type"::"Cheque Payment";

    end;

    var
        Txt_001: Label 'User Account %1 is not Setup for Payments Posting, Contact the System Administrator';
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        FundsManagement: Codeunit "Funds Management";
        FundsApprovalManager: Codeunit "Funds Approval Manager";
        FundsUserSetup: Record "Funds User Setup";
        PaymentHeader: Record "Payment Header";
        UserSetup: Record "User Setup";
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        PaymentLine: Record "Payment Line";
        FundsTransactionCodes: Record "Funds Transaction Code";
        PaymentLineImportBuffer: Record "Payment Line Import Buffer";
        JTemplate: Code[10];
        JBatch: Code[10];
        "DocNo.": Code[20];
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
        Txt_002: Label 'There is an open payment document under your name, use it before you create a new one.';
        Txt_003: Label 'Document reopened successfully.';
        ErrorUsedReferenceNumber: Label 'The Reference Number has been used for Payment No:%1';
        PaymentTxt: Label 'Payment';

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

        if (Rec.Status = Rec.Status::Open) or (Rec.Status = Rec.Status::"Pending Approval") then begin
            PageEditable := true;
        end else begin
            PageEditable := false;
        end;
    end;
}

