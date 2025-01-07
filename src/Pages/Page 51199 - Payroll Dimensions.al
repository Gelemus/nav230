page 51199 "Payroll Dimensions"
{
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Payroll Dimension";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Dimension Code"; Rec."Dimension Code")
                {
                }
                field("Dimension Value Code"; Rec."Dimension Value Code")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Payroll Code"; Rec."Payroll Code")
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        CurrTableID: Integer;
        CurrEmpNo: Code[20];
        CurrPayrollID: Code[10];
        CurrEDCode: Code[20];
        CurrEntryNo: Integer;
        SourceTableName: Text[100];
}

