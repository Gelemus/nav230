page 50260 "Training Group Line"
{
    Caption = 'Training Group Participants';
    PageType = ListPart;
    SourceTable = "HR Training Group Participants";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Training Group No."; Rec."Training Group No.")
                {
                    Visible = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Job Tittle"; Rec."Job Tittle")
                {
                }
                field("E-mail Address"; Rec."E-mail Address")
                {
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                }
            }
        }
    }

    actions
    {
    }
}

