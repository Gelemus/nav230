page 50073 "Journal Voucher Lines"
{
    PageType = ListPart;
    SourceTable = "Journal Voucher Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Account No."; Rec."Account No.")
                {
                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                }
                field("Bal. Account Name"; Rec."Bal. Account Name")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    Visible = false;
                }
                field("External Document No."; Rec."External Document No.")
                {
                }
                field("Reference No"; Rec."Reference No")
                {
                }
                field("FA Posting Date"; Rec."FA Posting Date")
                {
                    Visible = false;
                }
                field("FA Posting Type"; Rec."FA Posting Type")
                {
                    Visible = false;
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Upload File")
            {
                Caption = 'Upload File';
                Image = "Action";
                action("Upload csv")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Upload csv';
                    Image = ImportExcel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Import electronic bank statements from your bank to populate with data about actual bank transactions.';

                    trigger OnAction()
                    begin
                        /*CurrPage.UPDATE;
                        CLEAR(ImportBankStatementxml);
                        ImportBankStatementxml.SetstatementDetails("Statement No.","Bank Account No.");
                        ImportBankStatementxml.RUN;
                        */
                        //ImportBankStatement;

                    end;
                }
            }
        }
    }
}

