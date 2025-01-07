page 50066 "Fixed deposit Types list"
{
    Editable = false;
    PageType = List;
    SourceTable = "Fixed Deposit Type";
    SourceTableView = SORTING(Code, "Maximum Amount")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Duration; Rec.Duration)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("No. of Months"; Rec."No. of Months")
                {
                }
                field("Maximum Amount"; Rec."Maximum Amount")
                {
                }
            }
        }
    }

    actions
    {
    }
}

