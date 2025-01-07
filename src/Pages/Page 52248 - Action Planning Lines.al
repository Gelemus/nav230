page 52248 "Action Planning Lines"
{
    PageType = ListPart;
    SourceTable = "Action Planning Lines";

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
                field("Plan Date"; Rec."Plan Date")
                {
                }
                field(Plan; Rec.Plan)
                {
                }
                field("Plan Description"; Rec."Plan Description")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Budget Amount"; Rec."Budget Amount")
                {
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

