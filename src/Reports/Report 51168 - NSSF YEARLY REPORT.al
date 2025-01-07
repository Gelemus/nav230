report 51168 "NSSF YEARLY REPORT"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/NSSF YEARLY REPORT.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
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
            column(FOR_YEAR______FORMAT_Year_; 'FOR YEAR: ' + Format(Year))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(NSSFMonthAmt_1_; NSSFMonthAmt[1])
            {
            }
            column(NSSFMonthAmt_2_; NSSFMonthAmt[2])
            {
            }
            column(NSSFMonthAmt_3_; NSSFMonthAmt[3])
            {
            }
            column(NSSFMonthAmt_4_; NSSFMonthAmt[4])
            {
            }
            column(NSSFMonthAmt_5_; NSSFMonthAmt[5])
            {
            }
            column(NSSFMonthAmt_12_; NSSFMonthAmt[12])
            {
            }
            column(NSSFMonthAmt_11_; NSSFMonthAmt[11])
            {
            }
            column(NSSFMonthAmt_10_; NSSFMonthAmt[10])
            {
            }
            column(NSSFMonthAmt_9_; NSSFMonthAmt[9])
            {
            }
            column(NSSFMonthAmt_8_; NSSFMonthAmt[8])
            {
            }
            column(NSSFMonthAmt_7_; NSSFMonthAmt[7])
            {
            }
            column(GENDER; Gender)
            {
            }
            column(DataItem1101951051; NSSFMonthAmt[1] + NSSFMonthAmt[2] + NSSFMonthAmt[3] + NSSFMonthAmt[4] + NSSFMonthAmt[5] + NSSFMonthAmt[6] + NSSFMonthAmt[7] + NSSFMonthAmt[8] + NSSFMonthAmt[9] + NSSFMonthAmt[10] + NSSFMonthAmt[11] + NSSFMonthAmt[12])
            {
            }
            column(First_Name___________Middle_Name___________Last_Name_; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
            {
            }
            column(NSSFMonthAmt_6_; NSSFMonthAmt[6])
            {
            }
            column(Employee__Social_Security_No__; Employee."NSSF No.")
            {
            }
            column(Employee__No__; "No.")
            {
            }
            column(NSSFMonthAmt_1__Control1101951100; NSSFMonthAmt[1])
            {
            }
            column(NSSFMonthAmt_2__Control1101951101; NSSFMonthAmt[2])
            {
            }
            column(NSSFMonthAmt_3__Control1101951102; NSSFMonthAmt[3])
            {
            }
            column(NSSFMonthAmt_4__Control1101951103; NSSFMonthAmt[4])
            {
            }
            column(NSSFMonthAmt_5__Control1101951104; NSSFMonthAmt[5])
            {
            }
            column(NSSFMonthAmt_12__Control1101951112; NSSFMonthAmt[12])
            {
            }
            column(NSSFMonthAmt_11__Control1101951113; NSSFMonthAmt[11])
            {
            }
            column(NSSFMonthAmt_10__Control1101951115; NSSFMonthAmt[10])
            {
            }
            column(NSSFMonthAmt_9__Control1101951118; NSSFMonthAmt[9])
            {
            }
            column(NSSFMonthAmt_8__Control1101951120; NSSFMonthAmt[8])
            {
            }
            column(NSSFMonthAmt_7__Control1101951121; NSSFMonthAmt[7])
            {
            }
            column(DataItem1101951124; NSSFMonthAmt[1] + NSSFMonthAmt[2] + NSSFMonthAmt[3] + NSSFMonthAmt[4] + NSSFMonthAmt[5] + NSSFMonthAmt[6] + NSSFMonthAmt[7] + NSSFMonthAmt[8] + NSSFMonthAmt[9] + NSSFMonthAmt[10] + NSSFMonthAmt[11] + NSSFMonthAmt[12])
            {
            }
            column(NSSFMonthAmt_6__Control1101951126; NSSFMonthAmt[6])
            {
            }
            column(NSSF_YEARLY_REPORTCaption; NSSF_YEARLY_REPORTCaptionLbl)
            {
            }
            column(NAMECaption; NAMECaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Emp_No_Caption; Emp_No_CaptionLbl)
            {
            }
            column(NSSF_NO_Caption; NSSF_NO_CaptionLbl)
            {
            }
            column(TOTALSCaption; TOTALSCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
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

                                //Employee NSSF Contribution
                                SetFilter("ED Code Filter", PayrollSetup."NSSF ED Code");
                                CalcFields(Amount);
                                NSSFMonthAmt[i] := Amount;

                                //Employer NSSF Contribution
                                SetFilter("ED Code Filter", PayrollSetup."NSSF Company Contribution");
                                CalcFields(Amount);
                                NSSFMonthAmt[i] += Amount;
                            until PayrollHeader.Next = 0;
                    until PeriodRec.Next = 0;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");

                PeriodRec.SetCurrentKey("Start Date");
                PeriodRec.Ascending(true);
                PeriodRec.SetRange("Period Year", Year);
                PeriodRec.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                CurrReport.CreateTotals(NSSFMonthAmt);
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
        NSSFMonthAmt: array[12] of Decimal;
        i: Integer;
        HEADER: array[12] of Text[30];
        PeriodRec: Record Periods;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        NSSF_YEARLY_REPORTCaptionLbl: Label 'NSSF YEARLY REPORT';
        NAMECaptionLbl: Label 'NAME';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Emp_No_CaptionLbl: Label 'Emp No.';
        NSSF_NO_CaptionLbl: Label 'NSSF NO.';
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

