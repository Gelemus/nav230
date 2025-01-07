page 50185 "HR Lookup Values"
{
    DeleteAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = "HR Lookup Values";
    SourceTableView = SORTING(Code, Option)
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the following options Qualification,Requirement,Responsibility,Job Grade for a Job value';
                }
                field(Option; Rec.Option)
                {
                    ToolTip = 'Specifies the code.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description for the code.';
                }
            }
        }
    }

    actions
    {
    }
}

