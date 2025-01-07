pageextension 60078 pageextension60078 extends "Posted Purchase Rcpt. Subform"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on "Description(Control 6)".

        addfirst(Control1)
        {
            field("Line No."; Rec."Line No.")
            {
            }
        }
        addafter(Description)
        {
            // field("Description 2"; Rec."Description 2")
            // {
            // }
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "ShowDocumentLineTracking(PROCEDURE 14)".

}

