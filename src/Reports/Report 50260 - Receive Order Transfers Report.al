report 50260 "Receive Order Transfers Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Receive Order Transfers Report.rdl';

    dataset
    {
        dataitem("Transfer Receipt Header"; "Transfer Receipt Header")
        {
            RequestFilterFields = "No.", "Transfer-from Code", "Transfer-to Code", "Posting Date";
            column(No_TransferReceiptHeader; "Transfer Receipt Header"."No.")
            {
            }
            column(TransferfromCode_TransferReceiptHeader; "Transfer Receipt Header"."Transfer-from Code")
            {
            }
            column(TransferfromName_TransferReceiptHeader; "Transfer Receipt Header"."Transfer-from Name")
            {
            }
            column(TransfertoCode_TransferReceiptHeader; "Transfer Receipt Header"."Transfer-to Code")
            {
            }
            column(TransfertoName_TransferReceiptHeader; "Transfer Receipt Header"."Transfer-to Name")
            {
            }
            column(PostingDate_TransferReceiptHeader; "Transfer Receipt Header"."Posting Date")
            {
            }
            column(ShipmentDate_TransferReceiptHeader; "Transfer Receipt Header"."Shipment Date")
            {
            }
            column(ReceiptDate_TransferReceiptHeader; "Transfer Receipt Header"."Receipt Date")
            {
            }
            column(InTransitCode_TransferReceiptHeader; "Transfer Receipt Header"."In-Transit Code")
            {
            }
            column(TimeReceived_TransferReceiptHeader; "Transfer Receipt Header"."Time Received")
            {
            }
            dataitem("Transfer Receipt Line"; "Transfer Receipt Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(ShippingTime_TransferReceiptLine; "Transfer Receipt Line"."Shipping Time")
                {
                }
                column(DocumentNo_TransferReceiptLine; "Transfer Receipt Line"."Document No.")
                {
                }
                column(ItemNo_TransferReceiptLine; "Transfer Receipt Line"."Item No.")
                {
                }
                column(Quantity_TransferReceiptLine; "Transfer Receipt Line".Quantity)
                {
                }
                column(Description_TransferReceiptLine; "Transfer Receipt Line".Description)
                {
                }
                column(UnitofMeasure_TransferReceiptLine; "Transfer Receipt Line"."Unit of Measure")
                {
                }
                column(QuantityBase_TransferReceiptLine; "Transfer Receipt Line"."Quantity (Base)")
                {
                }
                column(ReceiptDate_TransferReceiptLine; "Transfer Receipt Line"."Receipt Date")
                {
                }
                column(InTransitCode_TransferReceiptLine; "Transfer Receipt Line"."In-Transit Code")
                {
                }
                column(TransferfromCode_TransferReceiptLine; "Transfer Receipt Line"."Transfer-from Code")
                {
                }
                column(TransfertoCode_TransferReceiptLine; "Transfer Receipt Line"."Transfer-to Code")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                /*Employee.RESET;
                Employee.SETRANGE(Employee."User ID","User Time Register"."User ID");
                IF Employee.FINDSET THEN BEGIN
                  Names:=Employee."Full Name";//Employee."First Name"+''+Employee."Middle Name"+''+Employee."Last Name";
                  Hours:="User Time Register".Minutes/60;
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

    trigger OnPreReport()
    begin
        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(Picture)
    end;

    var
        CompanyInfo: Record "Company Information";
        Names: Text;
        Employee: Record Employee;
        Hours: Decimal;
}

