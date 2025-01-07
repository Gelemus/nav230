page 50099 "Procurement User Setup"
{
    PageType = List;
    SourceTable = "Procurement User Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(UserID; UserID)
                {
                }
                field("Procurement Journal Template"; Rec."Procurement Journal Template")
                {
                }
                field("Procurement Journal Batch"; Rec."Procurement Journal Batch")
                {
                }
            }
        }
    }

    actions
    {
    }
}

