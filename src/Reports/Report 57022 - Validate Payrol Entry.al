report 57022 "Validate Payrol Entry"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Validate Payrol Entry.rdl';

    dataset
    {
        dataitem("ED Definitions"; "ED Definitions")
        {
            dataitem("Payroll Entry"; "Payroll Entry")
            {
                DataItemLink = "ED Code" = FIELD("ED Code");

                trigger OnAfterGetRecord()
                begin
                    "Payroll Entry"."Calculation Group" := "ED Definitions"."Calculation Group";
                    "Payroll Entry".Modify;
                    CountModified += 1;
                end;
            }
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
        Message('%1 records modified', CountModified);
    end;

    var
        CountModified: Integer;
}

