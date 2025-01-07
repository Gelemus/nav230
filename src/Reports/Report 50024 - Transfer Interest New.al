report 50024 "Transfer Interest New"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Transfer Interest New.rdl';

    dataset
    {
        dataitem("FD Processing"; "FD Processing")
        {
            DataItemTableView = WHERE("Fixed Deposit Status" = FILTER(<> Matured));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Document No.", "Fixed Deposit Status";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address2; Company."Address 2")
            {
            }
            column(Company_PhoneNo; Company."Phone No.")
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }

            trigger OnAfterGetRecord()
            begin

                Transfer := false;

                "FD Processing".CalcFields("FD Processing"."Untranfered Interest");
                if "FD Processing"."FD Maturity Date" <= Today then begin
                    if "FD Processing"."Untranfered Interest" > 0 then begin
                        //IF "FD Processing1"."Interest Earned">0 THEN BEGIN
                        if AccountType.Get("FD Processing"."Account Type") then begin
                            //IF AccountType."Fixed Deposit" = TRUE THEN BEGIN
                            if "FD Processing"."FD Maturity Date" <= PDate then begin
                                "FD Processing"."FD Marked for Closure" := true;
                                Transfer := true;

                                //Send E-Mail
                                /*
                                SMTPMAIL.NewMessage(Gensetup."Sender Address",'DIMKES SACCO - Fixed Deposit Maturity');
                                SMTPMAIL.SetWorkMode();
                                SMTPMAIL.ClearAttachments();
                                SMTPMAIL.ClearAllRecipients();
                                SMTPMAIL.SetDebugMode();
                                SMTPMAIL.SetFromAdress(Gensetup."Sender Address");
                                SMTPMAIL.SetHost(Gensetup."Outgoing Mail Server");
                                SMTPMAIL.SetUserID(Gensetup."Sender User ID");
                                SMTPMAIL.AddLine('Your fixed deposit has matured and the interested earned transfered to your savings account.');
                                SMTPMAIL.AddLine('');
                                SMTPMAIL.AddLine('GM - UN SACCO');
                                SMTPMAIL.SetToAdress("FD Processing1"."E-Mail");
                                SMTPMAIL.Send;
                                */
                                //Send E-Mail

                            end else
                                Transfer := false;
                        end else
                            Transfer := true;
                    end;

                    if Transfer = true then begin

                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Journal Batch Name" := 'INTCALC-F';
                        GenJournalLine."Document No." := DocNo;
                        GenJournalLine."External Document No." := "FD Processing"."FD Account";
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                        if AccountType.Get("FD Processing"."Account Type") then begin
                            //IF AccountType."Fixed Deposit" = TRUE THEN
                            //GenJournalLine."Account No.":="FD Processing1"."Savings Account No."
                            //ELSE
                            GenJournalLine."Account No." := "FD Processing"."FD Account";
                            //END ELSE
                            GenJournalLine."Account No." := "FD Processing"."FD Account";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            if "FD Processing"."FD Maturity Date" <= Today then begin
                                GenJournalLine."Posting Date" := "FD Processing"."FD Maturity Date"
                            end else
                                GenJournalLine."Posting Date" := PDate;
                            GenJournalLine.Description := 'Interest Earned';
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := -"FD Processing"."Untranfered Interest";
                            //GenJournalLine.Amount:=-"FD Processing1"."Interest Earned";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := '107080';
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;


                            //POST WITHHOLDING TAX
                            Gensetup.Get();
                            LineNo := LineNo + 10000;
                            Gensetup.Get();
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PURCHASES';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Journal Batch Name" := 'INTCALC-F';
                            GenJournalLine."Document No." := DocNo;
                            GenJournalLine."External Document No." := "FD Processing"."FD Account";
                            GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                            GenJournalLine."Account No." := '107220';
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            if "FD Processing"."FD Maturity Date" <= Today then begin
                                GenJournalLine."Posting Date" := "FD Processing"."FD Maturity Date"
                            end else
                                GenJournalLine."Posting Date" := PDate;
                            GenJournalLine.Description := 'Witholding Tax on Int';
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            //IF AccountType."Fixed Deposit" = TRUE THEN
                            GenJournalLine.Amount := -"FD Processing"."Untranfered Interest" * 0.15;
                            //ELSE
                            //GenJournalLine.Amount:=ROUND(((IntRate/1200)*"FD Processing1"."Balance (LCY)")*MidMonthFactor*0.15,0.05,'>');
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::Vendor;
                            GenJournalLine."Bal. Account No." := "FD Processing"."FD Account";
                            //GenJournalLine."Bal. Account No.":=AccountType."Interest Payable Account";
                            GenJournalLine."Shortcut Dimension 1 Code" := "FD Processing"."Global Dimension 1 Code";
                            GenJournalLine."Shortcut Dimension 2 Code" := "FD Processing"."Global Dimension 2 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            //IF GenJournalLine.Amount<>0 THEN
                            GenJournalLine.Insert;


                            "FD Processing".CalcFields("FD Processing"."Interest Earned");
                            //"FD Processing1".CALCFIELDS("FD Processing1"."Balance (LCY)");
                            "FD Processing"."Transfer Amount to Savings" := (("FD Processing"."FD Amount") + "FD Processing"."Interest Earned") - ("FD Processing"."Interest Earned" * 0.15);
                            if ("FD Processing"."FD Amount") < "FD Processing"."Transfer Amount to Savings" then
                                //ERROR('Fixed Deposit account does not have enough money to facilate the requested trasfer.');

                                LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PURCHASES';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Journal Batch Name" := 'INTCALC-F';
                            GenJournalLine."Document No." := "FD Account";
                            GenJournalLine."External Document No." := "FD Account";
                            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                            GenJournalLine."Account No." := "FD Processing"."FD Account";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            if "FD Processing"."FD Maturity Date" <= Today then begin
                                GenJournalLine."Posting Date" := "FD Processing"."FD Maturity Date"
                            end else
                                GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Term Balance Tranfers';
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := "FD Processing"."Transfer Amount to Savings";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            //IF GenJournalLine.Amount<>0 THEN
                            GenJournalLine.Insert;

                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PURCHASES';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Journal Batch Name" := 'INTCALC-F';
                            GenJournalLine."Document No." := "FD Account";
                            GenJournalLine."External Document No." := "FD Account";
                            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                            GenJournalLine."Account No." := "FD Processing"."Savings Account No.";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            if "FD Processing"."FD Maturity Date" <= Today then begin
                                GenJournalLine."Posting Date" := "FD Processing"."FD Maturity Date"
                            end else
                                GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Term Balance Tranfers';
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := -"FD Processing"."Transfer Amount to Savings";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            //IF GenJournalLine.Amount<>0 THEN
                            GenJournalLine.Insert;




                            InterestBuffer.Reset;
                            InterestBuffer.SetRange(InterestBuffer."Account No", "FD Processing"."FD Account");
                            if InterestBuffer.Find('-') then
                                InterestBuffer.ModifyAll(InterestBuffer.Transferred, true);

                            "FD Processing"."Fixed Deposit Status" := "FD Processing"."Fixed Deposit Status"::Matured;
                            "FD Processing".Modify;

                        end;
                    end;
                end;
                //END;

            end;

            trigger OnPostDataItem()
            begin

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                GenJournalLine.SetRange("Journal Batch Name", 'INTCALC-F');
                if GenJournalLine.Find('-') then begin
                    repeat
                        GLPosting.Run(GenJournalLine);
                    until GenJournalLine.Next = 0;
                end;


                /*GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                GenJournalLine.SETRANGE("Journal Batch Name",'INTCALC');
                GenJournalLine.DELETEALL;*/

            end;

            trigger OnPreDataItem()
            begin
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                GenJournalLine.SetRange("Journal Batch Name", 'INTCALC-F');
                GenJournalLine.DeleteAll;

                DocNo := 'INT EARNED';
                PDate := Today;

                Gensetup.Get(0);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Document_No; DocNo)
                {
                    Caption = 'Document_No';
                }
                field(Posting_Date; PDate)
                {
                    Caption = 'Posting_Date';
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

    trigger OnInitReport()
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);
    end;

    var
        Company: Record "Company Information";
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Account: Record Vendor;
        AccountType: Record "Bank Account";
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
        Transfer: Boolean;
        Gensetup: Record "Funds General Setup";
}

