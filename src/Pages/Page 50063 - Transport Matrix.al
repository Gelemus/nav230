page 50063 "Transport Matrix"
{
    PageType = List;
    SourceTable = "Allowance Matrix";
    SourceTableView = WHERE("Allowance Code" = FILTER('LOCALTRAVEL'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Allowance Code"; Rec."Allowance Code")
                {
                }
                field(From; Rec.From)
                {
                }
                field(Tos; Rec.Tos)
                {
                    Caption = 'To';
                }
                field(Amount; Rec.Amount)
                {
                }
            }
        }
    }

    actions
    {
    }
}

