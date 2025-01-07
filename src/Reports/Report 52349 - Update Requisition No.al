report 52349 "Update Requisition No"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Update Requisition No.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {

            trigger OnAfterGetRecord()
            begin
                PurchaseRequisitions.Reset;
                PurchaseRequisitions.SetRange(PurchaseRequisitions."Employee No.", Employee."No.");
                //PurchaseRequisitions.SETRANGE(PurchaseRequisitions."User ID",Employee."User ID");
                if PurchaseRequisitions.FindSet then begin
                    repeat
                        PurchaseRequisitions."Employee Name" := Employee."Full Name";
                        PurchaseRequisitions.Modify;
                    until PurchaseRequisitions.Next = 0;
                end;
                //MESSAGE('you have Successfully updated Purchase Receipt');
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
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchaseRequisitions: Record "Purchase Requisitions";
}

