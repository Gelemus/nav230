page 52220 "Return to Store Card"
{
    DeleteAllowed = false;
    PageType = Document;
    ApplicationArea = All;
    PromotedActionCategories = 'New,Process,Reports,Approvals,Cancellation,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Store Requisition Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Store Requistion No"; Rec."Store Requistion No")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Required Date"; Rec."Required Date")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Point Of Use"; Rec."Point Of Use")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    Visible = false;
                }
                field("Cost Amount"; Rec."Cost Amount")
                {
                }
                field("Total Sale Amount"; Rec."Total Sale Amount")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Reason for Cancellation"; Rec."Reason for Cancellation")
                {
                }
                field(SS; Rec."Cancellation comments")
                {
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                }
            }
            group("Customer Details")
            {
                Caption = 'Customer Details';
                field("Account No"; Rec."Account No")
                {
                }
                field("Customer No"; Rec."Customer No")
                {
                }
                field("Customer Name"; Rec."Customer Name")
                {
                }
                field("Integration Response"; Rec."Integration Response")
                {
                }
                field("Make Adjustment to Customer"; Rec."Make Adjustment to Customer")
                {
                }
                field("Adjustment Status"; Rec."Adjustment Status")
                {
                }
            }
            part("Store Requisition Line"; "Store Requisition Line3")
            {
                Caption = 'Store Requisition Line';
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
            systempart(Control18; Links)
            {
                Visible = false;
            }
            systempart(Control13; Notes)
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
            action(ReOpen)
            {
                Caption = 'ReOpen';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';
            }
            action("Requisition lines")
            {
                Image = Allocations;
                Promoted = true;
                RunObject = Page "Store Requisition Line2";
                RunPageLink = "Document No." = FIELD("Store Requistion No"),
                              Returned = CONST(false);

                trigger OnAction()
                begin
                    StoreLines.Reset;
                    StoreLines.SetRange(StoreLines."Document No.", Rec."Store Requistion No");
                    if StoreLines.FindSet then begin
                        repeat
                            StoreLines."Return Requisition No" := Rec."No.";
                            StoreLines.Select := false;
                            StoreLines.Modify;
                        until StoreLines.Next = 0;
                    end;
                end;
            }
            group(Posting)
            {
                Caption = 'Posting';
                action("Post Store Requisition")
                {
                    Caption = 'Post Store Requisition';
                    Image = Payment;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction()
                    begin
                        //InventoryManagement.CheckStoreRequisitionMandatoryFields(Rec,TRUE);
                        //TESTFIELD(Status,Status::Approved);
                        if InventoryUserSetup.Get(UserId) then begin
                            InventoryUserSetup.TestField(InventoryUserSetup."Item Journal Template");
                            InventoryUserSetup.TestField(InventoryUserSetup."Item Journal Batch");
                            JTemplate := InventoryUserSetup."Item Journal Template";
                            JBatch := InventoryUserSetup."Item Journal Batch";
                            InventoryManagement.PostStoreRequisitionReturn(Rec, JTemplate, JBatch);
                        end else begin
                            Error(Txt_001, UserId);
                        end;
                    end;
                }
                action("Post and Print Store Requisition")
                {
                    Caption = 'Post and Print Store Requisition';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';

                    trigger OnAction()
                    begin
                        InventoryManagement.CheckStoreRequisitionMandatoryFields(Rec, true);
                        //TESTFIELD(Status,Status::Approved);
                        if InventoryUserSetup.Get(UserId) then begin
                            InventoryUserSetup.TestField(InventoryUserSetup."Item Journal Template");
                            InventoryUserSetup.TestField(InventoryUserSetup."Item Journal Batch");
                            JTemplate := InventoryUserSetup."Item Journal Template";
                            JBatch := InventoryUserSetup."Item Journal Batch";
                            InventoryManagement.PostStoreRequisitionReturn(Rec, JTemplate, JBatch);
                        end else begin
                            Error(Txt_001, UserId);
                        end;
                    end;
                }
            }
            group("Report")
            {
                Caption = 'Report';
                action("Print Store Requisition")
                {
                    Caption = 'Print Store Requisition';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ToolTip = 'Prepare to print the document. A report request window where you can specify what to include on the print-out.';

                    trigger OnAction()
                    begin
                        StoreRequisitionHeader.Reset;
                        StoreRequisitionHeader.SetRange(StoreRequisitionHeader."No.", Rec."No.");
                        if StoreRequisitionHeader.FindFirst then begin
                            REPORT.RunModal(REPORT::"Return Material Report", true, false, StoreRequisitionHeader);
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
                        //IncomingDocumentAttachment.NewAttachmentFromStoreRequisitionDocument(Rec);
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
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Approval Entries";
                    RunPageLink = "Document No." = FIELD("No.");
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ",Payment,Receipt,Imprest,"Imprest Surrender","Funds Refund",Requisition,"Funds Transfer","HR Document";
                    begin
                        //WorkflowsEntriesBuffer.RunWorkflowEntriesDocumentPage(RECORDID,DATABASE::"Store Requisition Header","No.");
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
                    var
                        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
                    begin
                        Rec.TestField("Shortcut Dimension 3 Code");
                        Rec.TestField("Shortcut Dimension 4 Code");
                        Rec.TestField("Point Of Use");
                        InventoryManagement.CheckStoreRequisitionMandatoryFields(Rec, false);

                        if ApprovalsMgmt.CheckStoreRequisitionApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendStoreRequisitionForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalsMgmt.OnCancelStoreRequisitionApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
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
        Rec."Return to store" := true;
    end;

    var
        Txt_001: Label 'User %1 is not setup for Inventory Posting. Contact System Administrator';
        Text046: Label 'The %1 does not match the quantity defined in item tracking.';
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        InventoryManagement: Codeunit "Inventory Management";
        InventoryUserSetup: Record "Inventory User Setup";
        StoreRequisitionHeader: Record "Store Requisition Header";
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
        StoreLines: Record "Store Requisition Line";

    procedure UpdateControls()
    begin
    end;

    procedure CurrPageUpdate()
    begin
    end;

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

