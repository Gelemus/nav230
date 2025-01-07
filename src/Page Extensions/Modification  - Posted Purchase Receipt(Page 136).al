pageextension 60077 pageextension60077 extends "Posted Purchase Receipt"
{

    //Unsupported feature: Property Insertion (DeleteAllowed) on ""Posted Purchase Receipt"(Page 136)".

    actions
    {

        addafter("&Print")
        {
            action("PRINT GRN")

            {
                ApplicationArea = Suite;
                Caption = '&Print GRN';
                Ellipsis = true;
                Image = Print;
                Visible = true;
                Enabled = true;
                Promoted = true;
                PromotedCategory = Category10;
                ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    PurcharRecptseHeader: Record "Purch. Rcpt. Header";
                    GRN: Report "GOODS RECEIVED NOTE";

                begin
                    PurcharRecptseHeader.Reset;
                    PurcharRecptseHeader.SetRange("No.", PurcharRecptseHeader."No.");
                    Clear(GRN);
                    GRN.SetTableView(PurcharRecptseHeader);
                    GRN.Run
                    // PurcharRecptseHeader.Reset;
                    // PurcharRecptseHeader.SetRange("No.", PurcharRecptseHeader."No.");
                    // if PurcharRecptseHeader.FindFirst then begin
                    //     REPORT.RunModal(50110, true, false, PurcharRecptseHeader);
                    // end;
                end;
            }

        }
    }
}

