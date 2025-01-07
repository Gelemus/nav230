pageextension 60255 pageextension60255 extends "Bank Acc. Reconciliation Lines"
{
    layout
    {

        //Unsupported feature: Property Deletion (Visible) on ""Document No."(Control 24)".

        addafter(Description)
        {
            field("Payee Details"; Rec."Payee Details")
            {
            }
        }
        addafter("Additional Transaction Info")
        {
            field("Statement Line No."; Rec."Statement Line No.")
            {
            }
        }
    }


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetUserInteractions;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetUserInteractions;

    CalcFields(Payee);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "GetSelectedRecords(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "ToggleMatchedFilter(PROCEDURE 1)".

}

