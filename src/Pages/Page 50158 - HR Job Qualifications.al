page 50158 "HR Job Qualifications"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "HR Job Qualifications";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job No."; Rec."Job No.")
                {
                    Visible = false;
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ToolTip = 'Specifies the Qualification code.';
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                }
                field(Mandatory; Rec.Mandatory)
                {
                    ToolTip = 'Specifies if a qualification is mandatory.';
                }
            }
        }
    }

    actions
    {
    }
}

