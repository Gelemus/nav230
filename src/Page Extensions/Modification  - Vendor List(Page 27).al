pageextension 60219 pageextension60219 extends "Vendor List" 
{
    Caption = 'Supplier List';
    layout
    {

        //Unsupported feature: Property Modification (Name) on ""Search Name"(Control 12)".


        //Unsupported feature: Property Modification (SourceExpr) on ""Search Name"(Control 12)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Search Name"(Control 12)".

        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Country/Region Code")
        {
            Visible = false;
        }
        modify("Fax No.")
        {
            Visible = false;
        }
        modify("IC Partner Code")
        {
            Visible = false;
        }
        modify(Contact)
        {
            Visible = false;
        }
        modify("Purchaser Code")
        {
            Visible = false;
        }
        modify("Language Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Search Name"(Control 12)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Search Name"(Control 12)".

        modify("Location Code2")
        {
            Visible = false;
        }
        modify("Shipment Method Code")
        {
            Visible = false;
        }
        modify("Lead Time Calculation")
        {
            Visible = false;
        }
        modify("Base Calendar Code")
        {
            Visible = false;
        }
        moveafter("Currency Code";Blocked)
    }
    actions
    {
        addafter(PayVendor)
        {
            action("Import Suppliers")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = XMLport "Imprests Export and Import";
            }
        }
        addafter("Vendor - Detail Trial Balance")
        {
            action("Vendor Statements")
            {
                ApplicationArea = Suite;
                Caption = 'Vendor Statements';
                Image = "Report";
                RunObject = Report "Vendor Statements";
                ToolTip = 'View a list of all vendor ledger entries on which the On Hold field is marked.';
            }
        }
    }

    var
        UserSetup: Record "User Setup";
        PemissionDenied: Label 'You are not setup to Create Items. Contact System Administrator';


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        if SocialListeningSetupVisible then
          SocialListeningMgt.GetVendFactboxVisibility(Rec,SocialListeningSetupVisible,SocialListeningVisible);

        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);

        WorkflowWebhookManagement.GetCanRequestAndCanCancel(RecordId,CanRequestApprovalForFlow,CanCancelApprovalForFlow);

        // Contextual Power BI FactBox: send data to filter the report in the FactBox
        CurrPage."Power BI Report FactBox".PAGE.SetCurrentListSelection("No.",false,PowerBIVisible);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        {IF SocialListeningSetupVisible THEN
          SocialListeningMgt.GetVendFactboxVisibility(Rec,SocialListeningSetupVisible,SocialListeningVisible);

        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);

        WorkflowWebhookManagement.GetCanRequestAndCanCancel(RECORDID,CanRequestApprovalForFlow,CanCancelApprovalForFlow);

        // Contextual Power BI FactBox: send data to filter the report in the FactBox
        CurrPage."Power BI Report FactBox".PAGE.SetCurrentListSelection("No.",FALSE,PowerBIVisible);
        }
        */
    //end;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SetVendorNoVisibilityOnFactBoxes;
        CurrPage."Power BI Report FactBox".PAGE.InitFactBox(CurrPage.ObjectId(false),CurrPage.Caption,PowerBIVisible);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        {SetVendorNoVisibilityOnFactBoxes;
        CurrPage."Power BI Report FactBox".PAGE.InitFactBox(CurrPage.OBJECTID(FALSE),CurrPage.CAPTION,PowerBIVisible);}
        */
    //end;


    //Unsupported feature: Code Insertion on "OnInsertRecord".

    //trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    //begin
        /*
        Type:=Type::Normal;
        */
    //end;


    //Unsupported feature: Code Insertion on "OnNewRecord".

    //trigger OnNewRecord(BelowxRec: Boolean)
    //begin
        /*
        //Check if is allowed to create
        if UserSetup.Get(UserId) then begin
          if not UserSetup."Vendor Creation" then
            Error(PemissionDenied);
         end;
         // End Check if is allowed to create

        Type:=Type::Normal;
        */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SetFilter("Date Filter",'..%1',WorkDate);
        with SocialListeningSetup do
          SocialListeningSetupVisible := Get and "Show on Customers" and "Accept License Agreement" and ("Solution ID" <> '');
        ResyncVisible := ReadSoftOCRMasterDataSync.IsSyncEnabled;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SetFilter("Date Filter",'..%1',WorkDate);
        {WITH SocialListeningSetup DO
          SocialListeningSetupVisible := GET AND "Show on Customers" AND "Accept License Agreement" AND ("Solution ID" <> '');
        ResyncVisible := ReadSoftOCRMasterDataSync.IsSyncEnabled;}
        Type:=Type::Normal;
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "GetSelectionFilter(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "SetSelection(PROCEDURE 1)".

}

