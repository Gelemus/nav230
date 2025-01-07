report 50606 "Update Imprest Lines"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Update Imprest Lines.rdl';

    dataset
    {
        dataitem("Imprest Line"; "Imprest Line")
        {

            trigger OnAfterGetRecord()
            begin
                Amountgross := 0;
                Amountgross := "Imprest Line"."Gross Amount";
                if "Imprest Line"."Unit Amount" = 0 then begin
                    "Imprest Line".Quantity := 1;
                    "Imprest Line".Validate("Imprest Line"."Unit Amount", Amountgross);
                    "Imprest Line".Modify;
                end;
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
        Amountgross: Decimal;
}

