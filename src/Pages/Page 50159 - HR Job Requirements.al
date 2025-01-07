page 50159 "HR Job Requirements"
{
    PageType = ListPart;
    ShowFilter = false;
    SourceTable = "HR Job Requirements";

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
                field("Requirement Code"; Rec."Requirement Code")
                {
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description for the requirement code.';
                }
                field("No. of Years"; Rec."No. of Years")
                {
                    Visible = true;
                }
                field(Mandatory; Rec.Mandatory)
                {
                    Visible = true;
                }
            }
        }
    }

    actions
    {
    }
}

