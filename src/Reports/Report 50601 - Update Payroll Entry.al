report 50601 "Update Payroll Entry"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Update Payroll Entry.rdl';

    dataset
    {
        dataitem("Payroll Header"; "Payroll Header")
        {
            DataItemTableView = WHERE("Payroll ID" = CONST('1-2020'));

            trigger OnAfterGetRecord()
            begin

                "Payroll Header".Posted := true;
                "Payroll Header".Modify;
            end;
        }
        dataitem("Payroll Entry"; "Payroll Entry")
        {

            trigger OnAfterGetRecord()
            begin
                /*
                "Payroll Entry"."Copy to next":=TRUE;
                "Payroll Entry"."Payroll ID":='10-2019';
                "Payroll Entry".Date:=311019D;
                "Payroll Entry".MODIFY;
                */
                "Payroll Entry".Validate("ED Code");
                "Payroll Entry".Modify;

            end;
        }
        dataitem("Payroll Lines"; "Payroll Lines")
        {

            trigger OnAfterGetRecord()
            begin
                /*IF "Payroll Lines"."Payroll ID"='' THEN
                  "Payroll Lines"."Payroll ID":='9-2019';
                "Payroll Lines".MODIFY;*/

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
        PayrollEntry: Record "Payroll Entry";
}

