page 50032 "Funds Claim List"
{
    CardPageID = "Funds Claim Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Funds Claim Header";
    SourceTableView = WHERE(Status = FILTER(Open | "Pending Approval" | Released | Rejected));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Payee Type"; Rec."Payee Type")
                {
                }
                field("Payee No."; Rec."Payee No.")
                {
                }
                field("Payee Name"; Rec."Payee Name")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
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
            systempart(Control31; Links)
            {
                Visible = false;
            }
            systempart(Control30; Notes)
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

                trigger OnAction()
                begin
                    if FundsUserSetup.Get(UserId) then begin
                        if FundsUserSetup."Reopen Funds Documents" then begin
                            if Confirm(Txt_003, false, Rec."No.") then
                                FundsApprovalManager.ReOpenFundsClaim(Rec);
                        end else begin
                            Error(Txt_004, UserId);
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
                        FundsManagement.CheckFundsClaimMandatoryFields(Rec, false);

                        // if ApprovalsMgmt.CheckFundsClaimApprovalsWorkflowEnabled(Rec) then
                        //   ApprovalsMgmt.OnSendFundsClaimHeaderForApproval(Rec);
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
                        // ApprovalsMgmt.CheckFundsClaimApprovalsWorkflowEnabled(Rec);
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
                        FundsManagement.CheckFundsClaimMandatoryFields(Rec, false);
                        if FundsUserSetup.Get(UserId) then begin
                            FundsUserSetup.TestField("Payment Journal Template");
                            FundsUserSetup.TestField("Payment Journal Batch");
                            JTemplate := FundsUserSetup."Payment Journal Template";
                            JBatch := FundsUserSetup."Payment Journal Batch";
                            FundsManagement.PostFundsClaim(Rec, JTemplate, JBatch, true);
                        end else begin
                            Error(Txt_001, UserId);
                        end;
                    end;
                }
                action("Post Funds Claim")
                {
                    Caption = 'Post Funds Claim';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction()
                    begin
                        FundsManagement.CheckFundsClaimMandatoryFields(Rec, true);
                        if FundsUserSetup.Get(UserId) then begin
                            FundsUserSetup.TestField(FundsUserSetup."Payment Journal Template");
                            FundsUserSetup.TestField(FundsUserSetup."Payment Journal Batch");
                            JTemplate := FundsUserSetup."Payment Journal Template";
                            JBatch := FundsUserSetup."Payment Journal Batch";
                            FundsManagement.PostFundsClaim(Rec, JTemplate, JBatch, false);
                        end else begin
                            Error(Txt_001, UserId);
                        end;
                    end;
                }
                action("Post and Print Funds Claim")
                {
                    Caption = 'Post and Print Funds Claim';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';

                    trigger OnAction()
                    begin
                        FundsManagement.CheckFundsClaimMandatoryFields(Rec, true);
                        "DocNo." := Rec."No.";
                        if FundsUserSetup.Get(UserId) then begin
                            FundsUserSetup.TestField(FundsUserSetup."Payment Journal Template");
                            FundsUserSetup.TestField(FundsUserSetup."Payment Journal Batch");
                            JTemplate := FundsUserSetup."Payment Journal Template";
                            JBatch := FundsUserSetup."Payment Journal Batch";
                            FundsManagement.PostFundsClaim(Rec, JTemplate, JBatch, false);
                            Commit;
                            FundsClaimHeader.Reset;
                            FundsClaimHeader.SetRange(FundsClaimHeader."No.", "DocNo.");
                            if FundsClaimHeader.FindFirst then begin
                                REPORT.RunModal(REPORT::"Posted Imprest Surrender Lines", true, false, FundsClaimHeader);
                            end;
                        end else begin
                            Error(Txt_001, UserId);
                        end;
                    end;
                }
            }
            group("Report")
            {
                Caption = 'Report';
                action("Print Funds Claim")
                {
                    Caption = 'Print Funds Claim';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        FundsClaimHeader.Reset;
                        FundsClaimHeader.SetRange(FundsClaimHeader."No.", Rec."No.");
                        if FundsClaimHeader.FindFirst then begin
                            REPORT.RunModal(REPORT::"Funds Claim Voucher", true, false, FundsClaimHeader);
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

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Released);
                        Rec.TestField("Cheque Type", Rec."Cheque Type"::"Computer Cheque");

                        FundsClaimHeader.Reset;
                        FundsClaimHeader.SetRange(FundsClaimHeader."No.", Rec."No.");
                        if FundsClaimHeader.FindFirst then
                            REPORT.Run(REPORT::"Cheque Print", true, true, FundsClaimHeader);
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
                        IncomingDocumentAttachment.NewAttachmentFromFundsClaimDocument(Rec);
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
        FundsClaimHeader.Reset;
        FundsClaimHeader.SetRange("User ID", UserId);
        FundsClaimHeader.SetRange(FundsClaimHeader.Status, FundsClaimHeader.Status::Open);
        if FundsClaimHeader.FindFirst then begin
            Error(Txt_002);
        end;
    end;

    trigger OnOpenPage()
    begin
        Rec.SetRange(Rec."User ID", UserId);
    end;

    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        FundsManagement: Codeunit "Funds Management";
        FundsApprovalManager: Codeunit "Funds Approval Manager";
        FundsUserSetup: Record "Funds User Setup";
        FundsClaimHeader: Record "Funds Claim Header";
        JTemplate: Code[10];
        JBatch: Code[10];
        "DocNo.": Code[20];
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
        Txt_001: Label 'User Account %1 is not Setup for funds claim Posting, Contact the System Administrator';
        Txt_002: Label 'There is an open funds claim document under your name, use it before you create a new one.';
        Txt_003: Label 'Reopen funds claim no.%1?';
        Txt_004: Label 'User Account %1 is not Setup for reopening funds claim, Contact the System Administrator';

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

