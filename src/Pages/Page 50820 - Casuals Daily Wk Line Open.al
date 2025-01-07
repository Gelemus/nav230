page 50820 "Casuals Daily Wk Line Open"
{
    PageType = ListPart;
    SourceTable = "Imprest Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Names; Rec.Names)
                {
                }
                field("Daily Rate"; Rec."Daily Rate")
                {
                }
                field("No of Meters/Others"; Rec."No of Meters/Others")
                {
                }
                field("Day 1"; Rec."Day 1")
                {
                }
                field("Day 2"; Rec."Day 2")
                {
                }
                field("Day 3"; Rec."Day 3")
                {
                }
                field("Day 4"; Rec."Day 4")
                {
                }
                field("Day 5"; Rec."Day 5")
                {
                }
                field("Day 6"; Rec."Day 6")
                {
                }
                field("Day 7"; Rec."Day 7")
                {
                }
                field("Total Days"; Rec."Total Days")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        AllowanceMatrix: Record "Allowance Matrix";
        FromToEditable: Boolean;
        CityEditable: Boolean;
        CityCodes: Record "Procurement Lookup Values";
        ImprestLine: Record "Imprest Line";
        Error001: Label 'Destination Town is Similar to Depature Town';
        Error002: Label 'Imprest exist on this activity day';
}

