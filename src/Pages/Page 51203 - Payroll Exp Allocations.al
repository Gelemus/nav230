page 51203 "Payroll Exp Allocations"
{
    PageType = List;
    SourceTable = "Payroll Exp Allocation Matrix";

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
                field("ED Code"; Rec."ED Code")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Dimension Code1"; Rec."Dimension Code1")
                {
                }
                field("Dimension Value Code1"; Rec."Dimension Value Code1")
                {
                }
                field("Dimension Code2"; Rec."Dimension Code2")
                {
                }
                field("Dimension Value Code2"; Rec."Dimension Value Code2")
                {
                }
                field("Dimension Code3"; Rec."Dimension Code3")
                {
                }
                field("Dimension Value Code3"; Rec."Dimension Value Code3")
                {
                }
                field("Dimension Code4"; Rec."Dimension Code4")
                {
                }
                field("Dimension Value Code4"; Rec."Dimension Value Code4")
                {
                }
                field("Dimension Code5"; Rec."Dimension Code5")
                {
                    Visible = false;
                }
                field("Dimension Value Code5"; Rec."Dimension Value Code5")
                {
                    Visible = false;
                }
                field("Dimension Code6"; Rec."Dimension Code6")
                {
                    Visible = false;
                }
                field("Dimension Value Code6"; Rec."Dimension Value Code6")
                {
                    Visible = false;
                }
                field("Dimension Code7"; Rec."Dimension Code7")
                {
                    Visible = false;
                }
                field("Dimension Value Code7"; Rec."Dimension Value Code7")
                {
                    Visible = false;
                }
                field("Dimension Code8"; Rec."Dimension Code8")
                {
                    Visible = false;
                }
                field("Dimension Value Code8"; Rec."Dimension Value Code8")
                {
                    Visible = false;
                }
                field(Allocated; Rec.Allocated)
                {
                }
            }
        }
    }

    actions
    {
    }
}

