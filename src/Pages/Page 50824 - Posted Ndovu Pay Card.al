page 50824 "Posted Ndovu Pay Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Payment Header";
    SourceTableView = WHERE("Payment Type" = CONST("Cheque Payment"),
                            Posted = CONST(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the field name';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Cheque Type"; Rec."Cheque Type")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                }
                field("Loan No."; Rec."Loan No.")
                {
                }
                field("Payee Type"; Rec."Payee Type")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Payee No."; Rec."Payee No.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Payee Name"; Rec."Payee Name")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Payee Bank Account Name"; Rec."Payee Bank Account Name")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Total Amount(LCY)"; Rec."Total Amount(LCY)")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("WithHolding Tax Amount"; Rec."WithHolding Tax Amount")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("WithHolding Tax Amount(LCY)"; Rec."WithHolding Tax Amount(LCY)")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Withholding VAT Amount"; Rec."Withholding VAT Amount")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Withholding VAT Amount(LCY)"; Rec."Withholding VAT Amount(LCY)")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Net Amount(LCY)"; Rec."Net Amount(LCY)")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the field name';
                }
                field(Status; Rec.Status)
                {
                    Editable = true;
                    ToolTip = 'Specifies the field name';
                }
                field("Posted By"; Rec."Posted By")
                {
                }
                field("Date Posted"; Rec."Date Posted")
                {
                }
                field("Time Posted"; Rec."Time Posted")
                {
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the field name';
                }
                field(Reversed; Rec.Reversed)
                {
                }
                field("Reversed By"; Rec."Reversed By")
                {
                }
                field("Reversal Date"; Rec."Reversal Date")
                {
                }
                field("Reversal Time"; Rec."Reversal Time")
                {
                }
            }
            part(Control35; "Payment Line")
            {
                Editable = false;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
        area(factboxes)
        {
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = Advanced;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Advanced;
                ShowFilter = false;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(Control25; Links)
            {
                Visible = false;
            }
            systempart(Control24; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Approvals)
            {
            }
            action("Print Payment")
            {
                Caption = 'Print Payment';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ToolTip = 'Prepare to print the document. A report request window where you can specify what to include on the print-out.';

                trigger OnAction()
                begin
                    PaymentHeader.Reset;
                    PaymentHeader.SetRange(PaymentHeader."No.", Rec."No.");
                    if PaymentHeader.FindFirst then begin
                        REPORT.RunModal(REPORT::"Payment Voucher II", true, false, PaymentHeader);
                    end;
                end;
            }
            action("Print Vendor Payment")
            {
                Caption = 'Print Vendor Payment';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ToolTip = 'Prepare to print the document. A report request window where you can specify what to include on the print-out.';

                trigger OnAction()
                begin
                    PaymentHeader.Reset;
                    PaymentHeader.SetRange(PaymentHeader."No.", Rec."No.");
                    if PaymentHeader.FindFirst then begin
                        REPORT.RunModal(REPORT::"Payment Voucher III", true, false, PaymentHeader);
                    end;
                end;
            }
            action("Print Cheque")
            {
                Caption = 'Print Cheque';
                Image = Check;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ToolTip = 'Print Bank Cheque for this Payment';

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Posted);
                    Rec.TestField("Cheque Type", Rec."Cheque Type"::"Computer Cheque");

                    PaymentHeader.Reset;
                    PaymentHeader.SetRange(PaymentHeader."No.", Rec."No.");
                    if PaymentHeader.FindFirst then
                        REPORT.Run(REPORT::"Cheque Print", true, true, PaymentHeader);
                end;
            }
            group(Reversal)
            {
                Caption = 'Reversal';
                Image = "Action";
                action("Reverse Payment")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reverse Payment';
                    Ellipsis = true;
                    Image = ReverseRegister;
                    Scope = Repeater;
                    ToolTip = 'Reverse a posted payment.';

                    trigger OnAction()
                    var
                        ReversalEntry: Record "Reversal Entry";
                        "TransactionNo.": Integer;
                        "G/LEntry": Record "G/L Entry";
                        CustLedgerEntry: Record "Cust. Ledger Entry";
                        VendorLedgerEntry: Record "Vendor Ledger Entry";
                    begin
                        Clear(ReversalEntry);
                        if Rec.Reversed then
                            ReversalEntry.AlreadyReversedDocument(PaymentTxt, Rec."No.");

                        //Get transaction no.
                        BankAccountLedgerEntry.Reset;
                        BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Document No.", Rec."No.");
                        BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry.Reversed, false);
                        if BankAccountLedgerEntry.FindFirst then begin
                            ReversalEntry.ReverseTransaction(BankAccountLedgerEntry."Transaction No.");
                        end;

                        Commit;

                        //Update the document
                        BankAccountLedgerEntry.Reset;
                        BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Document No.", Rec."No.");
                        BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry.Reversed, true);
                        if BankAccountLedgerEntry.FindLast then begin
                            Rec.Status := Rec.Status::Reversed;
                            Rec.Reversed := true;
                            Rec."Reversal Date" := Today;
                            Rec."Reversal Time" := Time;
                            Rec."Reversed By" := UserId;
                            Rec.Modify;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(Rec.RecordId);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RecordId);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Cheque Payment";
    end;

    var
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        PaymentHeader: Record "Payment Header";
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
        PaymentTxt: Label 'Payment';

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabled := (not HasIncomingDocument) and (Rec."No." <> '');
    end;
}

