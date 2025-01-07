pageextension 60400 pageextension60400 extends "Fixed Asset Card"
{
    layout
    {

        //Unsupported feature: Property Modification (Level) on ""FA Class Code"(Control 43)".


        //Unsupported feature: Property Modification (Level) on ""FA Subclass Code"(Control 45)".


        //Unsupported feature: Property Modification (ImplicitType) on ""FA Location Code"(Control 52)".

        addafter(Description)
        {
            field("FA Tag No."; Rec."FA Tag No.")
            {
            }
        }
        addafter(Control34)
        {
            field("Location Code"; Rec."Location Code")
            {
                Visible = false;
            }
        }
        addafter("Budgeted Asset")
        {
            field("Registration No."; Rec."Registration No.")
            {
            }
            field("Asset Condition"; Rec."Asset Condition")
            {
            }
        }
        addafter("Serial No.")
        {
            field(Model; Rec.Model)
            {
            }
            field("Year of Manufacture"; Rec."Year of Manufacture")
            {
            }
            field("Logbook No."; Rec."Logbook No.")
            {
            }
            field("Booking Status"; Rec."Booking Status")
            {
            }
            field("Body Type"; Rec."Body Type")
            {
            }
            field("Color of  Body"; Rec."Color of  Body")
            {
            }
            field("Chasses No."; Rec."Chasses No.")
            {
            }
            field("Engine No."; Rec."Engine No.")
            {
            }
            field("Propelled By"; Rec."Propelled By")
            {
            }
        }
        addafter(Blocked)
        {
            field("Transport Type"; Rec."Transport Type")
            {
            }
        }
        addafter(Acquired)
        {
            field("Tyre Size"; Rec."Tyre Size")
            {
            }
            field("Fuel Type"; Rec."Fuel Type")
            {
            }
            field(Make; Rec.Make)
            {
            }
            field("Specialized use of the vehicle"; Rec."Specialized use of the vehicle")
            {
            }
            field("Specialized system"; Rec."Specialized system")
            {
            }
            field(Control78; Rec.Insurance)
            {
                ShowCaption = false;
            }
            field("Asset No"; Rec."Asset No")
            {
            }
            field("I.D NO."; Rec."I.D NO.")
            {
            }
            field(Dimension; Rec.Dimension)
            {
            }
            field(Supplier; Rec.Supplier)
            {
            }
            field("Nature of Ownership"; Rec."Nature of Ownership")
            {
            }
            field("Purchase Date"; Rec."Purchase Date")
            {
            }
            field("Completion Date"; Rec."Completion Date")
            {
            }
            field("Date of disposal"; Rec."Date of disposal")
            {
            }
        }
        addafter(NumberOfDepreciationYears)
        {
            field("Straight Line %"; FADepreciationBook."Straight-Line %")
            {
            }
            field("Declining Balance %"; FADepreciationBook."Declining-Balance %")
            {
            }
        }
        moveafter(Control34; "FA Subclass Code")
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
}

