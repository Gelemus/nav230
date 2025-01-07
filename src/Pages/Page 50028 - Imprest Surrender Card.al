page 50028 "Imprest Surrender Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Imprest Surrender Header";
    SourceTableView = WHERE(Posted = CONST(false));

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
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Imprest No."; Rec."Imprest No.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Imprest Date"; Rec."Imprest Date")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the field name';
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Actual Spent"; Rec."Actual Spent")
                {
                    ToolTip = 'Specifies the field name';
                }
                field(Difference; Rec.Amount - Rec."Actual Spent")
                {
                    ToolTip = 'Specifies the field name';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Visible = false;
                }
                field("Reason for Cancellation"; Rec."Reason for Cancellation")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the field name';
                }
                field("Document Name"; Rec."Document Name")
                {
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the field name';
                }
            }
            part(Control17; "Imprest Surrender Line")
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
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(Control28; Links)
            {
                Visible = false;
            }
            systempart(Control27; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("View Attachement")
            {
                Caption = 'View Attachement>';
                Image = Documents;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //FileManagement.DownloadFile("Document Path");
                    PortalSetup.Get;
                    HyperLink(PortalSetup."Server File Path" + Rec."Document Name");
                end;
            }
            action(AttachedDoc)
            {
                ApplicationArea = Suite;
                Caption = 'View  Attached Document';
                Image = ViewOrder;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'View any incoming document records and file attachments that exist for the entry or document, for example for auditing purposes';

                trigger OnAction()
                var
                    IncomingDocument: Record "Incoming Document";
                    PortalSetup: Record "Portal Setup";
                begin
                    //IncomingDocument.ShowCardFromEntryNo("Incoming Document Entry No.");
                    PortalSetup.Get;
                    HyperLink(PortalSetup."Server File Path" + Rec."Document Name");
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
                var
                    UserSetup: Record "User Setup";
                begin
                    UserSetup.Reset;
                    UserSetup.SetRange(UserSetup."User ID", UserId);
                    if UserSetup.FindFirst then begin
                        if UserSetup."Reopen Documents" = false then
                            Error(Error202);
                    end;



                    Rec.TestField(Status, Rec.Status::Released);
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify;
                    Message(text101);
                end;
            }
            action(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;

                trigger OnAction()
                begin
                    FundsApprovalManager.ReleaseImprestSurrenderHeader(Rec);
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

                trigger OnAction()
                begin
                    if (Rec.Status = Rec.Status::Open) or (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Approved) then begin
                        Rec.TestField("Reason for Cancellation");
                        if Confirm('Are you sure you want to cancel?', true) then begin
                            Rec."Cancelled By" := UserId;
                            Rec."Date Cancelled" := Today;
                            Rec."Time Cancelled" := Time;
                            Rec.Status := Rec.Status::Cancelled;
                            Rec.Modify;
                            Message('Cancelled ;');
                        end;
                    end;
                end;
            }
            group("Request Approval")
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
                    RunObject = Page "Approval Entries";
                    RunPageLink = "Document No." = FIELD("No.");
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
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
                        FundsManagement.CheckImprestSurrenderMandatoryFields(Rec, false);

                        // if ApprovalsMgmt.CheckImprestSurrenderApprovalsWorkflowEnabled(Rec) then
                        //   ApprovalsMgmt.OnSendImprestSurrenderHeaderForApproval(Rec);
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
                        // ApprovalsMgmt.OnCancelImprestSurrenderHeaderApprovalRequest(Rec);
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
                        FundsManagement.CheckImprestSurrenderMandatoryFields(Rec, true);
                        if FundsUserSetup.Get(UserId) then begin
                            FundsUserSetup.TestField("Imprest Template");
                            FundsUserSetup.TestField("Imprest Batch");
                            JTemplate := FundsUserSetup."Imprest Template";
                            JBatch := FundsUserSetup."Imprest Batch";
                            FundsManagement.PostImprestSurrender(Rec, JTemplate, JBatch, true);
                        end else begin
                            Error(UserAccountNotSetup, UserId);
                        end;
                    end;
                }
                action("Post Imprest Surrender")
                {
                    Caption = 'Post Imprest Surrender';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction()
                    begin
                        FundsManagement.CheckImprestSurrenderMandatoryFields(Rec, true);
                        if FundsUserSetup.Get(UserId) then begin
                            FundsUserSetup.TestField("Imprest Template");
                            FundsUserSetup.TestField("Imprest Batch");
                            JTemplate := FundsUserSetup."Imprest Template";
                            JBatch := FundsUserSetup."Imprest Batch";
                            FundsManagement.PostImprestSurrender(Rec, JTemplate, JBatch, false);
                        end else begin
                            Error(UserAccountNotSetup, UserId);
                        end;
                    end;
                }
                action("Post and Print Imprest Surrender")
                {
                    Caption = 'Post and Print Imprest Surrender';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';

                    trigger OnAction()
                    begin
                        FundsManagement.CheckImprestSurrenderMandatoryFields(Rec, true);
                        "DocNo." := Rec."No.";
                        if FundsUserSetup.Get(UserId) then begin
                            FundsUserSetup.TestField("Imprest Template");
                            FundsUserSetup.TestField("Imprest Batch");
                            JTemplate := FundsUserSetup."Imprest Template";
                            JBatch := FundsUserSetup."Imprest Batch";
                            FundsManagement.PostImprestSurrender(Rec, JTemplate, JBatch, false);
                            Commit;
                            ImprestSurrenderHeader.Reset;
                            ImprestSurrenderHeader.SetRange("No.", "DocNo.");
                            if ImprestSurrenderHeader.FindFirst then begin
                                REPORT.RunModal(REPORT::"Imprest Surrender Voucher", true, false, ImprestSurrenderHeader);
                            end;
                        end else begin
                            Error(UserAccountNotSetup, UserId);
                        end;
                    end;
                }
                action("Print Imprest Surrender")
                {
                    Caption = 'Print Imprest Surrender';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ToolTip = 'Print Imprest Surrender';

                    trigger OnAction()
                    begin
                        ImprestSurrenderHeader.Reset;
                        ImprestSurrenderHeader.SetRange("No.", Rec."No.");
                        if ImprestSurrenderHeader.FindFirst then begin
                            REPORT.RunModal(REPORT::"Imprest Surrender Voucher", true, false, ImprestSurrenderHeader);
                        end;
                    end;
                }
                action("View Imprest")
                {
                    Image = AmountByPeriod;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        //Posted Imprest List

                        ImprestHeader.Reset;
                        ImprestHeader.SetRange("No.", Rec."Imprest No.");
                        if ImprestHeader.FindFirst then begin
                            PAGE.RunModal(PAGE::"Posted Imprest Card", ImprestHeader);
                        end;
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
                        IncomingDocumentAttachment.NewAttachmentFromImprestSurrenderDocument(Rec);
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
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
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
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Reject the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'Delegate the requested changes to the substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
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
        Rec."Document Type" := Rec."Document Type"::"Imprest Surrender";
        /*Rec.RESET;
        Rec.SETRANGE("User ID",USERID);
        Rec.SETRANGE(Rec.Status,Rec.Status::Open);
        IF Rec.FINDFIRST THEN BEGIN
          ERROR(Txt_002);
        END;*/
        Rec."Document Type" := Rec."Document Type"::"Imprest Surrender";

    end;

    var
        UserAccountNotSetup: Label 'User Account %1 is not Setup for Imprest Surrender Posting, Contact the System Administrator';
        FundsManagement: Codeunit "Funds Management";
        FundsUserSetup: Record "Funds User Setup";
        JTemplate: Code[10];
        JBatch: Code[10];
        "DocNo.": Code[20];
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
        ImprestHeader: Record "Imprest Header";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
        text101: Label 'Document has been successfully Re-Opened Succefully';
        Error202: Label 'Contact System Administrator to perform this Action';
        FundsApprovalManager: Codeunit "Funds Approval Manager";
        Txt_002: Label 'There is an open imprest document under your name, use it before you create a new one';
        PortalSetup: Record "Portal Setup";
        InventoryManagement: Codeunit "Inventory Management";
        StoreLines: Record "Store Requisition Line";
        StoreRequisitionHeader: Record "Store Requisition Header";
        InventoryUserSetup: Record "Inventory User Setup";

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

