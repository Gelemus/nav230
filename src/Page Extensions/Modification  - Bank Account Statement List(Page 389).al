pageextension 60260 pageextension60260 extends "Bank Account Statement List"
{
    layout
    {
        addafter("Bank Account No.")
        {
            // field("Bank Account name";"Bank Account name")
            // {
            // }
        }
    }
    actions
    {

        addfirst(creation)
        {
            action("Report")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Report';
                Image = EditLines;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Report "Posted Reconciliation Report";
                ShortCutKey = 'Shift+F7';
                ToolTip = 'View or change detailed information about the record that is being processed on the journal line.';
            }
            action("Bank Account Reconciliation")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Account Reconciliation';
                Image = EditList;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                ShortCutKey = 'Shift+F7';
                ToolTip = 'Bank Account Reconciliation';
            }
        }
    }

    var
        BankAccountStatement: Record "Bank Account Statement";
}

