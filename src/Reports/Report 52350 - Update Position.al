report 52350 "Update Position"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Update Position.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
            dataitem("Payroll Header"; "Payroll Header")
            {
                DataItemLink = "Employee no." = FIELD("No.");

                trigger OnAfterGetRecord()
                begin
                    "Payroll Header"."Middle Name" := Employee."Middle Name";
                    "Payroll Header".Modify;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                /*
                PurchRcptHeader.RESET;
                PurchRcptHeader.SETRANGE(PurchRcptHeader."User ID","User ID");
                IF PurchRcptHeader.FINDSET THEN BEGIN
                  REPEAT
                    PurchRcptHeader."Position Title" := Employee."Position Title";
                  UNTIL PurchRcptHeader.NEXT=0;
                
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

    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
}

