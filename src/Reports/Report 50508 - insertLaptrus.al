report 50508 insertLaptrus
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/insertLaptrus.rdl';

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Payroll Period"; payrollPeriod)
                {
                    TableRelation = Periods;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        if (payrollPeriod = '') then
            Error('Input Payroll filters');


        PayrollEntry.Reset;
        PayrollEntry.SetRange("Payroll ID", payrollPeriod);
        PayrollEntry.SetFilter("ED Code", '=%1', 'LAPTRUST');
        if PayrollEntry.FindFirst then
            repeat
                TotalEarning := 0;
                PayrollEntry2.Reset;
                PayrollEntry2.SetRange("Employee No.", PayrollEntry."Employee No.");
                PayrollEntry2.SetRange("Payroll ID", payrollPeriod);
                PayrollEntry2.SetFilter("ED Code", '=%1|%2', 'BASIC', 'HOUSE');
                if PayrollEntry2.FindFirst then
                    repeat
                        TotalEarning := TotalEarning + PayrollEntry2.Amount;
                    until PayrollEntry2.Next = 0;
                if TotalEarning <> 0 then begin
                    PayrollEntry.Validate(Amount, Round(((7.5 / 100) * TotalEarning), 1, '='));
                    PayrollEntry.Modify;

                end;
            until PayrollEntry.Next = 0;
    end;

    var
        Employee: Record Employee;
        PayrollEntry: Record "Payroll Entry";
        TotalEarning: Decimal;
        Employeecode: Code[10];
        payrollPeriod: Code[10];
        PayrollEntry2: Record "Payroll Entry";
}

