page 50182 "Interview Header List"
{
    CardPageID = "Interview Header Card";
    PageType = List;
    SourceTable = "Interview Attendance Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Interview No"; Rec."Interview No")
                {
                }
                field("Interview Committee code"; Rec."Interview Committee code")
                {
                }
                field("Interview Committee Name"; Rec."Interview Committee Name")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control7; MyNotes)
            {
            }
            systempart(Control8; Links)
            {
            }
        }
    }

    actions
    {
    }
}

