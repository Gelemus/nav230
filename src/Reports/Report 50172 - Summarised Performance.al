report 50172 "Summarised Performance"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Summarised Performance.rdl';

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
            column(PrincipleNotArrears; VPrincipleNotArrears)
            {
            }

            trigger OnAfterGetRecord()
            begin
                /*PeriodDate:=RunDate;
                TakeOnDate:=060116D;
                    VPrincipleInArrears:=0;VInterestInArrears:=0;VPenaltyInArrears:=0;VLoanFeeInArrears:=0;TotalArrears:=0;
                    VPrincipleNotArrears:=0;VInterestNotArrears:=0;VPenaltyNotArrears:=0;VLoanFeeNotArrears:=0;
                    TotalBilled:=0;LoanGiven:=0;NonDueBalance:=0;CurrentPayOff:=0;

                    //PrincipleInArrears
                    CustLedger.RESET;
                    CustLedger.SETRANGE(CustLedger."Customer No.","Meeting Date");
                    CustLedger.SETRANGE(CustLedger."Investment Account No.","Meeting No");
                    IF "Repayment Frequency"='DAILY'THEN BEGIN
                      CustLedger.SETRANGE(CustLedger."Posting Date",StartDate,CALCDATE('-1D',PeriodDate));
                    END;
                    IF "Repayment Frequency"='WEEKLY'THEN BEGIN
                      CustLedger.SETRANGE(CustLedger."Posting Date",StartDate,CALCDATE('CW',CALCDATE('-1W',PeriodDate)));
                    END;
                    IF "Repayment Frequency"='MONTHLY'THEN BEGIN
                      CustLedger.SETRANGE(CustLedger."Posting Date",StartDate,CALCDATE('CM',CALCDATE('-1M',PeriodDate)));
                    END;
                    IF "Repayment Frequency"='QUARTERLY'THEN BEGIN
                      CustLedger.SETRANGE(CustLedger."Posting Date",StartDate,CALCDATE('CQ',CALCDATE('-1Q',PeriodDate)));
                    END;
                    IF "Repayment Frequency"='ANNUALLY'THEN BEGIN

                      LoanDisburse.RESET;
                      LoanDisburse.SETCURRENTKEY(LoanDisburse."Account No.",LoanDisburse.Status);
                      LoanDisburse.SETRANGE(LoanDisburse."Account No.","Meeting No");
                      IF LoanDisburse.FINDLAST THEN BEGIN
                        IF PeriodDate > LoanDisburse.Description THEN BEGIN
                          CustLedger.SETRANGE(CustLedger."Posting Date",StartDate,PeriodDate);
                        END ELSE BEGIN
                          CustLedger.SETRANGE(CustLedger."Posting Date",0D);
                        END;
                      END;
                    END;
                    CustLedger.SETRANGE(CustLedger."Investment Transaction Type",CustLedger."Investment Transaction Type"::"Principal Receivable");
                    CustLedger.SETFILTER(CustLedger."Date Filter",'%1..%2',StartDate,PeriodDate);
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
                    IF "Repayment Frequency"='DAILY'THEN BEGIN
                      CustLedger.SETRANGE(CustLedger."Posting Date",StartDate,CALCDATE('-1D',PeriodDate));
                    END;
                    IF "Repayment Frequency"='WEEKLY'THEN BEGIN
                      CustLedger.SETRANGE(CustLedger."Posting Date",StartDate,CALCDATE('CW',CALCDATE('-1W',PeriodDate)));
                    END;
                    IF "Repayment Frequency"='MONTHLY'THEN BEGIN
                      CustLedger.SETRANGE(CustLedger."Posting Date",StartDate,CALCDATE('CM',CALCDATE('-1M',PeriodDate)));
                    END;
                    IF "Repayment Frequency"='QUARTERLY'THEN BEGIN
                      CustLedger.SETRANGE(CustLedger."Posting Date",StartDate,CALCDATE('CQ',CALCDATE('-1Q',PeriodDate)));
                    END;
                    IF "Repayment Frequency"='ANNUALLY'THEN BEGIN
                      LoanDisburse.RESET;
                      LoanDisburse.SETCURRENTKEY(LoanDisburse."Account No.",LoanDisburse.Status);
                      LoanDisburse.SETRANGE(LoanDisburse."Account No.","Meeting No");
                      IF LoanDisburse.FINDLAST THEN BEGIN
                        IF PeriodDate > LoanDisburse.Description THEN BEGIN
                          CustLedger.SETRANGE(CustLedger."Posting Date",StartDate,PeriodDate);
                        END ELSE BEGIN
                          CustLedger.SETRANGE(CustLedger."Posting Date",0D);
                        END;
                      END;
                    END;
                    CustLedger.SETRANGE(CustLedger."Investment Transaction Type",CustLedger."Investment Transaction Type"::"Principal Payment");
                    CustLedger.SETFILTER(CustLedger."Date Filter",'%1..%2',StartDate,PeriodDate);
                    IF (CustLedger.FINDSET) THEN BEGIN
                      REPEAT
                        CustLedger.CALCFIELDS(CustLedger."Remaining Amount");
                        VInterestInArrears:=VInterestInArrears+CustLedger."Remaining Amount";
                      UNTIL CustLedger.NEXT=0;
                    END;

                    //PenaltyInArrears
                    CustLedger.RESET;
                    CustLedger.SETRANGE(CustLedger."Customer No.","Meeting Date");
                    CustLedger.SETRANGE(CustLedger."Investment Account No.","Meeting No");
                    CustLedger.SETRANGE(CustLedger."Posting Date",StartDate,PeriodDate);
                    CustLedger.SETRANGE(CustLedger."Investment Transaction Type",CustLedger."Investment Transaction Type"::"Interest Payment");
                    CustLedger.SETFILTER(CustLedger."Date Filter",'%1..%2',StartDate,CALCDATE('-1D',PeriodDate));
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
                    CustLedger.SETRANGE(CustLedger."Posting Date",StartDate,PeriodDate);
                    CustLedger.SETRANGE(CustLedger."Investment Transaction Type",CustLedger."Investment Transaction Type"::"Penalty Interest Payment");
                    CustLedger.SETFILTER(CustLedger."Date Filter",'%1..%2',StartDate,PeriodDate);
                    IF CustLedger.FINDSET THEN BEGIN
                      REPEAT
                        CustLedger.CALCFIELDS(CustLedger."Remaining Amount");
                        VLoanFeeInArrears:=VLoanFeeInArrears+CustLedger."Remaining Amount";
                      UNTIL CustLedger.NEXT=0;
                    END;
                    //--------------------------------------------------------------------------------------------------------------
                    //LoanGiven
                    NonDueDate:=0D;
                    NonDueBalance:=0;
                    CustLedger.RESET;
                    CustLedger.SETCURRENTKEY(CustLedger."Customer No.",CustLedger."Investment Account No.",CustLedger."Posting Date");
                    CustLedger.SETRANGE(CustLedger."Customer No.","Meeting Date");
                    CustLedger.SETRANGE(CustLedger."Investment Account No.","Meeting No");
                    CustLedger.SETRANGE(CustLedger."Posting Date",StartDate,PeriodDate);
                    CustLedger.SETRANGE(CustLedger."Investment Transaction Type",CustLedger."Investment Transaction Type"::"Loan Disbursement");
                    IF CustLedger.FINDFIRST THEN BEGIN
                      NonDueDate:=CustLedger."Posting Date";
                    END;
                    IF NonDueDate<>0D THEN BEGIN
                      CustLedger.RESET;
                      CustLedger.SETCURRENTKEY(CustLedger."Customer No.",CustLedger."Investment Account No.",CustLedger."Posting Date");
                      CustLedger.SETRANGE(CustLedger."Customer No.","Meeting Date");
                      CustLedger.SETRANGE(CustLedger."Investment Account No.","Meeting No");
                      CustLedger.SETRANGE(CustLedger."Posting Date",NonDueDate,PeriodDate);
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
                    IF "Repayment Frequency"='DAILY'THEN BEGIN
                      CustLedger.SETRANGE(CustLedger."Posting Date",PeriodDate);
                    END;
                    IF "Repayment Frequency"='WEEKLY'THEN BEGIN
                      CustLedger.SETRANGE(CustLedger."Posting Date",CALCDATE('-CW',PeriodDate),CALCDATE('CW',PeriodDate));
                    END;
                    IF "Repayment Frequency"='MONTHLY'THEN BEGIN
                      CustLedger.SETRANGE(CustLedger."Posting Date",CALCDATE('-CM',PeriodDate),CALCDATE('CM',PeriodDate));
                    END;
                    IF "Repayment Frequency"='QUARTERLY'THEN BEGIN
                      CustLedger.SETRANGE(CustLedger."Posting Date",CALCDATE('-CQ',PeriodDate),CALCDATE('CQ',PeriodDate));
                    END;
                    IF "Repayment Frequency"='ANNUALLY'THEN BEGIN
                      LoanDisburse.RESET;
                      LoanDisburse.SETCURRENTKEY(LoanDisburse."Account No.",LoanDisburse.Status);
                      LoanDisburse.SETRANGE(LoanDisburse."Account No.","Meeting No");
                      IF LoanDisburse.FINDLAST THEN BEGIN
                        IF PeriodDate > LoanDisburse.Description THEN BEGIN
                          CustLedger.SETRANGE(CustLedger."Posting Date",0D);
                        END ELSE BEGIN
                          CustLedger.SETRANGE(CustLedger."Posting Date",StartDate,PeriodDate);
                        END;
                      END;
                    END;
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
                    IF "Repayment Frequency"='DAILY'THEN BEGIN
                      CustLedger.SETRANGE(CustLedger."Posting Date",PeriodDate);
                    END;
                    IF "Repayment Frequency"='WEEKLY'THEN BEGIN
                      CustLedger.SETRANGE(CustLedger."Posting Date",CALCDATE('-CW',PeriodDate),CALCDATE('CW',PeriodDate));
                    END;
                    IF "Repayment Frequency"='MONTHLY'THEN BEGIN
                      CustLedger.SETRANGE(CustLedger."Posting Date",CALCDATE('-CM',PeriodDate),CALCDATE('CM',PeriodDate));
                    END;
                    IF "Repayment Frequency"='QUARTERLY'THEN BEGIN
                      CustLedger.SETRANGE(CustLedger."Posting Date",CALCDATE('-CQ',PeriodDate),CALCDATE('CQ',PeriodDate));
                    END;
                    IF "Repayment Frequency"='ANNUALLY'THEN BEGIN
                      LoanDisburse.RESET;
                      LoanDisburse.SETCURRENTKEY(LoanDisburse."Account No.",LoanDisburse.Status);
                      LoanDisburse.SETRANGE(LoanDisburse."Account No.","Meeting No");
                      IF LoanDisburse.FINDLAST THEN BEGIN
                        IF PeriodDate > LoanDisburse.Description THEN BEGIN
                          CustLedger.SETRANGE(CustLedger."Posting Date",0D);
                        END ELSE BEGIN
                          CustLedger.SETRANGE(CustLedger."Posting Date",StartDate,PeriodDate);
                        END;
                      END;
                    END;
                    CustLedger.SETRANGE(CustLedger."Investment Transaction Type",CustLedger."Investment Transaction Type"::"Principal Payment");
                    CustLedger.SETFILTER(CustLedger."Date Filter",'%1..%2',StartDate,CALCDATE('-1D',PeriodDate));
                    //CustLedger.SETFILTER(CustLedger."Date Filter",'%1..%2',StartDate,RunDate);
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
                    //----------------------------------------------------------------------------
              */

            end;

            trigger OnPreDataItem()
            begin
                if StartDate = 0D then
                    Error('Select the Start Date, it cannot be Null');
                if RunDate = 0D then
                    Error('Select the End Date, it cannot be Null');

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
                field("Start Date"; StartDate)
                {
                }
                field("End Date"; RunDate)
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
        NonDueDate: Date;
        LoanDisburse: Record "Tender Questions";
        StartDate: Date;
}

