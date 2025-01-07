pageextension 60230 pageextension60230 extends "Item Card"
{
    layout
    {
        modify("Unit Cost")
        {
            Editable = PriceEditable;
        }

        //Unsupported feature: Property Deletion (Enabled) on ""Unit Cost"(Control 30)".

        addafter(Blocked)
        {
            field("Meter Size (Inches)"; Rec."Meter Size (Inches)")
            {
                Visible = false;
            }
        }
        addafter("Automatic Ext. Texts")
        {
            field("Item G/L Budget Account"; Rec."Item G/L Budget Account")
            {
            }
            field("Is Connection Item"; Rec."Is Connection Item")
            {
                Visible = false;
            }
            field("NEW CONNECTIONS"; Rec."NEW CONNECTIONS")
            {
                Caption = 'new Connection';
            }
            field("Sequence New Connections"; Rec."Sequence New Connections")
            {
            }
            field("New Connection Quantity"; Rec."New Connection Quantity")
            {
            }
        }
        addfirst("Prices & Sales")
        {
            field("Market Price"; Rec."Market Price")
            {
            }
        }
    }

    var
        UserSetup: Record "User Setup";
        PemissionDenied: Label 'You are not setup to Create Items. Contact System Administrator';


    //Unsupported feature: Code Modification on "OnNewRecord".

    //trigger OnNewRecord(BelowxRec: Boolean)
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnNewRec
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //Check if is allowed to create Item
    if UserSetup.Get(UserId) then begin
      if not UserSetup."Item Creation" then
        Error(PemissionDenied);
     end;
     // End Check if is allowed to create Item

    OnNewRec
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCreateItemFromTemplate(PROCEDURE 9)".

}

