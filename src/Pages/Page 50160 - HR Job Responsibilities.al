page 50160 "HR Job Responsibilities"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "HR Job Responsibilities";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job No."; Rec."Job No.")
                {
                    ToolTip = 'Specifies the Job Number.';
                    Visible = false;
                }
                field("Responsibility Type"; Rec."Responsibility Type")
                {
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description on the responsibility code.';
                }
            }
        }
    }

    actions
    {
    }
}

