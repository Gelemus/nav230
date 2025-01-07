page 51206 "Commission Rates"
{
    AutoSplitKey = true;
    PageType = List;
    SourceTable = "Commission Rates";

    layout
    {
        area(content)
        {
            repeater(Control1102754000)
            {
                ShowCaption = false;
                field("Employee No"; Rec."Employee No")
                {
                }
                field(Base; Rec.Base)
                {
                }
                field("Valid To Date"; Rec."Valid To Date")
                {
                }
                field("ED Code"; Rec."ED Code")
                {
                }
                field("Threshold Amount LCY"; Rec."Threshold Amount LCY")
                {
                }
                field("Commission %"; Rec."Commission %")
                {
                }
                field("Commission Amount LCY"; Rec."Commission Amount LCY")
                {
                }
            }
        }
    }

    actions
    {
    }
}

