page 50800 "Hr Job Purpose"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "HrJob purpose";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job No"; Rec."Job No")
                {
                }
                field("Purpose Code"; Rec."Purpose Code")
                {
                }
                field(Descrpition; Rec.Descrpition)
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

