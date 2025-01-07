report 50051 "Budget Utilization Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Budget Utilization Report.rdl';

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            RequestFilterFields = "Item No.";
            column(MarketPrice; MarketPrice)
            {
            }
            column(CostAmountActual_ItemLedgerEntry; "Item Ledger Entry"."Cost Amount (Actual)")
            {
            }
            column(ItemNo_ItemLedgerEntry; "Item Ledger Entry"."Item No.")
            {
            }
            column(PostingDate_ItemLedgerEntry; "Item Ledger Entry"."Posting Date")
            {
            }
            column(EntryType_ItemLedgerEntry; "Item Ledger Entry"."Entry Type")
            {
            }
            column(SourceNo_ItemLedgerEntry; "Item Ledger Entry"."Source No.")
            {
            }
            column(DocumentNo_ItemLedgerEntry; "Item Ledger Entry"."Document No.")
            {
            }
            column(Description_ItemLedgerEntry; "Item Ledger Entry".Description)
            {
            }
            column(ItemDescription; ItemDescription)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(pic; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_Phone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Fax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Email; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfo_Web; CompanyInfo."Home Page")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if ItemList.Get("Item Ledger Entry"."Item No.") then
                    ItemDescription := ItemList.Description;



                ItemMarketPrice.Reset;
                ItemMarketPrice.SetRange(ItemMarketPrice.Item, "Item Ledger Entry"."Item No.");
                //ItemMarketPrice.SETRANGE(ItemMarketPrice."From Date",ItemMarketPrice."To Date","Item Ledger Entry"."Posting Date");
                if ItemMarketPrice.FindFirst then begin
                    MarketPrice := ItemMarketPrice."Market Price";
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

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture)
    end;

    var
        ItemMarketPrice: Record "Item Market Price";
        ItemList: Record Item;
        MarketPrice: Decimal;
        CompanyInfo: Record "Company Information";
        ItemDescription: Text;
}

