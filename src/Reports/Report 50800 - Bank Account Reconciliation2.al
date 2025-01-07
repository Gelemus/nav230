report 50800 "Bank Account Reconciliation2"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Bank Account Reconciliation2.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Bank Account Statement"; "Bank Account Statement")
        {
            column(BankAccountNo_BankAccountStatement; "Bank Account Statement"."Bank Account No.")
            {
            }
            column(StatementNo_BankAccountStatement; "Bank Account Statement"."Statement No.")
            {
            }
            column(StatementEndingBalance_BankAccountStatement; "Bank Account Statement"."Statement Ending Balance")
            {
            }
            column(StatementDate_BankAccountStatement; "Bank Account Statement"."Statement Date")
            {
            }
            column(BalanceLastStatement_BankAccountStatement; "Bank Account Statement"."Balance Last Statement")
            {
            }
            column(BankName; BankName)
            {
            }
            column(BankAccNo; BankAccNo)
            {
            }
            column(BalanceBF; BalanceBF)
            {
            }
            column(BalanceCF; BalanceCF)
            {
            }
            column(StartDate2; StartDate2)
            {
            }
            column(Receipts; Receipts)
            {
            }
            column(CompanyPic; CompanyInformation.Picture)
            {
            }
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(Payments; Payments)
            {
            }
            column(Unpresented; Unpresented)
            {
            }
            column(Uncredited; Uncredited)
            {
            }
            column(CurrencyCode; CurrencyCode)
            {
            }
            column(TodayFormatted; Format(Today, 0, 4))
            {
            }
            column(CompanyName1; UpperCase(CompanyName))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No.");
                DataItemTableView = SORTING("Bank Account No.", "Posting Date") ORDER(Ascending);
                column(Bnkpostingdate; "Bank Account Ledger Entry"."Posting Date")
                {
                }
                column(BnkDocumentno; "Bank Account Ledger Entry"."Document No.")
                {
                }
                column(BnkDesc; "Bank Account Ledger Entry".Description)
                {
                }
                column(BnkCheck; "Bank Account Ledger Entry"."External Document No.")
                {
                }
                column(Credit; "Bank Account Ledger Entry"."Credit Amount")
                {
                }
                column(Amount_BankAccountLedgerEntry; "Bank Account Ledger Entry".Amount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    // MESSAGE('%1',"Bank Account Ledger Entry"."Entry No.");
                end;

                trigger OnPreDataItem()
                begin
                    //Unpresented
                    BankAccLedger.Reset;
                    BankAccLedger.SetRange(BankAccLedger."Bank Account No.", "Bank Account Statement"."Bank Account No.");
                    "Bank Account Ledger Entry".SetRange("Bank Account Ledger Entry"."Posting Date", 0D, EndDate);
                    "Bank Account Ledger Entry".SetFilter("Bank Account Ledger Entry"."Statement No.", '>%1|=%2', StatementNo, '');
                    "Bank Account Ledger Entry".SetFilter("Bank Account Ledger Entry"."Posting Date", '>%1|=%2', StatementDate, 0D);
                    //"Bank Account Ledger Entry".SETFILTER("Bank Account Ledger Entry"."Statement Status",'<>%1',"Bank Account Ledger Entry"."Statement Status"::Closed);
                    "Bank Account Ledger Entry".SetFilter("Bank Account Ledger Entry".Amount, '<%1', 0);


                    if BankAccLedger.Find('-') then begin
                        repeat
                            Unpresented := Unpresented + BankAccLedger.Amount;
                        until BankAccLedger.Next = 0;
                    end;
                    Unpresented := -Unpresented;
                end;
            }
            dataitem(BankAccountLedgerEntry2; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No.");
                DataItemTableView = SORTING("Bank Account No.", "Posting Date") ORDER(Ascending);
                column(Bnkpostingdate2; "Bank Account Ledger Entry"."Posting Date")
                {
                }
                column(BnkDocumentno2; "Bank Account Ledger Entry"."Document No.")
                {
                }
                column(BnkDesc2; "Bank Account Ledger Entry".Description)
                {
                }
                column(AmountBankAccountLedgerEntry2; "Bank Account Ledger Entry".Amount)
                {
                }
                column(BnkCheck2; "Bank Account Ledger Entry"."External Document No.")
                {
                }
                column(Debit; "Bank Account Ledger Entry"."Debit Amount")
                {
                }
                column(PostingDate; PostingDate)
                {
                }
                column(Description; Description)
                {
                }
                column(DocNo; DocNo)
                {
                }
                column(Amount; Amount)
                {
                }
                column(TotalAmount; TotalAmount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    // MESSAGE('%1',BankAccountLedgerEntry2."Entry No.");

                    PostingDate := 0D;
                    Description := '';
                    DocNo := '';
                    Amount := 0;

                    PostingDate := BankAccountLedgerEntry2."Posting Date";
                    Description := BankAccountLedgerEntry2.Description;
                    DocNo := BankAccountLedgerEntry2."Document No.";
                    Amount := BankAccountLedgerEntry2.Amount;
                    TotalAmount := TotalAmount + Amount;
                    //MESSAGE('%1',TotalAmount);
                end;

                trigger OnPreDataItem()
                begin
                    //Unpresented
                    //BankAccLedger.RESET;
                    //BankAccLedger.SETRANGE(BankAccLedger."Bank Account No.","Bank Account Statement"."Bank Account No.");
                    BankAccountLedgerEntry2.Reset;
                    BankAccountLedgerEntry2.SetRange(BankAccountLedgerEntry2."Bank Account No.", BankAcc);
                    BankAccountLedgerEntry2.SetRange(BankAccountLedgerEntry2."Posting Date", 0D, EndDate);
                    BankAccountLedgerEntry2.SetRange(BankAccountLedgerEntry2.Open, true);
                    BankAccountLedgerEntry2.SetFilter(BankAccountLedgerEntry2."Statement No.", '>%1|=%2', StatementNo, '');
                    BankAccountLedgerEntry2.SetFilter(BankAccountLedgerEntry2."Posting Date", '>%1|=%2', StatementDate, 0D);
                    //BankAccountLedgerEntry2.SETFILTER(BankAccountLedgerEntry2."Statement Status",'<>%1',BankAccountLedgerEntry2."Statement Status"::Closed);
                    BankAccountLedgerEntry2.SetFilter(BankAccountLedgerEntry2.Amount, '>%1', 0);

                    if BankAccountLedgerEntry2.Find('-') then begin
                        repeat
                            Unpresented := Unpresented + BankAccountLedgerEntry2.Amount;
                        until BankAccountLedgerEntry2.Next = 0;
                    end;
                    Unpresented := -Unpresented;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                StartDate1 := CalcDate('CD+1D', "Bank Account Statement"."Statement Date");
                StartDate2 := CalcDate('CD-1M', StartDate1);
                StartDate3 := CalcDate('CD-1D', StartDate2);

                EndDate := "Bank Account Statement"."Statement Date";
                StatementNo := "Bank Account Statement"."Statement No.";
                if BankStatement.Get("Bank Account Statement"."Bank Account No.", "Bank Account Statement"."Statement No.") then
                    StatementDate := BankStatement."Statement Date";


                if Banks.Get("Bank Account Statement"."Bank Account No.") then begin
                    BankName := Banks.Name;
                    BankAccNo := Banks."Bank Account No.";
                    BankAcc := Banks."No.";

                    CurrencyCode := Banks."Currency Code";

                    if CurrencyCode = '' then begin
                        GenLedgerSetup.Get;
                        CurrencyCode := GenLedgerSetup."LCY Code";
                    end

                end;

                Banks.SetRange(Banks."Date Filter", 0D, StartDate3);
                Banks.CalcFields(Banks.Balance);
                BalanceBF := Banks.Balance;


                Banks.SetRange(Banks."Date Filter", 0D, "Bank Account Statement"."Statement Date");
                Banks.CalcFields(Banks.Balance);
                BalanceCF := Banks.Balance;

                //MESSAGE('%1',BalanceBF);
                //MESSAGE('%1',BalanceCF);


                //Receipts
                BankAccLedger.Reset;
                BankAccLedger.SetRange(BankAccLedger."Bank Account No.", "Bank Account Statement"."Bank Account No.");
                BankAccLedger.SetRange(BankAccLedger."Posting Date", StartDate2, "Bank Account Statement"."Statement Date");
                //BankAccLedger.SETFILTER(BankAccLedger."Statement Status",'<>%1',BankAccLedger."Statement Status"::Closed);
                BankAccLedger.SetFilter(BankAccLedger.Amount, '>%1', 0);

                if BankAccLedger.Find('-') then begin
                    repeat
                        Receipts := Receipts + BankAccLedger.Amount;
                    until BankAccLedger.Next = 0;
                end;


                //Payments
                BankAccLedger.Reset;
                BankAccLedger.SetRange(BankAccLedger."Bank Account No.", "Bank Account Statement"."Bank Account No.");
                BankAccLedger.SetRange(BankAccLedger."Posting Date", StartDate2, "Bank Account Statement"."Statement Date");
                //BankAccLedger.SETFILTER(BankAccLedger."Statement Status",'<>%1',BankAccLedger."Statement Status"::Closed);
                BankAccLedger.SetFilter(BankAccLedger.Amount, '<%1', 0);

                if BankAccLedger.Find('-') then begin
                    repeat
                        Payments := Payments + BankAccLedger.Amount;
                    until BankAccLedger.Next = 0;
                end;


                //Uncredited
                BankAccLedger.Reset;
                BankAccLedger.SetRange(BankAccLedger."Bank Account No.", "Bank Account Statement"."Bank Account No.");
                BankAccLedger.SetRange(BankAccLedger."Posting Date", 0D, "Bank Account Statement"."Statement Date");
                BankAccLedger.SetRange(BankAccLedger.Open, true);
                //BankAccLedger.SETFILTER(BankAccLedger."Statement Status",'<>%1',BankAccLedger."Statement Status"::Closed);
                BankAccLedger.SetFilter(BankAccLedger."Statement No.", '>%1', Format("Bank Account Statement"."Statement No."));
                BankAccLedger.SetFilter(BankAccLedger."Statement No.", '>%1|=%2', "Bank Account Statement"."Statement No.", '');
                BankAccLedger.SetFilter(BankAccLedger."Posting Date", '>%1|=%2', "Bank Account Statement"."Statement Date", 0D);
                BankAccLedger.SetFilter(BankAccLedger.Amount, '>%1', 0);

                if BankAccLedger.Find('-') then begin
                    repeat
                        Uncredited := Uncredited + BankAccLedger.Amount;
                    until BankAccLedger.Next = 0;
                end;
                Uncredited := -Uncredited;

                //Unpresented
                BankAccLedger.Reset;
                BankAccLedger.SetRange(BankAccLedger."Bank Account No.", "Bank Account Statement"."Bank Account No.");
                BankAccLedger.SetRange(BankAccLedger."Posting Date", 0D, "Bank Account Statement"."Statement Date");
                BankAccLedger.SetRange(BankAccLedger.Open, true);
                //BankAccLedger.SETFILTER(BankAccLedger."Statement Status",'<>%1',BankAccLedger."Statement Status"::Closed);
                BankAccLedger.SetFilter(BankAccLedger."Statement No.", '<>%1', Format("Bank Account Statement"."Statement No."));
                BankAccLedger.SetFilter(BankAccLedger."Statement No.", '>%1|=%2', "Bank Account Statement"."Statement No.", '');
                BankAccLedger.SetFilter(BankAccLedger."Posting Date", '>%1|=%2', "Bank Account Statement"."Statement Date", 0D);
                BankAccLedger.SetFilter(BankAccLedger.Amount, '<%1', 0);

                if BankAccLedger.Find('-') then begin
                    repeat
                        Unpresented := Unpresented + BankAccLedger.Amount;
                    until BankAccLedger.Next = 0;
                end;
                Unpresented := -Unpresented;
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

    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;

    var
        BankName: Code[50];
        BankAccNo: Code[50];
        Banks: Record "Bank Account";
        BalanceBF: Decimal;
        BalanceCF: Decimal;
        StartDate1: Date;
        StartDate2: Date;
        StartDate3: Date;
        BankAccLedger: Record "Bank Account Ledger Entry";
        Receipts: Decimal;
        Payments: Decimal;
        Unpresented: Decimal;
        Uncredited: Decimal;
        EndDate: Date;
        StatementNo: Code[10];
        CurrencyCode: Code[10];
        GenLedgerSetup: Record "General Ledger Setup";
        BankAcc: Code[10];
        PostingDate: Date;
        Description: Text[100];
        DocNo: Code[20];
        Amount: Decimal;
        TotalAmount: Decimal;
        BankStatement: Record "Bank Account Statement";
        StatementDate: Date;
        CompanyInformation: Record "Company Information";
}

