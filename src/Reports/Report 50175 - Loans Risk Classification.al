report 50175 "Loans Risk Classification"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Loans Risk Classification.rdl';

    dataset
    {
        dataitem("Meeting Attendance"; "Meeting Attendance")
        {
            //The property 'DataItemTableView' shouldn't have an empty value.
            //DataItemTableView = '';
            column(LoanNo; "Meeting No")
            {
            }
            column(OldLoanNo; "Meeting No")
            {
            }
            column(ClientName; "Meeting Name")
            {
            }
            column(Repayment_LoansRegister; "Meeting Name")
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
            column(GlobalDim1; "Meeting Name")
            {
            }
            column(RiskClassification; "Meeting Name")
            {
            }
            column(T0to30Days; "0to30Days")
            {
            }
            column(T31to90Days; "31to90Days")
            {
            }
            column(T91to180Days; "91to180Days")
            {
            }
            column(T181to360Days; "181to360Days")
            {
            }
            column(Above360Days; Above360Days)
            {
            }

            trigger OnAfterGetRecord()
            begin
                /*IF "New Repayment Period" > 0 THEN BEGIN
                  INST:="New Repayment Period" ;
                  END ELSE BEGIN
                  INST:=Installments ;
                  END;*/
                /* INST:="Meeting Attendance"."No. of Installments";

               LoanReg.GET("Meeting No");
               LoanReg."Risk Classification":=LoanReg."Risk Classification"::"1";
               LoanReg.MODIFY;
               COMMIT;

               PeriodDate:=RunDate;
               StartDate:=0D;
               EndDate:=0D;
               TakeOnDate:=060116D;
                   VPrincipleInArrears:=0;VInterestInArrears:=0;VPenaltyInArrears:=0;VLoanFeeInArrears:=0;TotalArrears:=0;
                   VPrincipleNotArrears:=0;VInterestNotArrears:=0;VPenaltyNotArrears:=0;VLoanFeeNotArrears:=0;
                   TotalBilled:=0;LoanGiven:=0;NonDueBalance:=0;CurrentPayOff:=0;

                   "0to30Days":=0;"31to90Days":=0;"91to180Days":=0;"181to360Days":=0;Above360Days:=0;
                   //0to30DaysInArrears-Normal
                   EndDate:=PeriodDate;
                   StartDate:=CALCDATE('-30D',PeriodDate);
                   CustLedger.RESET;
                   CustLedger.SETRANGE(CustLedger."Customer No.","Meeting Date");
                   CustLedger.SETRANGE(CustLedger."Investment Account No.","Meeting No");
                   CustLedger.SETRANGE(CustLedger.Open,TRUE);
                   CustLedger.SETRANGE(CustLedger."Due Date",StartDate,EndDate);
                   CustLedger.SETFILTER(CustLedger."Investment Transaction Type",'%1|%2|%3|%4',CustLedger."Investment Transaction Type"::"Principal Receivable",
                                        CustLedger."Investment Transaction Type"::"Principal Payment",CustLedger."Investment Transaction Type"::"Interest Payment",
                                        CustLedger."Investment Transaction Type"::"Penalty Interest Payment");
                   IF CustLedger.FINDSET THEN BEGIN
                     LoanReg.GET("Meeting No");
                     LoanReg."Risk Classification":=LoanReg."Risk Classification"::"1";
                     LoanReg.MODIFY;
                     COMMIT;
                     REPEAT
                       CustLedger.CALCFIELDS(CustLedger."Remaining Amount");
                       "0to30Days":="0to30Days"+CustLedger."Remaining Amount";
                     UNTIL CustLedger.NEXT=0;
                   END;
                   //31to90DaysInArrears-Watch
                   EndDate:=CALCDATE('-1D',StartDate);
                   StartDate:=CALCDATE('-90D',PeriodDate);
                   CustLedger.RESET;
                   CustLedger.SETRANGE(CustLedger."Customer No.","Meeting Date");
                   CustLedger.SETRANGE(CustLedger."Investment Account No.","Meeting No");
                   CustLedger.SETRANGE(CustLedger.Open,TRUE);
                   CustLedger.SETRANGE(CustLedger."Due Date",StartDate,EndDate);
                   CustLedger.SETFILTER(CustLedger."Investment Transaction Type",'%1|%2|%3|%4',CustLedger."Investment Transaction Type"::"Principal Receivable",
                                        CustLedger."Investment Transaction Type"::"Principal Payment",CustLedger."Investment Transaction Type"::"Interest Payment",
                                        CustLedger."Investment Transaction Type"::"Penalty Interest Payment");
                   IF CustLedger.FINDSET THEN BEGIN
                     LoanReg.GET("Meeting No");
                     LoanReg."Risk Classification":=LoanReg."Risk Classification"::"2";
                     LoanReg.MODIFY;
                     COMMIT;
                     REPEAT
                       CustLedger.CALCFIELDS(CustLedger."Remaining Amount");
                       "31to90Days":="31to90Days"+CustLedger."Remaining Amount";
                     UNTIL CustLedger.NEXT=0;
                   END;

                   //91to180DaysInArrears-Substandard
                   EndDate:=CALCDATE('-1D',StartDate);
                   StartDate:=CALCDATE('-180D',PeriodDate);
                   CustLedger.RESET;
                   CustLedger.SETRANGE(CustLedger."Customer No.","Meeting Date");
                   CustLedger.SETRANGE(CustLedger."Investment Account No.","Meeting No");
                   CustLedger.SETRANGE(CustLedger.Open,TRUE);
                   CustLedger.SETRANGE(CustLedger."Due Date",StartDate,EndDate);
                   CustLedger.SETFILTER(CustLedger."Investment Transaction Type",'%1|%2|%3|%4',CustLedger."Investment Transaction Type"::"Principal Receivable",
                                        CustLedger."Investment Transaction Type"::"Principal Payment",CustLedger."Investment Transaction Type"::"Interest Payment",
                                        CustLedger."Investment Transaction Type"::"Penalty Interest Payment");
                   IF CustLedger.FINDSET THEN BEGIN
                     LoanReg.GET("Meeting No");
                     LoanReg."Risk Classification":=LoanReg."Risk Classification"::"3";
                     LoanReg.MODIFY;
                     COMMIT;
                     REPEAT
                       CustLedger.CALCFIELDS(CustLedger."Remaining Amount");
                       "91to180Days":="91to180Days"+CustLedger."Remaining Amount";
                     UNTIL CustLedger.NEXT=0;
                   END;

                   //181to360DaysInArrears - Doubtful
                   EndDate:=CALCDATE('-1D',StartDate);
                   StartDate:=CALCDATE('-360D',PeriodDate);
                   CustLedger.RESET;
                   CustLedger.SETRANGE(CustLedger."Customer No.","Meeting Date");
                   CustLedger.SETRANGE(CustLedger."Investment Account No.","Meeting No");
                   CustLedger.SETRANGE(CustLedger.Open,TRUE);
                   CustLedger.SETRANGE(CustLedger."Due Date",StartDate,EndDate);
                   CustLedger.SETFILTER(CustLedger."Investment Transaction Type",'%1|%2|%3|%4',CustLedger."Investment Transaction Type"::"Principal Receivable",
                                        CustLedger."Investment Transaction Type"::"Principal Payment",CustLedger."Investment Transaction Type"::"Interest Payment",
                                        CustLedger."Investment Transaction Type"::"Penalty Interest Payment");
                   IF CustLedger.FINDSET THEN BEGIN
                     LoanReg.GET("Meeting No");
                     LoanReg."Risk Classification":=LoanReg."Risk Classification"::"4";
                     LoanReg.MODIFY;
                     COMMIT;
                     REPEAT
                       CustLedger.CALCFIELDS(CustLedger."Remaining Amount");
                       "181to360Days":="181to360Days"+CustLedger."Remaining Amount";
                     UNTIL CustLedger.NEXT=0;
                   END;

                   //Above360DaysInArrears-Loss
                   EndDate:=CALCDATE('-1D',StartDate);
                   CustLedger.RESET;
                   CustLedger.SETRANGE(CustLedger."Customer No.","Meeting Date");
                   CustLedger.SETRANGE(CustLedger."Investment Account No.","Meeting No");
                   CustLedger.SETRANGE(CustLedger.Open,TRUE);
                   CustLedger.SETFILTER(CustLedger."Due Date",'<%1',EndDate);
                   CustLedger.SETFILTER(CustLedger."Investment Transaction Type",'%1|%2|%3|%4',CustLedger."Investment Transaction Type"::"Principal Receivable",
                                        CustLedger."Investment Transaction Type"::"Principal Payment",CustLedger."Investment Transaction Type"::"Interest Payment",
                                        CustLedger."Investment Transaction Type"::"Penalty Interest Payment");
                   IF CustLedger.FINDSET THEN BEGIN
                     LoanReg.GET("Meeting No");
                     LoanReg."Risk Classification":=LoanReg."Risk Classification"::"5";
                     LoanReg.MODIFY;
                     COMMIT;
                     REPEAT
                       CustLedger.CALCFIELDS(CustLedger."Remaining Amount");
                       Above360Days:=Above360Days+CustLedger."Remaining Amount";
                     UNTIL CustLedger.NEXT=0;
                   END;

                   //----------------------------------------------------------------------------
                   //LoanGiven
                   NonDueDate:=0D;
                   NonDueBalance:=0;
                   CustLedger.RESET;
                   CustLedger.SETCURRENTKEY(CustLedger."Customer No.",CustLedger."Investment Account No.",CustLedger."Due Date");
                   CustLedger.SETRANGE(CustLedger."Customer No.","Meeting Date");
                   CustLedger.SETRANGE(CustLedger."Investment Account No.","Meeting No");
                   CustLedger.SETRANGE(CustLedger."Due Date",StartDate,PeriodDate);
                   CustLedger.SETRANGE(CustLedger."Investment Transaction Type",CustLedger."Investment Transaction Type"::"Loan Disbursement");
                   IF CustLedger.FINDFIRST THEN BEGIN
                     NonDueDate:=CustLedger."Due Date";
                   END;
                   IF NonDueDate<>0D THEN BEGIN
                     CustLedger.RESET;
                     CustLedger.SETCURRENTKEY(CustLedger."Customer No.",CustLedger."Investment Account No.",CustLedger."Due Date");
                     CustLedger.SETRANGE(CustLedger."Customer No.","Meeting Date");
                     CustLedger.SETRANGE(CustLedger."Investment Account No.","Meeting No");
                     CustLedger.SETRANGE(CustLedger."Due Date",NonDueDate,PeriodDate);
                     CustLedger.SETFILTER(CustLedger."Investment Transaction Type",'%1|%2',CustLedger."Investment Transaction Type"::"Loan Disbursement",
                                                                                CustLedger."Investment Transaction Type"::"Principal Receivable");
                     IF CustLedger.FINDSET THEN BEGIN
                       REPEAT
                         CustLedger.CALCFIELDS(CustLedger.Amount);
                         IF CustLedger."Investment Transaction Type"=CustLedger."Investment Transaction Type"::"Loan Disbursement" THEN BEGIN
                           NonDueBalance:=NonDueBalance+CustLedger.Amount;
                         END ELSE BEGIN
                           NonDueBalance:=NonDueBalance-CustLedger.Amount;
                         END;
                       UNTIL CustLedger.NEXT=0;
                     END;
                   END;
                   //-----------------------------------------------------------------------------------------------------------------
                   //VPrincipleNotArrears
                   CustLedger.RESET;
                   CustLedger.SETRANGE(CustLedger."Customer No.","Meeting Date");
                   CustLedger.SETRANGE(CustLedger."Investment Account No.","Meeting No");
                   CustLedger.SETRANGE(CustLedger."Due Date",CALCDATE('-CM',PeriodDate),CALCDATE('CM',PeriodDate));
                   CustLedger.SETRANGE(CustLedger."Investment Transaction Type",CustLedger."Investment Transaction Type"::"Principal Receivable");
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
                   CustLedger.SETRANGE(CustLedger."Customer No.","Meeting Date");
                   CustLedger.SETRANGE(CustLedger."Investment Account No.","Meeting No");
                   IF "Repayment Frequency"='DAILY' THEN BEGIN
                     CustLedger.SETRANGE(CustLedger."Due Date",PeriodDate);
                   END;
                   IF "Repayment Frequency"='WEEKLY'THEN BEGIN
                     CustLedger.SETRANGE(CustLedger."Due Date",CALCDATE('-CW',PeriodDate),CALCDATE('CW',PeriodDate));
                   END;
                   IF "Repayment Frequency"='MONTHLY'THEN BEGIN
                     CustLedger.SETRANGE(CustLedger."Due Date",CALCDATE('-CM',PeriodDate),CALCDATE('CM',PeriodDate));
                   END;
                   IF "Repayment Frequency"='QUARTERLY'THEN BEGIN
                     CustLedger.SETRANGE(CustLedger."Due Date",CALCDATE('-CQ',PeriodDate),CALCDATE('CQ',PeriodDate));
                   END;
                   IF "Repayment Frequency"='ANNUALLY'THEN BEGIN

                     LoanDisburse.RESET;
                     LoanDisburse.SETCURRENTKEY(LoanDisburse."Line No",LoanDisburse.Status);
                     LoanDisburse.SETRANGE(LoanDisburse."Account No.","Meeting No");
                     IF LoanDisburse.FINDLAST THEN BEGIN
                       IF PeriodDate > LoanDisburse.Description THEN BEGIN
                         CustLedger.SETRANGE(CustLedger."Due Date",0D);
                       END ELSE BEGIN
                         CustLedger.SETRANGE(CustLedger."Due Date",StartDate,PeriodDate);
                       END;
                     END;
                   END;
                   CustLedger.SETRANGE(CustLedger."Investment Transaction Type",CustLedger."Investment Transaction Type"::"Principal Payment");
                   CustLedger.SETFILTER(CustLedger."Date Filter",'%1..%2',StartDate,PeriodDate);
                   IF CustLedger.FINDSET THEN BEGIN
                     REPEAT
                       CustLedger.CALCFIELDS(CustLedger."Remaining Amount");
                       VInterestNotArrears:=VInterestNotArrears+CustLedger."Remaining Amount";
                     UNTIL CustLedger.NEXT=0;
                   END;
                   //NonDueBalance:=NonDueBalance+VPrincipleNotArrears;
                   //CurrentPayoff
                   TotalArrears:="0to30Days"+"31to90Days"+"91to180Days"+"181to360Days"+Above360Days;
                   CurrentPayOff:=TotalArrears+NonDueBalance+VInterestNotArrears;
                   //----------------------------------------------------------------------------
             */

            end;

            trigger OnPreDataItem()
            begin
                if RunDate = 0D then
                    Error('Select the Run Date, it cannot be Null');
                // SETRANGE("Loan Type","Loan Type"::"1");
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
        ReportTitle: Label 'Risk Classification Report';
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
        INST: Integer;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Duration: Integer;
        MemberLoan: Record Customer;
        IssuedDate: Date;
        i: Integer;
        LoanBalance: Decimal;
        CumInterest: Decimal;
        CumMonthlyRepayment: Decimal;
        CumPrincipalRepayment: Decimal;
        j: Integer;
        LoanApp: Record "Meeting Attendance";
        GroupName: Text[70];
        TotalPrincipalRepayment: Decimal;
        Rate: Decimal;
        BankDetails: Text[250];
        Cust: Record Customer;
        EmployerName: Text;
        Monthly_RepaymentCaptionLbl: Label 'Monthly Repayment';
        "0to30Days": Decimal;
        "31to90Days": Decimal;
        "91to180Days": Decimal;
        "181to360Days": Decimal;
        Above360Days: Decimal;
        StartDate: Date;
        EndDate: Date;
        LoanReg: Record "Meeting Attendance";
        NonDueDate: Date;
        LoanDisburse: Record "Tender Questions";
}

