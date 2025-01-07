pageextension 60324 pageextension60324 extends "Purchase Lines"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on "Description(Control 23)".

        modify("Reserved Qty. (Base)")
        {
            Editable = true;
        }
        modify("Amt. Rcd. Not Invoiced (LCY)")
        {
            Editable = true;
        }
        addafter(Description)
        {
            //     field("Description 2"; Rec."Description 2")
            //     {
            //     }
        }
    }
}

