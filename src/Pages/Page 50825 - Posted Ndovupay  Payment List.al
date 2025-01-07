page 50825 "Posted Ndovupay  Payment List"
{
    CardPageID = "Posted Payment Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Payment Header";
    SourceTableView = SORTING("No.")
                      ORDER(Descending)
                      WHERE("Payment Mode" = CONST(NdovuPay),
                            Posted = CONST(true),
                            "Ndovu Pay Status" = CONST("Payment In Progress"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the document number';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the date when the journals will be posted.';
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ToolTip = 'Specifies the paying bank';
                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {
                    ToolTip = 'Specifies the paying bank name';
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ToolTip = 'Specifies the transaction external reference number, e.g. cheque number';
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                }
                field("Payee Name"; Rec."Payee Name")
                {
                    ToolTip = 'Specifies the vendor or employee being paid';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the transaction currency';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the total amount to be paid to the vendor';
                }
                field("WithHolding Tax Amount"; Rec."WithHolding Tax Amount")
                {
                    ToolTip = 'Specifies the amount of withholding tax being withheld in this payment';
                }
                field("Withholding VAT Amount"; Rec."Withholding VAT Amount")
                {
                    ToolTip = 'Specifies the amount of withholding vat being withheld in this payment';
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ToolTip = 'Specifies the net amount of payment after withholding tax and withholding vat.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the payment approval status,open/pending approval/released/rejected';
                }
                field("Deposit Transaction No"; Rec."Deposit Transaction No")
                {
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the user who did the payment ';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
            }
        }
        area(factboxes)
        {
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = Advanced;
                ToolTip = 'Approvals FactBox';
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Advanced;
                ShowFilter = false;
                ToolTip = 'Incoming Documents Attach FactBox';
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                ToolTip = 'Workflow Status';
                Visible = ShowWorkflowStatus;
            }
            systempart(Control20; Links)
            {
                ToolTip = 'Record Links';
                Visible = false;
            }
            systempart(Control19; Notes)
            {
                ToolTip = 'Notes';
            }
        }
    }

    actions
    {
        area(creation)
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
                        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
                        ReversalEntry: Record "Reversal Entry";
                        "TransactionNo.": Integer;
                        "G/LEntry": Record "G/L Entry";
                        CustLedgerEntry: Record "Cust. Ledger Entry";
                        VendorLedgerEntry: Record "Vendor Ledger Entry";
                        PaymentTxt: Label 'Payment';
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
        PaymentHeader: Record "Payment Header";
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabled := (not HasIncomingDocument) and (Rec."No." <> '');
    end;
}

