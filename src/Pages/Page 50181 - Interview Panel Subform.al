page 50181 "Interview Panel Subform"
{
    PageType = ListPart;
    SourceTable = "Interview Committee Dept Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No"; Rec."Line No")
                {
                    Visible = false;
                }
                field("Code"; Rec.Code)
                {
                    Visible = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
            }
        }
    }

    actions
    {
    }
}

