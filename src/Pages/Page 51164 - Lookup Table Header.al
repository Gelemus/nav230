page 51164 "Lookup Table Header"
{
    PageType = List;
    SourceTable = "Lookup Table Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table ID"; Rec."Table ID")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Min Extract Amount (LCY)"; Rec."Min Extract Amount (LCY)")
                {
                }
                field("Max Extract Amount (LCY)"; Rec."Max Extract Amount (LCY)")
                {
                }
                field("Calendar Year"; Rec."Calendar Year")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Action10)
            {
                Caption = 'Detail Lines';
                Image = AllLines;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Lookup Table Lines";
                RunPageLink = "Table ID" = FIELD("Table ID");
            }
        }
    }
}

