page 52673 "Calculated Earnings/Deductions"
{
    PageType = ListPart;
    SourceTable = "Payroll Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Payroll ID"; Rec."Payroll ID")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("ED Code"; Rec."ED Code")
                {
                }
                field(Text; Rec.Text)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Calculation Group"; Rec."Calculation Group")
                {
                }
            }
        }
    }

    actions
    {
    }
}

