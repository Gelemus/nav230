page 50225 "Leave Allocation Line"
{
    Editable = true;
    PageType = ListPart;
    SourceTable = "HR Leave Allocation Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'No.';
                }

                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the Employee Name.';
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ToolTip = 'Specifies the entry Type.';
                }
                field("New Days Allocated"; Rec."Days Allocated")
                {
                    ToolTip = 'Specifies the Days allocated.';
                }
                field("New Days Approved"; Rec."Days Approved")
                {
                    Editable = true;
                    ToolTip = 'Specifies the Days approved.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description.';
                }

            }
        }
    }
}



