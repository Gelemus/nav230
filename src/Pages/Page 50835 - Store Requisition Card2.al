page 50835 "Store Requisition Card2"
{
    DeleteAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approvals,Cancellation,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Store Requisition Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {

                }
                field("Required Date"; Rec."Required Date")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Project No"; Rec."Project No")
                {
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                }
                field(Template; Rec.Template)
                {
                    OptionCaption = ' None,Social Conection,Replenishment';
                    Visible = false;
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
                field("Point Of Use"; Rec."Point Of Use")
                {
                }
                field("Reference No"; Rec."Reference No")
                {
                }
                field("Cost Amount"; Rec."Cost Amount")
                {
                }
                field("Total Sale Amount"; Rec."Total Sale Amount")
                {
                }
                field("Purchase requisition Created"; Rec."Purchase requisition Created")
                {
                    Editable = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the field name';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the field name';
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                }
                field("Area Manager"; Rec."Area Manager")
                {
                    Visible = false;
                }
                field(HOD; Rec.HOD)
                {
                    Visible = false;
                }
                field(MD; Rec.MD)
                {
                    Visible = false;
                }
                field("Issued By"; Rec."Issued By")
                {
                    Editable = false;
                }
                field("Reason for Cancellation"; Rec."Reason for Cancellation")
                {
                }
                field("Cancellation comments"; Rec."Cancellation comments")
                {
                    Visible = false;
                }
                field("Driver No"; Rec."Driver No")
                {
                    Visible = false;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    Visible = false;
                }
            }
            part("Store Requisition Line"; "Store Requisition Line")
            {
                SubPageLink = "Document No." = FIELD("No.");

            }
        }
        area(factboxes)
        {
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
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
            systempart(Control39; Links)
            {
                Visible = false;
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
            action(ReOpen)
            {
                Caption = 'ReOpen';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';
            }
            action("Return To User")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Return To User';
                Image = Reject;
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



                    Rec.TestField("Cancellation comments");
                    ApprovalEntry.Reset;
                    ApprovalEntry.SetRange("Document No.", Rec."No.");
                    ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::Imprest);
                    ApprovalEntry.SetFilter(Status, '=%1|%2|%3', ApprovalEntry.Status::Approved, ApprovalEntry.Status::Open, ApprovalEntry.Status::Created);
                    ;
                    if ApprovalEntry.FindFirst then
                        repeat
                            ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
                            ApprovalEntry."Rejection Comments" := Rec."Cancellation comments";
                            ApprovalEntry.Modify;

                        until ApprovalEntry.Next = 0;
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify;
                    Message('Record changed successfully');
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
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        Rec.TestField("Global Dimension 1 Code");
                        Rec.TestField("Global Dimension 2 Code");
                        Rec.TestField("Shortcut Dimension 3 Code");
                        //TESTFIELD("Shortcut Dimension 4 Code");
                        //TESTFIELD("Cost Amount");
                        Rec.TestField("Point Of Use");
                        // InventoryManagement.CheckStoreRequisitionMandatoryFields(Rec, false);

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
                    PromotedCategory = Category8;
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
            group(Posting)
            {
                Caption = 'Posting';
                action("Post Material  Requisition")
                {
                    Caption = 'Post Material  Requisition';
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
                            InventoryManagement.PostStoreRequisition(Rec, JTemplate, JBatch);
                        end else begin
                            Error(Txt_001, UserId);
                        end;
                    end;
                }
                action("Create Purchase Requisition")
                {
                    Image = CreateJobSalesInvoice;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        Rec.TestField(Status, Rec.Status::Approved);
                        if DIALOG.Confirm('Are you sure you want to create an Purchase Requisition from Approved Store Requisitio1n No  %1', true, Rec."No.") then begin

                            StoreRequisitionHeader.Reset;
                            StoreRequisitionHeader.SetRange("No.", Rec."No.");
                            if StoreRequisitionHeader.FindSet then begin
                                PurchasesPayablesSetup.Reset;
                                PurchasesPayablesSetup.Get;
                                //Create Purchase Requisition Header
                                PurchaseRequisitionHeader.Init;
                                PurchaseRequisitionHeader."No." := NoSeriesMgt.GetNextNo(PurchasesPayablesSetup."Purchase Requisition Nos.", 0D, true);
                                PurchaseRequisitionHeader."No. Series" := PurchasesPayablesSetup."Purchase Requisition Nos.";
                                PurchaseRequisitionHeader."Document Date" := Today;
                                PurchaseRequisitionHeader."User ID" := UserId;
                                PurchaseRequisitionHeader."Requested Receipt Date" := StoreRequisitionHeader."Posting Date";
                                PurchaseRequisitionHeader."Purchase Requisition" := true;
                                PurchaseRequisitionHeader.Budget := PurchaseRequisitionHeader.Budget;
                                PurchaseRequisitionHeader.Description := StoreRequisitionHeader.Description;
                                PurchaseRequisitionHeader."Reference Document No." := StoreRequisitionHeader."No.";
                                PurchaseRequisitionHeader."Global Dimension 1 Code" := StoreRequisitionHeader."Global Dimension 1 Code";
                                PurchaseRequisitionHeader."Global Dimension 2 Code" := StoreRequisitionHeader."Global Dimension 2 Code";
                                PurchaseRequisitionHeader."Shortcut Dimension 3 Code" := StoreRequisitionHeader."Shortcut Dimension 3 Code";
                                PurchaseRequisitionHeader."Shortcut Dimension 4 Code" := StoreRequisitionHeader."Shortcut Dimension 4 Code";
                                PurchaseRequisitionHeader."Position Title" := StoreRequisitionHeader."Point Of Use";
                                PurchaseRequisitionHeader.Status := PurchaseRequisitionHeader.Status::Open;
                                PurchaseRequisitionHeader.Amount := StoreRequisitionHeader."Cost Amount";
                                PurchaseRequisitionHeader."Amount(LCY)" := PurchaseRequisitionHeader."Amount(LCY)";
                                PurchaseRequisitionHeader.Insert(true);

                                //Create Purchase Requisition Lines
                                StoreRequisitionLine.Reset;
                                StoreRequisitionLine.SetRange(StoreRequisitionLine."Document No.", StoreRequisitionHeader."No.");
                                if StoreRequisitionLine.FindSet then begin
                                    repeat
                                        PurchaseRequisitionLine.Init;
                                        PurchaseRequisitionLine."Line No." := StoreRequisitionLine."Line No.";
                                        PurchaseRequisitionLine."Document No." := PurchaseRequisitionHeader."No.";
                                        PurchaseRequisitionLine.Type := 2;//StoreRequisitionLine.Type;
                                                                          //PurchaseRequisitionLine.VALIDATE(Type);
                                        PurchaseRequisitionLine."No." := StoreRequisitionLine."Item No.";
                                        PurchaseRequisitionLine.Validate("No.");
                                        PurchaseRequisitionLine.Quantity := StoreRequisitionLine.Quantity;
                                        //  PurchaseRequisitionLine.VALIDATE(Quantity);
                                        PurchaseRequisitionLine.Description := StoreRequisitionLine.Description;
                                        //   PurchaseRequisitionLine.VALIDATE(Description);
                                        PurchaseRequisitionLine."Document Date" := Today;
                                        PurchaseRequisitionLine."Location Code" := StoreRequisitionLine."Location Code";
                                        // PurchaseRequisitionLine."Requisition Type" := StoreRequisitionLine.Type;
                                        PurchaseRequisitionLine."Unit of Measure" := StoreRequisitionLine."Unit of Measure Code";
                                        PurchaseRequisitionLine.Budget := PurchaseRequisitionHeader.Budget;
                                        PurchaseRequisitionLine."Total Cost" := StoreRequisitionLine."Line Amount";
                                        PurchaseRequisitionLine."Unit Cost" := StoreRequisitionLine."Unit Cost";
                                        PurchaseRequisitionLine."Total Cost(LCY)" := StoreRequisitionLine."Line Amount";
                                        PurchaseRequisitionLine."Global Dimension 1 Code" := PurchaseRequisitionHeader."Global Dimension 1 Code";
                                        PurchaseRequisitionLine."Global Dimension 2 Code" := PurchaseRequisitionHeader."Global Dimension 2 Code";
                                        PurchaseRequisitionLine.Insert(true);
                                    until StoreRequisitionLine.Next = 0;
                                end;

                                //Update the Store requisition Status closed
                                StoreRequisitionHeader.Status := StoreRequisitionHeader.Status::Converted;
                                StoreRequisitionHeader.Modify;
                                Message('Approved Store Requisition No. %1 converted successfully to Purchase Requisition No. %2', StoreRequisitionHeader."No.", PurchaseRequisitionHeader."No.");
                            end;
                        end;
                        /* PurchaseReqRec1.RESET;
                         PurchaseReqRec1.SETRANGE("No.",PurchaseReqRec."No.");
                         PAGE.RUN(50411,PurchaseReqRec1);
                         CurrPage.CLOSE();
                         //change Nos
                     //      PurchasesPayablesSetup.GET();
                     //      PurchaseRequisitionHeader.no := NoSeriesMgt.GetNextNo(PurchasesPayablesSetup."Requisition Nos.",TODAY,TRUE);
                     //      PurchaseRequisitionHeader."No. Series" := PurchasesPayablesSetup."Requisition Nos.";
                     //      PurchaseRequisitionHeader.MODIFY;
                       END;
                     END;
                     */

                    end;
                }
                action("Post and Print  Requisition")
                {
                    Caption = 'Post and Print  Requisition';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';
                    Visible = false;

                    trigger OnAction()
                    begin
                        InventoryManagement.CheckStoreRequisitionMandatoryFields(Rec, true);
                        Rec.TestField(Status, Rec.Status::Approved);
                        if InventoryUserSetup.Get(UserId) then begin
                            InventoryUserSetup.TestField(InventoryUserSetup."Item Journal Template");
                            InventoryUserSetup.TestField(InventoryUserSetup."Item Journal Batch");
                            JTemplate := InventoryUserSetup."Item Journal Template";
                            JBatch := InventoryUserSetup."Item Journal Batch";
                            InventoryManagement.PostStoreRequisition(Rec, JTemplate, JBatch);
                        end else begin
                            Error(Txt_001, UserId);
                        end;
                    end;
                }
            }
            group("Report")
            {
                Caption = 'Report';
                action("Print Material  Requisition Note")
                {
                    Caption = 'Print Material  Requisition';
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
                            //REPORT.RunModal(REPORT::"Store Requisition II", true, false, StoreRequisitionHeader);
                        end;
                    end;
                }
                action("Print  Delivery Document")
                {
                    Caption = 'Print Material  Delivery Document';
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
                            REPORT.RunModal(REPORT::"Store Requisition/Delivery Rep", true, false, StoreRequisitionHeader);
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
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
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
                    PromotedCategory = Category4;
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
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(Rec.RecordId);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RecordId);
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
        ApprovalEntry: Record "Approval Entry";
        StoreRequisitionLine: Record "Store Requisition Line";
        PurchaseRequisitionHeader: Record "Purchase Requisitions";
        PurchaseRequisitionLine: Record "Purchase Requisition Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";

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

