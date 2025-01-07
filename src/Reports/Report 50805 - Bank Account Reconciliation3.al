report 50805 "Bank Account Reconciliation3"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Bank Account Reconciliation3.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Bank Account Statement"; "Bank Account Statement")
        {
            RequestFilterFields = "Bank Account No.", "Statement No.";
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
            column(CompanyPic; CompanyInformation.Picture)
            {
            }
            column(CompanyName; CompanyInformation.Name)
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
                DataItemTableView = SORTING("Bank Account No.", "Posting Date") ORDER(Ascending) WHERE(Amount = FILTER(< 0));
                PrintOnlyIfDetail = false;
                column(PostingDate_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Posting Date")
                {
                }
                column(DocumentNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Document No.")
                {
                }
                column(Description_BankAccountLedgerEntry; "Bank Account Ledger Entry".Description)
                {
                }
                column(Amount_BankAccountLedgerEntry; "Bank Account Ledger Entry".Amount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    // MESSAGE('%1',"Bank Account Ledger Entry"."Entry No.");

                    if BankAccountLedgerEntry2."Statement No." = '' then
                        CurrReport.Skip;

                    Evaluate(sNo2, "Bank Account Statement"."Statement No.");
                    if sNo2 <= sNo1 then
                        CurrReport.Skip;
                    // END;
                end;

                trigger OnPreDataItem()
                begin
                    //Unpresented
                    "Bank Account Ledger Entry".Reset;
                    "Bank Account Ledger Entry".SetRange("Bank Account Ledger Entry"."Bank Account No.", "Bank Account Statement"."Bank Account No.");
                    "Bank Account Ledger Entry".SetRange("Bank Account Ledger Entry"."Posting Date", 0D, EndDate);
                    //"Bank Account Ledger Entry".SETFILTER("Bank Account Ledger Entry"."Statement No.",'>%1',FORMAT("Bank Account Statement"."Statement No."));
                    "Bank Account Ledger Entry".SetRange("Bank Account Ledger Entry".Open, false);
                    //"Bank Account Ledger Entry".SETFILTER("Bank Account Ledger Entry"."Statement No.",'>%1|=%2',StatementNo,'');
                    //"Bank Account Ledger Entry".SETFILTER("Bank Account Ledger Entry"."Statement Date",'>%1|=%2',StatementDate,0D);

                    "Bank Account Ledger Entry".SetFilter("Bank Account Ledger Entry".Amount, '<%1', 0);
                    if ("Bank Account Ledger Entry"."Statement Status" = "Bank Account Ledger Entry"."Statement Status"::Closed) and ("Bank Account Ledger Entry"."Statement No." = '') then
                        exit;
                    /*
                    IF BankAccLedger.FIND('-') THEN BEGIN
                    REPEAT
                    Unpresented:=Unpresented+BankAccLedger.Amount;
                    UNTIL BankAccLedger.NEXT=0;
                    END;
                    Unpresented:=-Unpresented;
                    
                    */

                end;
            }
            dataitem(BankAccountLedgerEntry3; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No.");
                DataItemTableView = SORTING("Bank Account No.", "Posting Date") ORDER(Ascending) WHERE(Amount = FILTER(< 0));
                PrintOnlyIfDetail = false;
                column(PostingDate_BankAccountLedgerEntry3; BankAccountLedgerEntry3."Posting Date")
                {
                }
                column(DocumentNo_BankAccountLedgerEntry3; BankAccountLedgerEntry3."Document No.")
                {
                }
                column(Description_BankAccountLedgerEntry3; BankAccountLedgerEntry3.Description)
                {
                }
                column(Amount_BankAccountLedgerEntry3; BankAccountLedgerEntry3.Amount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //MESSAGE('%1',"Bank Account Ledger Entry"."Entry No.");
                end;

                trigger OnPreDataItem()
                begin
                    //Unpresented
                    BankAccountLedgerEntry3.Reset;
                    BankAccountLedgerEntry3.SetRange(BankAccountLedgerEntry3."Bank Account No.", BankAcc);
                    BankAccountLedgerEntry3.SetRange(BankAccountLedgerEntry3."Posting Date", 0D, EndDate);
                    BankAccountLedgerEntry3.SetRange(BankAccountLedgerEntry3.Open, true);
                    BankAccountLedgerEntry3.SetFilter(BankAccountLedgerEntry3.Amount, '<%1', 0);
                end;
            }
            dataitem(BankAccountLedgerEntry4; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No.");
                DataItemTableView = SORTING("Bank Account No.", "Posting Date") ORDER(Ascending) WHERE(Amount = FILTER(> 0));
                PrintOnlyIfDetail = false;
                column(PostingDate_BankAccountLedgerEntry4; BankAccountLedgerEntry4."Posting Date")
                {
                }
                column(DocumentNo_BankAccountLedgerEntry4; BankAccountLedgerEntry4."Document No.")
                {
                }
                column(Description_BankAccountLedgerEntry4; BankAccountLedgerEntry4.Description)
                {
                }
                column(Amount_BankAccountLedgerEntry4; BankAccountLedgerEntry4.Amount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //MESSAGE('%1',"Bank Account Ledger Entry"."Entry No.");
                end;

                trigger OnPreDataItem()
                begin
                    //Unpresented
                    BankAccountLedgerEntry4.Reset;
                    BankAccountLedgerEntry4.SetRange(BankAccountLedgerEntry4."Bank Account No.", BankAcc);
                    BankAccountLedgerEntry4.SetRange(BankAccountLedgerEntry4."Posting Date", 0D, EndDate);
                    BankAccountLedgerEntry4.SetRange(BankAccountLedgerEntry4.Open, true);
                    BankAccountLedgerEntry4.SetFilter(BankAccountLedgerEntry4.Amount, '>%1', 0);
                end;
            }
            dataitem(BankAccountLedgerEntry2; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No.");
                DataItemTableView = SORTING("Bank Account No.", "Posting Date") ORDER(Ascending) WHERE(Amount = FILTER(> 0));
                PrintOnlyIfDetail = false;
                column(PostingDate_BankAccountLedgerEntry2; "Bank Account Ledger Entry"."Posting Date")
                {
                }
                column(DocumentNo_BankAccountLedgerEntry2; "Bank Account Ledger Entry"."Document No.")
                {
                }
                column(Description_BankAccountLedgerEntry2; "Bank Account Ledger Entry".Description)
                {
                }
                column(AmountBankAccountLedgerEntry2; "Bank Account Ledger Entry".Amount)
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
                    /*
                    PostingDate:=0D;
                    Description:='';
                    DocNo:='';
                    Amount:=0;
                    */
                    if BankAccountLedgerEntry2."Statement No." = '' then
                        CurrReport.Skip;

                    Evaluate(sNo4, BankAccountLedgerEntry2."Statement No.");
                    if sNo4 <= sNo1 then
                        CurrReport.Skip;

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
                    //BankAccountLedgerEntry2.SETFILTER(BankAccountLedgerEntry2."Statement No.",'>%1',FORMAT("Bank Account Statement"."Statement No."));
                    BankAccountLedgerEntry2.SetRange(BankAccountLedgerEntry2.Open, false);
                    //BankAccountLedgerEntry2.SETFILTER(BankAccountLedgerEntry2."Statement No.",'>%1|=%2',StatementNo,'');
                    //BankAccountLedgerEntry2.SETFILTER(BankAccountLedgerEntry2."Statement Date",'>%1|=%2',StatementDate,0D);

                    BankAccountLedgerEntry2.SetFilter(BankAccountLedgerEntry2.Amount, '>%1', 0);

                    if (BankAccountLedgerEntry2."Statement Status" = BankAccountLedgerEntry2."Statement Status"::Closed) and (BankAccountLedgerEntry2."Statement No." = '') then
                        exit;
                    /*
                    IF BankAccLedger.FIND('-') THEN BEGIN
                    REPEAT
                    Unpresented:=Unpresented+BankAccLedger.Amount;
                    UNTIL BankAccLedger.NEXT=0;
                    END;
                    Unpresented:=-Unpresented;
                    
                    
                    
                    BankAccountLedgerEntry2.RESET;
                    BankAccountLedgerEntry2.SETRANGE(BankAccountLedgerEntry2."Bank Account No.",BankAcc);
                    BankAccountLedgerEntry2.SETRANGE(BankAccountLedgerEntry2."Posting Date",0D,EndDate);
                    BankAccLedger.SETRANGE(BankAccLedger.Open,TRUE);
                    BankAccountLedgerEntry2.SETFILTER(BankAccountLedgerEntry2.Amount,'>%1',0);
                    */

                end;
            }

            trigger OnAfterGetRecord()
            begin
                StartDate1 := CalcDate('CD+1D', "Bank Account Statement"."Statement Date");
                StartDate2 := CalcDate('CD-1M', StartDate1);
                StartDate3 := CalcDate('CD-1D', StartDate2);
                Evaluate(sNo1, "Bank Account Statement"."Statement No.");

                BankAccLedger.Reset;
                BankAccLedger.SetRange(BankAccLedger."Bank Account No.", "Bank Account Statement"."Bank Account No.");
                BankAccLedger.SetRange(BankAccLedger."Posting Date", 0D, StartDate3);
                if BankAccLedger.FindSet then begin
                    repeat
                        BalanceBF := BankAccLedger.Amount + BalanceBF;
                    until BankAccLedger.Next = 0;
                end;
                BankAccLedger.Reset;
                BankAccLedger.SetRange(BankAccLedger."Bank Account No.", "Bank Account Statement"."Bank Account No.");
                BankAccLedger.SetRange(BankAccLedger."Posting Date", 0D, "Bank Account Statement"."Statement Date");
                if BankAccLedger.FindSet then begin
                    repeat
                        BalanceCF := BankAccLedger.Amount + BalanceCF;
                    until BankAccLedger.Next = 0;
                end;


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



                //MESSAGE('%1',BalanceCF);


                //Receipts
                BankAccLedger.Reset;
                BankAccLedger.SetRange(BankAccLedger."Bank Account No.", "Bank Account Statement"."Bank Account No.");
                BankAccLedger.SetRange("Statement No.", "Bank Account Statement"."Statement No.");
                //BankAccLedger.SETRANGE(BankAccLedger."Posting Date",StartDate2,"Bank Account Statement"."Statement Date");
                BankAccLedger.SetFilter(BankAccLedger.Amount, '>%1', 0);

                if BankAccLedger.Find('-') then begin
                    repeat
                        Receipts := Receipts + BankAccLedger.Amount;
                    until BankAccLedger.Next = 0;
                end;


                //Payments
                BankAccLedger.Reset;
                BankAccLedger.SetRange(BankAccLedger."Bank Account No.", "Bank Account Statement"."Bank Account No.");
                //BankAccLedger.SETRANGE(BankAccLedger."Posting Date",StartDate2,"Bank Account Statement"."Statement Date");
                BankAccLedger.SetRange("Statement No.", "Bank Account Statement"."Statement No.");
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

                BankAccLedger.SetRange(BankAccLedger.Open, false);
                //BankAccLedger.SETFILTER(BankAccLedger."Statement No.",'>%1',FORMAT("Bank Account Statement"."Statement No."));
                //BankAccLedger.SETFILTER(BankAccLedger."Statement No.",'>%1|=%2',"Bank Account Statement"."Statement No.",'');
                //BankAccLedger.SETFILTER(BankAccLedger."Statement Date",'>%1|=%2',"Bank Account Statement"."Statement Date",0D);
                BankAccLedger.SetFilter(BankAccLedger.Amount, '>%1', 0);

                if BankAccLedger.Find('-') then begin
                    if (BankAccLedger."Statement Status" = BankAccLedger."Statement Status"::Closed) and (BankAccLedger."Statement No." = '') then begin
                    end else begin
                        repeat
                            if BankAccLedger."Statement No." <> '' then begin
                                Evaluate(sNo5, BankAccLedger."Statement No.");
                                if sNo5 > sNo1 then begin
                                    Uncredited1 := Uncredited1 + BankAccLedger.Amount;
                                end;
                            end;
                        until BankAccLedger.Next = 0;
                    end;
                end;

                BankAccLedger.Reset;
                BankAccLedger.SetRange(BankAccLedger."Bank Account No.", "Bank Account Statement"."Bank Account No.");
                BankAccLedger.SetRange(BankAccLedger."Posting Date", 0D, "Bank Account Statement"."Statement Date");
                BankAccLedger.SetRange(BankAccLedger.Open, true);
                BankAccLedger.SetFilter(BankAccLedger."Statement No.", '<>%1', Format("Bank Account Statement"."Statement No."));
                //BankAccLedger.SETFILTER(BankAccLedger."Statement No.",'>%1|=%2',"Bank Account Statement"."Statement No.",'');
                //BankAccLedger.SETFILTER(BankAccLedger."Statement Date",'>%1|=%2',"Bank Account Statement"."Statement Date",0D);
                BankAccLedger.SetFilter(BankAccLedger.Amount, '>%1', 0);

                if BankAccLedger.Find('-') then begin
                    repeat
                        Uncredited3 := Uncredited3 + BankAccLedger.Amount;
                    until BankAccLedger.Next = 0;
                end;

                Uncredited := (Uncredited1 + Uncredited3);

                //Unpresented
                BankAccLedger.Reset;
                BankAccLedger.SetRange(BankAccLedger."Bank Account No.", "Bank Account Statement"."Bank Account No.");
                BankAccLedger.SetRange(BankAccLedger."Posting Date", 0D, "Bank Account Statement"."Statement Date");
                BankAccLedger.SetRange(BankAccLedger.Open, false);
                //BankAccLedger.SETFILTER(BankAccLedger."Statement No.",'>%1',FORMAT("Bank Account Statement"."Statement No."));
                //BankAccLedger.SETFILTER(BankAccLedger."Statement No.",'>%1|=%2',"Bank Account Statement"."Statement No.",'');
                //BankAccLedger.SETFILTER(BankAccLedger."Statement Date",'>%1|=%2',"Bank Account Statement"."Statement Date",0D);

                BankAccLedger.SetFilter(BankAccLedger.Amount, '<%1', 0);

                if BankAccLedger.Find('-') then begin
                    if (BankAccLedger."Statement Status" = BankAccLedger."Statement Status"::Closed) and (BankAccLedger."Statement No." = '') then begin
                    end else begin
                        repeat
                            if BankAccLedger."Statement No." <> '' then begin
                                Evaluate(sNo3, BankAccLedger."Statement No.");
                                if sNo3 > sNo1 then begin
                                    Unpresented1 := Unpresented1 + BankAccLedger.Amount;
                                end;
                            end;
                        until BankAccLedger.Next = 0;
                    end;
                end;

                Unpresented3 := 0;

                BankAccLedger.Reset;
                BankAccLedger.SetRange(BankAccLedger."Bank Account No.", "Bank Account Statement"."Bank Account No.");
                BankAccLedger.SetRange(BankAccLedger."Posting Date", 0D, "Bank Account Statement"."Statement Date");
                BankAccLedger.SetFilter(BankAccLedger.Open, 'TRUE');
                //BankAccLedger.SETFILTER(BankAccLedger."Statement No.",'>%1',FORMAT("Bank Account Statement"."Statement No."));
                //BankAccLedger.SETFILTER(BankAccLedger."Statement No.",'>%1|=%2',"Bank Account Statement"."Statement No.",'');
                //BankAccLedger.SETFILTER(BankAccLedger."Statement Date",'>%1|=%2',"Bank Account Statement"."Statement Date",0D);

                BankAccLedger.SetFilter(BankAccLedger.Amount, '<%1', 0);

                if BankAccLedger.FindSet then begin
                    repeat
                        Unpresented3 := Unpresented3 + BankAccLedger.Amount;
                    until BankAccLedger.Next = 0;
                end;



                Unpresented := -(Unpresented1 + Unpresented3);
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
        Banks1: Record "Bank Account";
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
        Unpresented1: Decimal;
        Uncredited1: Decimal;
        Unpresented3: Decimal;
        Uncredited3: Decimal;
        CompanyInformation: Record "Company Information";
        sNo1: Integer;
        sNo2: Integer;
        sNo3: Integer;
        sNo4: Integer;
        sNo5: Integer;
}

