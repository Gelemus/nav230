report 52200 "rename employee"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/rename employee.rdl';

    dataset
    {
        dataitem("Temp EMploye"; "Temp EMploye")
        {

            trigger OnAfterGetRecord()
            begin
                Employee.Reset;
                Employee.SetRange("No.", "Temp EMploye"."New No");
                if Employee.FindFirst then begin
                    Employee."Fixed Pay" := "Temp EMploye".Basic;
                    Employee.Modify;
                end;
                /*PayrollEntry.RESET;
                PayrollEntry.SETRANGE("Employee No.","Temp EMploye".OldNo);
                IF PayrollEntry.FINDFIRST THEN
                  REPEAT
                    PayrollEntry."Employee No.":="Temp EMploye"."New No";
                    PayrollEntry.MODIFY;
                
                  UNTIL PayrollEntry.NEXT=0;
                  PayrollLines.RESET;
                PayrollLines.SETRANGE("Employee No.","Temp EMploye".OldNo);
                IF PayrollLines.FINDFIRST THEN
                  REPEAT
                    PayrollLines."Employee No.":="Temp EMploye"."New No";
                    PayrollLines.MODIFY;
                
                  UNTIL PayrollLines.NEXT=0;
                  */

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

    var
        Employee: Record Employee;
        PayrollEntry: Record "Payroll Entry";
        PayrollLines: Record "Payroll Lines";
}

