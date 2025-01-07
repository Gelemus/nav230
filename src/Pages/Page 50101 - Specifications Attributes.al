page 50101 "Specifications Attributes"
{
    PageType = List;
    SourceTable = "Specification Attributes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Specification; Rec.Specification)
                {
                }
                field(Requirement; Rec.Requirement)
                {
                }
            }
        }
    }

    actions
    {
    }
}

