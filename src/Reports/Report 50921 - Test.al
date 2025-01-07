report 50921 Test
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Test.rdl';

    dataset
    {
        dataitem("Store Requisition Header"; "Store Requisition Header")
        {
            dataitem("Store Requisition Line"; "Store Requisition Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Line No.", "Document No.") ORDER(Ascending);
                RequestFilterFields = "Global Dimension 1 Code", "Global Dimension 2 Code", "Shortcut Dimension 3 Code", "Shortcut Dimension 4 Code", "Point Of Use";
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
                column(Quantitytoissue_StoreRequisitionLine; "Store Requisition Line"."Quantity to issue")
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
                column(UnitPrice_StoreRequisitionLine; "Store Requisition Line"."Unit Price")
                {
                }
                column(TotalSaleAmount_StoreRequisitionLine; "Store Requisition Line"."Total Sale Amount")
                {
                }
                column(LooseToolNo_StoreRequisitionLine; "Store Requisition Line"."Loose Tool No.")
                {
                }
                column(PointOfUse_StoreRequisitionLine; "Store Requisition Line"."Point Of Use")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    if "Store Requisition Line".Description = '' then
                        CurrReport.Skip;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                /*SETFILTER("Store Requisition Header"."Posting Date",'%1..%2',StartDate,EndDate);
                  StartDate := "Store Requisition Header".GETRANGEMIN("Posting Date");
                  EndDate := "Store Requisition Header".GETRANGEMAX("Posting Date");
                  */

            end;
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
        StartDate: Date;
        EndDate: Date;
}

