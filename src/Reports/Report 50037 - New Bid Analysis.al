report 50037 "New Bid Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/New Bid Analysis.rdl';

    dataset
    {
        dataitem("Bid Analysis"; "Bid Analysis")
        {
            RequestFilterFields = "Request for Quotation No.";
            column(RFQNo_BidAnalysis; "Request for Quotation No.")
            {
            }
            column(QuoteNo_BidAnalysis; "Quote No.")
            {
            }
            column(VendorNo_BidAnalysis; "Vendor No.")
            {
            }
            column(ItemNo_BidAnalysis; "Item No.")
            {
            }
            column(Description_BidAnalysis; Description)
            {
            }
            column(Quantity_BidAnalysis; Quantity)
            {
            }
            column(UnitOfMeasure_BidAnalysis; "Unit Of Measure")
            {
            }
            column(Amount_BidAnalysis; Amount)
            {
            }
            column(LineAmount_BidAnalysis; "Line Amount")
            {
            }
            column(RFQLineNo_BidAnalysis; "Line No.")
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(LastDirectCost_BidAnalysis; "Last Direct Cost")
            {
            }
            column(Total_BidAnalysis; Total)
            {
            }
            column(Name_Vendor; VendorName)
            {
            }
            column(SelectedVendor; SelectedVendor)
            {
            }
            column(SelectedPrice; SelectedPrice)
            {
            }
            column(TotalPrice; TotalPrice)
            {
            }
            column(SelectedRemarks; SelectedRemarks)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Vendor.Get("Bid Analysis"."Vendor No.") then
                    VendorName := Vendor.Name;
                BidAnalysis.Reset;
                BidAnalysis.SetRange("Request for Quotation No.", "Request for Quotation No.");
                BidAnalysis.SetRange("Line No.", "Line No.");
                BidAnalysis.SetCurrentKey(BidAnalysis."Request for Quotation No.", BidAnalysis."Line No.", BidAnalysis.Amount);
                if BidAnalysis.FindFirst then begin
                    Vendor.Get(BidAnalysis."Vendor No.");
                    SelectedVendor := Vendor.Name;
                    SelectedPrice := BidAnalysis.Amount;
                    TotalPrice := BidAnalysis.Amount * BidAnalysis.Quantity;
                    SelectedRemarks := BidAnalysis.Remarks;
                end
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        Vendor: Record Vendor;
        BidAnalysis: Record "Bid Analysis";
        SelectedVendor: Text;
        SelectedPrice: Decimal;
        TotalPrice: Decimal;
        VendorName: Text;
        SelectedRemarks: Text;
}

