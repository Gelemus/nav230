report 50215 "Item Consumption"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Item Consumption.rdl';

    dataset
    {
        dataitem(Item; Item)
        {
            column(Item_No; Item."No.")
            {
            }
            column(Last_Direct_Cost; Item."Last Direct Cost")
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Document Type", "Document Line No.") ORDER(Ascending) WHERE("Entry Type" = FILTER("Positive Adjmt." | "Negative Adjmt." | Purchase));
                RequestFilterFields = "Item No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Entry Type";
                column(UnitofMeasureCode_ItemLedgerEntry; "Item Ledger Entry"."Unit of Measure Code")
                {
                }
                column(GlobalDimension1Code_ItemLedgerEntry; "Item Ledger Entry"."Global Dimension 1 Code")
                {
                }
                column(GlobalDimension2Code_ItemLedgerEntry; "Item Ledger Entry"."Global Dimension 2 Code")
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
                column(DocumentNo_ItemLedgerEntry; "Item Ledger Entry"."Document No.")
                {
                }
                column(Description_ItemLedgerEntry; "Item Ledger Entry".Description)
                {
                }
                column(Quantity_ItemLedgerEntry; "Item Ledger Entry".Quantity)
                {
                }
                column(CostAmountActual_ItemLedgerEntry; "Item Ledger Entry".Quantity * Item."Last Direct Cost")
                {
                }
                column(Uom; "Item Ledger Entry"."Unit of Measure Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                    StartDate := "Item Ledger Entry".GetRangeMin("Posting Date");
                    EndDate := "Item Ledger Entry".GetRangeMax("Posting Date");
                    if "Item Ledger Entry"."Global Dimension 1 Code" = '' then
                        CurrReport.Skip;
                    "Item Ledger Entry".Quantity := Abs("Item Ledger Entry".Quantity);
                    "Item Ledger Entry"."Cost Amount (Actual)" := Abs("Item Ledger Entry"."Cost Amount (Actual)");
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("START DATE"; StartDate)
                {
                }
                field("END DATE"; EndDate)
                {
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CompanyInformation: Record "Company Information";
        StartDate: Date;
        EndDate: Date;
}

