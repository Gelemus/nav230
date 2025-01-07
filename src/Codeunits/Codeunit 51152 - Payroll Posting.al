codeunit 51152 "Payroll Posting"
{ // Permissions = TableData TableData52021050=rm,
    //               TableData TableData52021051=rimd,
    //               TableData TableData52021055=rimd,
    //               TableData TableData52021063=rm;

    trigger OnRun()
    begin
        gvTestPost := StrMenu('Print Test Journal Only,Print and Generate Journals,Generate Journals Without Printing');
        if gvTestPost = 0 then exit;

        gvPayrollUtilities.sGetActivePayroll(gvAllowedPayrolls);

        if gvTestPost > 1 then
            if Confirm('Once you generate payroll journals, the payroll month will not be\' +
                     'available for edit.\\' +
                     'Proceed anyway ?') = false then
                exit;

        if sGetPeriod then begin
            gvPostBuffer.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
            gvPostBuffer.DeleteAll(true);
            gvPostBuffer.Reset;
            if gvPostBuffer.FindLast then gvLastBufferNo := gvPostBuffer."Buffer No";

            sInitialInfo;
            sLoopHeader;
            sWriteToGenJnlLines;
            // sDeleteEntry;//To be uncommented  lateer

        end
    end;

    var
        gvPostBuffer: Record "Payroll Posting Buffer";
        gvLastBufferNo: BigInteger;
        gvPostingDate: Date;
        gvWindow: Dialog;
        gvPeriodID: Code[10];
        gvMonth: Integer;
        gvYear: Integer;
        gvBalAccount: Code[20];
        gvBalAccountType: Option "G/L Account",Customer,Vendor,"Bank Account";
        gvEmploPostingGroup: Code[20];
        gvEDPostingGroup: Code[20];
        gvEDAccount: Code[20];
        gvTemplateName: Code[10];
        gvBatchName: Code[10];
        gvEDPostingType: Option "None","G/L Account",Direct,Customer,Vendor;
        gvEDDebitCredit: Option Debit,Credit;
        gvWindowCounter: Integer;
        gvEmpCustNo: Code[20];
        gvEmpRec: Record Employee;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        gvPayrollUtilities: Codeunit "Payroll Posting";
        gvPayrollDims: Record "Payroll Dimension";
        gvTestPost: Integer;
        gvLineNo: Integer;
        "---V.6.1.65---": Integer;
        gvGenJnlLine: Record "Gen. Journal Line";
        "=TestCalculated=": Integer;
        gvAllowedPayrolls2: Record "Allowed Payrolls";
        gvPayrollUtilities2: Codeunit "Payroll Posting";
        "=PayrollUtilities": Integer;
        LoginMgmt: Codeunit "User Management";
        DimMgt: Codeunit DimensionManagement;
        gvPostBufferCopy: Record "Payroll Posting Buffer";

    procedure sGetPeriod(): Boolean
    var
        lvPayrollPeriod: Record Periods;
        lvHeader: Record "Payroll Header";
    begin
        //This function gets the first period which is "Open" and tests if the next period is open      *

        lvPayrollPeriod.SetCurrentKey("Start Date");
        lvPayrollPeriod.SetRange(Status, 1);
        lvPayrollPeriod.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");

        if lvPayrollPeriod.Find('-') then begin
            gvPeriodID := lvPayrollPeriod."Period ID";
            gvMonth := lvPayrollPeriod."Period Month";
            gvYear := lvPayrollPeriod."Period Year";
            gvPostingDate := lvPayrollPeriod."Posting Date";
        end else
            Error('There are no periods to be Posted');

        if gvTestPost > 1 then begin
            if Confirm('Do you really want to generate entries\for the period %1', false, gvPeriodID) then begin
                if not lvPayrollPeriod.Find('>') then Error('The next period must be open to post this period');
                lvPayrollPeriod.Get(gvPeriodID, gvMonth, gvYear, gvAllowedPayrolls."Payroll Code");
                lvPayrollPeriod.Status := lvPayrollPeriod.Status::Posted; //to be un commented later
                lvPayrollPeriod.Modify;

                gvWindow.Open('Creating Total           #1######\' +
                              'Posting to G/L Journal   #2######\' +
                              'Moving Payroll Header    #3######\' +
                              'Moving Payroll Lines     #4######');

                lvHeader.SetRange("Payroll ID", gvPeriodID);
                lvHeader.SetRange(Calculated, false);
                lvHeader.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                if lvHeader.Find('-') then Error('Not all Payroll entries are calculated!\Calculate them before posting.');
                exit(true);
            end else
                exit(false);
        end else begin
            if not lvPayrollPeriod.Find('>') then Error('The next period must be open to post this period');
            lvPayrollPeriod.Get(gvPeriodID, gvMonth, gvYear, gvAllowedPayrolls."Payroll Code");
            lvPayrollPeriod.Status := lvPayrollPeriod.Status::Posted;
            lvPayrollPeriod.Modify;

            gvWindow.Open('Creating Total           #1######\' +
                          'Posting to G/L Journal   #2######\' +
                          'Moving Payroll Header    #3######\' +
                          'Moving Payroll Lines     #4######');

            lvHeader.SetRange("Payroll ID", gvPeriodID);
            lvHeader.SetRange(Calculated, false);
            lvHeader.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
            if lvHeader.Find('-') then Error('Not all Payroll entries are calculated!\Calculate them before posting.');
            exit(true);
        end;
    end;

    procedure sInitialInfo()
    var
        lvPayrollSetup: Record "Payroll Setups";
    begin
        //Get payroll setup info.
        lvPayrollSetup.Get(gvAllowedPayrolls."Payroll Code");
        lvPayrollSetup.TestField("Payroll Template");
        lvPayrollSetup.TestField("Payroll Batch");

        gvTemplateName := lvPayrollSetup."Payroll Template";
        gvBatchName := lvPayrollSetup."Payroll Batch";
    end;

    procedure sLoopHeader()
    var
        lvHeader: Record "Payroll Header";
    begin
        lvHeader.LockTable(true);
        lvHeader.SetRange("Payroll ID", gvPeriodID);
        lvHeader.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
        //lvHeader.SETFILTER("Employee no.",'%1|%2','0008','0011/00882');
        gvWindowCounter := 0;
        lvHeader.Find('-');
        repeat
            gvWindowCounter := gvWindowCounter + 1;
            gvWindow.Update(1, gvWindowCounter);
            sLoopLines(lvHeader);
            sInsertNetpayLine(lvHeader);
            lvHeader.Posted := true;
            lvHeader.Modify;
        until lvHeader.Next = 0;

        //V.6.1.65 >>
        Clear(gvGenJnlLine);
        gvGenJnlLine.SetRange("Journal Batch Name", gvBatchName);
        gvGenJnlLine.SetRange("Journal Template Name", 'CASHRCPT');
        gvGenJnlLine.SetRange("Document Type", gvGenJnlLine."Document Type"::Payment);
        gvGenJnlLine.SetRange("Posting Date", gvPostingDate);
        if gvGenJnlLine.FindFirst then
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", gvGenJnlLine);
        //V.6.1.65 >>
    end;

    procedure sLoopLines(var Header: Record "Payroll Header")
    var
        lvLines: Record "Payroll Lines";
        lvLoanTypeRec: Record "Loan Types";
        lvLoansRec: Record "Loans/Advances";
        lvLoanEntryRec: Record "Loan Entry";
        lvAmount: Decimal;
        lvInterestAmount: Decimal;
        lvRepaymentAmount: Decimal;
        lvPayrollSetup: Record "Payroll Setups";
    begin
        lvLines.LockTable(true);
        lvLines.SetCurrentKey("Payroll ID", "Employee No.");
        lvLines.SetRange("Payroll ID", gvPeriodID);
        lvLines.SetRange("Employee No.", Header."Employee no.");
        //lvPayrollSetup.GET(lvLines."Payroll Code");

        sGetEmployeeInfo(Header);
        if lvLines.Find('-') then begin
            repeat
                //V.6.1.65 >>
                if lvPayrollSetup."Make Personal A/C Recoveries" then
                    if lvPayrollSetup."Personal Account Recoveries ED" = lvLines."ED Code" then sWriteToGenJnlLinesForPayment(lvLines);
                //V.6.1.65 >>

                if lvLines."Loan Entry" then begin
                    lvLoansRec.Get(lvLines."Loan ID");
                    lvLoanEntryRec.Get(lvLines."Loan Entry No", lvLines."Loan ID");
                    lvLoanTypeRec.Get(lvLoansRec."Loan Types", lvLines."Payroll Code");
                    //   lvLoanTypeRec.TESTFIELD("Loan Interest Account");//Frs271119>> to be uncommented after g/l setup

                    lvLoanEntryRec.Posted := true;
                    lvLoanEntryRec.Modify;
                    lvInterestAmount := -lvLines.Interest;
                    lvRepaymentAmount := -lvLines.Repayment;

                    if lvLoanTypeRec."Loan Accounts Type" = lvLoanTypeRec."Loan Accounts Type"::Employee then begin
                        // gvEmpRec.GET(Header."Employee no.");
                        //gvEmpCustNo := gvPayrollUtilities.fGetEmplyeeLoanAccount(gvEmpRec, lvLoanTypeRec);
                        sInsertLineWithAccountType(Header."Employee no.", lvRepaymentAmount, Header, lvLines, gvPostBuffer."Account Type"::Employee,
                          -lvLines."Repayment (LCY)");
                    end else begin
                        lvLoanTypeRec.TestField("Loan Account");
                        sInsertLineWithAccountType(lvLoanTypeRec."Loan Account", lvRepaymentAmount, Header, lvLines,
                          lvLoanTypeRec."Loan Accounts Type", -lvLines."Repayment (LCY)");
                    end;
                    sInsertLineWithAccountType(lvLoanTypeRec."Loan Interest Account", lvInterestAmount, Header, lvLines,
                        lvLoanTypeRec."Loan Interest Account Type", -lvLines."Interest (LCY)");
                end else begin
                    sGetEDInfo(lvLines."ED Code", lvLines."Employee No.");
                    lvAmount := lvLines.Amount;

                    case gvEDPostingType of
                        gvEDPostingType::"G/L Account":
                            sGLPosting(lvAmount, Header, lvLines, lvLines."Amount (LCY)");

                        gvEDPostingType::Direct:
                            begin
                                if gvEDDebitCredit = gvEDDebitCredit::Debit then
                                    sInsertLine(gvEDAccount, lvAmount, Header, lvLines, lvLines."Amount (LCY)")
                                else begin
                                    lvAmount := -lvAmount;
                                    sInsertLine(gvEDAccount, lvAmount, Header, lvLines, -lvLines."Amount (LCY)")
                                end;
                            end; //case

                        gvEDPostingType::Customer:
                            begin
                                gvEmpRec.Get(Header."Employee no.");
                                gvEmpRec.TestField("Customer No.");
                                gvEmpCustNo := gvEmpRec."Customer No.";
                                if gvEDDebitCredit = gvEDDebitCredit::Debit then
                                    sInsertLineWithAccountType(gvEmpCustNo, lvAmount, Header, lvLines, gvPostBuffer."Account Type"::Customer,
                                      lvLines."Amount (LCY)")
                                else begin
                                    lvAmount := -lvAmount;
                                    sInsertLineWithAccountType(gvEmpCustNo, lvAmount, Header, lvLines, gvPostBuffer."Account Type"::Customer,
                                      -lvLines."Amount (LCY)")
                                end;
                            end;

                        gvEDPostingType::Vendor:
                            begin
                                if gvEDDebitCredit = gvEDDebitCredit::Debit then
                                    sInsertLineWithAccountType(gvEDAccount, lvAmount, Header, lvLines, gvPostBuffer."Account Type"::Vendor,
                                      lvLines."Amount (LCY)")
                                else begin
                                    lvAmount := -lvAmount;
                                    sInsertLineWithAccountType(gvEDAccount, lvAmount, Header, lvLines, gvPostBuffer."Account Type"::Vendor,
                                     -lvLines."Amount (LCY)")
                                end;
                            end;
                    end; //Case
                end; //Else
            until lvLines.Next = 0;
        end;
    end;

    procedure sGetEmployeeInfo(var Header: Record "Payroll Header")
    var
        lvEmployee: Record Employee;
        lvModeOfPayment: Record "Mode of Payment";
    begin
        if lvEmployee.Get(Header."Employee no.") then begin
            gvEmpCustNo := '';
            lvEmployee.TestField("Posting Group");
            gvEmploPostingGroup := lvEmployee."Posting Group";

            lvEmployee.TestField("Mode of Payment");
            lvModeOfPayment.Get(lvEmployee."Mode of Payment");
            gvBalAccountType := lvModeOfPayment."Net Pay Account Type";
            gvBalAccount := lvModeOfPayment."Net Pay Account No";
        end else
            Error('Employee No. %1 does not exits\create the employee again', Header."Employee no.");
    end;

    procedure sGetEDInfo(var EDCode: Code[20]; EmpNo: Code[20])
    var
        lvEDDef: Record "ED Definitions";
        lvEmpRec: Record Employee;
    begin
        lvEDDef.Get(EDCode);
        gvEDPostingType := lvEDDef."Posting type";

        if lvEDDef."Posting type" = lvEDDef."Posting type"::Customer then begin
            lvEmpRec.Get(EmpNo);
            lvEmpRec.TestField("Customer No.");
            gvEDAccount := lvEmpRec."Customer No.";
        end else
            gvEDAccount := lvEDDef."Account No";

        gvEDPostingGroup := lvEDDef."ED Posting Group";

        lvEmpRec.Get(EmpNo);
        gvEDDebitCredit := lvEDDef."Debit/Credit";
    end;

    procedure sGLPosting(Amount: Decimal; PayrollHdr: Record "Payroll Header"; PayrollLine: Record "Payroll Lines"; AmountLCY: Decimal)
    var
        PostSetup: Record "Payroll Posting Setup";
    begin
        PostSetup.Get(gvEmploPostingGroup, gvEDPostingGroup);
        //PostSetup.TESTFIELD("Debit Account");
        //PostSetup.TESTFIELD("Credit Account");

        if PostSetup."Debit Account" <> '' then
            sInsertLine(PostSetup."Debit Account", Amount, PayrollHdr, PayrollLine, AmountLCY);

        if PostSetup."Credit Account" <> '' then begin
            sInsertLine(PostSetup."Credit Account", -Amount, PayrollHdr, PayrollLine, -AmountLCY)
        end;
    end;

    procedure sInsertLine(var AccountNo: Code[20]; Amount: Decimal; PayrollHdr: Record "Payroll Header"; PayrollLine: Record "Payroll Lines"; AmountLCY: Decimal)
    var
        "Account Type": Option "G/L Account",Customer,Vendor;
        PayrollBufferDims: Record "Payroll Dimension" temporary;
    begin
        //Posting to to a G/L Account
        gvPostBuffer.Reset;
        gvPostBuffer.SetCurrentKey("Account Type", "Account No", "Payroll Code", "ED Code");
        gvPostBuffer.SetRange("Account Type", gvPostBuffer."Account Type"::"G/L Account");
        gvPostBuffer.SetRange("Account No", AccountNo);
        gvPostBuffer.SetRange("Payroll Code", PayrollHdr."Payroll Code");
        gvPostBuffer.SetRange("ED Code", PayrollLine."ED Code");
        gvPostBuffer.SetRange("Currency Code", PayrollLine."Currency Code");

        if gvPostBuffer.FindFirst then
            if fWithSameDimensions(gvPostBuffer, PayrollHdr, PayrollLine, PayrollBufferDims) then begin
                gvPostBuffer.Amount += Amount;
                gvPostBuffer."Amount (LCY)" += AmountLCY;
                gvPostBuffer."Employee No." := PayrollHdr."Employee no."; //cmm 161011 add employee on journal posting line descrption AAFH
                gvPostBuffer.Modify;
            end else begin
                gvLastBufferNo += 1;
                gvPostBuffer.Reset;
                gvPostBuffer.Init;
                gvPostBuffer."Buffer No" := gvLastBufferNo;
                gvPostBuffer."Account Type" := gvPostBuffer."Account Type"::"G/L Account";
                gvPostBuffer."Account No" := AccountNo;
                gvPostBuffer."Payroll Code" := gvAllowedPayrolls."Payroll Code";
                gvPostBuffer."ED Code" := PayrollLine."ED Code";
                gvPostBuffer."Currency Code" := PayrollLine."Currency Code";
                gvPostBuffer.Amount := Amount;
                gvPostBuffer."Amount (LCY)" := AmountLCY;
                gvPostBuffer."Currency Factor" := PayrollLine."Currency Factor";
                gvPostBuffer."Employee No." := PayrollHdr."Employee no."; //cmm 161011 add employee on journal posting line descrption AAFH
                gvPostBuffer.Insert;
                sEnforceEmpEDDimRules(PayrollBufferDims, PayrollHdr, gvPostBuffer);
                sSetPostingDims(gvPostBuffer, PayrollBufferDims);
            end
        else begin
            gvLastBufferNo += 1;
            gvPostBuffer.Reset;
            gvPostBuffer.Init;
            gvPostBuffer."Buffer No" := gvLastBufferNo;
            gvPostBuffer."Account Type" := gvPostBuffer."Account Type"::"G/L Account";
            gvPostBuffer."Account No" := AccountNo;
            gvPostBuffer."Payroll Code" := gvAllowedPayrolls."Payroll Code";
            gvPostBuffer."ED Code" := PayrollLine."ED Code";
            gvPostBuffer."Currency Code" := PayrollLine."Currency Code";
            gvPostBuffer.Amount := Amount;
            gvPostBuffer."Amount (LCY)" := AmountLCY;
            gvPostBuffer."Currency Factor" := PayrollLine."Currency Factor";
            gvPostBuffer."Employee No." := PayrollLine."Employee No.";//cmm 161011 add employee on journal posting line descrption AAFH
            gvPostBuffer.Insert;
            sGetBufferDimsFromHdrandLine(PayrollHdr, PayrollLine, PayrollBufferDims);
            sEnforceEmpEDDimRules(PayrollBufferDims, PayrollHdr, gvPostBuffer);
            sSetPostingDims(gvPostBuffer, PayrollBufferDims);
        end;
    end;

    procedure sInsertLineWithAccountType(AccountNo: Code[20]; Amount: Decimal; PayrollHdr: Record "Payroll Header"; PayrollLine: Record "Payroll Lines"; AccountType: Option "G/L Account",Customer,Vendor; AmountLCY: Decimal)
    var
        PayrollBufferDims: Record "Payroll Dimension" temporary;
    begin
        //Posting to customer, vendor account

        gvPostBuffer.Reset;
        gvPostBuffer.SetCurrentKey("Account Type", "Account No", "Payroll Code", "ED Code");
        gvPostBuffer.SetRange("Account Type", AccountType);
        gvPostBuffer.SetRange("Account No", AccountNo);
        gvPostBuffer.SetRange("Payroll Code", PayrollHdr."Payroll Code");
        gvPostBuffer.SetRange("ED Code", PayrollLine."ED Code");
        gvPostBuffer.SetRange("Currency Code", PayrollLine."Currency Code");

        if gvPostBuffer.FindFirst then
            if fWithSameDimensions(gvPostBuffer, PayrollHdr, PayrollLine, PayrollBufferDims) then begin
                gvPostBuffer.Amount += Amount;
                gvPostBuffer."Amount (LCY)" += AmountLCY;
                gvPostBuffer."Employee No." := PayrollHdr."Employee no."; //cmm 161011 add employee on journal posting line descrption AAFH
                gvPostBuffer.Modify;
            end else begin
                gvLastBufferNo += 1;
                gvPostBuffer.Reset;
                gvPostBuffer.Init;
                gvPostBuffer."Buffer No" := gvLastBufferNo;
                gvPostBuffer."Account Type" := AccountType;
                gvPostBuffer."Account No" := AccountNo;
                gvPostBuffer."Payroll Code" := gvAllowedPayrolls."Payroll Code";
                gvPostBuffer."ED Code" := PayrollLine."ED Code";
                gvPostBuffer."Currency Code" := PayrollLine."Currency Code";
                gvPostBuffer.Amount := Amount;
                gvPostBuffer."Amount (LCY)" := AmountLCY;
                gvPostBuffer."Currency Factor" := PayrollLine."Currency Factor";
                gvPostBuffer."Employee No." := PayrollHdr."Employee no."; //cmm 161011 add employee on journal posting line descrption AAFH
                gvPostBuffer.Insert;
                sEnforceEmpEDDimRules(PayrollBufferDims, PayrollHdr, gvPostBuffer);
                sSetPostingDims(gvPostBuffer, PayrollBufferDims);
            end
        else begin
            gvLastBufferNo += 1;
            gvPostBuffer.Reset;
            gvPostBuffer.Init;
            gvPostBuffer."Buffer No" := gvLastBufferNo;
            gvPostBuffer."Account Type" := AccountType;
            gvPostBuffer."Account No" := AccountNo;
            gvPostBuffer."Payroll Code" := gvAllowedPayrolls."Payroll Code";
            gvPostBuffer."ED Code" := PayrollLine."ED Code";
            gvPostBuffer."Currency Code" := PayrollLine."Currency Code";
            gvPostBuffer.Amount := Amount;
            gvPostBuffer."Amount (LCY)" := AmountLCY;
            gvPostBuffer."Currency Factor" := PayrollLine."Currency Factor";
            gvPostBuffer."Employee No." := PayrollLine."Employee No."; //cmm 161011 add employee on journal posting line descrption AAFH
            gvPostBuffer.Insert;
            sGetBufferDimsFromHdrandLine(PayrollHdr, PayrollLine, PayrollBufferDims);
            sEnforceEmpEDDimRules(PayrollBufferDims, PayrollHdr, gvPostBuffer);
            sSetPostingDims(gvPostBuffer, PayrollBufferDims);
        end;
    end;

    procedure sInsertNetpayLine(PayrollHdr: Record "Payroll Header")
    var
        AmountLCY: Decimal;
        PayrollBufferDims: Record "Payroll Dimension" temporary;
        EmpNetPay: Record Employee;
    begin
        gvPostBuffer.Reset;
        gvPostBuffer.SetCurrentKey("Account Type", "Account No", "Payroll Code", "ED Code");
        gvPostBuffer.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
        gvPostBuffer.CalcSums("Amount (LCY)");
        AmountLCY := -gvPostBuffer."Amount (LCY)";

        gvPostBuffer.Reset;
        gvPostBuffer.SetCurrentKey("Account Type", "Account No", "Payroll Code", "ED Code");
        EmpNetPay.Get(PayrollHdr."Employee no.");//ICS 28APR2017
        if EmpNetPay."Bank Code" = '001' then
            gvPostBuffer.SetRange("Account Type", gvPostBuffer."Account Type"::Vendor)//ICS 28APR2017
        else
            gvPostBuffer.SetRange("Account Type", gvBalAccountType);
        if EmpNetPay."Bank Code" = '001' then
            gvPostBuffer.SetRange("Account No", EmpNetPay."Bank Account No")
        else
            gvPostBuffer.SetRange("Account No", gvBalAccount);
        gvPostBuffer.SetRange("Payroll Code", PayrollHdr."Payroll Code");

        if gvPostBuffer.FindFirst then
            if fWithSameDimensions2(gvPostBuffer, PayrollHdr, PayrollBufferDims) then begin
                gvPostBuffer.Amount += AmountLCY;
                gvPostBuffer."Amount (LCY)" += AmountLCY;
                gvPostBuffer."Employee No." := PayrollHdr."Employee no."; //cmm 161011 add employee on journal posting line descrption AAFH
                gvPostBuffer.Modify;
            end else begin
                gvLastBufferNo += 1;
                gvPostBuffer.Reset;
                gvPostBuffer.Init;
                gvPostBuffer."Buffer No" := gvLastBufferNo;
                if EmpNetPay."Bank Code" = '001' then
                    gvPostBuffer."Account Type" := gvPostBuffer."Account Type"::Vendor else
                    gvPostBuffer."Account Type" := gvBalAccountType;
                if EmpNetPay."Bank Code" = '001' then gvPostBuffer."Account No" := EmpNetPay."Bank Account No";
                gvPostBuffer."Account No" := gvBalAccount;
                gvPostBuffer."Payroll Code" := gvAllowedPayrolls."Payroll Code";
                gvPostBuffer.Amount := AmountLCY;
                gvPostBuffer."Amount (LCY)" := AmountLCY;
                gvPostBuffer."Employee No." := PayrollHdr."Employee no."; //cmm 161011 add employee on journal posting line descrption AAFH
                gvPostBuffer.Insert;
                sEnforceEmpEDDimRules(PayrollBufferDims, PayrollHdr, gvPostBuffer);
                sSetPostingDims(gvPostBuffer, PayrollBufferDims);
            end
        else begin
            gvLastBufferNo += 1;
            gvPostBuffer.Reset;
            gvPostBuffer.Init;
            gvPostBuffer."Buffer No" := gvLastBufferNo;
            if EmpNetPay."Bank Code" = '001' then
                gvPostBuffer."Account Type" := gvPostBuffer."Account Type"::Vendor else
                gvPostBuffer."Account Type" := gvBalAccountType;
            //gvPostBuffer."Account Type" := gvBalAccountType;
            if EmpNetPay."Bank Code" = '001' then
                gvPostBuffer."Account No" := EmpNetPay."Bank Account No"
            else //ICS 28APR
                gvPostBuffer."Account No" := gvBalAccount;
            gvPostBuffer."Account No" := gvBalAccount;
            gvPostBuffer."Payroll Code" := gvAllowedPayrolls."Payroll Code";
            gvPostBuffer.Amount := AmountLCY;
            gvPostBuffer."Amount (LCY)" := AmountLCY;
            gvPostBuffer."Employee No." := PayrollHdr."Employee no."; //cmm 161011 add employee on journal posting line descrption AAFH
            gvPostBuffer.Insert;
            sGetBufferDimsFromHdr(PayrollHdr, PayrollBufferDims);
            sEnforceEmpEDDimRules(PayrollBufferDims, PayrollHdr, gvPostBuffer);
            sSetPostingDims(gvPostBuffer, PayrollBufferDims);
        end;
    end;

    procedure fWithSameDimensions(var PayrollPostingBuffer: Record "Payroll Posting Buffer"; PayrollHdr: Record "Payroll Header"; PayrollLine: Record "Payroll Lines"; var PayrollBufferDims: Record "Payroll Dimension" temporary): Boolean
    var
        lvPayrollPostingBuffer: Record "Payroll Posting Buffer";
        lvPayrollDimsTemp: Record "Payroll Dimension" temporary;
        lvPayrollSetup: Record "Payroll Setups";
        lvNewBufferEntryHasDims: Boolean;
        lvSameDims: Boolean;
        lvIndex: Integer;
    begin
        //skm060606 this function checks whether a payroll posting buffer entry with same dimensions as
        //for the current payroll header and payroll line combination already exists

        sGetBufferDimsFromHdrandLine(PayrollHdr, PayrollLine, PayrollBufferDims);
        lvNewBufferEntryHasDims := PayrollBufferDims.FindFirst;

        //Check if posting buffer entry with same dimensions exists
        if lvNewBufferEntryHasDims then begin
            lvSameDims := false; //Assume there isn't a buffer entry with same dimensions as the new buffer entry
            lvPayrollPostingBuffer.SetCurrentKey("Account Type", "Account No", "Payroll Code", "ED Code", "Currency Code");
            lvPayrollPostingBuffer.SetRange("Account Type", PayrollPostingBuffer."Account Type");
            lvPayrollPostingBuffer.SetRange("Account No", PayrollPostingBuffer."Account No");
            lvPayrollPostingBuffer.SetRange("Payroll Code", PayrollPostingBuffer."Payroll Code");
            lvPayrollPostingBuffer.SetRange("ED Code", PayrollPostingBuffer."ED Code");
            lvPayrollPostingBuffer.SetRange("Currency Code", PayrollPostingBuffer."Currency Code");
            if lvPayrollPostingBuffer.FindSet(false, false) then
                repeat //compare dimensions if any
                    lvIndex := 1;
                    gvPayrollDims.Reset;
                    gvPayrollDims.SetRange("Table ID", DATABASE::"Payroll Posting Buffer");
                    gvPayrollDims.SetRange("Entry No", lvPayrollPostingBuffer."Buffer No");
                    if gvPayrollDims.FindSet(false, false) then //buffer entry has dimensions
                        repeat
                            PayrollBufferDims.Reset;
                            PayrollBufferDims.SetRange("Table ID", gvPayrollDims."Table ID");
                            PayrollBufferDims.SetRange("ED Code", gvPayrollDims."ED Code");
                            PayrollBufferDims.SetRange("Dimension Code", gvPayrollDims."Dimension Code");
                            PayrollBufferDims.SetRange("Dimension Value Code", gvPayrollDims."Dimension Value Code");
                            PayrollBufferDims.SetRange("Payroll Code", gvPayrollDims."Payroll Code");
                            if lvIndex = 1 then
                                lvSameDims := PayrollBufferDims.FindFirst
                            else
                                lvSameDims := PayrollBufferDims.FindFirst and lvSameDims;
                            lvIndex += 1;
                        until gvPayrollDims.Next = 0;

                    if lvSameDims then begin
                        PayrollPostingBuffer.Get(lvPayrollPostingBuffer."Buffer No");
                        exit(true);
                    end;
                until lvPayrollPostingBuffer.Next = 0;

            exit(false);
        end;

        //Check if same posting buffer entry without dimensions exists
        lvPayrollPostingBuffer.Reset;
        lvPayrollPostingBuffer.SetCurrentKey("Account Type", "Account No", "Payroll Code", "ED Code", "Currency Code");
        lvPayrollPostingBuffer.SetRange("Account Type", PayrollPostingBuffer."Account Type");
        lvPayrollPostingBuffer.SetRange("Account No", PayrollPostingBuffer."Account No");
        lvPayrollPostingBuffer.SetRange("Payroll Code", PayrollPostingBuffer."Payroll Code");
        lvPayrollPostingBuffer.SetRange("ED Code", PayrollPostingBuffer."ED Code");
        lvPayrollPostingBuffer.SetRange("Currency Code", PayrollPostingBuffer."Currency Code");
        if lvPayrollPostingBuffer.FindSet(false, false) then
            repeat
                gvPayrollDims.Reset;
                gvPayrollDims.SetRange("Table ID", DATABASE::"Payroll Posting Buffer");
                gvPayrollDims.SetRange("Entry No", lvPayrollPostingBuffer."Buffer No");
                if not gvPayrollDims.FindSet(false, false) then //same buffer entry without dimensions
                    repeat
                        PayrollBufferDims.Reset;
                        PayrollBufferDims.SetRange("Table ID", gvPayrollDims."Table ID");
                        PayrollBufferDims.SetRange("ED Code", gvPayrollDims."ED Code");
                        PayrollBufferDims.SetRange("Dimension Code", gvPayrollDims."Dimension Code");
                        PayrollBufferDims.SetRange("Dimension Value Code", gvPayrollDims."Dimension Value Code");
                        PayrollBufferDims.SetRange("Payroll Code", gvPayrollDims."Payroll Code");

                        if not PayrollBufferDims.FindFirst then begin //same buffer entry without dimensions
                            PayrollPostingBuffer.Get(lvPayrollPostingBuffer."Buffer No");
                            exit(true);
                        end
                    until gvPayrollDims.Next = 0
            until lvPayrollPostingBuffer.Next = 0;

        exit(false);
        //End
    end;

    procedure fWithSameDimensions2(var PayrollPostingBuffer: Record "Payroll Posting Buffer"; PayrollHdr: Record "Payroll Header"; var PayrollBufferDims: Record "Payroll Dimension" temporary): Boolean
    var
        lvPayrollPostingBuffer: Record "Payroll Posting Buffer";
        lvNewBufferEntryHasDims: Boolean;
        lvSameDims: Boolean;
        lvIndex: Integer;
    begin
        //skm070606 this function checkS whether a payroll posting buffer entry with same dimensions as
        //for the current payroll header already exists

        sGetBufferDimsFromHdr(PayrollHdr, PayrollBufferDims);
        lvNewBufferEntryHasDims := PayrollBufferDims.FindFirst;

        //Check if posting buffer entry with same dimensions exists
        if lvNewBufferEntryHasDims then begin
            lvSameDims := false; //Assume there isn't a buffer entry with same dimensions as the new buffer entry
            lvPayrollPostingBuffer.SetCurrentKey("Account Type", "Account No", "Payroll Code", "ED Code", "Currency Code");
            lvPayrollPostingBuffer.SetRange("Account Type", PayrollPostingBuffer."Account Type");
            lvPayrollPostingBuffer.SetRange("Account No", PayrollPostingBuffer."Account No");
            lvPayrollPostingBuffer.SetRange("Payroll Code", PayrollPostingBuffer."Payroll Code");
            lvPayrollPostingBuffer.SetRange("ED Code", PayrollPostingBuffer."ED Code");
            lvPayrollPostingBuffer.SetRange("Currency Code", PayrollPostingBuffer."Currency Code");
            if lvPayrollPostingBuffer.FindSet(false, false) then
                repeat //compare dimensions if any
                    lvIndex := 1;
                    gvPayrollDims.Reset;
                    gvPayrollDims.SetRange("Table ID", DATABASE::"Payroll Posting Buffer");
                    gvPayrollDims.SetRange("Entry No", lvPayrollPostingBuffer."Buffer No");
                    if gvPayrollDims.FindSet(false, false) then //buffer entry has dimensions
                        repeat
                            PayrollBufferDims.Reset;
                            PayrollBufferDims.SetRange("Table ID", gvPayrollDims."Table ID");
                            PayrollBufferDims.SetRange("ED Code", gvPayrollDims."ED Code");
                            PayrollBufferDims.SetRange("Dimension Code", gvPayrollDims."Dimension Code");
                            PayrollBufferDims.SetRange("Dimension Value Code", gvPayrollDims."Dimension Value Code");
                            PayrollBufferDims.SetRange("Payroll Code", gvPayrollDims."Payroll Code");
                            if lvIndex = 1 then
                                lvSameDims := PayrollBufferDims.FindFirst
                            else
                                lvSameDims := PayrollBufferDims.FindFirst and lvSameDims;
                            lvIndex += 1;
                        until gvPayrollDims.Next = 0;

                    if lvSameDims then begin
                        PayrollPostingBuffer.Get(lvPayrollPostingBuffer."Buffer No");
                        exit(true);
                    end;
                until lvPayrollPostingBuffer.Next = 0;

            exit(false);
        end;
        //Check if posting buffer entry with same dimensions exists

        /*skm20110317 AAFH payroll expense allocation. Due to change in payroll utilities not to use both Payroll Expense Allocaions
        and Employee/Payroll Header Dimensions at the same time, this code is no longer usable.
        //Check if same posting buffer entry without dimensions exists
          lvPayrollPostingBuffer.RESET;
          lvPayrollPostingBuffer.SETCURRENTKEY("Account Type", "Account No", "Payroll Code", "ED Code", "Currency Code");
          lvPayrollPostingBuffer.SETRANGE("Account Type", PayrollPostingBuffer."Account Type");
          lvPayrollPostingBuffer.SETRANGE("Account No", PayrollPostingBuffer."Account No");
          lvPayrollPostingBuffer.SETRANGE("Payroll Code", PayrollPostingBuffer."Payroll Code");
          lvPayrollPostingBuffer.SETRANGE("ED Code", PayrollPostingBuffer."ED Code");
          lvPayrollPostingBuffer.SETRANGE("Currency Code", PayrollPostingBuffer."Currency Code");
          IF lvPayrollPostingBuffer.FINDSET(FALSE, FALSE) THEN
            REPEAT
              gvPayrollDims.RESET;
              gvPayrollDims.SETRANGE("Table ID", DATABASE::"Payroll Posting Buffer");
              gvPayrollDims.SETRANGE("Entry No", lvPayrollPostingBuffer."Buffer No");
              IF NOT gvPayrollDims.FINDSET(FALSE, FALSE) THEN //same buffer entry without dimensions
                REPEAT
                  PayrollBufferDims.RESET;
                  PayrollBufferDims.SETRANGE("Table ID", gvPayrollDims."Table ID");
                  PayrollBufferDims.SETRANGE("ED Code", gvPayrollDims."ED Code");
                  PayrollBufferDims.SETRANGE("Dimension Code", gvPayrollDims."Dimension Code");
                  PayrollBufferDims.SETRANGE("Dimension Value Code", gvPayrollDims."Dimension Value Code");
                  PayrollBufferDims.SETRANGE("Payroll Code", gvPayrollDims."Payroll Code");
        
                  IF NOT PayrollBufferDims.FINDFIRST THEN BEGIN //same buffer entry without dimensions
                    PayrollPostingBuffer.GET(lvPayrollPostingBuffer."Buffer No");
                    EXIT(TRUE);
                  END
                UNTIL gvPayrollDims.NEXT = 0
            UNTIL lvPayrollPostingBuffer.NEXT = 0;
        
          EXIT(FAaLSE);
        //End
        */

    end;

    procedure sGetBufferDimsFromHdrandLine(PayrollHdr: Record "Payroll Header"; PayrollLine: Record "Payroll Lines"; var PayrollBufferDims: Record "Payroll Dimension" temporary)
    var
        lvPayrollDimsTemp: Record "Payroll Dimension" temporary;
        lvPayrollSetup: Record "Payroll Setups";
    begin
        //skm060606 this sub generates payroll posting buffer dimensions from a given
        //payroll header and payroll line

        lvPayrollSetup.Get(PayrollHdr."Payroll Code");

        //Generate dims for current header & line comnination
        //Uncomment if dimension on journal are required BV 31.07.2023
        if lvPayrollSetup."Priority to Dims Assigned To" = lvPayrollSetup."Priority to Dims Assigned To"::Employee then begin
            //Copy header/employee dims to temporary dim merge table
            gvPayrollDims.Reset;
            gvPayrollDims.SetRange("Table ID", DATABASE::"Payroll Header");
            gvPayrollDims.SetRange("Payroll ID", PayrollHdr."Payroll ID");
            gvPayrollDims.SetRange("Employee No", PayrollHdr."Employee no.");
            gvPayrollDims.SetRange("Payroll Code", PayrollHdr."Payroll Code");
            if gvPayrollDims.FindSet(false, false) then
                repeat
                    lvPayrollDimsTemp.Copy(gvPayrollDims);
                    lvPayrollDimsTemp."Table ID" := DATABASE::"Payroll Posting Buffer";
                    lvPayrollDimsTemp.Insert;
                until gvPayrollDims.Next = 0;

            //Merge header and line dims giving priority to header/employee dimension in case of conflict
            gvPayrollDims.Reset;
            gvPayrollDims.SetRange("Table ID", DATABASE::"Payroll Lines");
            gvPayrollDims.SetRange("Payroll ID", PayrollHdr."Payroll ID");
            gvPayrollDims.SetRange("Employee No", PayrollHdr."Employee no.");
            gvPayrollDims.SetRange("Payroll Code", PayrollHdr."Payroll Code");
            gvPayrollDims.SetRange("Entry No", PayrollLine."Entry No.");
            gvPayrollDims.SetRange("ED Code", PayrollLine."ED Code");
            if gvPayrollDims.FindSet(false, false) then
                repeat
                    lvPayrollDimsTemp.SetRange("Table ID", DATABASE::"Payroll Posting Buffer");
                    lvPayrollDimsTemp.SetRange("Payroll ID", PayrollHdr."Payroll ID");
                    lvPayrollDimsTemp.SetRange("Employee No", PayrollHdr."Employee no.");
                    lvPayrollDimsTemp.SetRange("Payroll Code", PayrollHdr."Payroll Code");
                    lvPayrollDimsTemp.SetRange("Dimension Code", gvPayrollDims."Dimension Code");

                    if lvPayrollDimsTemp.FindFirst then begin //conflict, copy from header
                        PayrollBufferDims.Copy(lvPayrollDimsTemp);
                        PayrollBufferDims."Employee No" := '';
                        PayrollBufferDims."Entry No" := gvPayrollDims."Entry No";
                        PayrollBufferDims."ED Code" := gvPayrollDims."ED Code";
                        PayrollBufferDims.Insert;
                        lvPayrollDimsTemp.Delete;
                    end else begin //no conflict, copy from line
                        PayrollBufferDims.Copy(gvPayrollDims);
                        PayrollBufferDims."Employee No" := '';
                        PayrollBufferDims."Table ID" := DATABASE::"Payroll Posting Buffer";
                        PayrollBufferDims.Insert;
                    end
                until gvPayrollDims.Next = 0;

            //copy from header dims not in line
            lvPayrollDimsTemp.Reset;
            if lvPayrollDimsTemp.FindSet(true, false) then
                repeat
                    PayrollBufferDims.Copy(lvPayrollDimsTemp);
                    PayrollBufferDims."Employee No" := '';
                    PayrollBufferDims."Entry No" := PayrollLine."Entry No.";
                    PayrollBufferDims."ED Code" := PayrollLine."ED Code";
                    PayrollBufferDims.Insert;
                until lvPayrollDimsTemp.Next = 0;
            lvPayrollDimsTemp.DeleteAll;
        end else begin //Priority to dims on the line
            //Copy line dims to temporary dim merge table
            gvPayrollDims.Reset;
            gvPayrollDims.SetRange("Table ID", DATABASE::"Payroll Lines");
            gvPayrollDims.SetRange("Payroll ID", PayrollHdr."Payroll ID");
            gvPayrollDims.SetRange("Employee No", PayrollHdr."Employee no.");
            gvPayrollDims.SetRange("Payroll Code", PayrollHdr."Payroll Code");
            gvPayrollDims.SetRange("Entry No", PayrollLine."Entry No.");
            gvPayrollDims.SetRange("ED Code", PayrollLine."ED Code");
            if gvPayrollDims.FindSet(false, false) then
                repeat
                    lvPayrollDimsTemp.Copy(gvPayrollDims);
                    lvPayrollDimsTemp."Table ID" := DATABASE::"Payroll Posting Buffer";
                    lvPayrollDimsTemp.Insert;
                until gvPayrollDims.Next = 0;

            //Merge header and line dims giving priority to line dimension in case of conflict
            gvPayrollDims.Reset;
            gvPayrollDims.SetRange("Table ID", DATABASE::"Payroll Header");
            gvPayrollDims.SetRange("Payroll ID", PayrollHdr."Payroll ID");
            gvPayrollDims.SetRange("Employee No", PayrollHdr."Employee no.");
            gvPayrollDims.SetRange("Payroll Code", PayrollHdr."Payroll Code");
            if gvPayrollDims.FindSet(false, false) then
                repeat
                    lvPayrollDimsTemp.SetRange("Table ID", DATABASE::"Payroll Posting Buffer");
                    lvPayrollDimsTemp.SetRange("Payroll ID", PayrollHdr."Payroll ID");
                    lvPayrollDimsTemp.SetRange("Employee No", PayrollHdr."Employee no.");
                    lvPayrollDimsTemp.SetRange("Payroll Code", PayrollHdr."Payroll Code");
                    lvPayrollDimsTemp.SetRange("Dimension Code", gvPayrollDims."Dimension Code");

                    if lvPayrollDimsTemp.FindFirst then begin //conflict, copy from line
                        PayrollBufferDims.Copy(lvPayrollDimsTemp);
                        PayrollBufferDims."Employee No" := '';
                        PayrollBufferDims.Insert;
                        lvPayrollDimsTemp.Delete;
                    end else begin //no conflict, copy from header
                        PayrollBufferDims.Copy(gvPayrollDims);
                        PayrollBufferDims."Employee No" := '';
                        PayrollBufferDims."Table ID" := DATABASE::"Payroll Posting Buffer";
                        PayrollBufferDims.Insert;
                    end
                until gvPayrollDims.Next = 0;

            //copy from line dims not in header
            lvPayrollDimsTemp.Reset;
            if lvPayrollDimsTemp.Find('-') then
                repeat
                    PayrollBufferDims.Copy(lvPayrollDimsTemp);
                    PayrollBufferDims."Employee No" := '';
                    PayrollBufferDims.Insert;
                until lvPayrollDimsTemp.Next = 0;
            lvPayrollDimsTemp.DeleteAll;
        end;//BV
        //Generate dims for current header & line comnination
    end;

    procedure sGetBufferDimsFromHdr(PayrollHdr: Record "Payroll Header"; var PayrollBufferDims: Record "Payroll Dimension" temporary)
    begin
        //skm070606 this sub generates payroll posting buffer entry dimensions
        //from a given payroll header

        //Copy header/employee dims to temporary posting buffer dims
        //Uncomment if dimension on journal are required BV 31.07.2023
        gvPayrollDims.Reset;
        gvPayrollDims.SetRange("Table ID", DATABASE::"Payroll Header");
        gvPayrollDims.SetRange("Payroll ID", PayrollHdr."Payroll ID");
        gvPayrollDims.SetRange("Employee No", PayrollHdr."Employee no.");
        gvPayrollDims.SetRange("Payroll Code", PayrollHdr."Payroll Code");
        if gvPayrollDims.FindSet(false, false) then
            repeat
                PayrollBufferDims.Copy(gvPayrollDims);
                PayrollBufferDims."Employee No" := '';
                PayrollBufferDims."Table ID" := DATABASE::"Payroll Posting Buffer";
                PayrollBufferDims.Insert;
            until gvPayrollDims.Next = 0;//BV
    end;

    procedure sEnforceEmpEDDimRules(var PayrollBufferDims: Record "Payroll Dimension" temporary; PayrollHdr: Record "Payroll Header"; PayrollPostingBuffer: Record "Payroll Posting Buffer")
    var
        lvDefaultDimension: Record "Default Dimension";
    begin
        //skm140606 this function validates temporary payroll posting buffer dimensions before they are
        //assigned to the payroll posting buffer for comformity with dimension rules for the associated
        //Employee and ED

        //Validate against employee dimension rules
        //Uncomment if dimension on journal are required BV 31.07.2023
        lvDefaultDimension.Reset;
        lvDefaultDimension.SetRange("Table ID", DATABASE::Employee);
        lvDefaultDimension.SetRange("No.", PayrollHdr."Employee no.");
        if lvDefaultDimension.FindSet(false, false) then
            repeat
                case lvDefaultDimension."Value Posting" of
                    lvDefaultDimension."Value Posting"::"Code Mandatory":
                        begin
                            PayrollBufferDims.Reset;
                            PayrollBufferDims.SetRange("Table ID", DATABASE::"Payroll Posting Buffer");
                            PayrollBufferDims.SetRange("Payroll ID", PayrollHdr."Payroll ID");
                            PayrollBufferDims.SetRange("Payroll Code", PayrollHdr."Payroll Code");
                            PayrollBufferDims.SetRange("Dimension Code", lvDefaultDimension."Dimension Code");
                            if not PayrollBufferDims.FindFirst then
                                Error('Please specify a %1 dimension in Payroll Header %2 %3.',
                                      lvDefaultDimension."Dimension Code", PayrollHdr."Payroll ID", PayrollHdr."Employee no.")
                        end;

                    lvDefaultDimension."Value Posting"::"Same Code":
                        begin
                            PayrollBufferDims.Reset;
                            PayrollBufferDims.SetRange("Table ID", DATABASE::"Payroll Posting Buffer");
                            PayrollBufferDims.SetRange("Payroll ID", PayrollHdr."Payroll ID");
                            PayrollBufferDims.SetRange("Payroll Code", PayrollHdr."Payroll Code");
                            PayrollBufferDims.SetRange("Dimension Code", lvDefaultDimension."Dimension Code");
                            PayrollBufferDims.SetRange("Dimension Value Code", lvDefaultDimension."Dimension Value Code");
                            if not PayrollBufferDims.FindFirst then
                                Error('Please specify %1 %2 dimension in Payroll Header %3 %4.',
                                      lvDefaultDimension."Dimension Code", lvDefaultDimension."Dimension Value Code",
                                      PayrollHdr."Payroll ID", PayrollHdr."Employee no.")
                        end;

                    lvDefaultDimension."Value Posting"::"No Code":
                        begin
                            PayrollBufferDims.Reset;
                            PayrollBufferDims.SetRange("Table ID", DATABASE::"Payroll Posting Buffer");
                            PayrollBufferDims.SetRange("Payroll ID", PayrollHdr."Payroll ID");
                            PayrollBufferDims.SetRange("Payroll Code", PayrollHdr."Payroll Code");
                            PayrollBufferDims.SetRange("Dimension Code", lvDefaultDimension."Dimension Code");
                            if PayrollBufferDims.FindFirst then
                                Error('You must not specify a %1 dimension in Payroll Header %2 %3.',
                                      lvDefaultDimension."Dimension Code", PayrollHdr."Payroll ID", PayrollHdr."Employee no.")
                        end;
                end
            until lvDefaultDimension.Next = 0;
        //End Validate against employee dimension rules

        //Validate against ED dimension rules
        lvDefaultDimension.Reset;
        lvDefaultDimension.SetRange("Table ID", DATABASE::"ED Definitions");
        lvDefaultDimension.SetRange("No.", PayrollPostingBuffer."ED Code");
        if lvDefaultDimension.FindSet(false, false) then
            repeat
                case lvDefaultDimension."Value Posting" of
                    lvDefaultDimension."Value Posting"::"Code Mandatory":
                        begin
                            PayrollBufferDims.Reset;
                            PayrollBufferDims.SetRange("Table ID", DATABASE::"Payroll Posting Buffer");
                            PayrollBufferDims.SetRange("Payroll ID", PayrollHdr."Payroll ID");
                            PayrollBufferDims.SetRange("Payroll Code", PayrollHdr."Payroll Code");
                            PayrollBufferDims.SetRange("ED Code", PayrollPostingBuffer."ED Code");
                            PayrollBufferDims.SetRange("Dimension Code", lvDefaultDimension."Dimension Code");
                            if not PayrollBufferDims.FindFirst then
                                Error('Please specify a %1 dimension in Payroll Header %2 %3 for ED %4.',
                                      lvDefaultDimension."Dimension Code", PayrollHdr."Payroll ID",
                                      PayrollHdr."Employee no.", PayrollPostingBuffer."ED Code")
                        end;

                    lvDefaultDimension."Value Posting"::"Same Code":
                        begin
                            PayrollBufferDims.Reset;
                            PayrollBufferDims.SetRange("Table ID", DATABASE::"Payroll Posting Buffer");
                            PayrollBufferDims.SetRange("Payroll ID", PayrollHdr."Payroll ID");
                            PayrollBufferDims.SetRange("Payroll Code", PayrollHdr."Payroll Code");
                            PayrollBufferDims.SetRange("ED Code", PayrollPostingBuffer."ED Code");
                            PayrollBufferDims.SetRange("Dimension Code", lvDefaultDimension."Dimension Code");
                            PayrollBufferDims.SetRange("Dimension Value Code", lvDefaultDimension."Dimension Value Code");
                            if not PayrollBufferDims.FindFirst then
                                Error('Please specify %1 %2 dimension in Payroll Header %3 %4 for ED %5.',
                                      lvDefaultDimension."Dimension Code", lvDefaultDimension."Dimension Value Code",
                                      PayrollHdr."Payroll ID", PayrollHdr."Employee no.", PayrollPostingBuffer."ED Code")
                        end;

                    lvDefaultDimension."Value Posting"::"No Code":
                        begin
                            PayrollBufferDims.Reset;
                            PayrollBufferDims.SetRange("Table ID", DATABASE::"Payroll Posting Buffer");
                            PayrollBufferDims.SetRange("Payroll ID", PayrollHdr."Payroll ID");
                            PayrollBufferDims.SetRange("Payroll Code", PayrollHdr."Payroll Code");
                            PayrollBufferDims.SetRange("ED Code", PayrollPostingBuffer."ED Code");
                            PayrollBufferDims.SetRange("Dimension Code", lvDefaultDimension."Dimension Code");
                            if PayrollBufferDims.FindFirst then
                                Error('You must not specify a %1 dimension in Payroll Header %2 %3 ED %4.',
                                      lvDefaultDimension."Dimension Code", PayrollHdr."Payroll ID",
                                      PayrollHdr."Employee no.", PayrollPostingBuffer."ED Code")
                        end;
                end
            until lvDefaultDimension.Next = 0;
        //End Validate against employee dimension rules

        PayrollBufferDims.Reset;
        //BV
    end;

    procedure sSetPostingDims(PayrollPostingBuffer: Record "Payroll Posting Buffer"; var PayrollBufferDims: Record "Payroll Dimension" temporary)
    begin
        //skm060606 this function sets posting dimensions for a payroll posting buffer entry given the
        //dimensions copied from the current payroll header and payroll line
        //Uncomment if dimension on journal are required BV 31.07.2023
        PayrollBufferDims.Reset;
        if PayrollBufferDims.FindSet(true, false) then
            repeat
                gvPayrollDims.Copy(PayrollBufferDims);
                gvPayrollDims."Entry No" := PayrollPostingBuffer."Buffer No";
                gvPayrollDims.Insert;
            until PayrollBufferDims.Next = 0;
        PayrollBufferDims.DeleteAll
        //BV
    end;

    procedure sWriteToGenJnlLines()
    var
        lvGenJnlLine: Record "Gen. Journal Line";
        lvLineNo: Integer;
        lvGenjnlPost: Codeunit "Gen. Jnl.-Post";
        lvED: Record "ED Definitions";
        rptPayrollPostingBuffer: Report "Payroll Posting Buffer";
        lvPayrollSetup: Record "Payroll Setups";
        lvTestRptName: Text[250];
        lvPPSetup: Record "Payroll Posting Setup";
        lvDescString: Text[1024];
        lvTempName: Text[250];
        lvToFile: Text[100];
        lvPayrollEntryLoans: Record "Payroll Entry";
        lvHdrLoan: Record "Payroll Header";
        lvEmpLoan: Record Employee;
        TotalNetPay: Decimal;
    begin
        lvPayrollSetup.Get(gvAllowedPayrolls."Payroll Code");
        gvPostBuffer.Reset;
        gvPostBuffer.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");

        //Print Posting Buffer
        case gvTestPost of
            1:
                begin
                    lvPayrollSetup.TestField("Payroll Transfer Path");
                    // lvTempName := TemporaryPath +'\'+'gvPeriodID'+'.pdf';
                    lvTestRptName := lvPayrollSetup."Payroll Transfer Path" + '\';
                    rptPayrollPostingBuffer.SetTableView(gvPostBuffer);
                    // rptPayrollPostingBuffer.SaveAsPdf(lvTempName); //Added by csm for Windows/web client
                    lvToFile := gvPeriodID + '.pdf';
                    // if Download(lvTempName,'Save Payroll Transfer as',lvTestRptName,'PDF file(*.pdf)|*.pdf',lvToFile) then ;
                    // rptPayrollPostingBuffer.SAVEASHTML(lvTestRptName);  Commented by CSM 30072013 obsolete
                    // Error('Test report saved as: %1', lvTestRptName);
                end;

            2:
                begin
                    lvPayrollSetup.TestField("Payroll Transfer Path");
                    //  lvTempName := TemporaryPath +'\'+'gvPeriodID'+'.pdf';
                    lvTestRptName := lvPayrollSetup."Payroll Transfer Path" + '\';
                    lvToFile := gvPeriodID + '.pdf';
                    rptPayrollPostingBuffer.SetTableView(gvPostBuffer);
                    // rptPayrollPostingBuffer.SaveAsPdf(lvTempName); //Added by csm for Windows/web client
                    lvToFile := gvPeriodID + '.pdf';
                    // if Download(lvTempName,'Save Payroll Transfer as',lvTestRptName,'PDF file(*.pdf)|*.pdf',lvToFile) then ;
                    // Message('Test report saved as: %1', lvTestRptName);
                end;
        end;

        //Convert Posting Buffer Entries into General Journal Line
        lvGenJnlLine.LockTable(true);
        lvGenJnlLine.SetRange("Journal Batch Name", gvBatchName);
        lvGenJnlLine.SetRange("Journal Template Name", gvTemplateName);
        lvGenJnlLine.SetRange("Posting Date", gvPostingDate);
        if lvGenJnlLine.FindLast then
            Error('The Batch name %1 is not empty', gvBatchName);

        lvGenJnlLine.Reset;
        lvGenJnlLine.SetRange("Journal Batch Name", gvBatchName);
        lvGenJnlLine.SetRange("Journal Template Name", gvTemplateName);
        if lvGenJnlLine.FindLast then
            lvLineNo := lvGenJnlLine."Line No."
        else
            lvLineNo := 0;




        with gvPostBuffer do begin
            //gvPostBufferCopy.COPY(gvPostBuffer);
            //SETFILTER("ED Code",'<>%1','');
            Find('-');
            gvWindowCounter := 0;
            repeat
                if gvPostBuffer.Amount <> 0 then begin
                    gvWindowCounter := gvWindowCounter + 1;
                    gvWindow.Update(2, gvWindowCounter);

                    lvGenJnlLine."Journal Batch Name" := gvBatchName;
                    lvGenJnlLine."Journal Template Name" := gvTemplateName;
                    lvLineNo := lvLineNo + 10;
                    lvGenJnlLine."Line No." := lvLineNo;
                    lvGenJnlLine."Document No." := gvAllowedPayrolls."Payroll Code" + '-' + gvPeriodID;
                    lvGenJnlLine."Document Type" := 0;
                    lvGenJnlLine.Validate("Posting Date", gvPostingDate);
                    lvGenJnlLine.Validate("Account Type", "Account Type");
                    lvGenJnlLine.Validate("Account No.", "Account No");
                    lvGenJnlLine.Validate("Currency Code", gvPostBuffer."Currency Code");
                    lvGenJnlLine."Currency Factor" := gvPostBuffer."Currency Factor";

                    //Reset VAT Fields
                    lvGenJnlLine."Gen. Posting Type" := lvGenJnlLine."Gen. Posting Type"::" ";
                    lvGenJnlLine."VAT Bus. Posting Group" := '';
                    lvGenJnlLine."VAT %" := 0;
                    lvGenJnlLine."VAT Prod. Posting Group" := '';
                    lvGenJnlLine."Gen. Bus. Posting Group" := '';
                    lvGenJnlLine."Gen. Prod. Posting Group" := '';
                    //end reset vat

                    lvGenJnlLine.Validate(Amount, gvPostBuffer.Amount);
                    lvGenJnlLine.Validate("Amount (LCY)", gvPostBuffer."Amount (LCY)");

                    if gvPostBuffer."ED Code" <> '' then begin
                        lvED.Get("ED Code");
                        //cmm 161011 description shows Emp ID if setup is set - orginal code n {}
                        lvDescString := '';
                        if lvPayrollSetup."Emp ID in Payroll Posting Jnl" then begin
                            lvDescString := lvED.Description + '-' + gvPostBuffer."Employee No.";
                            if StrLen(lvDescString) > 50 then
                                lvGenJnlLine.Description := CopyStr(lvDescString, StrLen(lvDescString) - 49, 50)
                            else
                                lvGenJnlLine.Description := lvDescString
                        end else
                            lvGenJnlLine.Description := lvED.Description;
                        //end cmm
                        /*lvGenJnlLine.Description :=  lvED.Description; */
                        //cmm 161011 description shows Emp ID if setup is set - orginal code n {}
                    end else begin
                        lvDescString := '';
                        TotalNetPay += lvGenJnlLine.Amount;//Net Pay
                        if lvPayrollSetup."Emp ID in Payroll Posting Jnl" then begin
                            lvDescString := 'Payroll Batch for ' + gvPeriodID + '-' + gvPostBuffer."Employee No.";
                            if StrLen(lvDescString) > 50 then
                                lvGenJnlLine.Description := CopyStr(lvDescString, StrLen(lvDescString) - 49, 50)
                            else
                                lvGenJnlLine.Description := lvDescString;
                        end else
                            lvGenJnlLine.Description := 'Payroll Batch Net Pay for ' + gvPeriodID;
                    end;
                    //end cmm
                    /* END ELSE
                    lvGenJnlLine.Description :=  'Payroll Batch for ' + gvPeriodID;*/
                    if (gvPostBuffer."ED Code" <> '') and (lvGenJnlLine."Account No." <> '') then begin
                        lvGenJnlLine.Insert;
                        lvGenJnlLine."Dimension Set ID" := sCopyPayrollBufferDims(lvGenJnlLine, gvPostBuffer);//cmm 020813 new Dim NAV2013
                        if lvGenJnlLine."Dimension Set ID" <> 0 then
                            DimMgt.UpdateGlobalDimFromDimSetID(lvGenJnlLine."Dimension Set ID",
                            lvGenJnlLine."Shortcut Dimension 1 Code", lvGenJnlLine."Shortcut Dimension 2 Code");  //cmm 020813 new Dim NAV2013
                        lvGenJnlLine.Modify;   //cmm 020813
                    end;
                end;
            until Next = 0;

            //Insert Netpay
            if TotalNetPay <> 0 then begin
                gvWindowCounter := gvWindowCounter + 1;
                gvWindow.Update(2, gvWindowCounter);

                lvGenJnlLine."Journal Batch Name" := gvBatchName;
                lvGenJnlLine."Journal Template Name" := gvTemplateName;
                lvLineNo := lvLineNo + 10;
                lvGenJnlLine."Line No." := lvLineNo;
                lvGenJnlLine."Document No." := gvAllowedPayrolls."Payroll Code" + '-' + gvPeriodID;
                lvGenJnlLine."Document Type" := 0;
                lvGenJnlLine.Validate("Posting Date", gvPostingDate);
                lvGenJnlLine.Validate("Account Type", "Account Type");
                lvGenJnlLine.Validate("Account No.", "Account No");
                lvGenJnlLine.Validate("Currency Code", gvPostBuffer."Currency Code");
                lvGenJnlLine."Currency Factor" := gvPostBuffer."Currency Factor";

                //Reset VAT Fields
                lvGenJnlLine."Gen. Posting Type" := lvGenJnlLine."Gen. Posting Type"::" ";
                lvGenJnlLine."VAT Bus. Posting Group" := '';
                lvGenJnlLine."VAT %" := 0;
                lvGenJnlLine."VAT Prod. Posting Group" := '';
                lvGenJnlLine."Gen. Bus. Posting Group" := '';
                lvGenJnlLine."Gen. Prod. Posting Group" := '';
                //end reset vat

                lvGenJnlLine.Validate(Amount, TotalNetPay);
                lvGenJnlLine.Validate("Amount (LCY)", TotalNetPay);
                lvGenJnlLine.Description := 'Payroll Batch Net Pay for ' + gvPeriodID;
                lvGenJnlLine.Insert;
                lvGenJnlLine."Dimension Set ID" := sCopyPayrollBufferDims(lvGenJnlLine, gvPostBuffer);//cmm 020813 new Dim NAV2013
                if lvGenJnlLine."Dimension Set ID" <> 0 then
                    DimMgt.UpdateGlobalDimFromDimSetID(lvGenJnlLine."Dimension Set ID",
                    lvGenJnlLine."Shortcut Dimension 1 Code", lvGenJnlLine."Shortcut Dimension 2 Code");  //cmm 020813 new Dim NAV2013
                lvGenJnlLine.Modify;   //cmm 020813

            end;
            //End of net pay

            lvGenJnlLine."Payroll Calculated" := true;//mesh
        end; //with

        //ICS28APR2017 for the loans linked to SACCO module
        lvHdrLoan.SetFilter(lvHdrLoan."Payroll ID", gvPeriodID);
        if lvHdrLoan.FindFirst then
            repeat
                lvEmpLoan.Get(lvHdrLoan."Employee no.");
                lvPayrollEntryLoans.SetFilter("Payroll ID", lvHdrLoan."Payroll ID");
                lvPayrollEntryLoans.SetFilter(lvPayrollEntryLoans."Employee No.", lvHdrLoan."Employee no.");
                lvPayrollEntryLoans.SetFilter("Staff Vendor Entry", '<>%1', '');
                lvPayrollEntryLoans.SetFilter("ED Code", '<>%1', '10000');
                if lvPayrollEntryLoans.FindFirst then
                    repeat
                        lvGenJnlLine."Journal Batch Name" := gvBatchName;
                        lvGenJnlLine."Journal Template Name" := gvTemplateName;
                        lvLineNo := lvLineNo + 10;
                        lvGenJnlLine."Line No." := lvLineNo;
                        lvGenJnlLine."Document No." := gvAllowedPayrolls."Payroll Code" + '-' + gvPeriodID;
                        lvGenJnlLine."Document Type" := 0;
                        lvGenJnlLine.Validate("Posting Date", gvPostingDate);
                        lvGenJnlLine.Validate("Account Type", lvGenJnlLine."Account Type"::Vendor);
                        lvGenJnlLine.Validate("Account No.", lvPayrollEntryLoans."Staff Vendor Entry");
                        lvGenJnlLine.Validate("Currency Code", gvPostBuffer."Currency Code");
                        lvGenJnlLine."Currency Factor" := gvPostBuffer."Currency Factor";

                        //Reset VAT Fields
                        lvGenJnlLine."Gen. Posting Type" := lvGenJnlLine."Gen. Posting Type"::" ";
                        lvGenJnlLine."VAT Bus. Posting Group" := '';
                        lvGenJnlLine."VAT %" := 0;
                        lvGenJnlLine."VAT Prod. Posting Group" := '';
                        lvGenJnlLine."Gen. Bus. Posting Group" := '';
                        lvGenJnlLine."Gen. Prod. Posting Group" := '';
                        //end reset vat

                        lvGenJnlLine.Validate(Amount, lvPayrollEntryLoans.Amount);
                        lvGenJnlLine.Validate("Amount (LCY)", lvPayrollEntryLoans.Amount);

                        //IF gvPostBuffer."ED Code" <> '' THEN BEGIN
                        lvED.Get(lvPayrollEntryLoans."ED Code");
                        //  //cmm 161011 description shows Emp ID if setup is set - orginal code n {}
                        lvDescString := '';
                        if lvPayrollSetup."Emp ID in Payroll Posting Jnl" then begin
                            lvDescString := lvED.Description + '-' + gvPostBuffer."Employee No.";
                            if StrLen(lvDescString) > 50 then
                                lvGenJnlLine.Description := CopyStr(lvDescString, StrLen(lvDescString) - 49, 50)
                            else
                                lvGenJnlLine.Description := lvDescString
                        end else
                            lvGenJnlLine.Description := lvED.Description;
                        //end cmm
                        /*lvGenJnlLine.Description :=  lvED.Description; */
                        //cmm 161011 description shows Emp ID if setup is set - orginal code n {}
                        //END ELSE BEGIN
                        //  lvDescString:='';
                        //  IF lvPayrollSetup."Emp ID in Payroll Posting Jnl" THEN BEGIN
                        //    lvDescString:='Payroll Batch for ' + gvPeriodID + '-'+ gvPostBuffer."Employee No.";
                        //    IF STRLEN(lvDescString) > 50 THEN
                        //       lvGenJnlLine.Description := COPYSTR(lvDescString,STRLEN(lvDescString)-49,50)
                        //    ELSE
                        //    lvGenJnlLine.Description :=  lvDescString;
                        //  END ELSE lvGenJnlLine.Description :=  'Payroll Batch for ' + gvPeriodID;
                        //END;
                        //end cmm
                        /* END ELSE
                        lvGenJnlLine.Description :=  'Payroll Batch for ' + gvPeriodID;*/
                        lvGenJnlLine.Insert;
                    until lvPayrollEntryLoans.Next = 0;
            until lvHdrLoan.Next = 0;
        //lvGenJnlLine."Dimension Set ID":= sCopyPayrollBufferDims(lvGenJnlLine, gvPostBuffer);//cmm 020813 new Dim NAV2013
        //IF lvGenJnlLine."Dimension Set ID" <> 0 THEN
        //DimMgt.UpdateGlobalDimFromDimSetID(lvGenJnlLine."Dimension Set ID",
        //lvGenJnlLine."Shortcut Dimension 1 Code",lvGenJnlLine."Shortcut Dimension 2 Code");  //cmm 020813 new Dim NAV2013
        lvGenJnlLine.Modify;   //cmm 020813
                               //END;
                               //ICS 28APR2017

        if lvPayrollSetup."Auto-Post Payroll Journals" then lvGenjnlPost.Run(lvGenJnlLine);

    end;

    procedure sCopyPayrollBufferDims(GenJournalLine: Record "Gen. Journal Line"; PayrollBuffer: Record "Payroll Posting Buffer"): Integer
    var
        lvDimSetEntryTemp: Record "Dimension Set Entry" temporary;
        lvDimSetEntry: Record "Dimension Set Entry";
    begin
        //This sub copies dimensions from the payroll posting buffer to Journal Line Dimension

        gvPayrollDims.Reset;
        gvPayrollDims.SetRange("Table ID", DATABASE::"Payroll Posting Buffer");
        gvPayrollDims.SetRange("Entry No", PayrollBuffer."Buffer No");
        gvPayrollDims.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
        if gvPayrollDims.FindSet(false, false) then begin
            repeat
                //cmm 020813 new dimensions impl. NAV2013
                lvDimSetEntryTemp.Init;
                lvDimSetEntryTemp.Validate("Dimension Code", gvPayrollDims."Dimension Code");
                lvDimSetEntryTemp.Validate("Dimension Value Code", gvPayrollDims."Dimension Value Code");
                lvDimSetEntryTemp.Insert(true);
            //end cmm
            /*
            //clear any default dims from account
            lvJournalLineDimension.SETRANGE("Table ID", DATABASE::"Gen. Journal Line");
            lvJournalLineDimension.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
            lvJournalLineDimension.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
            lvJournalLineDimension.SETRANGE("Journal Line No.", GenJournalLine."Line No.");
            lvJournalLineDimension.SETRANGE("Allocation Line No.", 0);
            lvJournalLineDimension.SETRANGE("Dimension Code", gvPayrollDims."Dimension Code");
            lvJournalLineDimension.DELETEALL(TRUE);
            //end clear
        
            //Insert dims from payroll
            lvJournalLineDimension."Table ID" := DATABASE::"Gen. Journal Line";
            lvJournalLineDimension."Journal Template Name" := GenJournalLine."Journal Template Name";
            lvJournalLineDimension."Journal Batch Name" := GenJournalLine."Journal Batch Name";
            lvJournalLineDimension."Journal Line No." := GenJournalLine."Line No.";
            lvJournalLineDimension.VALIDATE("Dimension Code", gvPayrollDims."Dimension Code");
            lvJournalLineDimension.VALIDATE("Dimension Value Code", gvPayrollDims."Dimension Value Code");
            lvJournalLineDimension.INSERT(TRUE);
            */
            until gvPayrollDims.Next = 0;
            exit(DimMgt.GetDimensionSetID(lvDimSetEntryTemp)); //new dimension impl. NAV2013 CMM 020813
        end else
            exit(0);

    end;

    procedure sDeleteEntry()
    var
        Entry: Record "Payroll Entry";
    begin
        Entry.LockTable(true);
        Entry.SetCurrentKey("Payroll ID", "Employee No.");
        Entry.SetRange("Payroll ID", gvPeriodID);
        Entry.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
        Entry.DeleteAll;
    end;

    procedure sDeleteLumpSumPayments()
    var
        lvLumpsumPayments: Record "Lump Sum Payments";
        lvPayrollEntry: Record "Payroll Entry";
    begin
        //Clear lump sum payments already paid
        lvLumpsumPayments.SetFilter("Linked Payroll Entry No", '<>0');
        lvLumpsumPayments.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
        if lvLumpsumPayments.Find('-') then
            repeat
                if not lvPayrollEntry.Get(lvLumpsumPayments."Linked Payroll Entry No") then lvLumpsumPayments.Delete
            until lvLumpsumPayments.Next = 0;
    end;

    procedure "---V.6.1.65 ----"()
    begin
    end;

    procedure sWriteToGenJnlLinesForPayment(var lvLines: Record "Payroll Lines")
    var
        lvPayrollSetup: Record "Payroll Setups";
        lvGenJnlLine: Record "Gen. Journal Line";
        lvLineNo: Integer;
        lvED: Record "ED Definitions";
        lvEmp: Record Employee;
        lvPPSetup: Record "Payroll Posting Setup";
    begin
        lvPayrollSetup.Get(lvLines."Payroll Code");
        if lvPayrollSetup."Personal Account Recoveries ED" = lvLines."ED Code" then begin
            if gvPostBuffer.Amount <> 0 then begin
                gvWindowCounter := gvWindowCounter + 1;
                gvWindow.Update(2, gvWindowCounter);

                lvGenJnlLine."Journal Batch Name" := gvBatchName;
                lvGenJnlLine."Journal Template Name" := 'CASHRCPT';
                gvLineNo += 10;
                lvGenJnlLine."Line No." := gvLineNo;
                lvGenJnlLine."Document Type" := lvGenJnlLine."Document Type"::Payment;
                lvGenJnlLine."Document No." := gvAllowedPayrolls."Payroll Code" + '-' + gvPeriodID;
                lvGenJnlLine.Validate("Posting Date", gvPostingDate);
                lvGenJnlLine.Validate("Account Type", lvGenJnlLine."Account Type"::Customer);

                Clear(lvEmp);
                lvEmp.Get(lvLines."Employee No.");
                lvGenJnlLine.Validate("Account No.", lvEmp."Customer No.");

                lvGenJnlLine.Validate("Currency Code", gvPostBuffer."Currency Code");
                lvGenJnlLine."Currency Factor" := gvPostBuffer."Currency Factor";

                //Reset VAT Fields
                lvGenJnlLine."Gen. Posting Type" := lvGenJnlLine."Gen. Posting Type"::" ";
                lvGenJnlLine."VAT Bus. Posting Group" := '';
                lvGenJnlLine."VAT %" := 0;
                lvGenJnlLine."VAT Prod. Posting Group" := '';
                lvGenJnlLine."Gen. Bus. Posting Group" := '';
                lvGenJnlLine."Gen. Prod. Posting Group" := '';
                //end reset vat

                lvGenJnlLine.Validate(Amount, -lvLines.Amount);
                lvGenJnlLine.Validate("Amount (LCY)", -lvLines."Amount (LCY)");
                lvGenJnlLine."Bal. Account Type" := 0;

                lvPPSetup.Reset;
                lvPPSetup.SetRange(lvPPSetup."Posting Group", lvLines."Posting Group");
                lvPPSetup.SetRange(lvPPSetup."ED Posting Group", lvLines."ED Code");
                if lvPPSetup.FindFirst then
                    lvGenJnlLine."Bal. Account No." := lvPPSetup."Debit Account";

                if gvPostBuffer."ED Code" <> '' then begin
                    lvED.Get(lvLines."ED Code");
                    lvGenJnlLine.Description := lvED.Description;
                end else
                    lvGenJnlLine.Description := 'Payroll Batch for ' + gvPeriodID;
                lvGenJnlLine.Insert;
            end;
        end;
    end;

    procedure "==TestCalculated"()
    begin
    end;

    procedure TestCalculated(PayrollPeriod: Code[10]): Boolean
    var
        Header: Record "Payroll Header";
    begin
        gvPayrollUtilities2.sGetActivePayroll(gvAllowedPayrolls2);
        Header.SetRange("Payroll ID", PayrollPeriod);
        Header.SetRange(Calculated, false);
        Header.SetRange("Payroll Code", gvAllowedPayrolls2."Payroll Code");
        if Header.Find('-') then
            exit(false)
        else
            exit(true);
    end;

    procedure "==PayrollUtilities"()
    begin
    end;

    procedure sGetActivePayroll(var AllowedPayrolls: Record "Allowed Payrolls")
    var
        lvActiveSession: Record "Active Session";
    begin
        //SKM 260506 This sub retieve the authorized payroll that the current db user is logged to

        lvActiveSession.Reset;
        lvActiveSession.SetRange("Server Instance ID", ServiceInstanceId);
        lvActiveSession.SetRange("Session ID", SessionId);
        lvActiveSession.FindFirst;

        AllowedPayrolls.SetRange("User ID", lvActiveSession."User ID");
        AllowedPayrolls.SetRange("User ID", UserId);
        AllowedPayrolls.SetRange("Last Active Payroll", true);
        if not AllowedPayrolls.FindFirst then Error('You are not allowed access to any payroll dataset.');
    end;

    procedure sGetDefaultEmpDims(PayrollHdr: Record "Payroll Header")
    var
        lvPayrollDim: Record "Payroll Dimension";
        lvDefaultDim: Record "Default Dimension";
    begin
        //skm 300506
        //This function copies default dimensions from the Employee to the Payroll Header table

        lvDefaultDim.SetRange("Table ID", DATABASE::Employee);
        lvDefaultDim.SetRange("No.", PayrollHdr."Employee no.");
        if lvDefaultDim.FindFirst then
            repeat
                lvPayrollDim."Table ID" := DATABASE::"Payroll Header";
                lvPayrollDim."Payroll ID" := PayrollHdr."Payroll ID";
                lvPayrollDim."Employee No" := lvDefaultDim."No.";
                lvPayrollDim."Dimension Code" := lvDefaultDim."Dimension Code";
                lvPayrollDim."Dimension Value Code" := lvDefaultDim."Dimension Value Code";
                lvPayrollDim."Payroll Code" := PayrollHdr."Payroll Code";
                lvPayrollDim.Insert
            until lvDefaultDim.Next = 0
    end;

    procedure sGetDefaultEDDims(PayrollEntry: Record "Payroll Entry")
    var
        lvPayrollDim: Record "Payroll Dimension";
        lvDefaultDim: Record "Default Dimension";
    begin
        //skm 300506
        //This function copies default dimensions from the ED to the Payroll Entry table

        lvDefaultDim.SetRange("Table ID", DATABASE::"ED Definitions");
        lvDefaultDim.SetRange("No.", PayrollEntry."ED Code");
        if lvDefaultDim.FindFirst then
            repeat
                lvPayrollDim."Table ID" := DATABASE::"Payroll Entry";
                lvPayrollDim."Payroll ID" := PayrollEntry."Payroll ID";
                lvPayrollDim."Employee No" := PayrollEntry."Employee No.";
                lvPayrollDim."Entry No" := PayrollEntry."Entry No.";
                lvPayrollDim."ED Code" := PayrollEntry."ED Code";
                lvPayrollDim."Dimension Code" := lvDefaultDim."Dimension Code";
                lvPayrollDim."Dimension Value Code" := lvDefaultDim."Dimension Value Code";
                lvPayrollDim."Payroll Code" := PayrollEntry."Payroll Code";
                lvPayrollDim.Insert
            until lvDefaultDim.Next = 0
    end;

    procedure sGetDefaultEDDims2(PayrollLine: Record "Payroll Lines")
    var
        lvPayrollDim: Record "Payroll Dimension";
        lvDefaultDim: Record "Default Dimension";
    begin
        //skm 060606
        //This function copies default dimensions from the ED to the Payroll Line table

        lvDefaultDim.SetRange("Table ID", DATABASE::"ED Definitions");
        lvDefaultDim.SetRange("No.", PayrollLine."ED Code");
        if lvDefaultDim.FindFirst then
            repeat
                lvPayrollDim."Table ID" := DATABASE::"Payroll Lines";
                lvPayrollDim."Payroll ID" := PayrollLine."Payroll ID";
                lvPayrollDim."Employee No" := PayrollLine."Employee No.";
                lvPayrollDim."Entry No" := PayrollLine."Entry No.";
                lvPayrollDim."ED Code" := PayrollLine."ED Code";
                lvPayrollDim."Dimension Code" := lvDefaultDim."Dimension Code";
                lvPayrollDim."Dimension Value Code" := lvDefaultDim."Dimension Value Code";
                lvPayrollDim."Payroll Code" := PayrollLine."Payroll Code";
                lvPayrollDim.Insert
            until lvDefaultDim.Next = 0
    end;

    procedure sDeleteDefaultEmpDims(PayrollHdr: Record "Payroll Header")
    var
        lvPayrollDim: Record "Payroll Dimension";
    begin
        //skm 310506
        //This function deletes payroll dimensions assigned to a payroll header

        //lvPayrollDim.SETRANGE("Table ID", DATABASE::"Payroll Header"); skm20110316, delete even those for the payroll lines and payroll en
        lvPayrollDim.SetRange("Employee No", PayrollHdr."Employee no.");
        lvPayrollDim.SetRange("Payroll ID", PayrollHdr."Payroll ID");
        lvPayrollDim.DeleteAll;
    end;

    procedure sDeleteDefaultEDDims(PayrollEntry: Record "Payroll Entry")
    var
        lvPayrollDim: Record "Payroll Dimension";
    begin
        //skm 310506
        //This function deletes payroll dimensions assigned to a payroll entry

        lvPayrollDim.SetRange("Table ID", DATABASE::"Payroll Entry");
        lvPayrollDim.SetRange("Employee No", PayrollEntry."Employee No.");
        lvPayrollDim.SetRange("Payroll ID", PayrollEntry."Payroll ID");
        lvPayrollDim.SetRange("Entry No", PayrollEntry."Entry No.");
        lvPayrollDim.SetRange("ED Code", PayrollEntry."ED Code");
        lvPayrollDim.DeleteAll;
    end;

    procedure sDeletePayrollLineDims(PayrollLine: Record "Payroll Lines")
    var
        lvPayrollDim: Record "Payroll Dimension";
    begin
        //skm 060606
        //This function deletes payroll dimensions assigned to a payroll line

        lvPayrollDim.SetRange("Table ID", DATABASE::"Payroll Lines");
        lvPayrollDim.SetRange("Employee No", PayrollLine."Employee No.");
        lvPayrollDim.SetRange("Payroll ID", PayrollLine."Payroll ID");
        lvPayrollDim.SetRange("Entry No", PayrollLine."Entry No.");
        lvPayrollDim.SetRange("ED Code", PayrollLine."ED Code");
        lvPayrollDim.DeleteAll;
    end;

    procedure sDeletePostingBufferDims(PayrollPostingBuffer: Record "Payroll Posting Buffer")
    var
        lvPayrollDim: Record "Payroll Dimension";
    begin
        //skm 060606
        //This function deletes payroll dimensions assigned to a payroll posting buffer entry

        lvPayrollDim.SetRange("Table ID", DATABASE::"Payroll Posting Buffer");
        lvPayrollDim.SetRange("Entry No", PayrollPostingBuffer."Buffer No");
        lvPayrollDim.DeleteAll;
    end;

    procedure sCopyDimsFromEntryToLines(PayrollEntry: Record "Payroll Entry"; PayrollLine: Record "Payroll Lines")
    var
        lvFromPayrollDim: Record "Payroll Dimension";
        lvToPayrollDim: Record "Payroll Dimension";
    begin
        //skm 060606 this function copies dimensions assigned to the payroll entry to the payroll line
        //associated to the payroll entry when payroll is calculated.

        lvFromPayrollDim.SetRange("Table ID", DATABASE::"Payroll Entry");
        lvFromPayrollDim.SetRange("Payroll ID", PayrollEntry."Payroll ID");
        lvFromPayrollDim.SetRange("Employee No", PayrollEntry."Employee No.");
        lvFromPayrollDim.SetRange("Entry No", PayrollEntry."Entry No.");
        lvFromPayrollDim.SetRange("ED Code", PayrollEntry."ED Code");
        if lvFromPayrollDim.FindFirst then
            repeat
                lvToPayrollDim.Copy(lvFromPayrollDim);
                lvToPayrollDim."Table ID" := DATABASE::"Payroll Lines";
                lvToPayrollDim."Entry No" := PayrollLine."Entry No.";
                lvToPayrollDim.Insert;
            until lvFromPayrollDim.Next = 0
    end;

    procedure sCopyDimsFromLineToLine(FromPayrollLine: Record "Payroll Lines"; ToPayrollLine: Record "Payroll Lines")
    var
        lvFromPayrollDim: Record "Payroll Dimension";
        lvToPayrollDim: Record "Payroll Dimension";
    begin
        //skm 060606 this function copies dimensions assigned to the payroll line to another payroll line

        lvFromPayrollDim.SetRange("Table ID", DATABASE::"Payroll Lines");
        lvFromPayrollDim.SetRange("Payroll ID", FromPayrollLine."Payroll ID");
        lvFromPayrollDim.SetRange("Employee No", FromPayrollLine."Employee No.");
        lvFromPayrollDim.SetRange("Entry No", FromPayrollLine."Entry No.");
        lvFromPayrollDim.SetRange("ED Code", FromPayrollLine."ED Code");
        if lvFromPayrollDim.FindFirst then
            repeat
                lvToPayrollDim.Copy(lvFromPayrollDim);
                lvToPayrollDim."Entry No" := ToPayrollLine."Entry No.";
                lvToPayrollDim.Insert;
            until lvFromPayrollDim.Next = 0
    end;

    procedure fGetEmplyeeLoanAccount(pEmployee: Record Employee; pLoanType: Record "Loan Types"): Code[20]
    var
        lvEmpCustLoanLink: Record "payroll line";
    begin
        //Pick customer loan account from Employee-Loan Type Matrix if any
        lvEmpCustLoanLink.SetRange("Employee No", pEmployee."No.");
        lvEmpCustLoanLink.SetRange("Loan Type", pLoanType.Code);
        if lvEmpCustLoanLink.FindFirst then exit(lvEmpCustLoanLink."Customer No");

        //Pick From Employee Card
        if pEmployee."Customer No." <> '' then exit(pEmployee."Customer No.");

        //Lastly pick from Loan Type
        if (pLoanType."Loan Accounts Type" = pLoanType."Loan Accounts Type"::Customer) and
           (pLoanType."Loan Account" <> '') then
            exit(pLoanType."Loan Account");

        Error('Customer Loan A/C is missing in ALL three possible sources:\' +
              '1. Employee Customer Loan Link\' +
              '2. Customer No on the Payroll tab of the Employee Card\' +
              '3. Loan Types\\' +
              'For Employee %1, Loan Type %2', pEmployee."No.", pLoanType.Code)
    end;

    procedure sAllocatePayroll(pPeriodID: Code[10]; pPayrollCode: Code[10]; pEmpNo: Code[20])
    var
        lvAllocationMatrix: Record "Payroll Exp Allocation Matrix";
        lvPayrollLineToAllocate: Record "Payroll Lines";
        lvPayrollLineAllocated: Record "Payroll Lines";
        lvPayrollDims: Record "Payroll Dimension";
        lvPreviousEntryNo: Integer;
        lvDefaultDimension: Record "Default Dimension";
        lvPeriod: Record Periods;
        lvPayrollSetup: Record "Payroll Setups";
    begin
        //skm060706 this sub alloactes payroll as per alloaction criteria of each employee
        //called by calculate payroll code units.

        //cmm 020813 VSF PAY1 - variable allocations per month
        lvPayrollSetup.Get(pPayrollCode);
        lvPeriod.Reset;
        lvPeriod.SetRange("Period ID", pPeriodID);
        lvPeriod.SetRange("Payroll Code", pPayrollCode);
        lvPeriod.FindFirst;
        lvPeriod.TestField("Start Date");
        lvPeriod.TestField("End Date");
        //end cmm

        //skm20110317 - AAFH payroll posting buffer dimensions are incorrect if both payroll expense and employee dims are specified. Block.
        lvAllocationMatrix.SetCurrentKey("Employee No");
        lvAllocationMatrix.SetRange("Employee No", pEmpNo);

        //cmm 050913 VSF PAY 1
        if lvAllocationMatrix.FindFirst then begin
            if lvPayrollSetup."Payroll Expense Based On" = lvPayrollSetup."Payroll Expense Based On"::" " then
                Error('You must specify Payroll Expense Based in Payroll Setup for Payroll Code %1', pPayrollCode);
            if lvPayrollSetup."Payroll Expense Based On" = lvPayrollSetup."Payroll Expense Based On"::Month then
                lvAllocationMatrix.SetRange("Posting Date", lvPeriod."Start Date", lvPeriod."End Date");
        end;
        //end cmm

        if lvAllocationMatrix.FindFirst then begin
            lvDefaultDimension.SetRange("Table ID", DATABASE::Employee);
            lvDefaultDimension.SetRange("No.", pEmpNo);
            if lvDefaultDimension.FindFirst then
                Error('Employee %1: Both Employee Dimensions and Payroll Expense Allocations are not supported at the same time. ' +
                  'Delete either the Employee Dimensions or Payroll Expense Allocations for this employee and try again.', pEmpNo);

            lvPayrollDims.SetRange("Table ID", DATABASE::"Payroll Header");
            lvPayrollDims.SetRange("Payroll ID", pPeriodID);
            lvPayrollDims.SetRange("Employee No", pEmpNo);
            if lvPayrollDims.FindFirst then
                Error('Employee %1: Both Payroll Header Dimensions and Payroll Expense Allocations are not supported at the same time. ' +
                  'Delete either the Payroll Header Dimensions or Payroll Expense Allocations for this employee and try again.', pEmpNo);
        end;

        lvPayrollDims.Reset;
        lvAllocationMatrix.Reset;
        //skm end

        if lvPayrollLineToAllocate.FindLast then lvPreviousEntryNo := lvPayrollLineToAllocate."Entry No.";

        lvPayrollLineToAllocate.SetCurrentKey("Payroll ID", "Employee No.", "ED Code");
        lvPayrollLineToAllocate.SetRange("Payroll ID", pPeriodID);
        lvPayrollLineToAllocate.SetRange("Employee No.", pEmpNo);
        lvPayrollLineToAllocate.SetRange("Payroll Code", pPayrollCode);
        lvPayrollLineToAllocate.SetFilter("Entry No.", '<=%1', lvPreviousEntryNo);

        lvAllocationMatrix.SetCurrentKey("Employee No", "ED Code");
        if lvPayrollLineToAllocate.FindFirst then
            repeat
                lvAllocationMatrix.SetRange("Employee No", pEmpNo);
                lvAllocationMatrix.SetRange("ED Code", lvPayrollLineToAllocate."ED Code");
                if lvPayrollSetup."Payroll Expense Based On" = lvPayrollSetup."Payroll Expense Based On"::Month then
                    lvAllocationMatrix.SetRange("Posting Date", lvPeriod."Start Date", lvPeriod."End Date");   //cmm 020813 VSF PAY1
                if lvAllocationMatrix.FindFirst then begin
                    repeat
                        //Allocate Payroll Line
                        lvPayrollLineAllocated.Copy(lvPayrollLineToAllocate);
                        lvPreviousEntryNo += 1;
                        lvPayrollLineAllocated."Entry No." := lvPreviousEntryNo;
                        lvPayrollLineAllocated.Amount :=
                          Round(lvAllocationMatrix.Allocated / 100 * lvPayrollLineToAllocate.Amount, 0.01);
                        lvPayrollLineAllocated."Amount (LCY)" :=
                          Round(lvAllocationMatrix.Allocated / 100 * lvPayrollLineToAllocate."Amount (LCY)", 0.01);
                        lvPayrollLineAllocated.Quantity :=
                          Round(lvAllocationMatrix.Allocated / 100 * lvPayrollLineToAllocate.Quantity, 0.01);
                        lvPayrollLineAllocated.Rate :=
                          Round(lvAllocationMatrix.Allocated / 100 * lvPayrollLineToAllocate.Rate, 0.01);
                        lvPayrollLineAllocated.Interest :=
                          Round(lvAllocationMatrix.Allocated / 100 * lvPayrollLineToAllocate.Interest, 0.01);
                        lvPayrollLineAllocated.Repayment :=
                          Round(lvAllocationMatrix.Allocated / 100 * lvPayrollLineToAllocate.Repayment, 0.01);
                        //skm20110715 fix error on loan allocation, reported by AAFH. The following loan fields were not being allocated
                        lvPayrollLineAllocated."Interest (LCY)" :=
                          Round(lvAllocationMatrix.Allocated / 100 * lvPayrollLineToAllocate."Interest (LCY)", 0.01);
                        lvPayrollLineAllocated."Repayment (LCY)" :=
                          Round(lvAllocationMatrix.Allocated / 100 * lvPayrollLineToAllocate."Repayment (LCY)", 0.01);
                        lvPayrollLineAllocated."Remaining Debt (LCY)" :=
                          Round(lvAllocationMatrix.Allocated / 100 * lvPayrollLineToAllocate."Remaining Debt (LCY)", 0.01);
                        lvPayrollLineAllocated."Paid (LCY)" :=
                          Round(lvAllocationMatrix.Allocated / 100 * lvPayrollLineToAllocate."Paid (LCY)", 0.01);
                        //skm end
                        lvPayrollLineAllocated.Insert;

                        //Assign Payroll Line Dims from Allocation table
                        lvPayrollDims."Table ID" := DATABASE::"Payroll Lines";
                        lvPayrollDims."Payroll ID" := pPeriodID;
                        lvPayrollDims."Employee No" := lvPayrollLineToAllocate."Employee No.";
                        lvPayrollDims."Entry No" := lvPreviousEntryNo;
                        lvPayrollDims."ED Code" := lvPayrollLineToAllocate."ED Code";
                        lvPayrollDims."Dimension Code" := lvAllocationMatrix."Dimension Code1";
                        lvPayrollDims."Dimension Value Code" := lvAllocationMatrix."Dimension Value Code1";
                        lvPayrollDims."Payroll Code" := pPayrollCode;
                        lvPayrollDims.Insert;
                        if lvAllocationMatrix."Dimension Value Code2" <> '' then begin
                            lvPayrollDims."Dimension Code" := lvAllocationMatrix."Dimension Code2";
                            lvPayrollDims."Dimension Value Code" := lvAllocationMatrix."Dimension Value Code2";
                            lvPayrollDims.Insert;
                        end;
                        if lvAllocationMatrix."Dimension Value Code3" <> '' then begin
                            lvPayrollDims."Dimension Code" := lvAllocationMatrix."Dimension Code3";
                            lvPayrollDims."Dimension Value Code" := lvAllocationMatrix."Dimension Value Code3";
                            lvPayrollDims.Insert;
                        end;
                        if lvAllocationMatrix."Dimension Value Code4" <> '' then begin
                            lvPayrollDims."Dimension Code" := lvAllocationMatrix."Dimension Code4";
                            lvPayrollDims."Dimension Value Code" := lvAllocationMatrix."Dimension Value Code4";
                            lvPayrollDims.Insert;
                        end;
                        //CSM extra dimensions Added for Ticket 45 08122011
                        if lvAllocationMatrix."Dimension Value Code5" <> '' then begin
                            lvPayrollDims."Dimension Code" := lvAllocationMatrix."Dimension Code5";
                            lvPayrollDims."Dimension Value Code" := lvAllocationMatrix."Dimension Value Code5";
                            lvPayrollDims.Insert;
                        end;
                        if lvAllocationMatrix."Dimension Value Code6" <> '' then begin
                            lvPayrollDims."Dimension Code" := lvAllocationMatrix."Dimension Code6";
                            lvPayrollDims."Dimension Value Code" := lvAllocationMatrix."Dimension Value Code6";
                            lvPayrollDims.Insert;
                        end;
                        if lvAllocationMatrix."Dimension Value Code7" <> '' then begin
                            lvPayrollDims."Dimension Code" := lvAllocationMatrix."Dimension Code7";
                            lvPayrollDims."Dimension Value Code" := lvAllocationMatrix."Dimension Value Code7";
                            lvPayrollDims.Insert;
                        end;
                        if lvAllocationMatrix."Dimension Value Code8" <> '' then begin
                            lvPayrollDims."Dimension Code" := lvAllocationMatrix."Dimension Code8";
                            lvPayrollDims."Dimension Value Code" := lvAllocationMatrix."Dimension Value Code8";
                            lvPayrollDims.Insert;
                        end;
                    //End CSM
                    until lvAllocationMatrix.Next = 0;

                    lvPayrollLineToAllocate.Delete(true);
                end;
            until lvPayrollLineToAllocate.Next = 0;
    end;

    procedure gfShortUserID(var UserID: Text[100]): Code[20]
    var
        lvUserID: Code[50];
    begin
        //skm2200409 AA Timesheets, return a short user id from a windows login
        if StrPos(UserID, '\') in [0, StrLen(UserID)] then
            if StrLen(UserID) <= 20 then begin
                Evaluate(lvUserID, UserID);
                exit(lvUserID)
            end else
                exit('')
        else begin
            Evaluate(lvUserID, CopyStr(UserID, StrPos(UserID, '\') + 1, 20));
            exit(lvUserID);
        end;
    end;

    procedure gsAssignPayrollCode() "Payroll Code": Code[10]
    var
        lvAllowedPayrolls: Record "Allowed Payrolls";
        lvActiveSession: Record "Active Session";
    begin
        lvActiveSession.Reset;
        lvActiveSession.SetRange("Server Instance ID", ServiceInstanceId);
        lvActiveSession.SetRange("Session ID", SessionId);
        lvActiveSession.FindFirst;

        lvAllowedPayrolls.SetRange("User ID", lvActiveSession."User ID");
        lvAllowedPayrolls.SetRange("Last Active Payroll", true);
        if lvAllowedPayrolls.FindFirst then
            exit(lvAllowedPayrolls."Payroll Code");
    end;
}

