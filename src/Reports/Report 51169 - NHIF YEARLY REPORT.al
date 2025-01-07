report 51169 "NHIF YEARLY REPORT"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/NHIF YEARLY REPORT.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.";
            column(HEADER_1_; HEADER[1])
            {
            }
            column(HEADER_2_; HEADER[2])
            {
            }
            column(HEADER_3_; HEADER[3])
            {
            }
            column(HEADER_4_; HEADER[4])
            {
            }
            column(HEADER_5_; HEADER[5])
            {
            }
            column(HEADER_6_; HEADER[6])
            {
            }
            column(TOTAL_; 'TOTAL')
            {
            }
            column(HEADER_12_; HEADER[12])
            {
            }
            column(HEADER_11_; HEADER[11])
            {
            }
            column(HEADER_10_; HEADER[10])
            {
            }
            column(HEADER_9_; HEADER[9])
            {
            }
            column(HEADER_8_; HEADER[8])
            {
            }
            column(HEADER_7_; HEADER[7])
            {
            }
            column(FOR_YEAR______FORMAT_Year__________FORMAT_TOYear_; 'FOR YEAR: ' + Format(Year))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(NHIFMonthAmt_1_; NHIFMonthAmt[1])
            {
            }
            column(NHIFMonthAmt_2_; NHIFMonthAmt[2])
            {
            }
            column(NHIFMonthAmt_3_; NHIFMonthAmt[3])
            {
            }
            column(NHIFMonthAmt_4_; NHIFMonthAmt[4])
            {
            }
            column(NHIFMonthAmt_5_; NHIFMonthAmt[5])
            {
            }
            column(NHIFMonthAmt_12_; NHIFMonthAmt[12])
            {
            }
            column(NHIFMonthAmt_11_; NHIFMonthAmt[11])
            {
            }
            column(NHIFMonthAmt_10_; NHIFMonthAmt[10])
            {
            }
            column(NHIFMonthAmt_9_; NHIFMonthAmt[9])
            {
            }
            column(NHIFMonthAmt_8_; NHIFMonthAmt[8])
            {
            }
            column(NHIFMonthAmt_7_; NHIFMonthAmt[7])
            {
            }
            column(DataItem1101951051; NHIFMonthAmt[1] + NHIFMonthAmt[2] + NHIFMonthAmt[3] + NHIFMonthAmt[4] + NHIFMonthAmt[5] + NHIFMonthAmt[6] + NHIFMonthAmt[7] + NHIFMonthAmt[8] + NHIFMonthAmt[9] + NHIFMonthAmt[10] + NHIFMonthAmt[11] + NHIFMonthAmt[12])
            {
            }
            column(First_Name___________Middle_Name___________Last_Name_; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
            {
            }
            column(NHIFMonthAmt_6_; NHIFMonthAmt[6])
            {
            }
            column(Employee__Membership_No__; Employee."NHIF No.")
            {
            }
            column(Employee__No__; "No.")
            {
            }
            column(DataItem1101951001; NHIFMonthAmt[1] + NHIFMonthAmt[2] + NHIFMonthAmt[3] + NHIFMonthAmt[4] + NHIFMonthAmt[5] + NHIFMonthAmt[6] + NHIFMonthAmt[7] + NHIFMonthAmt[8] + NHIFMonthAmt[9] + NHIFMonthAmt[10] + NHIFMonthAmt[11] + NHIFMonthAmt[12])
            {
            }
            column(NHIFMonthAmt_12__Control1101951010; NHIFMonthAmt[12])
            {
            }
            column(NHIFMonthAmt_11__Control1101951014; NHIFMonthAmt[11])
            {
            }
            column(NHIFMonthAmt_10__Control1101951016; NHIFMonthAmt[10])
            {
            }
            column(NHIFMonthAmt_9__Control1101951020; NHIFMonthAmt[9])
            {
            }
            column(NHIFMonthAmt_8__Control1101951067; NHIFMonthAmt[8])
            {
            }
            column(NHIFMonthAmt_7__Control1101951099; NHIFMonthAmt[7])
            {
            }
            column(NHIFMonthAmt_6__Control1101951101; NHIFMonthAmt[6])
            {
            }
            column(NHIFMonthAmt_5__Control1101951102; NHIFMonthAmt[5])
            {
            }
            column(NHIFMonthAmt_4__Control1101951104; NHIFMonthAmt[4])
            {
            }
            column(NHIFMonthAmt_3__Control1101951107; NHIFMonthAmt[3])
            {
            }
            column(NHIFMonthAmt_2__Control1101951108; NHIFMonthAmt[2])
            {
            }
            column(NHIFMonthAmt_1__Control1101951111; NHIFMonthAmt[1])
            {
            }
            column(NHIF_YEARLY_REPORTCaption; NHIF_YEARLY_REPORTCaptionLbl)
            {
            }
            column(NAMECaption; NAMECaptionLbl)
            {
            }
            column(NHIF_NO_Caption; NHIF_NO_CaptionLbl)
            {
            }
            column(EMP_NO_Caption; EMP_NO_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(TOTALSCaption; TOTALSCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                /*CALCFIELDS("Membership No.");
                
                i := 0;
                FirstMonth :=  FALSE;
                SecondMonth := FALSE;
                IF PeriodRec.FIND('-') THEN
                  REPEAT
                    IF ((PeriodRec."NHIF Period Start") AND NOT(FirstMonth)) OR (NOT(PeriodRec."NHIF Period Start") AND(FirstMonth)) THEN
                      BEGIN
                        FirstMonth :=  TRUE;
                        i := i +1;
                        HEADER[i] := PeriodRec.Description;
                        PayrollHeader.RESET;
                        PayrollHeader.SETCURRENTKEY("Employee no.", "Payroll Year", "Payroll Month");
                        PayrollHeader.ASCENDING(FALSE);
                        PayrollHeader.SETRANGE("Employee no.", "No.");
                        PayrollHeader.SETRANGE("Payroll Year", PeriodRec."Period Year");
                        PayrollHeader.SETRANGE("Payroll Month", PeriodRec."Period Month");
                        IF PayrollHeader.FIND('-') THEN
                          REPEAT
                            SETFILTER("Date Filter", '%1..%2', PeriodRec."Start Date", PeriodRec."End Date");
                            SETFILTER("ED Code Filter", PayrollSetup."NHIF ED Code");
                            CALCFIELDS(Amount);
                            NHIFMonthAmt[i] := Amount;
                          UNTIL PayrollHeader.NEXT = 0;
                      END
                    ELSE IF ((PeriodRec."NHIF Period Start") AND (FirstMonth)) THEN BEGIN
                      SecondMonth :=  TRUE;
                      PeriodRec.NEXT;
                    END;
                  UNTIL( PeriodRec.NEXT = 0 ) OR ( i > 12) ;;  // SNG 090611 Ensure the report only processes 12 months
                  */
                if ("Termination Date" <> 0D) then
                    if (Date2DMY("Termination Date", 3) < Year) then CurrReport.Skip;

                i := 0;
                if PeriodRec.Find('-') then
                    repeat
                        i := i + 1;
                        HEADER[i] := PeriodRec.Description;
                        PayrollHeader.Reset;
                        PayrollHeader.SetCurrentKey("Employee no.", "Payroll Year", "Payroll Month");
                        PayrollHeader.Ascending(false);
                        PayrollHeader.SetRange("Employee no.", "No.");
                        PayrollHeader.SetRange("Payroll Year", Year);
                        PayrollHeader.SetRange("Payroll Month", PeriodRec."Period Month");
                        if PayrollHeader.Find('-') then
                            repeat
                                SetFilter("Date Filter", '%1..%2', PeriodRec."Start Date", PeriodRec."End Date");

                                //Employee NHIF Contribution
                                SetFilter("ED Code Filter", PayrollSetup."NHIF ED Code");
                                CalcFields(Amount);
                                NHIFMonthAmt[i] := Amount;
                            until PayrollHeader.Next = 0;
                    until PeriodRec.Next = 0;

            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                //TOYear := Year + 1;//SNG 090611 Remove user input for the Toyear value, thus avoiding overflow
                PeriodRec.SetCurrentKey("Start Date");
                PeriodRec.Ascending(true);
                PeriodRec.SetRange("Period Year", Year);//, TOYear);
                PeriodRec.SetRange(PeriodRec."Payroll Code", gvAllowedPayrolls."Payroll Code");
                CurrReport.CreateTotals(NHIFMonthAmt);

                //Employee.SETFILTER("ED Code Filter", PayrollSetup."NHIF ED Code");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control1102754001)
                {
                    ShowCaption = false;
                    field(Year; Year)
                    {
                        Caption = 'Year';
                        TableRelation = Year.Year;
                    }
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
        gsSegmentPayrollData;
        if Year = 0 then Error('You must specify the Year on the options tab');
        PayrollSetup.Get(gvAllowedPayrolls."Payroll Code");
    end;

    var
        Year: Integer;
        YearRec: Record Year;
        PayrollHeader: Record "Payroll Header";
        ColumnD: Decimal;
        ColumnL: Decimal;
        PayrollSetup: Record "Payroll Setups";
        NHIFMonthAmt: array[24] of Decimal;
        i: Integer;
        HEADER: array[24] of Text[30];
        PeriodRec: Record Periods;
        TOYear: Integer;
        FirstMonth: Boolean;
        SecondMonth: Boolean;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        NHIF_YEARLY_REPORTCaptionLbl: Label 'NHIF YEARLY REPORT';
        NAMECaptionLbl: Label 'NAME';
        NHIF_NO_CaptionLbl: Label 'NHIF NO.';
        EMP_NO_CaptionLbl: Label 'EMP NO.';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        TOTALSCaptionLbl: Label 'TOTALS';

    procedure gsSegmentPayrollData()
    var
        lvAllowedPayrolls: Record "Allowed Payrolls";
        lvPayrollUtilities: Codeunit "Payroll Posting";
        UsrID: Code[10];
        UsrID2: Code[10];
        StringLen: Integer;
        lvActiveSession: Record "Active Session";
    begin

        lvActiveSession.Reset;
        lvActiveSession.SetRange("Server Instance ID", ServiceInstanceId);
        lvActiveSession.SetRange("Session ID", SessionId);
        lvActiveSession.FindFirst;


        gvAllowedPayrolls.SetRange("User ID", lvActiveSession."User ID");
        gvAllowedPayrolls.SetRange("Last Active Payroll", true);
        if not gvAllowedPayrolls.FindFirst then
            Error('You are not allowed access to this payroll dataset.');
    end;
}

