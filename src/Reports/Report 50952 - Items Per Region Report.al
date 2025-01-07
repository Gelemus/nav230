report 50952 "Items Per Region Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Items Per Region Report.rdl';
    ApplicationArea = Basic, Suite, Advanced;
    Caption = 'Status';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Store Requisition Header"; "Store Requisition Header")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "User ID", "Global Dimension 1 Code", "Global Dimension 2 Code", "Shortcut Dimension 3 Code", "Shortcut Dimension 4 Code", "Point Of Use";
            column(AsofStatusDate; StrSubstNo(Text000, Format(StatusDate)))
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfoPic; CompanyInfo.Picture)
            {
            }
            column(CompanyWebPage; CompanyInfo."Home Page")
            {
            }
            column(No_StoreRequisitionHeader; "Store Requisition Header"."No.")
            {
            }
            column(DocumentDate_StoreRequisitionHeader; "Store Requisition Header"."Document Date")
            {
            }
            column(PostingDate_StoreRequisitionHeader; "Store Requisition Header"."Posting Date")
            {
            }
            column(RequesterID_StoreRequisitionHeader; "Store Requisition Header"."Requester ID")
            {
            }
            column(Description_StoreRequisitionHeader; "Store Requisition Header".Description)
            {
            }
            column(GlobalDimension1Code_StoreRequisitionHeader; "Store Requisition Header"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_StoreRequisitionHeader; "Store Requisition Header"."Global Dimension 2 Code")
            {
            }
            column(UserID_StoreRequisitionHeader; "Store Requisition Header"."User ID")
            {
            }
            column(PointOfUse_StoreRequisitionHeader; "Store Requisition Header"."Point Of Use")
            {
            }
            dataitem("Store Requisition Line"; "Store Requisition Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Line No.", "Document No.") ORDER(Ascending);
                RequestFilterFields = "Item No.";
                column(PointOfUse_StoreRequisitionLine; "Store Requisition Line"."Point Of Use")
                {
                }
                column(LineNo_StoreRequisitionLine; "Store Requisition Line"."Line No.")
                {
                }
                column(DocumentNo_StoreRequisitionLine; "Store Requisition Line"."Document No.")
                {
                }
                column(Type_StoreRequisitionLine; "Store Requisition Line".Type)
                {
                }
                column(ItemNo_StoreRequisitionLine; "Store Requisition Line"."Item No.")
                {
                }
                column(LocationCode_StoreRequisitionLine; "Store Requisition Line"."Location Code")
                {
                }
                column(Inventory_StoreRequisitionLine; "Store Requisition Line".Inventory)
                {
                }
                column(Quantity_StoreRequisitionLine; "Store Requisition Line".Quantity)
                {
                }
                column(UnitofMeasureCode_StoreRequisitionLine; "Store Requisition Line"."Unit of Measure Code")
                {
                }
                column(UnitCost_StoreRequisitionLine; "Store Requisition Line"."Unit Cost")
                {
                }
                column(LineAmount_StoreRequisitionLine; "Store Requisition Line"."Line Amount")
                {
                }
                column(Committed_StoreRequisitionLine; "Store Requisition Line".Committed)
                {
                }
                column(GenBusPostingGroup_StoreRequisitionLine; "Store Requisition Line"."Gen. Bus. Posting Group")
                {
                }
                column(GenProdPostingGroup_StoreRequisitionLine; "Store Requisition Line"."Gen. Prod. Posting Group")
                {
                }
                column(Description_StoreRequisitionLine; "Store Requisition Line".Description)
                {
                }
                column(GlobalDimension1Code_StoreRequisitionLine; "Store Requisition Line"."Global Dimension 1 Code")
                {
                }
                column(GlobalDimension2Code_StoreRequisitionLine; "Store Requisition Line"."Global Dimension 2 Code")
                {
                }
                column(ShortcutDimension3Code_StoreRequisitionLine; "Store Requisition Line"."Shortcut Dimension 3 Code")
                {
                }
                column(ShortcutDimension4Code_StoreRequisitionLine; "Store Requisition Line"."Shortcut Dimension 4 Code")
                {
                }
                column(ShortcutDimension5Code_StoreRequisitionLine; "Store Requisition Line"."Shortcut Dimension 5 Code")
                {
                }
                column(ShortcutDimension6Code_StoreRequisitionLine; "Store Requisition Line"."Shortcut Dimension 6 Code")
                {
                }
                column(ShortcutDimension7Code_StoreRequisitionLine; "Store Requisition Line"."Shortcut Dimension 7 Code")
                {
                }
                column(ShortcutDimension8Code_StoreRequisitionLine; "Store Requisition Line"."Shortcut Dimension 8 Code")
                {
                }
                column(ResponsibilityCenter_StoreRequisitionLine; "Store Requisition Line"."Responsibility Center")
                {
                }
                column(Status_StoreRequisitionLine; "Store Requisition Line".Status)
                {
                }
                column(Posted_StoreRequisitionLine; "Store Requisition Line".Posted)
                {
                }
                column(PostedBy_StoreRequisitionLine; "Store Requisition Line"."Posted By")
                {
                }
                column(DatePosted_StoreRequisitionLine; "Store Requisition Line"."Date Posted")
                {
                }
                column(TimePosted_StoreRequisitionLine; "Store Requisition Line"."Time Posted")
                {
                }
                column(ItemDescription_StoreRequisitionLine; "Store Requisition Line"."Item Description")
                {
                }
                column(Select_StoreRequisitionLine; "Store Requisition Line".Select)
                {
                }
                column(StoreRequisitionNo_StoreRequisitionLine; "Store Requisition Line"."Store Requisition No")
                {
                }
                column(ReturnRequisitionNo_StoreRequisitionLine; "Store Requisition Line"."Return Requisition No")
                {
                }
                column(Returned_StoreRequisitionLine; "Store Requisition Line".Returned)
                {
                }
                column(Posting_Date; "Store Requisition Header"."Posting Date")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                StartDate := "Store Requisition Header".GetRangeMin("Posting Date");
                EndDate := "Store Requisition Header".GetRangeMax("Posting Date");
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

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

        trigger OnOpenPage()
        begin
            /*IF StatusDate = 0D THEN
              StatusDate := WORKDATE;
            */

        end;
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
        Text000: Label 'As of %1';
        ValueEntry: Record "Value Entry";
        StatusDate: Date;
        ItemFilter: Text;
        InvtValue: Decimal;
        UnitCost: Decimal;
        RemainingQty: Decimal;
        AvgCost: Decimal;
        Text001: Label 'Enter the Posting Date';
        StatusCaptionLbl: Label 'Items Per Region';
        PageCaptionLbl: Label 'Page';
        UnitCostCaptionLbl: Label 'Unit Cost';
        PostingDateCaptionLbl: Label 'Posting Date';
        QuantityCaptionLbl: Label 'Quantity';
        InventoryValuationCaptionLbl: Label 'Inventory Valuation';
        TotalCaptionLbl: Label 'Total';
        HereofPositiveCaptionLbl: Label 'Hereof Positive';
        HereofNegativeCaptionLbl: Label 'Hereof Negative';
        IsAverageCostItem: Boolean;
        StartDate: Date;
        EndDate: Date;
        "Start Date": Date;
        CompanyInfo: Record "Company Information";
}

