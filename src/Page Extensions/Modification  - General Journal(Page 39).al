pageextension 60261 pageextension60261 extends "General Journal"
{
    layout
    {
        modify("Document Type")
        {
            Visible = false;
        }
        modify("Document No.")
        {
            Enabled = true;
            Editable = true;
        }

        //Unsupported feature: Property Modification (ImplicitType) on ""External Document No."(Control 81)".

        modify(Description)
        {
            Editable = false;
        }
        modify("Currency Code")
        {
            Visible = false;
        }
        modify("EU 3-Party Trade")
        {
            Visible = false;
        }
        modify("Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {

            //Unsupported feature: Property Modification (Name) on ""Shortcut Dimension 1 Code"(Control 136)".

            ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';

            //Unsupported feature: Property Modification (SourceExpr) on ""Shortcut Dimension 1 Code"(Control 136)".

            Visible = DimVisible2;
        }
        modify("Shortcut Dimension 2 Code")
        {

            //Unsupported feature: Property Modification (Name) on ""Shortcut Dimension 2 Code"(Control 135)".

            ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';

            //Unsupported feature: Property Modification (SourceExpr) on ""Shortcut Dimension 2 Code"(Control 135)".

            Visible = DimVisible1;
        }

        //Unsupported feature: Property Deletion (Visible) on ""External Document No."(Control 81)".

        addafter("Document Date")
        {
            field("Line No."; Rec."Line No.")
            {
                Visible = false;
            }
        }
        addafter("External Document No.")
        {
            field("Reference No"; Rec."Reference No")
            {
            }
        }
        addafter(Description)
        {
            field(Description2; Rec.Description2)
            {
                Visible = false;
            }
        }
        addafter("Payer Information")
        {
            field(Payee; Rec.Payee)
            {
            }
        }
        moveafter("Document Date"; "Document No.")
        moveafter("Document No."; "External Document No.")
        moveafter("Account No."; "Shortcut Dimension 2 Code")
        //moveafter("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
        moveafter("Direct Debit Mandate ID"; ShortcutDimCode6)
    }
    actions
    {
        addafter("Test Report")
        {
            action("Vote Payroll")
            {
                Caption = 'Vote Payroll';
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                ShortCutKey = 'F9';

                trigger OnAction()
                begin
                    if UserSetup.Get(UserId) then begin
                        if not UserSetup.CommitBudget then
                            if Confirm('Are you sure you wish to vote this payroll') then
                                FundManagement.CommitBudgetPayroll(Rec);
                        Message('Payroll Voted Successfully');
                    end;
                    //END;
                end;
            }
            action("Budget Committment Lines")
            {
                ApplicationArea = All;
                Caption = 'Budget Committment Lines';
                Promoted = true;
                PromotedCategory = Category7;
                PromotedOnly = true;
                RunObject = Page "Budget Committment Lines";
                RunPageLink = "Document No." = FIELD("Document No.");

                trigger OnAction()
                var
                    GenJournalBatch: Record "Gen. Journal Batch";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    // if OpenApprovalEntriesOnJnlLineExist then
                    //   ApprovalsMgmt.GetApprovalComment(Rec)
                    // else
                    //   if OpenApprovalEntriesOnJnlBatchExist then
                    //     if GenJournalBatch.Get("Journal Template Name","Journal Batch Name") then
                    //       ApprovalsMgmt.GetApprovalComment(GenJournalBatch);
                end;
            }
        }
    }

    var
        UserSetup: Record "User Setup";
        FundManagement: Codeunit "Funds Management";

    //Unsupported feature: Property Modification (Attributes) on "SetUserInteractions(PROCEDURE 2)".

}

