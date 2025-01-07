report 50259 "Shipped Order Transfers Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Shipped Order Transfers Report.rdl';

    dataset
    {
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            RequestFilterFields = "No.", "Transfer-from Code", "Transfer-to Code", "Posting Date";
            column(No_TransferShipmentHeader; "Transfer Shipment Header"."No.")
            {
            }
            column(TransferfromCode_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-from Code")
            {
            }
            column(TransferfromName_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-from Name")
            {
            }
            column(TransfertoCode_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to Code")
            {
            }
            column(TransfertoName_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to Name")
            {
            }
            column(PostingDate_TransferShipmentHeader; "Transfer Shipment Header"."Posting Date")
            {
            }
            column(ShippedBy_TransferShipmentHeader; "Transfer Shipment Header"."Shipped By")
            {
            }
            column(DateShipped_TransferShipmentHeader; "Transfer Shipment Header"."Date Shipped")
            {
            }
            column(TimeShipped_TransferShipmentHeader; "Transfer Shipment Header"."Time Shipped")
            {
            }
            column(AssignedUserID_TransferShipmentHeader; "Transfer Shipment Header"."Assigned User ID")
            {
            }
            dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(DocumentNo_TransferShipmentLine; "Transfer Shipment Line"."Document No.")
                {
                }
                column(ItemNo_TransferShipmentLine; "Transfer Shipment Line"."Item No.")
                {
                }
                column(Quantity_TransferShipmentLine; "Transfer Shipment Line".Quantity)
                {
                }
                column(UnitofMeasure_TransferShipmentLine; "Transfer Shipment Line"."Unit of Measure")
                {
                }
                column(Description_TransferShipmentLine; "Transfer Shipment Line".Description)
                {
                }
                column(TransferOrderNo_TransferShipmentLine; "Transfer Shipment Line"."Transfer Order No.")
                {
                }
                column(ShipmentDate_TransferShipmentLine; "Transfer Shipment Line"."Shipment Date")
                {
                }
                column(InTransitCode_TransferShipmentLine; "Transfer Shipment Line"."In-Transit Code")
                {
                }
                column(TransferfromCode_TransferShipmentLine; "Transfer Shipment Line"."Transfer-from Code")
                {
                }
                column(TransfertoCode_TransferShipmentLine; "Transfer Shipment Line"."Transfer-to Code")
                {
                }
                column(ShippingTime_TransferShipmentLine; "Transfer Shipment Line"."Shipping Time")
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

