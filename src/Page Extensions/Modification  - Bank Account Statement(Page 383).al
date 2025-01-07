pageextension 60258 pageextension60258 extends "Bank Account Statement"
{

    //Unsupported feature: Property Insertion (DeleteAllowed) on ""Bank Account Statement"(Page 383)".


    //Unsupported feature: Property Insertion (ModifyAllowed) on ""Bank Account Statement"(Page 383)".

    layout
    {
        addafter("Bank Account No.")
        {
            // field("Bank Account name";Rec."Bank Account name")
            // {
            // }
        }
    }
    actions
    {
        addafter("&Card")
        {
            action("Print Report")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Report';
                Image = EditLines;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                ShortCutKey = 'Shift+F7';
                ToolTip = 'View or change detailed information about the record that is being processed on the journal line.';
                Visible = false;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetRange("Bank Account No.", Rec."Bank Account No.");
                    Rec.SetRange("Statement No.", Rec."Statement No.");
                    if Rec.FindSet then begin
                        REPORT.RunModal(REPORT::"Bank Account Reconciliation2", true, false, Rec);
                    end;
                end;
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

                trigger OnAction()
                begin
                    BankAccountStatement.Reset;
                    BankAccountStatement.SetRange(BankAccountStatement."Bank Account No.", Rec."Bank Account No.");
                    BankAccountStatement.SetRange(BankAccountStatement."Statement No.", Rec."Statement No.");
                    if BankAccountStatement.FindFirst then begin
                        REPORT.RunModal(REPORT::"Bank Account Reconciliation4", true, false, BankAccountStatement);
                    end;
                end;
            }
        }
    }

    var
        BankAccountStatement: Record "Bank Account Statement";
}

