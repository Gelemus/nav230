report 50605 "Update payroll posting Group"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Update payroll posting Group.rdl';

    dataset
    {
        dataitem("ED Posting Group"; "ED Posting Group")
        {

            trigger OnAfterGetRecord()
            begin
                /*
                PayrollPostingSetup.INIT;
                PayrollPostingSetup."ED Posting Group":="ED Posting Group"."ED Posting Group Code";
                PayrollPostingSetup."Posting Group":='GENERAL';
                PayrollPostingSetup."Payroll Code":="ED Posting Group"."Payroll Code";
                PayrollPostingSetup.INSERT;
                */

            end;
        }
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {

            trigger OnAfterGetRecord()
            begin
                if "Gen. Journal Line"."Document No." = 'OPBAL' then
                    "Gen. Journal Line".Description := 'OPBAL   ' + "Gen. Journal Line".Description;
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

    var
        PayrollPostingSetup: Record "Payroll Posting Setup";
}

