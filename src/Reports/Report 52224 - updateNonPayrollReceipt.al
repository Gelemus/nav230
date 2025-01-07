report 52224 updateNonPayrollReceipt
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/updateNonPayrollReceipt.rdl';

    dataset
    {
        dataitem("loan bal"; "loan bal")
        {

            trigger OnAfterGetRecord()
            begin
                /* PayrollEntry.SETRANGE("Employee No.","loan bal"."Emp No");
                 PayrollEntry.SETRANGE("ED Code","loan bal"."Ed Code");
                 PayrollEntry.SETRANGE("Payroll ID",'6-2021');

                 IF PayrollEntry.FINDFIRST THEN BEGIN
                   LoanAdvance.RESET;
                   LoanAdvance.SETRANGE(Employee,PayrollEntry."Employee No.");
                   LoanAdvance.SETRANGE("Loan Types",'WELFARE LOAN');
                   IF LoanAdvance.COUNT < 1 THEN
                     PayrollEntry.DELETE;
                     LoanAdvance.RESET;
                     LoanAdvance.INIT;
                   END;

                 END
                 EmployeeRec.SETRANGE("ED Code Filter","Non payroll Receipt"."ED Code");
                 EmployeeRec.SETFILTER("Date Filter", FORMAT(DMY2DATE(1,1,2121)) + '..' + FORMAT(DMY2DATE(30,5,2121)));

                 EmployeeRec.CALCFIELDS("Amount To Date (LCY)","Non Payroll Receipts");
                 CumilativeDec :="Non payroll Receipt".Amount - EmployeeRec."Amount To Date (LCY)";
                 "Non payroll Receipt".Amount := CumilativeDec;
                 "Non payroll Receipt".MODIFY;*/

            end;

            trigger OnPreDataItem()
            begin
                //"Non payroll Receipt".SETRANGE("Employee No",'6061');
                //"Non payroll Receipt".SETRANGE("ED Code",'WEVARSITYSHARES');
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        Message('Done');
    end;

    var
        PayrollEntry: Record "Payroll Entry";
        EmployeeRec: Record Employee;
        CumilativeDec: Decimal;
        LoanAdvance: Record "Loans/Advances";
}

