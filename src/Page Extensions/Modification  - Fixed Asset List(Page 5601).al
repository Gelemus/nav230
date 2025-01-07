pageextension 60401 pageextension60401 extends "Fixed Asset List"
{
    Editable = true;
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on ""FA Location Code"(Control 33)".

        addafter("Responsible Employee")
        {
            field("Registration No."; Rec."Registration No.")
            {
            }
        }
        addafter("Search Description")
        {
            field("Serial No."; Rec."Serial No.")
            {
            }
        }
        moveafter(Description; "Responsible Employee")
        moveafter("Responsible Employee"; "FA Subclass Code")
        moveafter("FA Subclass Code"; Acquired)
        moveafter(Acquired; "FA Location Code")
        moveafter("FA Location Code"; "FA Class Code")
        moveafter("FA Class Code"; "Budgeted Asset")
        moveafter("Search Description"; "Maintenance Vendor No.")
    }
    actions
    {
        modify("Fixed Assets List")
        {
            Visible = false;
        }
        modify("Acquisition List")
        {

            //Unsupported feature: Property Modification (Name) on ""Acquisition List"(Action 1903109606)".

            Caption = 'Fixed Asset - Aquisition List';

            //Unsupported feature: Property Modification (RunObject) on ""Acquisition List"(Action 1903109606)".

        }
        modify(Details)
        {

            //Unsupported feature: Property Modification (Name) on "Details(Action 1901902606)".

            Caption = 'Fixed Asset - Details';

            //Unsupported feature: Property Modification (RunObject) on "Details(Action 1901902606)".

        }
        modify("FA Book Val. - Appr. & Write-D")
        {
            Visible = false;
        }
        modify(Analysis)
        {

            //Unsupported feature: Property Modification (Name) on "Analysis(Action 1901105406)".

            Caption = ' Fixed Asset - Analysis';

            //Unsupported feature: Property Modification (RunObject) on "Analysis(Action 1901105406)".

        }
        modify("Projected Value")
        {
            Visible = false;
        }
        modify("G/L Analysis")
        {
            Visible = false;
        }
    }

    var
        UserSetup: Record "User Setup";
        PemissionDenied: Label 'You are not setup to Create Fixed Assets. Contact System Administrator';


    //Unsupported feature: Code Insertion on "OnNewRecord".

    //trigger OnNewRecord(BelowxRec: Boolean)
    //begin
    /*
    //Check if is allowed to create
    if UserSetup.Get(UserId) then begin
      if not UserSetup."Fixed Asset  Creation" then
        Error(PemissionDenied);
     end;
     // End Check if is allowed to create
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "GetSelectionFilter(PROCEDURE 6)".

}

