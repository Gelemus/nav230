pageextension 60288 pageextension60288 extends "Purchase Quote"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on ""Buy-from Vendor Name"(Control 6)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Buy-from Address"(Control 72)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Buy-from Contact"(Control 8)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Name"(Control 40)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Address"(Control 42)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Ship-to Contact"(Control 48)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Pay-to Name"(Control 22)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Pay-to Address"(Control 24)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Pay-to Contact"(Control 30)".

        addafter("Buy-from Vendor Name")
        {
            field("Request for Quotation Code"; Rec."Request for Quotation Code")
            {
            }
        }
    }
    actions
    {
        modify(Print)
        {
            Visible = false;
        }


        //Unsupported feature: Code Modification on "Print(Action 70).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if ApplicationAreaMgmtFacade.IsFoundationEnabled then
          LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);

        DocPrint.PrintPurchHeader(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        {IF ApplicationAreaMgmtFacade.IsFoundationEnabled THEN
          LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);

        DocPrint.PrintPurchHeader(Rec);}
        */
        //end;
        // addfirst(ActionGroup92)
        // {
        //     action("Print Request for Quotation")
        //     {
        //         Caption = 'Print Quotation';
        //         Image = Print;
        //         Promoted = true;
        //         PromotedCategory = "Report";
        //         PromotedIsBig = true;
        //         ToolTip = 'Prepare to print the document. A report request window where you can specify what to include on the print-out.';

        //         trigger OnAction()
        //         begin

        //             PurchaseHeader.Reset;
        //             PurchaseHeader.SetRange(PurchaseHeader."Request for Quotation Code","Request for Quotation Code");
        //             if PurchaseHeader.FindFirst then begin
        //               REPORT.RunModal(REPORT::"Quatation Report",true,false,PurchaseHeader);
        //             end;


        //             /*
        //             SETRANGE("No.","No.");
        //             ReportSelections.Print(ReportSelections.Usage::RFQ,Rec,0);
        //             */

        //         end;
        //     }
        // }
    }

    var
        PurchaseHeader: Record "Purchase Header";
}

