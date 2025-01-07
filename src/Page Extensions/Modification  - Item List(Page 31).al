pageextension 60232 pageextension60232 extends "Item List"
{

    //Unsupported feature: Property Insertion (SourceTableView) on ""Item List"(Page 31)".

    layout
    {

        //Unsupported feature: Property Modification (Name) on ""Assembly BOM"(Control 8)".


        //Unsupported feature: Property Modification (SourceExpr) on ""Assembly BOM"(Control 8)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Assembly BOM"(Control 8)".


        //Unsupported feature: Property Modification (Name) on ""Price/Profit Calculation"(Control 57)".


        //Unsupported feature: Property Modification (SourceExpr) on ""Price/Profit Calculation"(Control 57)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Price/Profit Calculation"(Control 57)".


        //Unsupported feature: Property Modification (Name) on ""Profit %"(Control 59)".


        //Unsupported feature: Property Modification (SourceExpr) on ""Profit %"(Control 59)".


        //Unsupported feature: Property Modification (Name) on ""Unit Price"(Control 61)".


        //Unsupported feature: Property Modification (SourceExpr) on ""Unit Price"(Control 61)".


        //Unsupported feature: Property Modification (Name) on ""Vendor No."(Control 65)".


        //Unsupported feature: Property Modification (SourceExpr) on ""Vendor No."(Control 65)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Vendor No."(Control 65)".


        //Unsupported feature: Property Modification (Name) on ""Vendor Item No."(Control 67)".


        //Unsupported feature: Property Modification (SourceExpr) on ""Vendor Item No."(Control 67)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Vendor Item No."(Control 67)".

        modify("Created From Nonstock Item")
        {
            Visible = false;
        }
        modify("Substitutes Exist")
        {
            Visible = false;
        }
        modify("Stockkeeping Unit Exists")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (AccessByPermission) on ""Assembly BOM"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assembly BOM"(Control 8)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Assembly BOM"(Control 8)".

        modify("Production BOM No.")
        {
            Visible = false;
        }
        modify("Routing No.")
        {
            Visible = false;
        }
        modify("Base Unit of Measure")
        {
            Visible = false;
        }
        modify("Shelf No.")
        {
            Visible = false;
        }
        modify("Cost is Adjusted")
        {
            Visible = false;
        }
        modify("Standard Cost")
        {
            Visible = false;
        }
        modify("Last Direct Cost")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Price/Profit Calculation"(Control 57)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Price/Profit Calculation"(Control 57)".


        //Unsupported feature: Property Deletion (Visible) on ""Price/Profit Calculation"(Control 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Profit %"(Control 59)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Profit %"(Control 59)".


        //Unsupported feature: Property Deletion (Visible) on ""Profit %"(Control 59)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Price"(Control 61)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Unit Price"(Control 61)".

        modify("Inventory Posting Group")
        {
            Visible = false;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Item Disc. Group")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor No."(Control 65)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Vendor No."(Control 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor Item No."(Control 67)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Vendor Item No."(Control 67)".


        //Unsupported feature: Property Deletion (Visible) on ""Vendor Item No."(Control 67)".

        modify("Tariff No.")
        {
            Visible = false;
        }
        modify("Search Description")
        {
            Visible = false;
        }
        modify("Overhead Rate")
        {
            Visible = false;
        }
        modify("Indirect Cost %")
        {
            Visible = false;
        }
        modify("Item Category Code")
        {
            Visible = false;
        }
        modify("Sales Unit of Measure")
        {
            Visible = false;
        }
        modify("Replenishment System")
        {
            Visible = false;
        }
        modify("Purch. Unit of Measure")
        {
            Visible = false;
        }
        modify("Lead Time Calculation")
        {
            Visible = false;
        }
        modify("Manufacturing Policy")
        {
            Visible = false;
        }
        modify("Flushing Method")
        {
            Visible = false;
        }
        modify("Assembly Policy")
        {
            Visible = false;
        }
        modify("Item Tracking Code")
        {
            Visible = false;
        }
        modify("Default Deferral Template Code")
        {
            Visible = false;
        }
        moveafter(Description; "Costing Method")
        // moveafter(Control113;"Unit Cost")
        moveafter("Unit Price"; "Last Date Modified")
        moveafter("Last Date Modified"; "Profit %")
    }
    actions
    {
        modify("Item Journal")
        {
            Visible = false;
        }
        addfirst(Item)
        {
            action(UploadItems)
            {
                Promoted = true;
                PromotedIsBig = true;
                RunObject = XMLport "Store Requisition Export";
                Visible = false;
            }
        }
        addfirst(Inventory)
        {
            action("Inventory Listing Report")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Inventory Listing Report';
                Image = "Report";
                RunObject = Report "Inventory Listing";
                ToolTip = 'View various information about the item, such as name, unit of measure, posting group, shelf number, vendor''s item number, lead time calculation, minimum inventory, and alternate item number. You can also see if the item is blocked.';
            }
        }
        // addfirst(ActionGroup126)
        // {
        //     action("Import Item Register")
        //     {
        //         Caption = 'Import Item Register';
        //         //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
        //         //PromotedCategory = Process;
        //         RunObject = XMLport "Store Requisition Export";
        //         ToolTip = 'Import Items';

        //         trigger OnAction()
        //         begin
        //             //ApprovalsMgmt.OpenApprovalEntriesPage(RECORDID);
        //         end;
        //     }
        // }
    }

    var
        UserSetup: Record "User Setup";
        PemissionDenied: Label 'You are not setup to Create Items. Contact System Administrator';


    //Unsupported feature: Code Modification on "OnFindRecord".

    //trigger OnFindRecord()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if RunOnTempRec then begin
      TempItemFilteredFromAttributes.Copy(Rec);
      Found := TempItemFilteredFromAttributes.Find(Which);
      if Found then
        Rec := TempItemFilteredFromAttributes;
      exit(Found);
    end;
    exit(Find(Which));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*

    #1..8
    */
    //end;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage."Power BI Report FactBox".PAGE.InitFactBox(CurrPage.ObjectId(false),CurrPage.Caption,PowerBIVisible);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*

    CurrPage."Power BI Report FactBox".PAGE.InitFactBox(CurrPage.ObjectId(false),CurrPage.Caption,PowerBIVisible);
    */
    //end;


    //Unsupported feature: Code Insertion on "OnNewRecord".

    //trigger OnNewRecord(BelowxRec: Boolean)
    //begin
    /*
    //Check if is allowed to create Item
    if UserSetup.Get(UserId) then begin
      if not UserSetup."Item Creation" then
        Error(PemissionDenied);
     end;
     // End Check if is allowed to create Item
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
    with SocialListeningSetup do
      SocialListeningSetupVisible := Get and "Show on Customers" and "Accept License Agreement" and ("Solution ID" <> '');
    IsFoundationEnabled := ApplicationAreaMgmtFacade.IsFoundationEnabled;
    SetWorkflowManagementEnabledState;
    IsOnPhone := ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::Phone;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*

    #1..6
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "SelectActiveItems(PROCEDURE 180)".


    //Unsupported feature: Property Modification (Attributes) on "SelectActiveItemsForSale(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "SelectActiveItemsForPurchase(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "GetSelectionFilter(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "SetSelection(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "SetTempFilteredItemRec(PROCEDURE 7)".

}

