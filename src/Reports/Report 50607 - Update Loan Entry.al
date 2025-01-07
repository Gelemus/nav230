report 50607 "Update Loan Entry"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Update Loan Entry.rdl';

    dataset
    {
        dataitem("Loan Entry"; "Loan Entry")
        {

            trigger OnAfterGetRecord()
            begin
                /*
                IF ("Loan Entry".Period  IN ['10-2019','11-2019','12-2019']) THEN
                  BEGIN
                "Loan Entry"."Transfered To Payroll":=TRUE;
                "Loan Entry".Posted:=FALSE;
                END
                ELSE
                "Loan Entry"."Transfered To Payroll":=FALSE;
                MODIFY;
                */

            end;
        }
        dataitem("Payroll Header"; "Payroll Header")
        {

            trigger OnAfterGetRecord()
            begin
                if "Payroll Header"."Payroll ID" = '11-2019' then
                    "Payroll Header".Posted := true;
                Modify;
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
}

