pageextension 60755 pageextension60755 extends "Purchase Order List"
{

    //Unsupported feature: Property Modification (SourceTableView) on ""Purchase Order List"(Page 9307)".


    //Unsupported feature: Property Insertion (DeleteAllowed) on ""Purchase Order List"(Page 9307)".

    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on ""Buy-from Vendor Name"(Control 6)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Buy-from Contact"(Control 35)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Pay-to Name"(Control 161)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Pay-to Contact"(Control 151)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Name"(Control 145)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Contact"(Control 135)".

        modify("Location Code")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Document Date")
        {
            Visible = false;
        }
        // modify("Posting Description")
        // {

        //     //Unsupported feature: Property Modification (Name) on ""Posting Description"(Control 28)".


        //     //Unsupported feature: Property Modification (SourceExpr) on ""Posting Description"(Control 28)".


        //     //Unsupported feature: Property Modification (ImplicitType) on ""Posting Description"(Control 28)".

        //     Editable = false;
        // }
        // modify("Posting Date")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Description"(Control 28)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Posting Description"(Control 28)".


        //Unsupported feature: Property Deletion (Visible) on ""Posting Description"(Control 28)".

        addafter("Pay-to Name")
        {
            // field("Posting Description"; Rec."Posting Description")
            // {
            // }
        }
        // addafter("Posting Description")
        // {
        //     field("Reference No";Rec."Reference No")
        //     {
        //         Editable = false;
        //     }
        // }
        addafter("Assigned User ID")
        {
            field("User ID"; Rec."User ID")
            {
            }
        }
        addafter("Currency Code")
        {
            // field("Posting Date"; Rec."Posting Date")
            // {
            // }
        }
        addfirst(FactBoxes)
        {
            part(Control39; "Purchase Agent Activities")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control38; "My Vendors")
            {
                ApplicationArea = Basic, Suite;
            }
        }
        //  moveafter("Pay-to Name";"Posting Description")
    }
    actions
    {
        modify(Print)
        {
            Caption = '&Print LPO';
        }
        modify(Send)
        {
            Visible = false;
        }


        //Unsupported feature: Code Modification on "Print(Action 55).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PurchaseHeader := Rec;
        CurrPage.SetSelectionFilter(PurchaseHeader);
        PurchaseHeader.PrintRecords(true);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PurchaseHeader.Reset;
        PurchaseHeader.SetRange("No.","No.");
        Clear(LPO);
        //CurrPage.SETSELECTIONFILTER(PurchaseHeader);
        //PurchaseHeader.PrintRecords(TRUE);
        LPO.SetTableView(PurchaseHeader);
        LPO.Run
        */
        //end;


        //Unsupported feature: Code Modification on "Post(Action 52).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if ApplicationAreaMgmtFacade.IsFoundationEnabled then
          LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);

        #4..10
          PurchaseBatchPostMgt.RunWithUI(PurchaseHeader,Count,ReadyToPostQst);
        end else
          SendToPosting(CODEUNIT::"Purch.-Post (Yes/No)");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestInspectionStatus("No.");
        #1..13
        */
        //end;


        //Unsupported feature: Code Modification on "PostAndPrint(Action 53).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SendToPosting(CODEUNIT::"Purch.-Post + Print");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestInspectionStatus("No.");
        SendToPosting(CODEUNIT::"Purch.-Post + Print");
        */
        //end;
        addafter(Print)
        {
            action("Print LSO")
            {
                ApplicationArea = Suite;
                Caption = '&Print LSO';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category5;
                ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';
                Visible = false;

                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                begin
                    PurchaseHeader.Reset;
                    PurchaseHeader.SetRange("No.", Rec."No.");
                    Clear(LSO);
                    //CurrPage.SETSELECTIONFILTER(PurchaseHeader);
                    //PurchaseHeader.PrintRecords(TRUE);
                    LSO.SetTableView(PurchaseHeader);
                    LSO.Run
                end;
            }
        }
    }

    var
        LPO: Report "New Purchase Order";
        LSO: Report "New Service Order";

    //Unsupported feature: Property Modification (Attributes) on "SkipShowingLinesWithoutVAT(PROCEDURE 2)".

}

