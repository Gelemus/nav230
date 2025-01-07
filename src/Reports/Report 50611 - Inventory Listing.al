report 50611 "Inventory Listing"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Inventory Listing.rdl';

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", Blocked, Description, "Inventory Posting Group", Inventory;
            column(InventoryPostingGroup_Item; Item."Inventory Posting Group")
            {
            }
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
            column(ItemGLBudgetAccount_Item; Item."Item G/L Budget Account")
            {
            }
            column(Inventory_Item; Item.Inventory)
            {
            }
            column(Name; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(Address2; CompanyInfo."Address 2")
            {
            }
            column(PostalCode; CompanyInfo."Post Code")
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(Phone; CompanyInfo."Phone No.")
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(HomePage; CompanyInfo."Home Page")
            {
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);
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
        CompanyInfo: Record "Company Information";
}

