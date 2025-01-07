report 50023 "Bank Reconciliation Process"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Bank Reconciliation Process.rdl';
    UseRequestPage = false;

    dataset
    {
        dataitem("Bank Acc. Reconciliation Line"; "Bank Acc. Reconciliation Line")
        {

            trigger OnAfterGetRecord()
            begin


                ReconcilliationBuffer.Reset;
                ReconcilliationBuffer.SetRange(ReconcilliationBuffer."Bank Account No.", "Bank Acc. Reconciliation Line"."Bank Account No.");
                ReconcilliationBuffer.SetRange(ReconcilliationBuffer."Statement No.", "Bank Acc. Reconciliation Line"."Statement No.");
                ReconcilliationBuffer.SetRange(ReconcilliationBuffer."Check No.", "Bank Acc. Reconciliation Line"."Check No.");
                ReconcilliationBuffer.SetRange(ReconcilliationBuffer."Statement Amount", "Bank Acc. Reconciliation Line"."Statement Amount");
                if ReconcilliationBuffer.Find('-') then begin

                    "Bank Acc. Reconciliation Line".Reconciled1 := true;
                    "Bank Acc. Reconciliation Line"."Reconciling Date" := Today;
                    "Bank Acc. Reconciliation Line"."Applied Amount" := "Bank Acc. Reconciliation Line"."Statement Amount";
                    "Bank Acc. Reconciliation Line".Difference := 0;
                    "Bank Acc. Reconciliation Line"."Applied Entries" := 1;
                    "Bank Acc. Reconciliation Line"."Ready for Application" := true;
                    "Bank Acc. Reconciliation Line".Modify;

                    ReconcilliationBuffer.Reconciled := true;
                    ReconcilliationBuffer."Reconciling Date" := Today;
                    ReconcilliationBuffer.Modify;

                end else begin

                    "Bank Acc. Reconciliation Line"."Applied Amount" := 0;
                    "Bank Acc. Reconciliation Line".Difference := "Bank Acc. Reconciliation Line"."Statement Amount";
                    "Bank Acc. Reconciliation Line"."Applied Entries" := 0;
                    "Bank Acc. Reconciliation Line"."Ready for Application" := true;

                    "Bank Acc. Reconciliation Line".Modify;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Unique Transaction Have Reconcilled. Kindly check for unreconcilled items and match manually where necessary to make reconcilliation complete.');
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
        ReconcilliationBuffer: Record "Bank Acc. Statement Linevb";
}

