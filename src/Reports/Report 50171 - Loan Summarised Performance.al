report 50171 "Loan Summarised Performance"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Loan Summarised Performance.rdl';

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
            column(ClientName; "Meeting Attendance"."Meeting Name")
            {
            }
            column(PrincipleArrears; VPrincipleInArrears)
            {
            }
            column(InterestArrears; VInterestInArrears)
            {
            }
            column(PenaltyArrears; VPenaltyInArrears)
            {
            }
            column(LoanFeeArrears; VLoanFeeInArrears)
            {
            }
            column(TotalPastDue; TotalArrears)
            {
            }
            column(CompanyName; CompanyInformation.Name)
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
            column(ReportTitle; ReportTitle)
            {
            }
            column(RunDate; RunDate)
            {
            }
            column(NonDueBalance; NonDueBalance)
            {
            }
            column(CurrentPayOff; CurrentPayOff)
            {
            }
            column(NonDueInterest; VInterestNotArrears)
            {
            }

            trigger OnAfterGetRecord()
            begin
                /* PeriodDate:=RunDate;
                 TakeOnDate:=060116D;
                     VPrincipleInArrears:=0;VInterestInArrears:=0;VPenaltyInArrears:=0;VLoanFeeInArrears:=0;TotalArrears:=0;
                     VPrincipleNotArrears:=0;VInterestNotArrears:=0;VPenaltyNotArrears:=0;VLoanFeeNotArrears:=0;
                     TotalBilled:=0;LoanGiven:=0;NonDueBalance:=0;CurrentPayOff:=0;

                     //Principle InArrears
                     CustLedger.RESET;
                     CustLedger.SETRANGE(CustLedger."Customer No.","Meeting Date");
                     CustLedger.SETRANGE(CustLedger."Investment Account No.","Meeting No");
                     CustLedger.SETRANGE(CustLedger.Open,TRUE);
                     CustLedger.SETRANGE(CustLedger."Due Date",RunDate);
                     CustLedger.SETFILTER(CustLedger."Investment Transaction Type",'%1|%2',CustLedger."Investment Transaction Type"::"Principal Payment",CustLedger."Investment Transaction Type"::"Principal Receivable");
                     IF CustLedger.FINDSET THEN BEGIN
                       REPEAT
                         CustLedger.CALCFIELDS(CustLedger."Remaining Amount");
                         VPrincipleInArrears:=VPrincipleInArrears+CustLedger."Remaining Amount";
                       UNTIL CustLedger.NEXT=0;
                     END;

                     //InterestInArrears
                     CustLedger.RESET;
                     CustLedger.SETRANGE(CustLedger."Customer No.","Meeting Date");
                     CustLedger.SETRANGE(CustLedger."Investment Account No.","Meeting No");
                     CustLedger.SETRANGE(CustLedger.Open,TRUE);
                     CustLedger.SETRANGE(CustLedger."Due Date",RunDate);
                     CustLedger.SETFILTER(CustLedger."Investment Transaction Type",'%1|%2',CustLedger."Investment Transaction Type"::"Interest Payment",CustLedger."Investment Transaction Type"::"Interest Receivable");
                     IF CustLedger.FINDSET THEN BEGIN
                       REPEAT
                         CustLedger.CALCFIELDS(CustLedger."Remaining Amount");
                         VInterestInArrears:=VInterestInArrears+CustLedger."Remaining Amount";
                       UNTIL CustLedger.NEXT=0;
                     END;

                     //PenaltyInArrears
                     CustLedger.RESET;
                     CustLedger.SETRANGE(CustLedger."Customer No.","Meeting Date");
                     CustLedger.SETRANGE(CustLedger."Investment Account No.","Meeting No");
                     CustLedger.SETRANGE(CustLedger.Open,TRUE);
                     CustLedger.SETRANGE(CustLedger."Due Date",RunDate);
                     CustLedger.SETFILTER(CustLedger."Investment Transaction Type",'%1|%2',CustLedger."Investment Transaction Type"::"Penalty Interest Payment",CustLedger."Investment Transaction Type"::"Penalty Interest Receivable");
                     IF CustLedger.FINDSET THEN BEGIN
                       REPEAT
                         CustLedger.CALCFIELDS(CustLedger."Remaining Amount");
                         VPenaltyInArrears:=VPenaltyInArrears+CustLedger."Remaining Amount";
                       UNTIL CustLedger.NEXT=0;
                     END;

                     //LoanFeesInArrears
                     CustLedger.RESET;
                     CustLedger.SETRANGE(CustLedger."Customer No.","Meeting Date");
                     CustLedger.SETRANGE(CustLedger."Investment Account No.","Meeting No");
                     CustLedger.SETRANGE(CustLedger.Open,TRUE);
                     CustLedger.SETRANGE(CustLedger."Due Date",RunDate);
                     CustLedger.SETFILTER(CustLedger."Investment Transaction Type",'%1|%2',CustLedger."Investment Transaction Type"::"Loan Fee Payment",CustLedger."Investment Transaction Type"::"Loan Fee Receivable");
                     IF CustLedger.FINDSET THEN BEGIN
                       REPEAT
                         CustLedger.CALCFIELDS(CustLedger."Remaining Amount");
                         VLoanFeeInArrears:=VLoanFeeInArrears+CustLedger."Remaining Amount";
                       UNTIL CustLedger.NEXT=0;
                     END;

                     //----------------------------------------------------------------------------
                     //TotalBilled
                     {DtldCustLedger.RESET;
                     DtldCustLedger.SETRANGE(DtldCustLedger."Customer No.","Client Code");
                     DtldCustLedger.SETRANGE(DtldCustLedger."Loan No","Loan  No.");
                     //DtldCustLedger.SETRANGE(DtldCustLedger."Charge Period",TakeOnDate,PeriodDate);
                     DtldCustLedger.SETRANGE(DtldCustLedger."Charge Period",0D,PeriodDate);
                     DtldCustLedger.SETFILTER(DtldCustLedger."Transaction Type",'%1',DtldCustLedger."Transaction Type"::"Loan Principle");
                     IF DtldCustLedger.FINDSET THEN BEGIN
                       REPEAT
                         TotalBilled:=TotalBilled+DtldCustLedger.Amount;
                       UNTIL DtldCustLedger.NEXT=0;
                     END;}
                     //LoanGiven

                    { NonDueDate:=0D;
                     DtldCustLedger.RESET;
                     DtldCustLedger.SETCURRENTKEY(DtldCustLedger."Customer No.",DtldCustLedger."Loan Account No.",DtldCustLedger."Charge Period");
                     DtldCustLedger.SETRANGE(DtldCustLedger."Customer No.","Client Code");
                     DtldCustLedger.SETRANGE(DtldCustLedger."Loan No","Loan  No.");
                     DtldCustLedger.SETFILTER(DtldCustLedger."Transaction Type",'%1',DtldCustLedger."Transaction Type"::"1");
                     IF DtldCustLedger.FINDFIRST THEN BEGIN
                       NonDueDate:=DtldCustLedger."Charge Period";
                     END;
                     DtldCustLedger.RESET;
                     DtldCustLedger.SETCURRENTKEY(DtldCustLedger."Customer No.",DtldCustLedger."Loan No",DtldCustLedger."Charge Period");
                     DtldCustLedger.SETRANGE(DtldCustLedger."Customer No.","Client Code");
                     DtldCustLedger.SETRANGE(DtldCustLedger."Loan No","Loan  No.");
                     DtldCustLedger.SETRANGE(DtldCustLedger."Charge Period",NonDueDate,PeriodDate);
                     DtldCustLedger.SETFILTER(DtldCustLedger."Transaction Type",'%1|%2',DtldCustLedger."Transaction Type"::"1",
                                              DtldCustLedger."Transaction Type"::"2");
                     IF DtldCustLedger.FINDSET THEN BEGIN
                       REPEAT
                         IF DtldCustLedger."Transaction Type"=DtldCustLedger."Transaction Type"::"1" THEN BEGIN
                           NonDueBalance:=NonDueBalance+DtldCustLedger.Amount;
                         END ELSE BEGIN
                           NonDueBalance:=NonDueBalance-DtldCustLedger.Amount;
                         END;
                       UNTIL DtldCustLedger.NEXT=0;
                     END;
                     //VPrincipleNotArrears
                     DtldCustLedger.RESET;
                     DtldCustLedger.SETRANGE(DtldCustLedger."Customer No.","Client Code");
                     DtldCustLedger.SETRANGE(DtldCustLedger."Loan No","Loan  No.");
                     IF "Repayment Frequency"="Repayment Frequency"::"1" THEN BEGIN
                       DtldCustLedger.SETRANGE(DtldCustLedger."Charge Period",PeriodDate);
                     END;
                     IF "Repayment Frequency"="Repayment Frequency"::"2" THEN BEGIN
                       DtldCustLedger.SETRANGE(DtldCustLedger."Charge Period",CALCDATE('-CW',PeriodDate),CALCDATE('CW',PeriodDate));
                     END;
                     IF "Repayment Frequency"="Repayment Frequency"::"3" THEN BEGIN
                       DtldCustLedger.SETRANGE(DtldCustLedger."Charge Period",CALCDATE('-CM',PeriodDate),CALCDATE('CM',PeriodDate));
                     END;
                     IF "Repayment Frequency"="Repayment Frequency"::"4" THEN BEGIN
                       DtldCustLedger.SETRANGE(DtldCustLedger."Charge Period",CALCDATE('-CQ',PeriodDate),CALCDATE('CQ',PeriodDate));
                     END;
                     IF "Repayment Frequency"="Repayment Frequency"::"5" THEN BEGIN
                       NextPeriodTxt:='-'+FORMAT("Repayment UserDefined");
                       EVALUATE(NextPeriod,NextPeriodTxt);
                       DtldCustLedger.SETFILTER(DtldCustLedger."Charge Period",'>%1',CALCDATE('+1D',CALCDATE(NextPeriod,PeriodDate)));
                     END;
                     DtldCustLedger.SETFILTER(DtldCustLedger."Transaction Type",'%1',DtldCustLedger."Transaction Type"::"2");
                     IF DtldCustLedger.FINDSET THEN BEGIN
                       REPEAT
                         VPrincipleNotArrears:=VPrincipleNotArrears+DtldCustLedger.Amount;
                       UNTIL DtldCustLedger.NEXT=0;
                     END;
                     //NonDueBalance:=LoanGiven-TotalBilled;
                     //NonDueBalance:=NonDueBalance+VPrincipleNotArrears;

                     //Accrued Interest Not In Arrears
                     DtldCustLedger.RESET;
                     DtldCustLedger.SETRANGE(DtldCustLedger."Customer No.","Client Code");
                     DtldCustLedger.SETRANGE(DtldCustLedger."Loan No","Loan  No.");
                     IF "Repayment Frequency"="Repayment Frequency"::"1" THEN BEGIN
                       DtldCustLedger.SETRANGE(DtldCustLedger."Charge Period",PeriodDate);
                     END;
                     IF "Repayment Frequency"="Repayment Frequency"::"2" THEN BEGIN
                       DtldCustLedger.SETRANGE(DtldCustLedger."Charge Period",CALCDATE('-CW',PeriodDate),CALCDATE('CW',PeriodDate));
                     END;
                     IF "Repayment Frequency"="Repayment Frequency"::"3" THEN BEGIN
                       DtldCustLedger.SETRANGE(DtldCustLedger."Charge Period",CALCDATE('-CM',PeriodDate),CALCDATE('CM',PeriodDate));
                     END;
                     IF "Repayment Frequency"="Repayment Frequency"::"4" THEN BEGIN
                       DtldCustLedger.SETRANGE(DtldCustLedger."Charge Period",CALCDATE('-CQ',PeriodDate),CALCDATE('CQ',PeriodDate));
                     END;
                     IF "Repayment Frequency"="Repayment Frequency"::"5" THEN BEGIN
                       NextPeriodTxt:='-'+FORMAT("Repayment UserDefined");
                       EVALUATE(NextPeriod,NextPeriodTxt);
                       DtldCustLedger.SETFILTER(DtldCustLedger."Charge Period",'>%1',CALCDATE('+1D',CALCDATE(NextPeriod,PeriodDate)));
                     END;
                     DtldCustLedger.SETFILTER(DtldCustLedger."Transaction Type",'%1',DtldCustLedger."Transaction Type"::"3");
                     IF DtldCustLedger.FINDSET THEN BEGIN
                       REPEAT
                         VInterestNotArrears:=VInterestNotArrears+DtldCustLedger.Amount;
                       UNTIL DtldCustLedger.NEXT=0;
                     END;
                     //Accrued Penalty Not in Arrears
                     DtldCustLedger.RESET;
                     DtldCustLedger.SETRANGE(DtldCustLedger."Customer No.","Client Code");
                     DtldCustLedger.SETRANGE(DtldCustLedger."Loan No","Loan  No.");
                     IF "Repayment Frequency"="Repayment Frequency"::"1" THEN BEGIN
                       DtldCustLedger.SETRANGE(DtldCustLedger."Charge Period",PeriodDate);
                     END;
                     IF "Repayment Frequency"="Repayment Frequency"::"2" THEN BEGIN
                       DtldCustLedger.SETRANGE(DtldCustLedger."Charge Period",CALCDATE('-CW',PeriodDate),CALCDATE('CW',PeriodDate));
                     END;
                     IF "Repayment Frequency"="Repayment Frequency"::"3" THEN BEGIN
                       DtldCustLedger.SETRANGE(DtldCustLedger."Charge Period",CALCDATE('-CM',PeriodDate),CALCDATE('CM',PeriodDate));
                     END;
                     IF "Repayment Frequency"="Repayment Frequency"::"4" THEN BEGIN
                       DtldCustLedger.SETRANGE(DtldCustLedger."Charge Period",CALCDATE('-CQ',PeriodDate),CALCDATE('CQ',PeriodDate));
                     END;
                     IF "Repayment Frequency"="Repayment Frequency"::"5" THEN BEGIN
                       NextPeriodTxt:='-'+FORMAT("Repayment UserDefined");
                       EVALUATE(NextPeriod,NextPeriodTxt);
                       DtldCustLedger.SETFILTER(DtldCustLedger."Charge Period",'>%1',CALCDATE('+1D',CALCDATE(NextPeriod,PeriodDate)));
                     END;
                     DtldCustLedger.SETFILTER(DtldCustLedger."Transaction Type",'%1',DtldCustLedger."Transaction Type"::"5");
                     IF DtldCustLedger.FINDSET THEN BEGIN
                       REPEAT
                         VPenaltyNotArrears:=VPenaltyNotArrears+DtldCustLedger.Amount;
                       UNTIL DtldCustLedger.NEXT=0;
                     END;
                     //Loan Fee Not in Arrears
                     DtldCustLedger.RESET;
                     DtldCustLedger.SETRANGE(DtldCustLedger."Customer No.","Client Code");
                     DtldCustLedger.SETRANGE(DtldCustLedger."Loan No","Loan  No.");
                     IF "Repayment Frequency"="Repayment Frequency"::"1" THEN BEGIN
                       DtldCustLedger.SETRANGE(DtldCustLedger."Charge Period",PeriodDate);
                     END;
                     IF "Repayment Frequency"="Repayment Frequency"::"2" THEN BEGIN
                       DtldCustLedger.SETRANGE(DtldCustLedger."Charge Period",CALCDATE('-CW',PeriodDate),CALCDATE('CW',PeriodDate));
                     END;
                     IF "Repayment Frequency"="Repayment Frequency"::"3" THEN BEGIN
                       DtldCustLedger.SETRANGE(DtldCustLedger."Charge Period",CALCDATE('-CM',PeriodDate),CALCDATE('CM',PeriodDate));
                     END;
                     IF "Repayment Frequency"="Repayment Frequency"::"4" THEN BEGIN
                       DtldCustLedger.SETRANGE(DtldCustLedger."Charge Period",CALCDATE('-CQ',PeriodDate),CALCDATE('CQ',PeriodDate));
                     END;
                     IF "Repayment Frequency"="Repayment Frequency"::"5" THEN BEGIN
                       NextPeriodTxt:='-'+FORMAT("Repayment UserDefined");
                       EVALUATE(NextPeriod,NextPeriodTxt);
                       DtldCustLedger.SETFILTER(DtldCustLedger."Charge Period",'>%1',CALCDATE('+1D',CALCDATE(NextPeriod,PeriodDate)));
                     END;
                     DtldCustLedger.SETFILTER(DtldCustLedger."Transaction Type",'%1',DtldCustLedger."Transaction Type"::"7");
                     IF DtldCustLedger.FINDSET THEN BEGIN
                       REPEAT
                         VLoanFeeNotArrears:=VLoanFeeNotArrears+DtldCustLedger.Amount;
                       UNTIL DtldCustLedger.NEXT=0;
                     END;}
                     //CurrentPayoff
                     TotalArrears:=VPrincipleInArrears+VInterestInArrears+VPenaltyInArrears+VLoanFeeInArrears;
                     CurrentPayOff:=TotalArrears+NonDueBalance+VInterestNotArrears+VPenaltyNotArrears+VLoanFeeNotArrears;
                     //----------------------------------------------------------------------------
               */

            end;

            trigger OnPreDataItem()
            begin
                if RunDate = 0D then
                    Error('Select the Run Date, it cannot be Null');
                //  SETRANGE("Loan Type","Loan Type"::"2");
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

    trigger OnPreReport()
    begin
        CompanyInformation.Get;
        CompanyInformation.CalcFields(CompanyInformation.Picture);
    end;

    var
        RunDate: Date;
        CustLedger: Record "Cust. Ledger Entry";
        VPrincipleInArrears: Decimal;
        VInterestInArrears: Decimal;
        VPenaltyInArrears: Decimal;
        VLoanFeeInArrears: Decimal;
        PeriodDate: Date;
        NextPeriodTxt: Code[10];
        NextPeriod: DateFormula;
        TotalArrears: Decimal;
        CompanyInformation: Record "Company Information";
        ReportTitle: Label 'Loan Balances & Summarised Performance';
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
        NonDueDate: Date;
}

