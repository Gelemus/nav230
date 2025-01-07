page 50683 "Board Committee Members"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Board Committee Members";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Committee Code"; Rec."Committee Code")
                {
                }
                field("Member No"; Rec."Member No")
                {
                }
                field("Member Name"; Rec."Member Name")
                {
                    Editable = false;
                }
                field(Designation; Rec.Designation)
                {
                }
                field(Role; Rec.Role)
                {
                }
                field(Comments; Rec.Comments)
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
        }
    }
}

