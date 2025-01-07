report 50027 "Post FD Monthly Interest"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("FD Processing";"FD Processing")
        {

            trigger OnAfterGetRecord()
            begin
                TotalInterestAmount:=0;

                FundsGeneralSetup.Get;
                FundsGeneralSetup.TestField(FundsGeneralSetup."Fixed Deposit Interest A/c");
                //FundsGeneralSetup.TESTFIELD(FundsGeneralSetup."Fixed Deposit Receivable A/c");


                FDInterestBuffer.Reset;
                FDInterestBuffer.SetRange(FDInterestBuffer."Document No.","FD Processing"."Document No.");
                FDInterestBuffer.SetRange(FDInterestBuffer.Transferred,false);
                FDInterestBuffer.SetRange(FDInterestBuffer."Interest Date",StartDate,EndDate);
                if FDInterestBuffer.FindSet then begin
                  repeat
                    TotalInterestAmount:=TotalInterestAmount+FDInterestBuffer."Interest Amount";
                  until FDInterestBuffer.Next=0;
                end;

                  LineNo:=LineNo+10000;
                  GenJournalLine.Init;
                  GenJournalLine."Journal Template Name":='PURCHASES';
                  GenJournalLine."Line No.":=LineNo;
                  GenJournalLine."Journal Batch Name":='INTCALC';
                  GenJournalLine."Document No.":='FD/'+"FD Processing"."Document No.";
                  GenJournalLine."External Document No.":='FD/'+"FD Processing"."Document No."+'/'+Format(Today);
                  GenJournalLine."Account Type":=GenJournalLine."Account Type"::"Bank Account";
                  GenJournalLine."Account No.":="FD Processing"."FD Account";
                  GenJournalLine.Validate(GenJournalLine."Account No.");
                  GenJournalLine."Posting Date":=Today;
                  GenJournalLine.Description:='Fixed deposit interest for -'+"FD Processing"."Document No."+'- as at '+Format(Today);
                  GenJournalLine.Validate(GenJournalLine."Currency Code");
                  GenJournalLine.Amount:=TotalInterestAmount;
                  GenJournalLine.Validate(GenJournalLine.Amount);
                  GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                  GenJournalLine."Bal. Account No.":='';
                  GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                  if GenJournalLine.Amount<>0 then
                  GenJournalLine.Insert;

                  LineNo:=LineNo+10000;
                  GenJournalLine.Init;
                  GenJournalLine."Journal Template Name":='PURCHASES';
                  GenJournalLine."Line No.":=LineNo;
                  GenJournalLine."Journal Batch Name":='INTCALC';
                  GenJournalLine."Document No.":='FD/'+"FD Processing"."Document No.";
                  GenJournalLine."External Document No.":='FD/'+"FD Processing"."Document No."+'/'+Format(Today);
                  GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
                  GenJournalLine."Account No.":=FundsGeneralSetup."Fixed Deposit Interest A/c";
                  GenJournalLine.Validate(GenJournalLine."Account No.");
                  GenJournalLine."Posting Date":=Today;
                  GenJournalLine.Description:='Fixed deposit interest for -'+"FD Processing"."Document No."+'- as at '+Format(Today);
                  GenJournalLine.Validate(GenJournalLine."Currency Code");
                  GenJournalLine.Amount:=-TotalInterestAmount;
                  GenJournalLine.Validate(GenJournalLine.Amount);
                  GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                  GenJournalLine."Bal. Account No.":='';
                  GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                  if GenJournalLine.Amount<>0 then
                  GenJournalLine.Insert;

                Commit;

                //Post the Journal Lines
                CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Batch",GenJournalLine);
                Commit;

                FDInterestBuffer2.Reset;
                FDInterestBuffer2.SetRange(FDInterestBuffer2."Document No.","FD Processing"."Document No.");
                FDInterestBuffer2.SetRange(FDInterestBuffer2."Interest Date",StartDate,EndDate);
                FDInterestBuffer2.SetRange(FDInterestBuffer2.Transferred,false);
                if FDInterestBuffer2.FindSet then begin
                  repeat
                    FDInterestBuffer2.Transferred:=true;
                    FDInterestBuffer2.Modify;
                  until FDInterestBuffer2.Next=0;
                end;
            end;

            trigger OnPostDataItem()
            begin
                /*FDInterestBuffer.RESET;
                FDInterestBuffer.SETRANGE(FDInterestBuffer."Document No.","Document No.");
                IF FDInterestBuffer.FINDSET THEN BEGIN
                 // FDInterestBuffer.CALCSUMS(FDInterestBuffer."Interest Amount");
                
                  LineNo:=LineNo+10000;
                  GenJournalLine.INIT;
                  GenJournalLine."Journal Template Name":='PURCHASES';
                  GenJournalLine."Line No.":=LineNo;
                  GenJournalLine."Journal Batch Name":='INTCALC';
                  GenJournalLine."Document No.":='FD/'+"Interest Buffer"."Document No.";
                  GenJournalLine."External Document No.":='FD/'+"Interest Buffer"."Document No."+'/'+FORMAT(TODAY);
                  GenJournalLine."Account Type":=GenJournalLine."Account Type"::"Bank Account";
                  GenJournalLine."Account No.":=FDInterestBuffer."Account No";
                  GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                  GenJournalLine."Posting Date":=TODAY;
                  GenJournalLine.Description:='Fixed deposit interest for -'+FDInterestBuffer."Document No."+'- as at '+FORMAT(TODAY);
                  GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                  GenJournalLine.Amount:=FDInterestBuffer."Interest Amount";
                  GenJournalLine.VALIDATE(GenJournalLine.Amount);
                  GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                  GenJournalLine."Bal. Account No.":=FundsGeneralSetup."Fixed Deposit Interest A/c";
                  GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                  IF GenJournalLine.Amount<>0 THEN
                  GenJournalLine.INSERT;
                END;
                */

            end;

            trigger OnPreDataItem()
            begin
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
                GenJournalLine.SetRange("Journal Batch Name",'INTCALC');
                GenJournalLine.DeleteAll;

                EndDate:=20190930D;
                StartDate:=CalcDate('-CM',20190930D);
            end;
        }
    }

    requestpage
    {

        layout
        {
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
        LineNo: Integer;
        FDInterestBuffer: Record "Interest Buffer";
        FundsGeneralSetup: Record "Funds General Setup";
        FDInterestBuffer2: Record "Interest Buffer";
        FDProcessing2: Record "FD Processing";
        StartDate: Date;
        EndDate: Date;
        TotalInterestAmount: Decimal;
}

