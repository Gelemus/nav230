page 50093 "Request for Quotation List"
{
    CardPageID = "Request for Quotation Card";
    DeleteAllowed = false;
    PageType = List;
    ShowFilter = false;
    ApplicationArea = All;
    SourceTable = "Request for Quotation Header";
    SourceTableView = WHERE(Status = FILTER(<> Closed));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the unique document number';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the date when the request for quotation was created';
                }
                field(Type; Rec.Type)
                {
                    ShowMandatory = true;
                }
                field("Issue Date"; Rec."Issue Date")
                {
                }
                field("Closing Date"; Rec."Closing Date")
                {
                    ToolTip = 'Specifies the expected closing date for the request for quotation was created, after this date the request for quotation is considered complete and moved to the closed request for quotations';
                }
                field(Description; Rec.Description)
                {
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the approval status for the request for quotation';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the user who created the request for quotation';
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
                ToolTip = 'Incoming Document Attach FactBox';
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
            systempart(Control20; Links)
            {
                ToolTip = 'Record Links';
                Visible = false;
            }
            systempart(Control19; Notes)
            {
                ToolTip = 'Notes';
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Reopen)
            {
                Caption = 'Reopen';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                trigger OnAction()
                begin
                    /*TESTFIELD("User ID",USERID);
                    IF CONFIRM(Txt_003,FALSE,"No.") THEN BEGIN
                      ProcurementApprovalWorkflow.ReOpenRequestforQuotation(Rec);
                    END;
                    */

                end;
            }
            action(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Release the document to the next stage of processing. When a document is released, it will be included in all availability calculations from the expected receipt date of the items. You must reopen the document before you can make changes to it.';

                trigger OnAction()
                begin
                    /*TESTFIELD("User ID",USERID);
                    ProcurementManagement.CheckRequestforQuotationMandatoryFields(Rec);
                    IF CONFIRM(Txt_004,FALSE,"No.") THEN BEGIN
                      ProcurementApprovalWorkflow.ReleaseRequestforQuotation(Rec);
                    END;
                    */

                end;
            }
            action("Get Requisition Lines")
            {
                Caption = 'Get Requisition Lines';
                Image = GetLines;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Get the purchase requisition lines to add to this request for quotation';
                Visible = false;

                trigger OnAction()
                begin
                    Rec.TestField(Description);

                    CurrPage.Update(true);
                    InsertRFQLinesFromPurchaseRequisition();
                end;
            }
            group("Report")
            {
                Caption = 'Report';
                action("Print Request for Quotation")
                {
                    Caption = 'Print Request for Quotation';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ToolTip = 'Prepare to print the document. A report request window where you can specify what to include on the print-out.';

                    trigger OnAction()
                    begin
                        RequestforQuotationHeader.Reset;
                        RequestforQuotationHeader.SetRange(RequestforQuotationHeader."No.", Rec."No.");
                        if RequestforQuotationHeader.FindFirst then begin
                            REPORT.RunModal(REPORT::"Request for Quatation Report", true, false, RequestforQuotationHeader);
                        end;
                    end;
                }
                action("Print Bid Analysis")
                {
                    Caption = 'Print Bid Analysis';
                    Image = Bins;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ToolTip = 'Prepare to print the document. A report request window where you can specify what to include on the print-out.';

                    trigger OnAction()
                    begin
                        RequestforQuotationHeader.Reset;
                        RequestforQuotationHeader.SetRange(RequestforQuotationHeader."No.", Rec."No.");
                        if RequestforQuotationHeader.FindFirst then begin
                            REPORT.RunModal(REPORT::"Bids Analysis", true, false, RequestforQuotationHeader);
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
                        //IncomingDocumentAttachment.NewAttachmentFromRequestForQuotationDocument(Rec);
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
        /*RequestforQuotationHeader.RESET;
        RequestforQuotationHeader.SETRANGE("User ID",USERID);
        RequestforQuotationHeader.SETRANGE(Status,RequestforQuotationHeader.Status::Open);
        IF RequestforQuotationHeader.FINDFIRST THEN BEGIN
          ERROR(Txt_002);
        END;
        */

    end;

    trigger OnOpenPage()
    begin
        //SETRANGE("User ID",USERID);
    end;

    var
        PurchaseRequisitionLines: Record "Purchase Requisition Line";
        ProcurementManagement: Codeunit "Procurement Management";
        ProcurementApprovalWorkflow: Codeunit "Procurement Approval Manager";
        RequestforQuotationHeader: Record "Request for Quotation Header";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ",Payment,Receipt,Imprest,"Imprest Surrender","Funds Refund","Purchase Requisition";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
        Txt_002: Label 'There is an open request for quotation under your name, use it before you create a new one';
        Txt_003: Label 'Reopen Request for Quotation No.:%1';
        Txt_004: Label 'Release Request for Quotation No.:%1';

    procedure InsertRFQLinesFromPurchaseRequisition()
    var
        RequisitionLines: Page "Released Purchase Req. Line";
        SelectedPurchaseRequisitionLine: Record "Purchase Requisition Line";
        Counter: Integer;
        RFQLine: Record "Request for Quotation Line";
        "LineNo.": Integer;
        RFQLine2: Record "Request for Quotation Line";
    begin
        //Get Last Line No.
        RFQLine2.Reset;
        RFQLine2.SetRange(RFQLine2."Document No.", Rec."No.");
        RFQLine2.SetCurrentKey("Document No.", "Line No.");
        if RFQLine2.FindLast then begin
            "LineNo." := RFQLine2."Line No.";
        end else begin
            "LineNo." := 1000;
        end;
        //End Get Last Line No.
        RequisitionLines.LookupMode(true);
        if RequisitionLines.RunModal = ACTION::LookupOK then begin
            RequisitionLines.SetSelection(SelectedPurchaseRequisitionLine);
            Counter := SelectedPurchaseRequisitionLine.Count;
            if Counter > 0 then begin
                if SelectedPurchaseRequisitionLine.FindSet then
                    repeat
                        "LineNo." := "LineNo." + 1;
                        RFQLine.Init;
                        RFQLine."Line No." := "LineNo.";
                        RFQLine."Document No." := Rec."No.";
                        RFQLine."Document Date" := Rec."Document Date";
                        RFQLine."Requisition Type" := SelectedPurchaseRequisitionLine."Requisition Type";
                        RFQLine."Requisition Code" := SelectedPurchaseRequisitionLine."Requisition Code";
                        if RFQLine."Requisition Type" = RFQLine."Requisition Type"::Service then begin
                            RFQLine.Type := RFQLine.Type::"G/L Account";
                        end;
                        if RFQLine."Requisition Type" = RFQLine."Requisition Type"::Item then begin
                            RFQLine.Type := RFQLine.Type::Item;
                        end;
                        if RFQLine."Requisition Type" = RFQLine."Requisition Type"::"Fixed Asset" then begin
                            RFQLine.Type := RFQLine.Type::"Fixed Asset";
                        end;
                        RFQLine."No." := SelectedPurchaseRequisitionLine."No.";
                        RFQLine.Name := SelectedPurchaseRequisitionLine.Name;
                        RFQLine."Location Code" := SelectedPurchaseRequisitionLine."Location Code";
                        RFQLine."Unit of Measure Code" := SelectedPurchaseRequisitionLine."Unit of Measure";
                        RFQLine.Quantity := SelectedPurchaseRequisitionLine.Quantity;
                        RFQLine."Currency Code" := SelectedPurchaseRequisitionLine."Currency Code";
                        RFQLine."Currency Factor" := SelectedPurchaseRequisitionLine."Currency Factor";
                        RFQLine."Unit Cost" := SelectedPurchaseRequisitionLine."Unit Cost";
                        RFQLine."Unit Cost(LCY)" := SelectedPurchaseRequisitionLine."Unit Cost(LCY)";
                        RFQLine."Total Cost" := SelectedPurchaseRequisitionLine."Total Cost";
                        RFQLine."Total Cost(LCY)" := SelectedPurchaseRequisitionLine."Total Cost(LCY)";
                        RFQLine.Description := SelectedPurchaseRequisitionLine.Description;
                        RFQLine."Global Dimension 1 Code" := SelectedPurchaseRequisitionLine."Global Dimension 1 Code";
                        RFQLine."Global Dimension 2 Code" := SelectedPurchaseRequisitionLine."Global Dimension 2 Code";
                        RFQLine."Shortcut Dimension 3 Code" := SelectedPurchaseRequisitionLine."Shortcut Dimension 3 Code";
                        RFQLine."Shortcut Dimension 4 Code" := SelectedPurchaseRequisitionLine."Shortcut Dimension 4 Code";
                        RFQLine."Shortcut Dimension 5 Code" := SelectedPurchaseRequisitionLine."Shortcut Dimension 5 Code";
                        RFQLine."Shortcut Dimension 6 Code" := SelectedPurchaseRequisitionLine."Shortcut Dimension 6 Code";
                        RFQLine."Shortcut Dimension 7 Code" := SelectedPurchaseRequisitionLine."Shortcut Dimension 7 Code";
                        RFQLine."Shortcut Dimension 8 Code" := SelectedPurchaseRequisitionLine."Shortcut Dimension 8 Code";
                        RFQLine."Responsibility Center" := SelectedPurchaseRequisitionLine."Responsibility Center";
                        RFQLine."Purchase Requisition Line" := SelectedPurchaseRequisitionLine."Line No.";
                        RFQLine."Purchase Requisition No." := SelectedPurchaseRequisitionLine."Document No.";
                        if RFQLine.Insert then begin
                            PurchaseRequisitionLines.Reset;
                            PurchaseRequisitionLines.SetRange(PurchaseRequisitionLines."Line No.", SelectedPurchaseRequisitionLine."Line No.");
                            PurchaseRequisitionLines.SetRange(PurchaseRequisitionLines."Document No.", SelectedPurchaseRequisitionLine."Document No.");
                            PurchaseRequisitionLines.SetRange(PurchaseRequisitionLines."Requisition Code", SelectedPurchaseRequisitionLine."Requisition Code");
                            if PurchaseRequisitionLines.FindFirst then begin
                                PurchaseRequisitionLines.Closed := true;
                                PurchaseRequisitionLines."Request for Quotation No." := Rec."No.";
                                PurchaseRequisitionLines."Request for Quotation Line" := "LineNo.";
                                PurchaseRequisitionLines.Modify;
                            end;
                        end;
                    until SelectedPurchaseRequisitionLine.Next = 0;
            end;
        end;
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

