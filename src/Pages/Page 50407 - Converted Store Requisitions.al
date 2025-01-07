page 50407 "Converted Store Requisitions"
{
    CardPageID = "Store Requisition Card approve";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approvals,Cancellation,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Store Requisition Header";
    SourceTableView = WHERE(Status = FILTER(Converted),
                            Posted = CONST(false),
                            "Return to store" = FILTER(false),
                            "Bottled Water" = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755010; Notes)
            {
            }
            systempart(Control1102755012; Links)
            {
            }
            systempart(Control1102755011; MyNotes)
            {
            }
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
            systempart(Control19; Links)
            {
                Visible = false;
            }
            systempart(Control18; Notes)
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
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        /*TESTFIELD(Status,Status::Open);
                        InventoryManagement.CheckStoreRequisitionMandatoryFields(Rec,FALSE);
                        
                        IF ApprovalsMgmt.CheckStoreRequisitionApprovalsWorkflowEnabled(Rec) THEN
                          ApprovalsMgmt.OnSendStoreRequisitionForApproval(Rec);
                        */

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
                        /*ApprovalsMgmt.OnCancelStoreRequisitionApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(RECORDID);
                        */

                    end;
                }
            }
            group(Posting)
            {
                Caption = 'Posting';
                action("Post Store Requisition")
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
                action("Create Imprest Requisition")
                {
                    Image = CreateJobSalesInvoice;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*TESTFIELD(Status,Status::Approved);
                        IF DIALOG.CONFIRM('Are you sure you want to create an Imprest Requisition from Purchase Requisition No  %1', TRUE, "No.") THEN
                        BEGIN
                          PurchaseRequisitionHeader.RESET;
                          PurchaseRequisitionHeader.SETRANGE("No.","No.");
                          IF PurchaseRequisitionHeader.FINDSET THEN
                          BEGIN
                            FundsSetup.RESET;
                            FundsSetup.GET;
                        
                            ImprestRec.INIT;
                              ImprestRec."No." := NoSeriesMgt.GetNextNo(FundsSetup."Imprest Nos.",0D,TRUE);
                              ImprestRec."No. Series" := FundsSetup."Imprest Nos.";
                              ImprestRec."Document Type" := ImprestRec."Document Type"::Imprest;
                              ImprestRec."Posting Date" := TODAY;
                              ImprestRec."Date From" := TODAY;
                              ImprestRec."Date To" := TODAY;
                              ImprestRec."User ID" := USERID;
                              ImprestRec."Document Date" := TODAY;
                              ImprestRec.Type := ImprestRec.Type::Imprest;
                        
                              EmployeeRec.RESET;
                              EmployeeRec.SETRANGE("User ID",USERID);
                              IF EmployeeRec.FINDSET THEN
                              BEGIN
                                ImprestRec."Employee No." := EmployeeRec."No.";
                                ImprestRec."Employee Name" := EmployeeRec."First Name" + ' '+ EmployeeRec."Middle Name" +' ' +EmployeeRec."Last Name";
                                ImprestRec."Employee Posting Group" := EmployeeRec."Imprest Posting Group";
                                ImprestRec.position := EmployeeRec.Position;
                                ImprestRec."Position Title" := EmployeeRec."Position Title";
                                ImprestRec."Global Dimension 1 Code" := EmployeeRec."Global Dimension 1 Code";
                                ImprestRec."Global Dimension 2 Code" := EmployeeRec."Global Dimension 2 Code";
                                ImprestRec."Phone No." := EmployeeRec."Phone No.";
                                ImprestRec."HR Job Grade" := EmployeeRec."Employee Grade";
                              END;
                              ImprestRec.Description := PurchaseRequisitionHeader.Description;
                              ImprestRec."Purchase Requisition No"  := PurchaseRequisitionHeader."No.";
                            ImprestRec.INSERT(TRUE);
                        
                          //lines
                          PurchaseReqline.RESET;
                          PurchaseReqline.SETRANGE("Document No.",PurchaseRequisitionHeader."No.");
                          IF PurchaseReqline.FINDSET THEN
                          BEGIN
                            REPEAT
                              ImprestLines.INIT;
                                ImprestLines."Document No." := ImprestRec."No.";
                                ImprestLines."Line No." := PurchaseReqline."Line No.";
                                ImprestLines."Document Type" := ImprestLines."Document Type"::Imprest;
                                ImprestLines."Imprest Code" :=  PurchaseReqline."Requisition Code";
                                ImprestLines."Imprest Code Description" := PurchaseReqline.Name;
                                ImprestLines."Account Type" := ImprestLines."Account Type"::"G/L Account";
                                ImprestLines."Account No." := PurchaseReqline."No.";
                                ImprestLines."Account Name" := PurchaseReqline.Name;
                                ImprestLines.Description := PurchaseReqline.Description;
                                ImprestLines."Posting Date" := TODAY;
                                ImprestLines."Net Amount" := PurchaseReqline."Total Cost";
                                ImprestLines.Quantity := PurchaseReqline.Quantity;
                                ImprestLines."Unit Amount" := PurchaseReqline."Unit Cost";
                                ImprestLines."Global Dimension 1 Code" := PurchaseRequisitionHeader."Global Dimension 1 Code";
                                ImprestLines."Global Dimension 2 Code"  := PurchaseRequisitionHeader."Global Dimension 2 Code";
                                ImprestLines."Employee No" := PurchaseRequisitionHeader."Employee No.";
                                ImprestLines."Gross Amount" := PurchaseReqline."Total Cost";
                                ImprestLines."Gross Amount(LCY)" := PurchaseReqline."Total Cost(LCY)";
                              ImprestLines.INSERT(TRUE);
                            UNTIL PurchaseReqline.NEXT=0;
                          END;
                            //update the requisition to closed
                            PurchaseRequisitionHeader.Status := PurchaseRequisitionHeader.Status::Closed;
                            PurchaseRequisitionHeader.MODIFY;
                        
                            MESSAGE('Imprest Requisition %1 created successfully',ImprestRec."No.");
                            ImprestRec1.RESET;
                            ImprestRec1.SETRANGE("No.",ImprestRec."No.");
                            PAGE.RUN(50023,ImprestRec1);
                            CurrPage.CLOSE();
                          END;
                        END;*/

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
                                        PurchaseRequisitionLine."No." := StoreRequisitionLine."Item No.";
                                        PurchaseRequisitionLine.Validate("No.");
                                        PurchaseRequisitionLine.Quantity := StoreRequisitionLine.Quantity;
                                        PurchaseRequisitionLine.Description := StoreRequisitionLine.Description;
                                        PurchaseRequisitionLine."Document Date" := Today;
                                        PurchaseRequisitionLine."Location Code" := StoreRequisitionLine."Location Code";
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
                                StoreRequisitionHeader.Status := StoreRequisitionHeader.Status::Approved;
                                StoreRequisitionHeader.Modify;
                                Message('Approved Store Requisition No. %1 converted successfully to Purchase Requisition No. %2', StoreRequisitionHeader."No.", PurchaseRequisitionHeader."No.");
                            end;
                        end;
                        PurchaseReqRec1.Reset;
                        PurchaseReqRec1.SetRange("No.", PurchaseRequisitionHeader."No.");
                        PAGE.Run(50411, PurchaseReqRec1);
                        CurrPage.Close(); /*
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
                action("Post and Print Store Requisition")
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
                action("Print Store Requisition")
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
                            REPORT.RunModal(REPORT::"Store Requisition II", true, false, StoreRequisitionHeader);
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
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(Rec.RecordId);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RecordId);
    end;

    trigger OnOpenPage()
    begin
        //SETRANGE("User ID",USERID);
    end;

    var
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
        Txt_001: Label 'User %1 is not setup for Inventory Posting. Contact System Administrator';
        StoreRequisitionLine: Record "Store Requisition Line";
        PurchaseRequisitionHeader: Record "Purchase Requisitions";
        PurchaseRequisitionLine: Record "Purchase Requisition Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        PurchaseReqRec1: Record "Purchase Requisitions";

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

