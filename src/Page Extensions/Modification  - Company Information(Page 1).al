pageextension 60001 pageextension60001 extends "Company Information"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on ""Address 2"(Control 6)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Phone No."(Control 10)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Phone No.2"(Control 50)".

        addafter("Phone No.2")
        {
            field("Phone No. 2"; Rec."Phone No. 2")
            {
            }
            field("Telephone No."; Rec."Telephone No.")
            {
            }
        }
        addafter("E-Mail")
        {
            field("E-Mail 2"; Rec."E-Mail 2")
            {
            }
        }
        addafter("Ship-to Country/Region Code")
        {
            field(Control65; '')
            {
                ShowCaption = false;
            }
        }
    }
}

