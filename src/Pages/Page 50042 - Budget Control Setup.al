page 50042 "Budget Control Setup"
{
    PageType = List;
    SourceTable = "Budget Control Setup";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Current Budget Code"; Rec."Current Budget Code")
                {
                }
                field("Current Budget Start Date"; Rec."Current Budget Start Date")
                {
                }
                field("Current Budget End Date"; Rec."Current Budget End Date")
                {
                }
                field("Analysis View Code"; Rec."Analysis View Code")
                {
                }
                field(Mandatory; Rec.Mandatory)
                {
                }
                field("Allow OverExpenditure"; Rec."Allow OverExpenditure")
                {
                }
                field("Current Item Budget"; Rec."Current Item Budget")
                {
                }
            }
        }
    }

    actions
    {
    }
}

