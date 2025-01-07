report 50167 "Loans Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Loans Statement.rdl';
    Caption = 'Loan Statement';

    dataset
    {
        dataitem("Meeting Attendance"; "Meeting Attendance")
        {
            column(LoanNo; "Meeting Attendance"."Meeting No")
            {
            }
            column(OldLoanNo; "Meeting Attendance"."Meeting No")
            {
            }
            column(ClientName; "Meeting Attendance"."Meeting No")
            {
            }
            column(Project_Type; "Meeting Attendance"."Meeting No")
            {
            }
            column(Currency; "Meeting Attendance"."Meeting No")
            {
            }
            column(PrincipleArrears; "Meeting Attendance"."Meeting No")
            {
            }
            column(InterestArrears; "Meeting Attendance"."Meeting No")
            {
            }
            column(PenaltyArrears; "Meeting Attendance"."Meeting No")
            {
            }
            column(LoanFeeArrears; "Meeting Attendance"."Meeting No")
            {
            }
            column(TotalPastDue; "Meeting Attendance"."Meeting No")
            {
            }
            column(CompanyName; "Meeting Attendance"."Meeting No")
            {
            }
            column(CompanyAddress; CompanyInformation.Address)
            {
            }
            column(Address2; CompanyInformation."Address 2")
            {
            }
            column(PostCode; CompanyInformation."Post Code")
            {
            }
            column(City; CompanyInformation.City)
            {
            }
            column(Country; CompanyInformation."Country/Region Code")
            {
            }
            column(CompanyPhoneNo; CompanyInformation."Phone No.")
            {
            }
            column(CompanyFaxNo; CompanyInformation."Fax No.")
            {
            }
            column(E_mail; CompanyInformation."E-Mail")
            {
            }
            column(CPic; CompanyInformation.Picture)
            {
            }
            column(ReportTitle; "Meeting Attendance"."Meeting No")
            {
            }
            column(RunDate; "Meeting Attendance"."Meeting No")
            {
            }
            column(NonDueBalance; "Meeting Attendance"."Meeting No")
            {
            }
            column(CurrentPayOff; "Meeting Attendance"."Meeting No")
            {
            }
            column(NonDueInterest; "Meeting Attendance"."Meeting No")
            {
            }
            column(ApprovedAmt; "Meeting Attendance"."Meeting No")
            {
            }
            column(OverPayment; "Meeting Attendance"."Meeting No")
            {
            }
            column(CustAddress; "Meeting Attendance"."Meeting No")
            {
            }
            column(CustAddressLocation; "Meeting Attendance"."Meeting No")
            {
            }
            column(PhysicalLocation; "Meeting Attendance"."Meeting No")
            {
            }
            column(OpeningBal; "Meeting Attendance"."Meeting No")
            {
            }
            column(StartDate; "Meeting Attendance"."Meeting No")
            {
            }
            column(EndDate; "Meeting Attendance"."Meeting No")
            {
            }
            dataitem(LoanPrinciple; "Cust. Ledger Entry")
            {
                column(LoanPrincipleTransactionType; "Meeting Attendance"."Meeting No")
                {
                }
                column(LoanPrinciplePostingDate; "Meeting Attendance"."Meeting No")
                {
                }
                column(LoanPrincipleDueDate; "Meeting Attendance"."Meeting No")
                {
                }
                column(LoanPrincipleAmount; "Meeting Attendance"."Meeting No")
                {
                }
                column(LoanPrincipleDescription; "Meeting Attendance"."Meeting No")
                {
                }
                column(DebitAmt; "Meeting Attendance"."Meeting No")
                {
                }
                column(CreditAmt; "Meeting Attendance"."Meeting No")
                {
                }
                column(RunningAmt; "Meeting Attendance"."Meeting No")
                {
                }
                column(StatementNo; "Meeting Attendance"."Meeting No")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    /*DebitAmt:=0;CreditAmt:=0;

                    //LoanPrinciple.SETFILTER(LoanPrinciple."Posting Date",'%1..%2',StartDate,PeriodDate);
                    LoanPrinciple.SETRANGE(LoanPrinciple."Date Filter",StartDate,PeriodDate);
                    LoanPrinciple.CALCFIELDS(LoanPrinciple.Amount);
                    IF LoanPrinciple.Reversed <> TRUE THEN BEGIN
                     DebitAmt:=DebitAmt+LoanPrinciple.Amount;
                    END;
                    IF LoanPrinciple."Posting Date"<=060116D THEN BEGIN
                      Descriptions:=LoanPrinciple.Description;
                      //Descriptions:='OPENING BALANCE AS AT 01-JUN-2016';
                    END ELSE BEGIN
                      Descriptions:=LoanPrinciple.Description;
                    END;*/

                end;
            }

            trigger OnAfterGetRecord()
            begin
                //Amount Financed
                /* LoanGiven:=0;
                 "G/LEntry".RESET;
                 "G/LEntry".SETRANGE("G/LEntry"."G/L Account No.",'103110');
                 "G/LEntry".SETRANGE("G/LEntry"."Loan Account No.","No.");
                 IF "G/LEntry".FINDSET THEN BEGIN
                   REPEAT
                     IF "G/LEntry".Amount>0 THEN BEGIN
                       LoanGiven:=LoanGiven+"G/LEntry".Amount;
                     END;
                   UNTIL "G/LEntry".NEXT=0;
                 END;

                 Cust.RESET;
                 Cust.SETRANGE(Cust."No.","No.");
                 IF Cust.FINDFIRST THEN BEGIN
                   CustAddress:=Cust.Address+'-'+Cust."Post Code";
                   CustAddressLocation:=Cust.City+','+Cust."Country/Region Code";
                   PhysicalLocation:=Cust."Address 2";
                 END;
                 IF GETFILTER("No.")='' THEN BEGIN
                   ERROR('Loan Account Filter Not Specified');
                 END;
                 //Get Prepayment
                 OverPayment:=0;
                 CustLedger.RESET;
                 CustLedger.SETRANGE(CustLedger."Customer No.","No.");
                 CustLedger.SETRANGE(CustLedger."Loan Transaction Type",CustLedger."Loan Transaction Type"::" ");
                 IF CustLedger.FINDSET THEN BEGIN
                   REPEAT
                     CustLedger.CALCFIELDS(CustLedger.Amount);
                     OverPayment:=OverPayment+CustLedger.Amount;
                   UNTIL CustLedger.NEXT=0;
                 END;

                 RunDate:=EndDate;
                 PeriodDate:=RunDate;
                 TakeOnDate:=060116D;
                     VPrincipleInArrears:=0;VInterestInArrears:=0;VPenaltyInArrears:=0;VLoanFeeInArrears:=0;TotalArrears:=0;
                     VPrincipleNotArrears:=0;VInterestNotArrears:=0;VPenaltyNotArrears:=0;VLoanFeeNotArrears:=0;
                     TotalBilled:=0;LoanGiven:=0;NonDueBalance:=0;CurrentPayOff:=0;
                     //"Repayment Frequency By"::Month
                     //PrincipleInArrears
                     CustLedger.RESET;
                     CustLedger.SETRANGE(CustLedger."Customer No.","Appl. Legal Due Diligence"."Postal Code");
                     CustLedger.SETRANGE(CustLedger."Loan Account No.","Loan Account No."."No.");
                     CustLedger.SETRANGE(CustLedger."Due Date",StartDate,CALCDATE('CM',CALCDATE('-1M',PeriodDate)));
                     CustLedger.SETRANGE(CustLedger."Loan Transaction Type",CustLedger."Loan Transaction Type"::"2");
                     CustLedger.SETFILTER(CustLedger."Date Filter",'%1..%2',StartDate,PeriodDate);
                     IF CustLedger.FINDSET THEN BEGIN
                       REPEAT
                         CustLedger.CALCFIELDS(CustLedger."Remaining Amount");
                         VPrincipleInArrears:=VPrincipleInArrears+CustLedger."Remaining Amount";
                       UNTIL CustLedger.NEXT=0;
                     END;

                     //InterestInArrears
                     CustLedger.RESET;
                     CustLedger.SETRANGE(CustLedger."Customer No.","Appl. Legal Due Diligence"."Postal Code");
                     CustLedger.SETRANGE(CustLedger."Loan Account No.","Appl. Legal Due Diligence"."No.");
                     CustLedger.SETRANGE(CustLedger."Due Date",StartDate,CALCDATE('CM',CALCDATE('-1M',PeriodDate)));
                     CustLedger.SETRANGE(CustLedger."Loan Transaction Type",CustLedger."Loan Transaction Type"::"4");
                     CustLedger.SETFILTER(CustLedger."Date Filter",'%1..%2',StartDate,PeriodDate);
                     IF (CustLedger.FINDSET) THEN BEGIN
                       REPEAT
                         CustLedger.CALCFIELDS(CustLedger."Remaining Amount");
                         VInterestInArrears:=VInterestInArrears+CustLedger."Remaining Amount";
                       UNTIL CustLedger.NEXT=0;
                     END;

                     //PenaltyInArrears
                     CustLedger.RESET;
                     CustLedger.SETRANGE(CustLedger."Customer No.","Appl. Legal Due Diligence"."Postal Code");
                     CustLedger.SETRANGE(CustLedger."Loan Account No.","Appl. Legal Due Diligence"."No.");
                     CustLedger.SETRANGE(CustLedger."Due Date",StartDate,PeriodDate);
                     CustLedger.SETRANGE(CustLedger."Loan Transaction Type",CustLedger."Loan Transaction Type"::"6");
                     CustLedger.SETFILTER(CustLedger."Date Filter",'%1..%2',StartDate,PeriodDate);
                     IF CustLedger.FINDSET THEN BEGIN
                       REPEAT
                         CustLedger.CALCFIELDS(CustLedger."Remaining Amount");
                         VPenaltyInArrears:=VPenaltyInArrears+CustLedger."Remaining Amount";
                       UNTIL CustLedger.NEXT=0;
                     END;

                     //LoanFeesInArrears
                     CustLedger.RESET;
                     CustLedger.SETRANGE(CustLedger."Customer No.","Appl. Legal Due Diligence"."Postal Code");
                     CustLedger.SETRANGE(CustLedger."Loan Account No.","Appl. Legal Due Diligence"."No.");
                     CustLedger.SETRANGE(CustLedger."Due Date",StartDate,PeriodDate);
                     CustLedger.SETRANGE(CustLedger."Loan Transaction Type",CustLedger."Loan Transaction Type"::"8");
                     CustLedger.SETFILTER(CustLedger."Date Filter",'%1..%2',StartDate,PeriodDate);
                     IF CustLedger.FINDSET THEN BEGIN
                       REPEAT
                         CustLedger.CALCFIELDS(CustLedger."Remaining Amount");
                         VLoanFeeInArrears:=VLoanFeeInArrears+CustLedger."Remaining Amount";
                       UNTIL CustLedger.NEXT=0;
                     END;
                     //--------------------------------------------------------------------------------------------------------------

                     //LoanGiven
                     {NonDueDate:=0D;
                     NonDueBalance:=0;
                     CustLedger.RESET;
                     CustLedger.SETCURRENTKEY(CustLedger."Customer No.",CustLedger."Loan Account No.",CustLedger."Due Date");
                     CustLedger.SETRANGE(CustLedger."Customer No.","Investment Accounts"."Customer No.");
                     CustLedger.SETRANGE(CustLedger."Loan Account No.","Investment Accounts"."No.");
                     CustLedger.SETRANGE(CustLedger."Due Date",StartDate,PeriodDate);
                     CustLedger.SETRANGE(CustLedger,CustLedger."Transaction Type"::"1");
                     IF CustLedger.FINDFIRST THEN BEGIN
                       NonDueDate:=CustLedger."Charge Period";
                     END;
                     IF NonDueDate<>0D THEN BEGIN
                       CustLedger.RESET;
                       CustLedger.SETCURRENTKEY(CustLedger."Customer No.",CustLedger."Loan No",CustLedger."Charge Period");
                       CustLedger.SETRANGE(CustLedger."Customer No.","Interest Rate");
                       CustLedger.SETRANGE(CustLedger."Loan No",Code);
                       CustLedger.SETRANGE(CustLedger."Charge Period",NonDueDate,PeriodDate);
                       CustLedger.SETFILTER(CustLedger."Transaction Type",'%1|%2',CustLedger."Transaction Type"::"1",
                                                                                  CustLedger."Transaction Type"::"2");
                       IF CustLedger.FINDSET THEN BEGIN
                         REPEAT
                           CustLedger.CALCFIELDS(CustLedger.Amount);
                           IF CustLedger."Transaction Type"=CustLedger."Transaction Type"::"1" THEN BEGIN
                             NonDueBalance:=NonDueBalance+CustLedger.Amount;
                           END ELSE BEGIN
                             NonDueBalance:=NonDueBalance-CustLedger.Amount;
                           END;
                         UNTIL CustLedger.NEXT=0;
                       END;
                     END;}
                     //-----------------------------------------------------------------------------------------------------------------

                     //VPrincipleNotArrears
                     CustLedger.RESET;
                     CustLedger.SETRANGE(CustLedger."Customer No.","Appl. Legal Due Diligence"."Postal Code");
                     CustLedger.SETRANGE(CustLedger."Loan Account No.","Appl. Legal Due Diligence"."No.");
                     CustLedger.SETRANGE(CustLedger."Due Date",CALCDATE('-CM',PeriodDate),CALCDATE('CM',PeriodDate));
                     CustLedger.SETRANGE(CustLedger."Loan Transaction Type",CustLedger."Loan Transaction Type"::"2");
                     CustLedger.SETFILTER(CustLedger."Date Filter",'%1..%2',StartDate,PeriodDate);
                     IF CustLedger.FINDSET THEN BEGIN
                       REPEAT
                         CustLedger.CALCFIELDS(CustLedger."Remaining Amount");
                         VPrincipleNotArrears:=VPrincipleNotArrears+CustLedger."Remaining Amount";
                       UNTIL CustLedger.NEXT=0;
                     END;
                     //-------------------------------------------------------------------------------------------------------------------

                     //Accrued Interest Not In Arrears
                     CustLedger.RESET;
                     CustLedger.SETRANGE(CustLedger."Customer No.","Appl. Legal Due Diligence"."Postal Code");
                     CustLedger.SETRANGE(CustLedger."Loan Account No.","Appl. Legal Due Diligence"."No.");
                     CustLedger.SETRANGE(CustLedger."Due Date",CALCDATE('-CM',PeriodDate),CALCDATE('CM',PeriodDate));
                     CustLedger.SETRANGE(CustLedger."Loan Transaction Type",CustLedger."Loan Transaction Type"::"4");
                     CustLedger.SETFILTER(CustLedger."Date Filter",'%1..%2',StartDate,PeriodDate);
                     IF CustLedger.FINDSET THEN BEGIN
                       REPEAT
                         CustLedger.CALCFIELDS(CustLedger."Remaining Amount");
                         VInterestNotArrears:=VInterestNotArrears+CustLedger."Remaining Amount";
                       UNTIL CustLedger.NEXT=0;
                     END;

                     //CurrentPayoff
                     TotalArrears:=VPrincipleInArrears+VInterestInArrears+VPenaltyInArrears+VLoanFeeInArrears;
                     //CurrentPayOff:=TotalArrears+NonDueBalance+VPrincipleNotArrears+VInterestNotArrears;
                     CurrentPayOff:=TotalArrears+NonDueBalance+VInterestNotArrears;
                     IF OverPayment<0 THEN BEGIN
                       CurrentPayOff:=CurrentPayOff+OverPayment;
                     END;
                     //----------------------------------------------------------------------------
                     */

            end;

            trigger OnPreDataItem()
            begin
                /*  IF GETFILTER("No.")='' THEN BEGIN
                    ERROR('Loan Account Filter Not Specified');
                  END;
                  RunningAmt:=0;*/

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(StartDate; StartDate)
                {
                }
                field(EndDate; EndDate)
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

    trigger OnPreReport()
    begin
        CompanyInformation.Get;
        CompanyInformation.CalcFields(CompanyInformation.Picture);
    end;

    var
        RunDate: Date;
        CustLedger: Record "Cust. Ledger Entry";
        "G/LEntry": Record "G/L Entry";
        VPrincipleInArrears: Decimal;
        VInterestInArrears: Decimal;
        VPenaltyInArrears: Decimal;
        VLoanFeeInArrears: Decimal;
        PeriodDate: Date;
        NextPeriodTxt: Code[10];
        NextPeriod: DateFormula;
        TotalArrears: Decimal;
        CompanyInformation: Record "Company Information";
        ReportTitle: Label 'Summarised Performance';
        NonDueBalance: Decimal;
        TakeOnDate: Date;
        TotalBilled: Decimal;
        CurrentPayOff: Decimal;
        LoansSchedule: Record "Agenda vote items";
        LoanGiven: Decimal;
        VInterestNotArrears: Decimal;
        VPenaltyNotArrears: Decimal;
        VLoanFeeNotArrears: Decimal;
        VPrincipleNotArrears: Decimal;
        DtldCustLedger: Record "Detailed Cust. Ledg. Entry";
        OverPayment: Decimal;
        Cust: Record Customer;
        CustAddress: Text[100];
        CustAddressLocation: Text[100];
        PhysicalLocation: Text[100];
        OpeningBal: Decimal;
        StartDate: Date;
        EndDate: Date;
        DebitAmt: Decimal;
        CreditAmt: Decimal;
        RunningAmt: Decimal;
        LoanDisburse: Record "Meeting Attendance";
        NonDueDate: Date;
        Descriptions: Text[250];
}

