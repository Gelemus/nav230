page 50674 "Vendor Categories"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Supplier Category";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Number"; Rec."Document Number")
                {
                }
                field(Decription; Rec.Decription)
                {
                }
            }
        }
    }

    actions
    {
    }
}

