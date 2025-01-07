pageextension 60280 pageextension60280 extends "Inventory Setup"
{
    layout
    {
        addafter("Location Mandatory")
        {
            field("Location Code for templates"; Rec."Location Code for templates")
            {
            }
        }
        addafter("Posted Invt. Put-away Nos.")
        {
            field("Stores Requisition Nos."; Rec."Stores Requisition Nos.")
            {
                ApplicationArea = All;
            }
            field("Return Store Requisition Nos."; Rec."Return Store Requisition Nos.")
            {
                ApplicationArea = All;
            }
            field("Donation Nos."; Rec."Donation Nos.")
            {
                ApplicationArea = All;
            }
            field("Bottled Water Nos."; Rec."Bottled Water Nos.")
            {
                ApplicationArea = All;
            }
            field("Store Issue Note Nos."; Rec."Store Issue Note Nos.")
            {
                ApplicationArea = All;
            }
            field(Returnable; Rec.Returnable)
            {

            }

        }
    }
}

