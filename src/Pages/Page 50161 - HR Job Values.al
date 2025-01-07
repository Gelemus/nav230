page 50161 "HR Job Values"
{
    DeleteAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = "HR Job Lookup Value";
    SourceTableView = SORTING(Option, Code)
                      ORDER(Descending)
                      WHERE(Option = FILTER(<> "Job Grade"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Option; Rec.Option)
                {
                    ToolTip = 'Specifies the following options Qualification,Requirement,Responsibility,Job Grade for a Job value';
                }
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the code.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description for the code.';
                }
                field(Blocked; Rec.Blocked)
                {
                }
                field("Required Stage"; Rec."Required Stage")
                {
                }
            }
        }
    }

    actions
    {
    }
}

