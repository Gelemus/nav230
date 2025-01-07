pageextension 60424 pageextension60424 extends "Transfer Order Subform"
{
    layout
    {
        modify("Reserved Quantity Inbnd.")
        {
            Visible = false;
        }
        modify("Reserved Quantity Shipped")
        {
            Visible = false;
        }
        modify("Reserved Quantity Outbnd.")
        {
            Visible = false;
        }
        addafter("Transfer-To Bin Code")
        {
            field(Inventory; Rec.Inventory)
            {
            }
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "UpdateForm(PROCEDURE 2)".

}

