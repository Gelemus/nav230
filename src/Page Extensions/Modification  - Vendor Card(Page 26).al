pageextension 60218 pageextension60218 extends "Vendor Card"
{
    layout
    {
        // modify("Our Account No.")
        // {
        //     Visible = false;
        // }
        // addafter(Name)
        // {
        //     field(PIN; Rec.PIN)
        //     {
        //     }
        //     field("Our Account No."; Rec."Our Account No.")
        //     {
        //     }
        // }
    }
    actions
    {
        addafter("Vendor - Summary Aging")
        {
            action("Vendor Statement")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendor Statement';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                ToolTip = 'View a summary of the payables owed to each vendor, divided into three time periods.';

                trigger OnAction()
                begin
                    RunReport(REPORT::"Vendor Statement");
                end;
            }
        }
    }

    var
        UserSetup: Record "User Setup";
        PemissionDenied: Label 'You are not setup to Create Items. Contact System Administrator';


    //Unsupported feature: Code Modification on "OnNewRecord".

    //trigger OnNewRecord(BelowxRec: Boolean)
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if GuiAllowed then
      if "No." = '' then
        if DocumentNoVisibility.VendorNoSeriesIsDefault then
          NewMode := true;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //Check if is allowed to create
    if UserSetup.Get(UserId) then begin
      if not UserSetup."Vendor Creation" then
        Error(PemissionDenied);
     end;
     // End Check if is allowed to create

    #1..4
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCreateVendorFromTemplate(PROCEDURE 5)".

}

