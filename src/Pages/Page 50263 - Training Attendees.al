page 50263 "Training Attendees"
{
    PageType = ListPart;
    SourceTable = "HR Training Attendees";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No."; Rec."Application No.")
                {
                    Visible = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Job Title"; Rec."Job Title")
                {
                }
                field("E-mail Address"; Rec."E-mail Address")
                {
                }
                field("Phone Number"; Rec."Phone Number")
                {
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                }
                field("Actual Training Cost"; Rec."Actual Training Cost")
                {
                }
            }
        }
    }

    actions
    {
    }
}

