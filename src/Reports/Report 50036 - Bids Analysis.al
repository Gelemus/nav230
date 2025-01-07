report 50036 "Bids Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Bids Analysis.rdl';

    dataset
    {
        dataitem("Request for Quotation Header"; "Request for Quotation Header")
        {
            column(RFQNo; "Request for Quotation Header"."No.")
            {
            }
            column(RFQDocumentDate; "Request for Quotation Header"."Document Date")
            {
            }
            column(RFQClosingDate; "Request for Quotation Header"."Closing Date")
            {
            }
            column(RFQDescription; "Request for Quotation Header".Description)
            {
            }
            column(CName; CompanyInfo.Name)
            {
            }
            column(CAddress; CompanyInfo.Address)
            {
            }
            column(CAddress2; CompanyInfo."Address 2")
            {
            }
            column(CCity; CompanyInfo.City)
            {
            }
            column(CPic; CompanyInfo.Picture)
            {
            }
            column(CEmail; CompanyInfo."E-Mail")
            {
            }
            column(CPhone; CompanyInfo."Phone No.")
            {
            }
            dataitem("Purchase Header"; "Purchase Header")
            {
                DataItemLink = "Request for Quotation Code" = FIELD("No.");
                column(PurchaseNo; "Purchase Header"."No.")
                {
                }
                column(VendorNo; "Purchase Header"."Buy-from Vendor No.")
                {
                }
                column(VendorName; VendorName)
                {
                }
                dataitem("Purchase Line"; "Purchase Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    column(Type; "Purchase Line".Type)
                    {
                    }
                    column(No; "Purchase Line"."No.")
                    {
                    }
                    column(Description; "Purchase Line".Description)
                    {
                    }
                    column(UnitofMeasure; "Purchase Line"."Unit of Measure")
                    {
                    }
                    column(Quantity; "Purchase Line".Quantity)
                    {
                    }
                    column(UnitCost; "Purchase Line"."Direct Unit Cost")
                    {
                    }
                    column(Amount; "Purchase Line".Amount)
                    {
                    }
                }
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

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        VendorName: Text;
        CompanyInfo: Record "Company Information";
}

