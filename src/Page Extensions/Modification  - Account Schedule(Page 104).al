pageextension 60012 pageextension60012 extends "Account Schedule"
{
    layout
    {
        addafter("Row No.")
        {
            field("G/L Account"; Rec."G/L Account")
            {
            }
        }
        addafter(Description)
        {
            field(Notes; Rec.Notes)
            {
            }
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "SetAccSchedName(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "SetupAccSchedLine(PROCEDURE 3)".

}

