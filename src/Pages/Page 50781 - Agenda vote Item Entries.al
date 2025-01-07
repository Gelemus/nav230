page 50781 "Agenda vote Item Entries"
{
    Editable = false;
    PageType = List;
    SourceTable = "Agenda Item Voters";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Agenda Vote Item code"; Rec."Agenda Vote Item code")
                {
                }
                field("Agenda No"; Rec."Agenda No")
                {
                }
                field("Meeting No"; Rec."Meeting No")
                {
                }
                field("Voter ID"; Rec."Voter ID")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Voted; Rec.Voted)
                {
                }
                field("Vote decision"; Rec."Vote decision")
                {
                }
            }
        }
    }

    actions
    {
    }
}

