report 50025 "Generate Interest-Fixed New1."
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Generate Interest-Fixed New1..rdl';

    dataset
    {
        dataitem("FD Processing"; "FD Processing")
        {
            DataItemTableView = WHERE("FD Maturity Date" = FILTER(<> 0D), "Fixed Deposit Status" = FILTER(Active));
            RequestFilterFields = "Document No.", "Expected Maturity Date";

            trigger OnAfterGetRecord()
            begin

                IntRate := 0;
                AccruedInt := 0;
                MidMonthFactor := 1;
                MinBal := false;
                RIntDays := IntDays;
                AsAt := PostStart;

                CalcFields("Last Interest Earned Date");
                if "Last Interest Earned Date" <> 0D then begin
                    LastIntDate := "Last Interest Earned Date";
                end else if ("Last Interest Earned Date" = 0D) then
                        LastIntDate := "Fixed Deposit Start Date";

                if "FD Maturity Date" < RunDate then begin
                    RIntDays := LastIntDate - "FD Maturity Date";
                end else
                    RIntDays := LastIntDate - RunDate;

                FDProcess.Reset;
                FDProcess.SetRange(FDProcess."Document No.", "FD Processing"."Document No.");
                //FXDCODE:=FDProcess."Account Type";
                //FDProcess.SETFILTER(FDProcess."Date Filter",DFilter);
                if FDProcess.FindSet then begin
                    repeat
                        Bal := FDProcess."FD Amount";
                        DBALANCE := Round(((3 / 1200) * Bal) * 1, 0.05, '=');
                        if "FD Maturity Date" < RunDate then begin
                            PDate := "FD Maturity Date"
                        end else
                            PDate := RunDate;


                        Rate := "Interest rate";
                        DURATION := "FD Processing"."FD Duration";
                        //FXDINterest:=ROUND(((Bal*Rate/100)/12)*DURATION,1);

                        FXDINterest := Round(((Bal * Rate / 100) / 365) * RIntDays, 0.05, '=');
                        //MESSAGE('THE DURATION IS %1',DURATION);
                        //MESSAGE('the comp interest is %1',FXDINterest);






                        AccruedInt := FXDINterest;
                        //IF (AccruedInt>0)  THEN BEGIN
                        //MESSAGE(FORMAT(AccruedInt));
                        LineNo := LineNo + 10000;
                        //sysre 2019

                        /*
                        GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Journal Batch Name":='INTCALC';
                        GenJournalLine."Document No.":=DocNo;
                        GenJournalLine."External Document No.":="FD Processing"."FD Account";
                        GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
                        GenJournalLine."Account No.":='103210';
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        {IF "FD Maturity Date"<RunDate THEN BEGIN
                        GenJournalLine."Posting Date":="FD Maturity Date"
                        END ELSE}
                        GenJournalLine."Posting Date":=PDate;
                        GenJournalLine.Description:="FD Processing".Name;
                        GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                        //IF AccountType."Fixed Deposit" = TRUE THEN
                        //GenJournalLine.Amount:=AccruedInt
                        //ELSE

                        //AccruedInt:=AccruedInt+ROUND(((IntRate/1200)*Bal)*MidMonthFactor,0.05,'>');
                        GenJournalLine.Amount:=AccruedInt;
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                        GenJournalLine."Bal. Account No.":='107080';
                        //GenJournalLine."Shortcut Dimension 1 Code":="FD Processing1"."Global Dimension 1 Code";
                        //GenJournalLine."Shortcut Dimension 2 Code":="FD Processing1"."Global Dimension 2 Code";
                        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                        IF GenJournalLine.Amount<>0 THEN
                        GenJournalLine.INSERT;
                        */
                        //sysre end



                        /*//POST WITHHOLDING TAX
                        GenSetUp.GET();
                        LineNo:=LineNo+10000;

                        GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Journal Batch Name":='INTCALC';
                        GenJournalLine."Document No.":=DocNo;
                        GenJournalLine."External Document No.":="FD Processing1"."Destination Account";
                        GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
                        GenJournalLine."Account No.":=GenSetUp."WithHolding Tax Account";
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":=PDate;
                        GenJournalLine.Description:='Witholding Tax on Int';
                        GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                        //IF AccountType."Fixed Deposit" = TRUE THEN
                        GenJournalLine.Amount:=-AccruedInt*0.15;
                        //ELSE
                        //GenJournalLine.Amount:=ROUND(((IntRate/1200)*"FD Processing1"."Balance (LCY)")*MidMonthFactor*0.15,0.05,'>');
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        //enJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                        //GenJournalLine."Bal. Account No.":=;
                        //GenJournalLine."Bal. Account No.":=AccountType."Interest Payable Account";
                        GenJournalLine."Shortcut Dimension 1 Code":="FD Processing1"."Global Dimension 1 Code";
                        GenJournalLine."Shortcut Dimension 2 Code":="FD Processing1"."Global Dimension 2 Code";
                        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                        //IF GenJournalLine.Amount<>0 THEN
                        GenJournalLine.INSERT;
                        */

                        /*
                        //POST FXD TO ACCOUNT

                        LineNo:=LineNo+10000;

                        GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Journal Batch Name":='INTCALC';
                        GenJournalLine."Document No.":=DocNo;
                        GenJournalLine."External Document No.":="FD Processing1"."Destination Account";
                        GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
                        GenJournalLine."Account No.":="FD Processing1"."Destination Account";
                        GenJournalLine."Account No.":="FD Processing1"."Destination Account";
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":=PDate;
                        GenJournalLine.Description:='FXD Interest';
                        GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                        GenJournalLine.Amount:=-(AccruedInt-(AccruedInt*0.15));
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                        GenJournalLine."Bal. Account No.":=AccountType."Interest Payable Account";
                        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                        IF GenJournalLine.Amount<>0 THEN
                        GenJournalLine.INSERT;

                        */
                        //INTEREST BUFFER

                        /*
                        //Post
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                        GenJournalLine.SETRANGE("Journal Batch Name",'INTCALC');
                        IF GenJournalLine.FIND('-') THEN BEGIN
                        REPEAT
                        GLPosting.RUN(GenJournalLine);
                        UNTIL GenJournalLine.NEXT = 0;
                        END;


                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                        GenJournalLine.SETRANGE("Journal Batch Name",'INTCALC');
                        GenJournalLine.DELETEALL;
                        //Post
                              */
                        //INTEREST BUFFER

                        IntBufferNo := IntBufferNo + 1;

                        InterestBuffer.Init;
                        InterestBuffer.No := IntBufferNo;
                        InterestBuffer."Account No" := "FD Processing"."FD Account";
                        InterestBuffer."Account Type" := "FD Processing"."Account Type";
                        InterestBuffer."Document No." := "FD Processing"."Document No.";
                        InterestBuffer."Interest Date" := PDate;
                        //IF AccountType."Fixed Deposit" = TRUE THEN
                        InterestBuffer."Interest Amount" := AccruedInt * -1;
                        //ELSE
                        //InterestBuffer."Interest Amount":=ROUND(((IntRate/1200)*"FD Processing1"."Balance (LCY)")*MidMonthFactor,0.05,'>');
                        InterestBuffer."User ID" := UserId;
                        if InterestBuffer."Interest Amount" <> 0 then
                            InterestBuffer.Insert(true);

                    until FDProcess.Next = 0;
                end;


                //END;

                //END;
                //END;
                //END;
                //END;

            end;

            trigger OnPostDataItem()
            begin
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                GenJournalLine.SetRange("Journal Batch Name", 'INTCALC');
                if GenJournalLine.Find('-') then begin
                    CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);
                end;
            end;

            trigger OnPreDataItem()
            begin

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                GenJournalLine.SetRange("Journal Batch Name", 'INTCALC');
                GenJournalLine.DeleteAll;

                if RunDate = 0D then Error('Run date must be specified');
                DocNo := 'INT EARNED';
                if PDate = 0D then
                    PDate := RunDate;

                InterestBuffer.Reset;
                if InterestBuffer.Find('+') then
                    IntBufferNo := InterestBuffer.No;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(RunDate; RunDate)
                {
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Account: Record Vendor;
        AccountType: Record "Fixed Deposit Type";
        LineNo: Integer;
        ChequeType: Record "Fixed Deposit Type";
        FDInterestCalc: Record "FD Interest Calculation Crite";
        InterestBuffer: Record "Interest Buffer";
        IntRate: Decimal;
        DocNo: Code[10];
        PDate: Date;
        IntBufferNo: Integer;
        MidMonthFactor: Decimal;
        DaysInMonth: Integer;
        StartDate: Date;
        IntDays: Integer;
        AsAt: Date;
        MinBal: Boolean;
        AccruedInt: Decimal;
        RIntDays: Integer;
        Bal: Decimal;
        DFilter: Text[50];
        FixedDtype: Record "Fixed Deposit Type";
        DURATION: Integer;
        Dfilter2: Date;
        Dfilter3: Text[30];
        PostStart: Date;
        PostEnd: Date;
        DBALANCE: Decimal;
        FXDCODE: Code[20];
        Rate: Decimal;
        FXDINterest: Decimal;
        FXD: Record "Fixed Deposit Type";
        FDDURATION: DateFormula;
        FDINTEREST: Decimal;
        FXDLINE: Record "FD Interest Calculation Crite";
        DURATION2: Decimal;
        "Maturity Status": Option "Roll Back","Close Account","Transfer Interest";
        GnlJnlline: Record "Gen. Journal Line";
        GenSetUp: Record "Funds General Setup";
        LastIntDate: Date;
        FDProcess: Record "FD Processing";
        RunDate: Date;
}

