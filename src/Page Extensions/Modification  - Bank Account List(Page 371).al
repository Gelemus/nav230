pageextension 60249 pageextension60249 extends "Bank Account List"
{
    layout
    {

        //Unsupported feature: Property Modification (Name) on ""Currency Code"(Control 8)".


        //Unsupported feature: Property Modification (SourceExpr) on ""Currency Code"(Control 8)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Currency Code"(Control 8)".

        modify(OnlineFeedStatementStatus)
        {
            Visible = false;
        }
        modify("Post Code")
        {
            Visible = false;
        }
        modify("Country/Region Code")
        {
            Visible = false;
        }
        modify("Phone No.")
        {
            Visible = false;
        }
        modify("Fax No.")
        {
            Visible = false;
        }
        modify(Contact)
        {
            Visible = false;
        }
        // modify("Bank Account No.")
        // {
        //     Visible = false;
        // }
        modify("SWIFT Code")
        {
            Visible = false;
        }
        modify(IBAN)
        {
            Visible = false;
        }
        modify("Our Contact Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 8)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Currency Code"(Control 8)".


        //Unsupported feature: Property Deletion (Visible) on ""Currency Code"(Control 8)".

        modify("Language Code")
        {
            Visible = false;
        }
        modify("Search Name")
        {
            Visible = false;
        }
        addafter(Name)
        {
            // field("Bank Account No."; Rec."Bank Account No.")
            // {
            // }
            field(Control32; Rec.Balance)
            {
                ShowCaption = false;
            }
        }
    }

    var
        UserSetup: Record "User Setup";
        PemissionDenied: Label 'You are not setup to Create Chart of Accountss. Contact System Administrator';


    //Unsupported feature: Code Insertion on "OnNewRecord".

    //trigger OnNewRecord(BelowxRec: Boolean)
    //begin
    /*
    //Check if is allowed to create
    if UserSetup.Get(UserId) then begin
      if not UserSetup."Bank Account  Creation" then
        Error(PemissionDenied);
     end;
     // End Check if is allowed to create
    */
    //end;
}

