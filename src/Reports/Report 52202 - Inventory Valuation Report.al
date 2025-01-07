report 52202 "Inventory Valuation Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Inventory Valuation Report.rdl';

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = Inventory, "Location Code";
            column(No_Item; Item."No.")
            {
            }
            column(Description_Item; Item.Description)
            {
            }
            column(BaseUnitofMeasure_Item; Item."Base Unit of Measure")
            {
            }
            column(UnitCost_Item; Item."Unit Cost")
            {
            }
            column(Inventory_Item; Item.Inventory)
            {
            }
            column(Total_Cost; Item."Unit Cost" * Item.Inventory)
            {
            }
            column(LocationCode_Item; Item."Location Code")
            {
            }
            column(GenProdPostingGroup_Item; Item."Gen. Prod. Posting Group")
            {
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
}

