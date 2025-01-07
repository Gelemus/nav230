report 50098 "Update Payslip Text"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Update Payslip Text.rdl';

    dataset
    {
        dataitem("ED Definitions"; "ED Definitions")
        {

            trigger OnAfterGetRecord()
            var
                PayslipLines: Record "Payslip Lines";
            begin
                /*IF "ED Definitions"."Payroll Text"='' THEN
                  BEGIN
                  "ED Definitions"."Payroll Text":="ED Definitions".Description;
                    intcount+=1;
                    MODIFY;
                    END;
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

    trigger OnPostReport()
    begin
        Message(Format(intcount));
    end;

    var
        intcount: Integer;
}

