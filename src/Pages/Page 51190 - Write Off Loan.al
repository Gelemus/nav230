page 51190 "Write Off Loan"
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
            action("Write Off")
            {
                Caption = 'Write Off';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    lvEmployee: Record Employee;
                begin
                    if not Confirm('Do you realy want to Pay Off This loan', false) then exit;

                    LoanEntryRecTmp.Copy(Rec);
                    LoanEntryRecTmp.Interest := 0;
                    LoanEntryRecTmp.Repayment := Rec."Remaining Debt" + Rec.Repayment;
                    LoanEntryRecTmp."Transfered To Payroll" := true;
                    LoanEntryRecTmp."Remaining Debt" := 0;
                    LoanEntryRecTmp.Posted := true;
                    //LoanEntryRecTmp."Payroll Code":="Payroll Code";
                    LoanEntryRecTmp.Insert;
                    lvEmployee.Get(Rec.Employee);

                    Rec.SetFilter("No.", '>=%1', LoanEntryRecTmp."No.");
                    Rec.DeleteAll;

                    Rec.Copy(LoanEntryRecTmp);
                    Rec.Insert;

                    Rec.Get(LoanEntryRecTmp."No.", LoanEntryRecTmp."Loan ID");

                    Loansetup.Get(Rec."Payroll Code");
                    Loansetup.TestField(Loansetup."Loan Losses Batch");
                    Loansetup.TestField(Loansetup."Loan Template");

                    LoansRec.Get(Rec."Loan ID");

                    if not LoansRec."Paid to Employee" then
                        Error('The Loan is not paid out to Employee');

                    LoanTypeRec.Get(LoansRec."Loan Types", Rec."Payroll Code");

                    TemplateName := Loansetup."Loan Template";
                    BatchName := Loansetup."Loan Payments Batch";
                    /*
                    GenJnlLine.SETRANGE("Journal Template Name",TemplateName);
                    GenJnlLine.SETRANGE("Journal Batch Name",BatchName);
                    IF GenJnlLine.FIND('+') THEN
                      LineNo := GenJnlLine."Line No."
                    ELSE
                      LineNo := 0;
                    
                    LineNo := LineNo + 10000;
                    GenJnlLine."Journal Batch Name" := BatchName;
                    GenJnlLine."Journal Template Name" := TemplateName;
                    GenJnlLine."Line No." := LineNo;
                    GenJnlLine."Document No." := STRSUBSTNO('%1', "Loan ID");
                    
                    CASE LoanTypeRec."Loan Accounts Type" OF
                      LoanTypeRec."Loan Accounts Type"::"G/L Account": BEGIN
                      //  LoanTypeRec.TESTFIELD("Loan Account");//Frs2719 to be uncommented after gl setup
                        GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                        GenJnlLine.VALIDATE("Account No.", LoanTypeRec."Loan Account");
                      END;
                    
                      LoanTypeRec."Loan Accounts Type"::Customer: BEGIN
                        GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::Customer);
                        GenJnlLine.VALIDATE("Account No.", gvPayrollUtilities.fGetEmplyeeLoanAccount(lvEmployee, LoanTypeRec));
                      END;
                    
                      LoanTypeRec."Loan Accounts Type"::Vendor: BEGIN
                        LoanTypeRec.TESTFIELD("Loan Account");
                        GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::Vendor);
                        GenJnlLine.VALIDATE("Account No.", LoanTypeRec."Loan Account");
                      END;
                    END; //Case
                    
                    GenJnlLine.VALIDATE("Posting Date", WORKDATE);
                    GenJnlLine.Description := STRSUBSTNO('Write off Loan %1', "Loan ID");
                    GenJnlLine.VALIDATE("Currency Code", LoansRec."Currency Code");
                    GenJnlLine.VALIDATE(Amount, -Repayment);
                    GenJnlLine.VALIDATE("Bal. Account Type", LoanTypeRec."Loan Accounts Type");
                    GenJnlLine.VALIDATE("Bal. Account No.", LoanTypeRec."Losses Account Name");
                    GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", lvEmployee."Global Dimension 1 Code");
                    GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", lvEmployee."Global Dimension 2 Code");
                    GenJnlLine.UpdateLineBalance;
                    GenJnlLine.INSERT;
                    */
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

