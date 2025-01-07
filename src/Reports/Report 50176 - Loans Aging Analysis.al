report 50176 "Loans Aging Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Loans Aging Analysis.rdl';

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
            column(Repayment_LoansRegister; "Meeting Attendance"."Meeting No")
            {
            }
            column(GlobalDimension2Code_LoansRegister; "Meeting Attendance"."Meeting No")
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
            column(GlobalDim1; "Meeting Attendance"."Meeting No")
            {
            }
            column(RiskClassification; "Meeting Attendance"."Meeting No")
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
                /*
                  INST:="No. of Installments" ;
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
                                           CustLedger."Investment Transaction Type"::"Interest Receivable",CustLedger."Investment Transaction Type"::"Penalty Interest Receivable",
                                           CustLedger."Investment Transaction Type"::"Loan Fee Receivable");
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
                                           CustLedger."Investment Transaction Type"::"Interest Receivable",CustLedger."Investment Transaction Type"::"Penalty Interest Receivable",
                                           CustLedger."Investment Transaction Type"::"Loan Fee Receivable");
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
                                           CustLedger."Investment Transaction Type"::"Interest Receivable",CustLedger."Investment Transaction Type"::"Penalty Interest Receivable",
                                           CustLedger."Investment Transaction Type"::"Loan Fee Receivable");
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
                                           CustLedger."Investment Transaction Type"::"Interest Receivable",CustLedger."Investment Transaction Type"::"Penalty Interest Receivable",
                                           CustLedger."Investment Transaction Type"::"Loan Fee Receivable");
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
                                           CustLedger."Investment Transaction Type"::"Interest Receivable",CustLedger."Investment Transaction Type"::"Penalty Interest Receivable",
                                           CustLedger."Investment Transaction Type"::"Loan Fee Receivable");
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
                      //TotalBilled
                      DtldCustLedger.RESET;
                      DtldCustLedger.SETRANGE(DtldCustLedger."Customer No.","Meeting Date");
                      DtldCustLedger.SETRANGE(DtldCustLedger."Investment Account No.","Meeting No");
                      IF "Repayment Frequency"='DAILY'THEN BEGIN
                        DtldCustLedger.SETRANGE(DtldCustLedger."Posting Date",CALCDATE('-1D',PeriodDate));
                      END;
                      IF "Repayment Frequency"='WEEKLY' THEN BEGIN
                        DtldCustLedger.SETRANGE(DtldCustLedger."Posting Date",0D,CALCDATE('CW',CALCDATE('-1W',PeriodDate)));
                      END;
                      IF "Repayment Frequency"='MONTHLY' THEN BEGIN
                        DtldCustLedger.SETRANGE(DtldCustLedger."Posting Date",0D,CALCDATE('CM',CALCDATE('-1M',PeriodDate)));
                      END;
                      IF "Repayment Frequency"='QUARTERLY' THEN BEGIN
                        DtldCustLedger.SETRANGE(DtldCustLedger."Posting Date",0D,CALCDATE('CQ',CALCDATE('-1Q',PeriodDate)));
                      END;
                      IF "Repayment Frequency"='ANNUALLY'THEN BEGIN
                        NextPeriodTxt:='-'+FORMAT("Repayment Start Date"); //"Repayment UserDefined"
                        EVALUATE(NextPeriod,NextPeriodTxt);
                        DtldCustLedger.SETFILTER(DtldCustLedger."Initial Entry Due Date",'>%1',CALCDATE('+1D',CALCDATE(NextPeriod,PeriodDate)));
                      END;
                      DtldCustLedger.SETFILTER(DtldCustLedger."Investment Transaction Type",'%1',DtldCustLedger."Investment Transaction Type"::"2");
                      IF DtldCustLedger.FINDSET THEN BEGIN
                        REPEAT
                          TotalBilled:=TotalBilled+DtldCustLedger.Amount;
                        UNTIL DtldCustLedger.NEXT=0;
                      END;
                
                      //LoanGiven
                      DtldCustLedger.RESET;
                      DtldCustLedger.SETRANGE(DtldCustLedger."Customer No.","Meeting Date");
                      DtldCustLedger.SETRANGE(DtldCustLedger."Investment Account No.","Meeting No");
                      DtldCustLedger.SETRANGE(DtldCustLedger."Posting Date",0D,PeriodDate);
                      DtldCustLedger.SETFILTER(DtldCustLedger."Investment Transaction Type",'%1',DtldCustLedger."Investment Transaction Type"::"1");
                      IF DtldCustLedger.FINDSET THEN BEGIN
                        REPEAT
                          LoanGiven:=LoanGiven+DtldCustLedger.Amount;
                        UNTIL DtldCustLedger.NEXT=0;
                      END;
                
                     //VPrincipleNotArrears
                      DtldCustLedger.RESET;
                      DtldCustLedger.SETRANGE(DtldCustLedger."Customer No.","Meeting Date");
                      DtldCustLedger.SETRANGE(DtldCustLedger."Investment Account No.","Meeting No");
                      IF "Repayment Frequency"='DAILY' THEN BEGIN
                        DtldCustLedger.SETRANGE(DtldCustLedger."Posting Date",PeriodDate);
                      END;
                      IF "Repayment Frequency"='WEEKLY' THEN BEGIN
                        DtldCustLedger.SETRANGE(DtldCustLedger."Posting Date",CALCDATE('-CW',PeriodDate),CALCDATE('CW',PeriodDate));
                      END;
                      IF "Repayment Frequency"='MONTHLY' THEN BEGIN
                        DtldCustLedger.SETRANGE(DtldCustLedger."Posting Date",CALCDATE('-CM',PeriodDate),CALCDATE('CM',PeriodDate));
                      END;
                      IF "Repayment Frequency"='QUATERLY'THEN BEGIN
                        DtldCustLedger.SETRANGE(DtldCustLedger."Posting Date",CALCDATE('-CQ',PeriodDate),CALCDATE('CQ',PeriodDate));
                      END;
                      IF "Repayment Frequency"='ANNUALLY' THEN BEGIN
                        NextPeriodTxt:='-'+FORMAT("Repayment Start Date"); //"Repayment UserDefined"
                        EVALUATE(NextPeriod,NextPeriodTxt);
                        DtldCustLedger.SETFILTER(DtldCustLedger."Posting Date",'>%1',CALCDATE('+1D',CALCDATE(NextPeriod,PeriodDate)));
                      END;
                      DtldCustLedger.SETFILTER(DtldCustLedger."Investment Transaction Type",'%1',DtldCustLedger."Investment Transaction Type"::"2");
                      IF DtldCustLedger.FINDSET THEN BEGIN
                        REPEAT
                          VPrincipleNotArrears:=VPrincipleNotArrears+DtldCustLedger.Amount;
                        UNTIL DtldCustLedger.NEXT=0;
                      END;
                      NonDueBalance:=0;
                      NonDueBalance:=LoanGiven-TotalBilled;
                      NonDueBalance:=NonDueBalance+VPrincipleNotArrears;
                
                      //Accrued Interest Not In Arrears
                      DtldCustLedger.RESET;
                      DtldCustLedger.SETRANGE(DtldCustLedger."Customer No.","Meeting Date");
                      DtldCustLedger.SETRANGE(DtldCustLedger."Investment Account No.","Meeting No");
                      IF "Repayment Frequency"='DAILY'THEN BEGIN
                        DtldCustLedger.SETRANGE(DtldCustLedger."Posting Date",PeriodDate);
                      END;
                      IF "Repayment Frequency"='WEEKLY' THEN BEGIN
                        DtldCustLedger.SETRANGE(DtldCustLedger."Posting Date",CALCDATE('-CW',PeriodDate),CALCDATE('CW',PeriodDate));
                      END;
                      IF "Repayment Frequency"='MONTHLY'THEN BEGIN
                        DtldCustLedger.SETRANGE(DtldCustLedger."Posting Date",CALCDATE('-CM',PeriodDate),CALCDATE('CM',PeriodDate));
                      END;
                      IF "Repayment Frequency"='QUARTERLY' THEN BEGIN
                        DtldCustLedger.SETRANGE(DtldCustLedger."Posting Date",CALCDATE('-CQ',PeriodDate),CALCDATE('CQ',PeriodDate));
                      END;
                      IF "Repayment Frequency"='ANNUALLY' THEN BEGIN
                        NextPeriodTxt:='-'+FORMAT("Repayment Start Date"); //"Repayment UserDefined"
                        EVALUATE(NextPeriod,NextPeriodTxt);
                        DtldCustLedger.SETFILTER(DtldCustLedger."Posting Date",'>%1',CALCDATE('+1D',CALCDATE(NextPeriod,PeriodDate)));
                      END;
                      DtldCustLedger.SETFILTER(DtldCustLedger."Investment Transaction Type",'%1',DtldCustLedger."Investment Transaction Type"::"3");
                      IF DtldCustLedger.FINDSET THEN BEGIN
                        REPEAT
                          VInterestNotArrears:=VInterestNotArrears+DtldCustLedger.Amount;
                        UNTIL DtldCustLedger.NEXT=0;
                      END;
                      //Accrued Penalty Not in Arrears
                      DtldCustLedger.RESET;
                      DtldCustLedger.SETRANGE(DtldCustLedger."Customer No.","Meeting Date");
                      DtldCustLedger.SETRANGE(DtldCustLedger."Investment Account No.","Meeting No");
                      IF "Repayment Frequency"='DAILY' THEN BEGIN
                        DtldCustLedger.SETRANGE(DtldCustLedger."Posting Date",PeriodDate);
                      END;
                      IF "Repayment Frequency"='WEEKLY' THEN BEGIN
                        DtldCustLedger.SETRANGE(DtldCustLedger."Posting Date",CALCDATE('-CW',PeriodDate),PeriodDate);
                      END;
                      IF "Repayment Frequency"='MONTHLY' THEN BEGIN
                        DtldCustLedger.SETRANGE(DtldCustLedger."Posting Date",CALCDATE('-CM',PeriodDate),PeriodDate);
                      END;
                      IF "Repayment Frequency"='QUARTERLY' THEN BEGIN
                        DtldCustLedger.SETRANGE(DtldCustLedger."Posting Date",CALCDATE('-CQ',PeriodDate),PeriodDate);
                      END;
                      IF "Repayment Frequency"='ANNUALLY' THEN BEGIN
                        NextPeriodTxt:='-'+FORMAT("Repayment Start Date");
                        EVALUATE(NextPeriod,NextPeriodTxt);
                        DtldCustLedger.SETFILTER(DtldCustLedger."Posting Date",'>%1',CALCDATE('+1D',CALCDATE(NextPeriod,PeriodDate)));
                      END;
                      DtldCustLedger.SETFILTER(DtldCustLedger."Investment Transaction Type",'%1',DtldCustLedger."Investment Transaction Type"::"5");
                      IF DtldCustLedger.FINDSET THEN BEGIN
                        REPEAT
                          VPenaltyNotArrears:=VPenaltyNotArrears+DtldCustLedger.Amount;
                        UNTIL DtldCustLedger.NEXT=0;
                      END;
                      //Loan Fee Not in Arrears
                      DtldCustLedger.RESET;
                      DtldCustLedger.SETRANGE(DtldCustLedger."Customer No.","Meeting Date");
                      DtldCustLedger.SETRANGE(DtldCustLedger."Investment Account No.","Meeting No");
                      IF "Repayment Frequency"='DAILY' THEN BEGIN
                        DtldCustLedger.SETRANGE(DtldCustLedger."Posting Date",PeriodDate);
                      END;
                      IF "Repayment Frequency"='WEEKLY' THEN BEGIN
                        DtldCustLedger.SETRANGE(DtldCustLedger."Posting Date",CALCDATE('-CW',PeriodDate),PeriodDate);
                      END;
                      IF "Repayment Frequency"='MONTHLY' THEN BEGIN
                        DtldCustLedger.SETRANGE(DtldCustLedger."Posting Date",CALCDATE('-CM',PeriodDate),PeriodDate);
                      END;
                      IF "Repayment Frequency"='QUARTERLY' THEN BEGIN
                        DtldCustLedger.SETRANGE(DtldCustLedger."Posting Date",CALCDATE('-CQ',PeriodDate),PeriodDate);
                      END;
                      IF "Repayment Frequency"='ANNUALLY' THEN BEGIN
                        NextPeriodTxt:='-'+FORMAT("Repayment Start Date");
                        EVALUATE(NextPeriod,NextPeriodTxt);
                        DtldCustLedger.SETRANGE(DtldCustLedger."Posting Date",CALCDATE('+1D',CALCDATE(NextPeriod,PeriodDate)),PeriodDate);
                      END;
                      DtldCustLedger.SETFILTER(DtldCustLedger."Posting Date",'>%1',CALCDATE('+1D',CALCDATE(NextPeriod,PeriodDate)));
                      IF DtldCustLedger.FINDSET THEN BEGIN
                        REPEAT
                          VLoanFeeNotArrears:=VLoanFeeNotArrears+DtldCustLedger.Amount;
                        UNTIL DtldCustLedger.NEXT=0;
                      END;
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
                //  SETRANGE("Loan Type","Loan Type"::"1");
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
        ReportTitle: Label 'Arrear Aging Analysis(Sector)';
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
}

