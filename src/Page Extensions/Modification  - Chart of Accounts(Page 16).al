pageextension 60123 pageextension60123 extends "Chart of Accounts"
{
    layout
    {

        //Unsupported feature: Property Modification (Name) on ""Debit Amount"(Control 15)".


        //Unsupported feature: Property Modification (SourceExpr) on ""Debit Amount"(Control 15)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Debit Amount"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Debit Amount"(Control 15)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Debit Amount"(Control 15)".


        //Unsupported feature: Property Deletion (Visible) on ""Debit Amount"(Control 15)".

        //     modify("Credit Amount")
        //     {
        //         Visible = false;
        //     }
        //     addafter("Debit Amount")
        //     {
        //         field("Debit Amount";"Debit Amount")
        //         {
        //         }
        //         field("Credit Amount";"Credit Amount")
        //         {
        //         }
        //     }
        //     moveafter(Name;"Debit Amount")
        //     moveafter(Balance;"Balance at Date")
        // }
        // actions
        // {


        //Unsupported feature: Code Insertion on ""Detail Trial Balance"(Action 1900670506)".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //begin
        /*
        //RESET;
        Rec.SetRange("No.",xRec."No.");
        if FindSet then begin
          REPORT.RunModal(REPORT::"Detail Trial Balance",true,false,Rec);
        end;
        */
        //end;


        //Unsupported feature: Code Insertion on ""Trial Balance"(Action 1904082706)".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //begin
        /*
        //RESET;
        Rec.SetRange("No.",xRec."No.");
        if FindSet then begin
          REPORT.RunModal(REPORT::"Trial Balance",true,false,Rec);
        end;
        */
        //end;
        //     addafter("Detail Trial Balance")
        //     {
        //         action("Working Capital Ledger")
        //         {
        //             ApplicationArea = Basic,Suite;
        //             Caption = 'Working Capital Ledger';
        //             Image = "Report";
        //             Promoted = true;
        //             PromotedCategory = "Report";
        //             PromotedOnly = true;
        //             RunObject = Report "Working Capital Ledger";
        //             ToolTip = 'View a detail trial balance for the general ledger accounts that you specify.';
        //         }
        //     }
        // }

        // var
        //     UserSetup: Record "User Setup";
        //     PemissionDenied: Label 'You are not setup to Create Chart of Accountss. Contact System Administrator';


        //Unsupported feature: Code Modification on "OnNewRecord".

        //trigger OnNewRecord(BelowxRec: Boolean)
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SetupNewGLAcc(xRec,BelowxRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //Check if is allowed to create
        if UserSetup.Get(UserId) then begin
          if not UserSetup."Chart of Account Creation" then
            Error(PemissionDenied);
         end;
         // End Check if is allowed to create

        SetupNewGLAcc(xRec,BelowxRec);
        */
        //end;
    }

}