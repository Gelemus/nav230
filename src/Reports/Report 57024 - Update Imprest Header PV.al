report 57024 "Update Imprest Header PV"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = 'src/Layouts/Update Imprest Header PV.rdl';
    ProcessingOnly = true;
    dataset
    {
        dataitem("Payment Line"; "Payment Line")
        {
            DataItemTableView = WHERE("Payee Type" = FILTER(Imprest | "Petty Cash Request"));
            dataitem("Imprest Header"; "Imprest Header")
            {
                DataItemLink = "No." = FIELD("Payee No.");

                trigger OnAfterGetRecord()
                begin
                    if "Imprest Header"."Payment Voucher No" = '' then begin
                        "Imprest Header"."Payment Voucher No" := "Payment Line"."Document No.";
                        "Imprest Header".Modify;
                        CountModified += 1;
                    end;
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
        Message(Format(CountModified));
    end;

    var
        CountModified: Integer;
}

