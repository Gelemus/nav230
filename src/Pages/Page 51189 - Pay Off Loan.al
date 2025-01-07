page 51189 "Pay Off Loan"
{
    PageType = List;
    Permissions = TableData "Payroll Header" = rimd,
                  TableData "Payroll Entry" = rimd,
                  TableData "Loan Entry" = rimd;
    SourceTable = "Loan Entry";
    SourceTableView = SORTING("No.", "Loan ID")
                      WHERE(Posted = FILTER(false));

    layout
    {
        area(content)
        {
            field(PayOffCode; PayOffCode)
            {
                Caption = 'Payment Type';

                trigger OnLookup(var Text: Text): Boolean
                begin
                    if ACTION::LookupOK = PAGE.RunModal(0, LoanPaymentRec) then
                        PayOffCode := LoanPaymentRec.Code;
                end;
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Period; Rec.Period)
                {
                    Editable = false;
                }
                field("Remaining Debt"; Rec."Remaining Debt")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Pay Off")
            {
                Caption = 'Pay Off';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    lvEmployee: Record Employee;
                begin
                    if PayOffCode = '' then Error('There must be a Payment Code');

                    if not Confirm('Do you realy want to Pay Off This loan', false) then exit;

                    LoanEntryRecTmp.Copy(Rec);
                    LoanEntryRecTmp.Interest := 0;
                    LoanEntryRecTmp.Repayment := Rec."Remaining Debt" + Rec.Repayment;
                    LoanEntryRecTmp."Transfered To Payroll" := true;
                    LoanEntryRecTmp."Remaining Debt" := 0;
                    LoanEntryRecTmp.Posted := true;
                    LoanEntryRecTmp.Insert;

                    Rec.SetFilter("No.", '>=%1', LoanEntryRecTmp."No.");
                    Rec.DeleteAll;

                    Rec.Copy(LoanEntryRecTmp);
                    Rec.Insert;

                    Rec.Get(LoanEntryRecTmp."No.", LoanEntryRecTmp."Loan ID");

                    LoanPaymentRec.Get(PayOffCode);
                    LoanPaymentRec.TestField("Account No.");

                    Loansetup.Get(Rec."Payroll Code");
                    Loansetup.TestField(Loansetup."Loan Template");
                    Loansetup.TestField("Loan Payments Batch");

                    LoansRec.Get(Rec."Loan ID");
                    if not LoansRec."Paid to Employee" then Error('The Loan is not paid out to Employee');
                    LoanTypeRec.Get(LoansRec."Loan Types");
                    lvEmployee.Get(Rec.Employee);

                    TemplateName := Loansetup."Loan Template";
                    BatchName := Loansetup."Loan Payments Batch";

                    GenJnlLine.SetRange("Journal Template Name", TemplateName);
                    GenJnlLine.SetRange("Journal Batch Name", BatchName);
                    if GenJnlLine.Find('+') then
                        LineNo := GenJnlLine."Line No."
                    else
                        LineNo := 0;

                    GenJnlLine."Journal Batch Name" := BatchName;
                    GenJnlLine."Journal Template Name" := TemplateName;
                    LineNo := LineNo + 10000;
                    GenJnlLine."Line No." := LineNo;
                    GenJnlLine."Document No." := StrSubstNo('%1', Rec."Loan ID");
                    GenJnlLine."Posting Date" := WorkDate;

                    case LoanTypeRec."Loan Accounts Type" of
                        LoanTypeRec."Loan Accounts Type"::"G/L Account":
                            begin
                                LoanTypeRec.TestField("Loan Account");
                                GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::"G/L Account");
                                GenJnlLine.Validate("Account No.", LoanTypeRec."Loan Account");
                            end;

                        LoanTypeRec."Loan Accounts Type"::Customer:
                            begin
                                GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Customer);
                                GenJnlLine.Validate("Account No.", gvPayrollUtilities.fGetEmplyeeLoanAccount(lvEmployee, LoanTypeRec));
                            end;

                        LoanTypeRec."Loan Accounts Type"::Vendor:
                            begin
                                LoanTypeRec.TestField("Loan Account");
                                GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Vendor);
                                GenJnlLine.Validate("Account No.", LoanTypeRec."Loan Account");
                            end;
                    end; //Case

                    GenJnlLine.Description := StrSubstNo('Pay off Loan %1', Rec."Loan ID");
                    GenJnlLine.Validate("Currency Code", LoansRec."Currency Code");
                    GenJnlLine.Validate(Amount, -Rec.Repayment);
                    if LoanPaymentRec."Account Type" = LoanPaymentRec."Account Type"::"G/L Account" then
                        GenJnlLine.Validate("Bal. Account Type", GenJnlLine."Bal. Account Type"::"G/L Account")
                    else
                        GenJnlLine.Validate("Bal. Account Type", GenJnlLine."Bal. Account Type"::"Bank Account");
                    GenJnlLine.Validate("Bal. Account No.", LoanPaymentRec."Account No.");
                    GenJnlLine.Validate("Shortcut Dimension 1 Code", lvEmployee."Global Dimension 1 Code");
                    GenJnlLine.Validate("Shortcut Dimension 2 Code", lvEmployee."Global Dimension 2 Code");
                    GenJnlLine.UpdateLineBalance;
                    GenJnlLine.Insert;

                    CurrPage.Update;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        gsSegmentPayrollData;
        if Rec.Find('-') then;
    end;

    var
        LoanEntryRecTmp: Record "Loan Entry" temporary;
        GenJnlLine: Record "Gen. Journal Line";
        Loansetup: Record "Payroll Setups";
        LoanTypeRec: Record "Loan Types";
        LoansRec: Record "Loans/Advances";
        LoanPaymentRec: Record "Loan Payments";
        TemplateName: Code[10];
        BatchName: Code[10];
        LineNo: Integer;
        PayOffCode: Code[20];
        gvPayrollUtilities: Codeunit "Payroll Posting";

    procedure gsSegmentPayrollData()
    var
        lvAllowedPayrolls: Record "Allowed Payrolls";
        lvPayrollUtilities: Codeunit "Payroll Posting";
        UsrID: Code[10];
        UsrID2: Code[10];
        StringLen: Integer;
        lvActiveSession: Record "Active Session";
    begin
        /*lvSession.SETRANGE("My Session", TRUE);
        lvSession.FINDFIRST; //fire error in absence of a login
        IF lvSession."Login Type" = lvSession."Login Type"::Database THEN
          lvAllowedPayrolls.SETRANGE("User ID", USERID)
        ELSE*/

        lvActiveSession.Reset;
        lvActiveSession.SetRange("Server Instance ID", ServiceInstanceId);
        lvActiveSession.SetRange("Session ID", SessionId);
        lvActiveSession.FindFirst;


        lvAllowedPayrolls.SetRange("User ID", lvActiveSession."User ID");
        lvAllowedPayrolls.SetRange("Last Active Payroll", true);
        if lvAllowedPayrolls.FindFirst then
            Rec.SetRange("Payroll Code", lvAllowedPayrolls."Payroll Code")
        else
            Error('You are not allowed access to this payroll dataset.');
        Rec.FilterGroup(100);

    end;
}

