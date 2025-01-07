page 51208 "Employee grades"
{
    PageType = List;
    SourceTable = "Employee Grades2";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Grade Code"; Rec."Grade Code")
                {
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                }
                field("OT Qualifying"; Rec."OT Qualifying")
                {
                }
                field("Leave Travel Allowance"; Rec."Leave Travel Allowance")
                {
                }
                field("Grade 0"; Rec."Grade 0")
                {
                }
                field("Grade 1 - 5"; Rec."Grade 1 - 5")
                {
                }
                field(Management; Rec.Management)
                {
                }
            }
        }
    }

    actions
    {
    }
}

