page 52251 "Project Implementataion Lines"
{
    PageType = ListPart;
    SourceTable = "Project Implementation Lines";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Line No."; Rec."Line No.")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Planning Line No."; Rec."Planning Line No.")
                {
                }
                field(Plan; Rec.Plan)
                {
                }
                field("Action"; Rec.Action)
                {
                }
                field("Action Description"; Rec."Action Description")
                {
                }
                field("Actual Cost"; Rec."Actual Cost")
                {
                }
            }
        }
    }

    actions
    {
    }
}

