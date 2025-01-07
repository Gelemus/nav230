page 50072 "Journal Voucher"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Journal Voucher Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("JV No."; Rec."JV No.")
                {
                    Editable = false;
                }
                field("Document date"; Rec."Document date")
                {
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Requires Voting"; Rec."Requires Voting")
                {
                    ShowMandatory = true;
                }
                field(Voted; Rec.Voted)
                {
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                }
                field("JV Lines Cont"; Rec."JV Lines Cont")
                {
                }
                field("Total Debit"; Rec."Total Debit")
                {
                }
                field("Total Credit"; Rec."Total Credit")
                {
                }
                field("Total Amount"; Rec."Total Amount")
                {
                }
            }
            part(Control11; "Journal Voucher Lines")
            {
                SubPageLink = "JV No." = FIELD("JV No.");
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
            systempart(Control29; Links)
            {
                Visible = false;
            }
            systempart(Control28; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Print JV Report")
            {
                Image = PrepaymentSimulation;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    JournalVoucher.Reset;
                    JournalVoucher.SetRange(JournalVoucher."JV No.", Rec."JV No.");
                    if JournalVoucher.FindFirst then begin
                        REPORT.RunModal(REPORT::"Journal Voucher Report", true, false, JournalVoucher);
                    end;
                end;
            }
            group("Release Journal Voucher")
            {
                Caption = 'Release';
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
                        /*UserSetup.RESET;
                        UserSetup.SETRANGE(UserSetup."User ID",USERID);
                        IF UserSetup.FINDFIRST THEN BEGIN
                          IF UserSetup."Reopen Documents" THEN
                            FundsApprovalManager.ReOpenPaymentHeader(Rec);
                          MESSAGE(Txt_003);
                          CurrPage.CLOSE;
                        END;*/
                        if (Rec."Requires Voting" = Rec."Requires Voting"::Yes) or (Rec.Voted = true) then
                            FundsManagement.ReverseJournalVoucherBudget(Rec);
                        if Rec.Status = Rec.Status::Approved/*CONFIRM(ReOpenLeaveApplication,FALSE,"No.")*/ then begin
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;
                        end;

                    end;
                }
                action(Release)
                {
                    Caption = 'Release';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        /*UserSetup.RESET;
                        UserSetup.SETRANGE(UserSetup."User ID",USERID);
                        IF UserSetup.FINDFIRST THEN BEGIN
                          IF UserSetup."Reopen Documents" THEN
                            FundsApprovalManager.ReOpenPaymentHeader(Rec);
                          MESSAGE(Txt_003);
                          CurrPage.CLOSE;
                        END;*/
                        //added on 05/03/2024
                        if (Rec."Requires Voting" = Rec."Requires Voting"::Yes) and (Rec.Voted = false) then begin
                            FundsManagement.CommitjounalVoucher(Rec);
                        end else begin
                            if Rec.Status = Rec.Status::Open/*CONFIRM(ReOpenLeaveApplication,FALSE,"No.")*/ then begin
                                Rec.Status := Rec.Status::Approved;
                                Rec.Modify;
                            end;
                        end;

                    end;
                }
            }
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action("Vote Journal Voucher")
                {
                    ApplicationArea = Suite;
                    Caption = 'Vote Journal Voucher';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Vote Journal Voucher';
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
                    begin
                        UserSetup.Reset;
                        UserSetup.SetRange(UserSetup."User ID", UserId);
                        if UserSetup.FindFirst then begin
                            if UserSetup.CommitBudget then
                                if Confirm('Are you sure you want to vote this journal voucher') then
                                    FundsManagement.CommitjounalVoucher(Rec);// FundsManagement.CommitjounalVoucher(Rec); //FundsApprovalManager.ReOpenPaymentHeader(Rec);
                            Message(Txt_003);
                            // CurrPage.CLOSE;
                        end;
                    end;
                }
                action("UnVote Journal Voucher")
                {
                    ApplicationArea = Suite;
                    Caption = 'UnVote Journal Voucher';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'UnVote Journal Voucher';
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        UserSetup.Reset;
                        UserSetup.SetRange(UserSetup."User ID", UserId);
                        if UserSetup.FindFirst then begin
                            if UserSetup.CommitBudget then
                                if Confirm('Are you sure you want to unvote this journal voucher') then
                                    FundsManagement.ReverseJournalVoucherBudget(Rec);// FundsManagement.CommitjounalVoucher(Rec); //FundsApprovalManager.ReOpenPaymentHeader(Rec);
                            Message(Txt_004);
                        end;
                    end;
                }
                action("Budget Committment Lines")
                {
                    Caption = 'Budget Committment Lines';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Budget Committment Lines";
                    RunPageLink = "Document No." = FIELD("JV No.");

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                        //WorkflowsEntriesBuffer.RunWorkflowEntriesDocumentPage(RECORDID,DATABASE::"Purchase Requisition Header","No.");
                        //WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RECORDID,DATABASE::"Purchase Requisition Header","No.");
                    end;
                }
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Approval Entries";
                    RunPageLink = "Document No." = FIELD("JV No.");
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                        //WorkflowsEntriesBuffer.RunWorkflowEntriesDocumentPage(RECORDID,DATABASE::"Purchase Requisition Header","No.");
                        //WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RECORDID,DATABASE::"Purchase Requisition Header","No.");
                    end;
                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Open);

                        FundsManagement.CheckJournalVoucherMandatoryFields(Rec, false);

                        if ApprovalsMgmt.CheckJournalVoucherApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendJournalVoucherForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    begin
                        ApprovalsMgmt.OnCancelJournalVoucherApprovalRequest(Rec);
                        // WorkflowWebhookMgt.FindAndCancel(RecordId);

                        //CanCancelApprovalForRecord OR CanCancelApprovalForFlow
                    end;
                }
            }
            group(Postings)
            {
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
                        FundsManagement.CheckJournalVoucherMandatoryFields(Rec, false);

                        if FundsUserSetup.Get(UserId) then begin
                            FundsUserSetup.TestField("JV Template");
                            FundsUserSetup.TestField("JV Batch");
                            JTemplate := FundsUserSetup."JV Template";
                            JBatch := FundsUserSetup."JV Batch";
                            FundsManagement.PostJournalVoucher(Rec, JTemplate, JBatch, true);
                        end else begin
                            Error(Txt_001, UserId);
                        end;
                    end;
                }
                action("Post Journal")
                {
                    Caption = 'Post Journal';
                    Image = Payment;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction()
                    begin
                        FundsManagement.CheckJournalVoucherMandatoryFields(Rec, true);

                        Rec.TestField(Posted, false);//FRS191819
                        if FundsUserSetup.Get(UserId) then begin
                            FundsUserSetup.TestField(FundsUserSetup."JV Template");
                            FundsUserSetup.TestField(FundsUserSetup."JV Batch");
                            JTemplate := FundsUserSetup."JV Template";
                            JBatch := FundsUserSetup."JV Batch";
                            FundsManagement.PostJournalVoucher(Rec, JTemplate, JBatch, false);
                        end else begin
                            Error(Txt_001, UserId);
                        end;
                    end;
                }
                action("Post and Print Journal")
                {
                    Caption = 'Post and Print Journal';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';

                    trigger OnAction()
                    begin
                        FundsManagement.CheckJournalVoucherMandatoryFields(Rec, true);

                        "DocNo." := Rec."JV No.";

                        if FundsUserSetup.Get(UserId) then begin
                            FundsUserSetup.TestField(FundsUserSetup."JV Template");
                            FundsUserSetup.TestField(FundsUserSetup."JV Batch");
                            JTemplate := FundsUserSetup."JV Template";
                            JBatch := FundsUserSetup."JV Batch";
                            FundsManagement.PostJournalVoucher(Rec, JTemplate, JBatch, false);

                            Commit;

                            JournalVoucher.Reset;
                            JournalVoucher.SetRange(JournalVoucher."JV No.", "DocNo.");
                            if JournalVoucher.FindFirst then begin
                                REPORT.RunModal(REPORT::"Journal Voucher Report", true, false, JournalVoucher);
                            end;
                        end else begin
                            Error(Txt_001, UserId);
                        end;
                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Reject the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
            }
            group(Reversal)
            {
                Caption = 'Reversal';
                Image = "Action";
                action("Reverse Journal Voucher")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reverse Journal Voucher';
                    Ellipsis = true;
                    Image = ReverseRegister;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Scope = Repeater;
                    ToolTip = 'Reverse Journal Voucher';

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
                            ReversalEntry.AlreadyReversedDocument(JournalTxt, Rec."JV No.");

                        //Get transaction no.
                        BankAccountLedgerEntry.Reset;
                        BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Document No.", Rec."JV No.");
                        BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry.Reversed, false);
                        if BankAccountLedgerEntry.FindFirst then begin
                            ReversalEntry.ReverseTransaction(BankAccountLedgerEntry."Transaction No.");
                        end;

                        Commit;

                        //Update the document
                        BankAccountLedgerEntry.Reset;
                        BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Document No.", Rec."JV No.");
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
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        /*Rec.RESET;
        Rec.SETRANGE("User ID",USERID);
        Rec.SETRANGE(Rec.Status,Rec.Status::Open);
        IF Rec.FINDFIRST THEN BEGIN
          ERROR(Txt_002);
        END;
        */

    end;

    trigger OnOpenPage()
    begin
        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable(false);
    end;

    var
        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
        FundsManagement: Codeunit "Funds Management";
        FundsUserSetup: Record "Funds User Setup";
        JTemplate: Code[30];
        JBatch: Code[30];
        Txt_001: Label 'User Account %1 is not Setup for Journal Posting, Contact the System Administrator';
        "DocNo.": Code[30];
        JournalVoucher: Record "Journal Voucher Header";
        Txt_002: Label 'There is an open  document under your name, use it before you create a new one';
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        JournalTxt: Label 'Journal Voucher';
        FundsApprovalManager: Codeunit "Funds Approval Manager";
        PaymentHeader: Record "Payment Header";
        UserSetup: Record "User Setup";
        PaymentLine: Record "Payment Line";
        FundsTransactionCodes: Record "Funds Transaction Code";
        PaymentLineImportBuffer: Record "Payment Line Import Buffer";
        Txt_003: Label 'Journal Voted Successfully';
        Txt_004: Label 'Journal Decommited Succesfully';

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        //HasIncomingDocument := "Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabled := (not HasIncomingDocument) and (Rec."JV No." <> '');

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;
}

