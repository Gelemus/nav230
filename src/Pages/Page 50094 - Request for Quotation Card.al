page 50094 "Request for Quotation Card"
{
    DeleteAllowed = false;
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Request for Quotation Header";
    SourceTableView = WHERE(Status = FILTER(Released | Open));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the unique document number for the request for quotation';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the date when the request for quotation was created';
                }
                field("Issue Date"; Rec."Issue Date")
                {
                }
                field("Closing Date"; Rec."Closing Date")
                {
                    ToolTip = 'Specifies the expected closing date for the request for quotation was created, after this date the request for quotation is considered complete and moved to the closed request for quotations';
                }
                field(Time; Time)
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the currency used for the amounts on the request for quotation';
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the estimated total amount of the request for quotation';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description for the purchase requisition';
                }
                field(Timeline; Rec.Timeline)
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the approval status for the purchase requisition';
                }
                field("Reason for Cancellation"; Rec."Reason for Cancellation")
                {
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the user who created the purchase requisition';
                }
            }
            part(Control16; "Request for Quotation Line")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ToolTip = 'Request for Quotation Line';
            }
            part(Control43; "Procurement Requirements")
            {
                SubPageLink = "Document No." = FIELD("No.");
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
            systempart(Control18; Links)
            {
                ToolTip = 'Record Links';
                Visible = false;
            }
            systempart(Control17; Notes)
            {
                ToolTip = 'Notes';
            }
        }
    }

    actions
    {
        area(creation)
        {
            ToolTip = 'NewDocumentItems';
            action("Send Email")
            {
                Caption = 'Send Email';
                Image = SendEmailPDF;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetRange("No.", Rec."No.");
                    // REPORT.RunModal(REPORT::"Email Sender-Report(RFQ)",true,false,Rec);
                end;
            }
            action("RFQ Lines Attributes")
            {
                Image = AddWatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Request for Quotation Line";
                RunPageLink = "Document No." = FIELD("No.");
                Visible = false;
            }
            action("PR Lines")
            {
                Image = AutoReserve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Requisition Line";
                RunPageLink = "Request for Quotation No." = FIELD("No.");
                Visible = false;
            }
            group(RequestforQuotation)
            {
                action(Reopen)
                {
                    Caption = 'Reopen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.TestField("User ID", UserId);
                        if Confirm(Txt_003, false, Rec."No.") then begin
                            ProcurementApprovalWorkflow.ReOpenRequestforQuotation(Rec);
                        end;
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
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.TestField("User ID", UserId);
                        ProcurementManagement.CheckRequestforQuotationMandatoryFields(Rec);
                        if Confirm(Txt_004, false, Rec."No.") then begin
                            ProcurementApprovalWorkflow.ReleaseRequestforQuotation(Rec);
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

                    trigger OnAction()
                    begin
                        if (Rec.Status = Rec.Status::Open) or (Rec.Status = Rec.Status::Released) then begin
                            Rec.TestField("Reason for Cancellation");
                            if Confirm('Are you sure you want to cancel?', true) then begin
                                /* "Cancelled By" :=USERID;
                                 "Date Cancelled" := TODAY;
                                 "Time Cancelled" := TIME;
                                 Status := Status::Cancelled;
                                 MODIFY;*/
                                Rec.Status := Rec.Status::Rejected;
                                Rec.Modify;
                                Message('Cancelled ;');
                            end;
                        end;

                    end;
                }
                action("Get Requisition Lines")
                {
                    Caption = 'Get Requisition Lines';
                    Image = GetLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Get the purchase requisition lines to add to this request for quotation';

                    trigger OnAction()
                    begin
                        Rec.TestField(Description);

                        CurrPage.Update(true);
                        InsertRFQLinesFromPurchaseRequisition();
                    end;
                }
                action("Assign Vendors")
                {
                    Caption = 'Assign Vendor(s)';
                    Image = Vendor;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Request for Quotation Vendors";
                    RunPageLink = "RFQ Document No." = FIELD("No.");
                    ToolTip = 'Assign Vendors to the Request for Quotation';

                    trigger OnAction()
                    var
                        Vends: Record Vendor;
                    begin
                    end;
                }
            }
            group("Report")
            {
                Caption = 'Report';
                ToolTip = 'Report';
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


                        /*
                        SETRANGE("No.","No.");
                        ReportSelections.Print(ReportSelections.Usage::RFQ,Rec,0);
                        */

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
                ToolTip = 'Incoming Document';
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
        area(processing)
        {
            group(ActionGroup37)
            {
                action("Create RFQ(s)")
                {
                    Caption = 'Create Quote(s)';
                    Image = Quote;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        ////IF "Request For Quotation Created" THEN ERROR('Requests for Quotation have already been Created for this Document');
                        if not Confirm('Are you sure you want to create Quote(s)?') then
                            exit;

                        PurchasesPayablesSetup.Get;
                        VendorSelection.Reset;
                        VendorSelection.SetRange("RFQ Document No.", Rec."No.");
                        if VendorSelection.FindFirst then begin
                            repeat
                                PurchaseHeader.Init;
                                PurchaseHeader."No." := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Quote Nos.", Today, true);
                                PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Quote;
                                PurchaseHeader.Validate("Buy-from Vendor No.", VendorSelection."Vendor No.");
                                PurchaseHeader."Document Date" := Today;
                                PurchaseHeader."Posting Date" := Today;
                                PurchaseHeader."Request for Quotation Code" := Rec."No.";
                                PurchaseHeader.Insert(true);

                                Lineno := 0;
                                RFQLines.Reset;
                                RFQLines.SetRange("Document No.", Rec."No.");
                                if RFQLines.FindFirst then
                                    repeat
                                        Lineno := Lineno + 1000;
                                        PurchaseLine.Init;
                                        PurchaseLine."Document No." := PurchaseHeader."No.";
                                        PurchaseLine."Line No." := Lineno;
                                        PurchaseLine."Document Type" := PurchaseHeader."Document Type";
                                        /*IF RFQLines.Type=RFQLines.Type::Item THEN
                                          PurchaseLine.Type:=PurchaseLine.Type::Item
                                        ELSE  IF RFQLines.Type=RFQLines.Type::"Non-Stock Item" THEN
                                           PurchaseLine.Type:=PurchaseLine.Type::"Fixed Asset"
                                        ELSE IF RFQLines.Type=RFQLines.Type::Service THEN
                                         PurchaseLine.Type:=PurchaseLine.Type::Item;*/
                                        PurchaseLine.Validate(Type, RFQLines.Type);

                                        PurchaseLine.Validate("No.", RFQLines."No.");
                                        PurchaseLine.Validate(Quantity, RFQLines.Quantity);
                                        PurchaseLine.Validate("Direct Unit Cost", 0);
                                        PurchaseLine.Insert(true);
                                        ;

                                    until RFQLines.Next = 0;
                                VendorSelection."Quote No" := PurchaseHeader."No.";
                                VendorSelection.Modify;
                            until VendorSelection.Next = 0;
                        end else
                            Error('Kindly select at least one Vendor');
                        Rec."Request For Quatation Created" := true;
                        Rec.Modify;
                        Message('Requests For Quotation have been successfully created');

                    end;
                }
                action("Create Order(s)")
                {
                    Image = "Order";
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if not Rec."Request For Quatation Created" then Error('Requests for Quotation have  not been Created for this Document');
                        if not Confirm('Are you sure you want to create Purchase orders for this document?') then
                            exit;
                        RFQLines.Reset;
                        RFQLines.SetRange("Document No.", Rec."No.");
                        if RFQLines.FindFirst then
                            repeat
                                RFQLines.TestField("Vendor Selected");
                            until RFQLines.Next = 0;
                        PurchasesPayablesSetup.Get;
                        PurchasesPayablesSetup.TestField("Order Nos.");
                        PurchasesPayablesSetup.TestField("Posted Receipt Nos.");
                        PurchasesPayablesSetup.TestField("Posted Invoice Nos.");
                        VendorSelection.Reset;
                        VendorSelection.SetRange("RFQ Document No.", Rec."No.");
                        if VendorSelection.FindFirst then begin
                            repeat


                                Lineno := 0;
                                RFQLines.Reset;
                                RFQLines.SetRange("Document No.", Rec."No.");
                                RFQLines.SetRange("Vendor Selected", VendorSelection."Vendor No.");
                                if RFQLines.FindFirst then begin
                                    PurchaseHeader.Init;
                                    PurchaseHeader."No." := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Order Nos.", Today, true);
                                    PurchaseHeader.Validate("No.");
                                    PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Order;
                                    PurchaseHeader.Validate("Buy-from Vendor No.", VendorSelection."Vendor No.");
                                    PurchaseHeader.Validate("Document Date", Today);
                                    PurchaseHeader.Validate("Posting Date", Today);
                                    PurchaseHeader."Request for Quotation Code" := Rec."No.";
                                    PurchaseHeader."Purchase Requisition" := RFQLines."Purchase Requisition No.";
                                    PurchaseHeader."Posting No. Series" := PurchasesPayablesSetup."Posted Invoice Nos.";
                                    PurchaseHeader."Receiving No. Series" := PurchasesPayablesSetup."Posted Receipt Nos.";
                                    PurchaseHeader.Validate("Order Date", Today);
                                    PurchaseHeader.Insert(true);
                                    repeat
                                        PurchaseLine2.SetRange("Document Type", PurchaseLine."Document Type"::Quote);
                                        PurchaseLine2.SetRange("Document No.", VendorSelection."Quote No");
                                        PurchaseLine2.SetRange("No.", RFQLines."No.");
                                        if PurchaseLine2.FindFirst then;

                                        Lineno := Lineno + 1000;
                                        PurchaseLine.Init;
                                        PurchaseLine."Document No." := PurchaseHeader."No.";
                                        PurchaseLine."Line No." := Lineno;
                                        PurchaseLine."Document Type" := PurchaseHeader."Document Type";
                                        /*
                                        IF RFQLines.Type=RFQLines.Type::Item THEN
                                          PurchaseLine.Type:=PurchaseLine.Type::Item
                                        ELSE  IF RFQLines.Type=RFQLines.Type::"Non-Stock Item" THEN
                                           PurchaseLine.Type:=PurchaseLine.Type::"Fixed Asset"
                                        ELSE IF RFQLines.Type=RFQLines.Type::Service THEN
                                         PurchaseLine.Type:=PurchaseLine.Type::Item;*/
                                        //MESSAGE(RFQLines."Requisition No");
                                        PurchaseLine.Type := RFQLines.Type;

                                        PurchaseLine.Validate("No.", RFQLines."No.");
                                        PurchaseLine.Validate(Quantity, RFQLines.Quantity);
                                        PurchaseLine.Validate("Direct Unit Cost", PurchaseLine2."Direct Unit Cost");
                                        PurchaseLine."PR NO" := RFQLines."Purchase Requisition No.";
                                        PurchaseLine."PR NO Line" := RFQLines."Purchase Requisition Line";
                                        PurchaseLine.Insert(true);
                                        ;

                                    until RFQLines.Next = 0;
                                end;

                                VendorSelection."Order No" := PurchaseHeader."No.";
                                VendorSelection.Modify;
                            until VendorSelection.Next = 0;
                        end else
                            Error('Kindly select at least one Vendor');
                        Rec.Status := Rec.Status::Closed;
                        Rec.Modify;
                        Message('Purchase Orders for this document have been successfully created');

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
        ReportSelections: Record "Report Selections";
        RFQLines: Record "Request for Quotation Line";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        VendorSelection: Record "Request for Quotation Vendors";
        Lineno: Integer;
        PurchaseHeader: Record "Purchase Header";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        PurchaseLine2: Record "Purchase Line";
        PurchaseLine: Record "Purchase Line";

    procedure InsertRFQLinesFromPurchaseRequisition()
    var
        RequisitionLines: Page "Released Purchase Req. Line";
        SelectedPurchaseRequisitionLine: Record "Purchase Requisition Line";
        Counter: Integer;
        RFQLine: Record "Request for Quotation Line";
        "LineNo.": Integer;
        RFQLine2: Record "Request for Quotation Line";
    begin
        Rec.TestField(Description);

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

    [Scope('Internal')]
    procedure SendRecords()
    var
        DocumentSendingProfile: Record "Document Sending Profile";
        DummyReportSelections: Record "Report Selections";
    begin
        /*CheckMixedDropShipment;
        
        DocumentSendingProfile.SendVendorRecords(
          DummyReportSelections.Usage::"P.Order",Rec,DocTxt,"Buy-from Vendor No.","No.",
          FIELDNO("Buy-from Vendor No."),FIELDNO("No."));*/

    end;
}

