page 50457 "Repair Order Subform"
{
    PageType = ListPart;
    SourceTable = "Travelling Employee";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Description; Rec.Description)
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Price per Unit"; Rec."Price per Unit")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
            }
        }
    }

    actions
    {
    }
}

