pageextension 60295 pageextension60295 extends "Purchase Order"
{

    //Unsupported feature: Property Insertion (DeleteAllowed) on ""Purchase Order"(Page 50)".

    layout
    {
        modify("No.")
        {
            Editable = false;
        }

        //Unsupported feature: Property Modification (ImplicitType) on ""Buy-from Vendor Name"(Control 6)".

        modify("Posting Description")
        {

            ShowMandatory = true;
            Visible = true;
            Enabled = true;
        }

        //Unsupported feature: Property Modification (ImplicitType) on ""Buy-from Address"(Control 89)".


        //Unsupported feature: Property Modification (Level) on ""Buy-from County"(Control 121)".


        //Unsupported feature: Property Modification (Level) on ""Buy-from Contact"(Control 8)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Buy-from Contact"(Control 8)".

        modify("Document Date")
        {
            Importance = Standard;
            Editable = false;
        }
        modify("Posting Date")
        {
            Importance = Standard;
            // ShowMandatory = VendorInvoiceNoMandatory;
        }
        modify("Due Date")
        {
            Caption = 'Required On';
        }
        modify(Status)
        {
            Editable = false;
        }

        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Name"(Control 42)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Address"(Control 44)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Contact"(Control 50)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Pay-to Name"(Control 24)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Pay-to Address"(Control 26)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Pay-to Contact"(Control 32)".


        //Unsupported feature: Property Deletion (Visible) on ""Posting Description"(Control 110)".

        addafter("Buy-from Vendor No.")
        {
            field("Vendor Email"; Rec."Vendor Email")
            {
            }
        }
        addafter("Buy-from City")
        {
            field(Email; Rec."Vendor Email")
            {
            }
            field("Phone Number"; Rec."Vendor Phone Number")
            {
            }
        }
        addafter("Buy-from Contact No.")
        {
            field("Receiving No. Series"; Rec."Receiving No. Series")
            {
            }
        }
        addafter("Buy-from Contact")
        {
            field("Purchase Requisition"; Rec."Purchase Requisition")
            {
            }
            field("position Title"; Rec."position Title")
            {
                Visible = false;
            }
            field("Reference No"; Rec."Reference No")
            {
            }
        }
        addafter("Vendor Invoice No.")
        {
            field("Vendor Account No"; Rec."Vendor Account No")
            {
            }
            field("Delivery Note No."; Rec."Delivery Note No.")
            {
                // ShowMandatory = VendorInvoiceNoMandatory;
            }
            field("Inspection No"; Rec."Inspection No")
            {
                // ShowMandatory = VendorInvoiceNoMandatory;
            }
        }
        addafter("Assigned User ID")
        {
            field("User ID"; Rec."User ID")
            {
                Caption = 'User ID';
                Visible = true;
                Enabled = true;

            }
            field("Reason for Cancellation"; Rec."Reason for Cancellation")
            {
            }
            field("Cancelled By"; Rec."Cancelled By")
            {
                Editable = false;
            }
            field("Date Cancelled"; Rec."Date Cancelled")
            {
                Editable = false;
            }
        }
        moveafter("Buy-from Contact"; "Purchaser Code")
        moveafter("Purchaser Code"; "Order Date")
        moveafter("Order Date"; "Due Date")

        addafter(PurchLines)
        {
            part("Approval Enttries I"; "Approval Enttries I")
            {
                Caption = 'Approval Entries';
                SubPageLink = "Document No." = FIELD("No.");
                ToolTip = 'Approval Entries';
            }
        }

    }

    actions
    {
        modify("&Print")
        {

            Caption = '&Print LPO';
            Visible = false;
            Enabled = false;
            Promoted = false;
        }
        modify(Release)
        {

            Visible = false;
        }

        addafter(Reopen)
        {
            action(Cancel)
            {
                Image = CancelledEntries;
                Promoted = true;

                trigger OnAction()
                begin
                    Rec.TestField("Reason for Cancellation");
                    if Confirm('Are you sure you want to cancel?', true) then begin
                        Rec.Status := Rec.Status::Released;
                        Rec."Cancelled By" := UserId;
                        Rec."Date Cancelled" := Today;
                        Rec.Modify;
                        Message('Cancelled Successfully');
                    end;
                end;
            }
            action(ReleseDocument)
            {
                Image = CancelledEntries;
                Promoted = true;
                Enabled = true;
                Visible = true;
                Caption = 'Release Document';

                trigger OnAction()
                begin
                    //Rec.TestField("Reason for Cancellation");
                    if Confirm('Are you sure you want to Release?', true) then begin
                        Rec.Status := Rec.Status::Released;
                        // Rec."Cancelled By" := UserId;
                        // Rec."Date Cancelled" := Today;
                        Rec.Modify;
                        Message('Released Successfully');
                    end;
                end;
            }
        }
        addbefore(AttachAsPDF)
        {
            action("&Print LPO")
            {
                ApplicationArea = Suite;
                Caption = '&Print LPO';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category10;
                ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                    LPO: Report "New Purchase Order";

                begin
                    PurchaseHeader.Reset;
                    PurchaseHeader.SetRange("No.", Rec."No.");
                    Clear(LPO);
                    CurrPage.SETSELECTIONFILTER(PurchaseHeader);
                    PurchaseHeader.PrintRecords(TRUE);
                    LPO.SetTableView(PurchaseHeader);
                    LPO.Run
                end;
            }
            action("&Print LSO")
            {
                ApplicationArea = Suite;
                Caption = '&Print LSO';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category10;
                ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                    LPO: Report "New Purchase Order";
                    LSO: Report "New Service Order";
                begin
                    PurchaseHeader.Reset;
                    PurchaseHeader.SetRange("No.", Rec."No.");
                    Clear(LSO);
                    CurrPage.SETSELECTIONFILTER(PurchaseHeader);
                    PurchaseHeader.PrintRecords(TRUE);
                    LSO.SetTableView(PurchaseHeader);
                    LSO.Run
                end;
            }
        }

    }

    var
        LPO: Report "New Purchase Order";
    //LSO: Report "New Service Order";

    var
        LSO: Report "New Service Order";
        Purchaseline: Record "Purchase Line";
        InspectionNoMandatory: Boolean;
}



