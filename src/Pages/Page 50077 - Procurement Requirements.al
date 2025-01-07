page 50077 "Procurement Requirements"
{
    PageType = ListPart;
    SourceTable = "Procurement Requirements";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}

