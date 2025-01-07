report 50262 "NSSF Tier Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/NSSF Tier Report.rdl';

    dataset
    {
        dataitem(Periods; Periods)
        {
            DataItemTableView = SORTING("Start Date") WHERE(Status = FILTER(Open | Posted));
            RequestFilterFields = "Period ID";
            column(EmployerName; EmployerName)
            {
            }
            column(TitleText; TitleText)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyHomePage; CompanyInfo."Home Page")
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(Periods__Period_Month_; "Period Month")
            {
            }
            column(EmployerNo; EmployerNo)
            {
            }
            column(Periods_Description; Description)
            {
            }
            column(TotalAmountArray_2_; TotalAmountArray[2])
            {
            }
            column(TotalAmountArray_1_; TotalAmountArray[1])
            {
            }
            column(TotalAmountArray_3_; TotalAmountArray[3])
            {
            }
            column(Counter; Counter)
            {
            }
            column(TotalCounter; TotalCounter)
            {
            }
            column(Employee_ContributionCaption; Employee_ContributionCaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employer_ContributionCaption; Employer_ContributionCaptionLbl)
            {
            }
            column(Monthly_TotalCaption; Monthly_TotalCaptionLbl)
            {
            }
            column(Membership_No_Caption; Membership_No_CaptionLbl)
            {
            }
            column(Periods__Period_Month_Caption; Periods__Period_Month_CaptionLbl)
            {
            }
            column(EmployerNoCaption; EmployerNoCaptionLbl)
            {
            }
            column(Periods_DescriptionCaption; Periods_DescriptionCaptionLbl)
            {
            }
            column(RemarksCaption; RemarksCaptionLbl)
            {
            }
            column(TotalsCaption; TotalsCaptionLbl)
            {
            }
            column(CounterCaption; CounterCaptionLbl)
            {
            }
            column(Name; NameCaptionLbl)
            {
            }
            column(Signature; SignatureCaptioLbl)
            {
            }
            column(Designation; DesignationCaptLbl)
            {
            }
            column(Date; DateCaptionLbl)
            {
            }
            column(DateCaption; DateCaption_ConLbl)
            {
            }
            column(Peeled_By; Peeled_ByCaptionLbl)
            {
            }
            column(Checked; CheckedCaptionLbl)
            {
            }
            column(DataItem1102754035; DateCaption_000Lbl)
            {
            }
            column(DataItem1102754036; DateCaption_001Lbl)
            {
            }
            // column(Receivedby;ReceivedbyCaptionLbl)
            // {
            // }
            column(For_Official_use_onlyCaption; For_Official_use_onlyCaptionLbl)
            {
            }
            column(DataItem1102754039; CheckedbyCaptiLbl)
            {
            }
            column(DataItem1102754040; DateCaption_002Lbl)
            {
            }
            column(DataItem1102754041; DateCaption_003Lbl)
            {
            }
            column(Punched; PunchedCaptionLbl)
            {
            }
            column(NB_THIS_FORM_IS_INVALID_WITHOUT_THE_OFFICIAL_RUBBER_STAMP_OF_THE_EMPLOYERCaption; NB_THIS_FORM_IS_INVALID_WITHOUT_THE_OFFICIAL_RUBBER_STAMP_OF_THE_EMPLOYERCaptionLbl)
            {
            }
            column(Certified_correct_by_Company_Authorised_Officer_Caption; Certified_correct_by_Company_Authorised_Officer_CaptionLbl)
            {
            }
            column(Periods_Period_ID; "Period ID")
            {
            }
            column(Periods_Period_Year; "Period Year")
            {
            }
            column(Periods_Payroll_Code; "Payroll Code")
            {
            }
            dataitem(Employee; Employee)
            {
                DataItemTableView = SORTING("No.");
                RequestFilterFields = "No.", "Statistics Group Code", "Global Dimension 1 Code", "Global Dimension 2 Code", Status;
                column(Employee_Name; Name)
                {
                }
                column(Employee__No__; "No.")
                {
                }
                column(NationalID_Employee; Employee."National ID")
                {
                }
                column(PeriodAmountArray_1_; PeriodAmountArray[1])
                {
                }
                column(PeriodAmountArray_3_; PeriodAmountArray[3])
                {
                }
                column(PeriodAmountArray_2_; PeriodAmountArray[2])
                {
                }
                column(PeriodAmountArray_4_; PeriodAmountArray[4])
                {
                }
                column(PeriodAmountArray_5_; PeriodAmountArray[5])
                {
                }
                column(PeriodAmountArray_6_; PeriodAmountArray[6])
                {
                }
                column(FORMAT_EmployeeRec__Membership_No___; Format(EmployeeRec."NSSF No."))
                {
                }
                column(RtcCounter; RtcCounter)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Clear(PeriodAmountArray);
                    Name := Employee.FullName;

                    EmployeeRec.Get(Employee."No.");
                    EmployeeRec.SetFilter("Date Filter", '%1..%2', Periods."Start Date", Periods."End Date");
                    EmployeeRec.SetRange("ED Code Filter", PayrollSetup."Nssf Tier 1 Employee");
                    EmployeeRec.CalcFields(Amount, "Membership No.");

                    if EmployeeRec.Amount <= 0 then CurrReport.Skip;

                    PeriodAmountArray[1] := EmployeeRec.Amount;
                    TotalAmountArray[1] := TotalAmountArray[1] + EmployeeRec.Amount;
                    PeriodAmountArray[3] := PeriodAmountArray[3] + PeriodAmountArray[1] + PeriodAmountArray[2];
                    TotalAmountArray[3] := TotalAmountArray[3] + PeriodAmountArray[1];

                    EmployeeRec.SetRange("ED Code Filter", PayrollSetup."Nssf Tier 1 Employer");
                    EmployeeRec.CalcFields(Amount);

                    PeriodAmountArray[2] := EmployeeRec.Amount;//200;
                    TotalAmountArray[2] := TotalAmountArray[2] + EmployeeRec.Amount;//200;
                    PeriodAmountArray[3] := PeriodAmountArray[3] + PeriodAmountArray[2];
                    TotalAmountArray[3] := TotalAmountArray[3] + PeriodAmountArray[2];

                    EmployeeRec.SetRange("ED Code Filter", PayrollSetup."Nssf Tier 2 Employee");
                    EmployeeRec.CalcFields(Amount);

                    PeriodAmountArray[4] := EmployeeRec.Amount;
                    TotalAmountArray[4] := TotalAmountArray[4] + EmployeeRec.Amount;
                    PeriodAmountArray[3] := PeriodAmountArray[3] + PeriodAmountArray[4];
                    TotalAmountArray[3] := TotalAmountArray[3] + PeriodAmountArray[4];

                    EmployeeRec.SetRange("ED Code Filter", PayrollSetup."Nssf Tier 2  Employer");
                    EmployeeRec.CalcFields(Amount);

                    PeriodAmountArray[5] := EmployeeRec.Amount;
                    TotalAmountArray[5] := TotalAmountArray[5] + EmployeeRec.Amount;
                    PeriodAmountArray[3] := PeriodAmountArray[3] + PeriodAmountArray[5];
                    TotalAmountArray[3] := TotalAmountArray[3] + PeriodAmountArray[5];

                    EmployeeRec.SetRange("ED Code Filter", PayrollSetup."Nssf Voluntary");
                    EmployeeRec.CalcFields(Amount);

                    PeriodAmountArray[6] := EmployeeRec.Amount;
                    TotalAmountArray[6] := TotalAmountArray[6] + EmployeeRec.Amount;
                    PeriodAmountArray[3] := PeriodAmountArray[3] + PeriodAmountArray[6];
                    TotalAmountArray[3] := TotalAmountArray[3] + PeriodAmountArray[6];

                    Counter := Counter + 1;
                    RtcCounter += 1;
                end;

                trigger OnPostDataItem()
                begin
                    TotalCounter := Counter;
                end;

                trigger OnPreDataItem()
                begin
                    SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");

                    RtcCounter := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TitleText := 'NSSF Contributions for ' + Periods.Description;

                Clear(PeriodAmountArray);
                Clear(TotalAmountArray);
                Counter := 0;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");

                //IF Periods.GETFILTER(Periods."Period ID")=''THEN ERROR('Specify the Period ID');
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
        gsSegmentPayrollData;
        PayrollSetup.Get(gvAllowedPayrolls."Payroll Code");
        EmployerName := PayrollSetup."Employer Name";
        EmployerNo := PayrollSetup."Employer NSSF No.";
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        PayrollSetup: Record "Payroll Setups";
        PeriodRec: Record Periods;
        EmployeeRec: Record Employee;
        Name: Text[100];
        EmployerNo: Code[20];
        TitleText: Text[60];
        EmployerName: Text[50];
        PeriodAmountArray: array[6] of Decimal;
        TotalAmountArray: array[6] of Decimal;
        Counter: Integer;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        TotalCounter: Integer;
        PeriodFilter: Text[150];
        RtcCounter: Integer;
        Employee_ContributionCaptionLbl: Label 'Employee Contribution';
        NameCaptioLbl: Label 'Name';
        No_CaptionLbl: Label 'No.';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Employer_ContributionCaptionLbl: Label 'Employer Contribution';
        Monthly_TotalCaptionLbl: Label 'Monthly Total';
        Membership_No_CaptionLbl: Label 'Membership No.';
        Periods__Period_Month_CaptionLbl: Label 'Batch No.';
        EmployerNoCaptionLbl: Label 'Employer No.';
        Periods_DescriptionCaptionLbl: Label 'Period';
        RemarksCaptionLbl: Label 'Remarks';
        TotalsCaptionLbl: Label 'Totals';
        CounterCaptionLbl: Label 'No of Entries';
        NameCaptionLbl: Label 'Name';
        SignatureCaptioLbl: Label 'Signature';
        DesignationCaptLbl: Label 'Designation....................................';
        DateCaptionLbl: Label 'Date.............................................';
        DateCaption_ConLbl: Label 'Date.............';
        Peeled_ByCaptionLbl: Label 'Peeled By................';
        CheckedCaptionLbl: Label 'Checked.............';
        DateCaption_000Lbl: Label 'Date..............';
        DateCaption_001Lbl: Label 'Date........................';
        Received_byCaptLbl: Label 'Received by...................................................';
        For_Official_use_onlyCaptionLbl: Label 'For Official use only';
        CheckedbyCaptiLbl: Label 'Checked by............';
        DateCaption_002Lbl: Label 'Date...................';
        DateCaption_003Lbl: Label 'Date................';
        PunchedCaptionLbl: Label 'Punched...............................';
        NB_THIS_FORM_IS_INVALID_WITHOUT_THE_OFFICIAL_RUBBER_STAMP_OF_THE_EMPLOYERCaptionLbl: Label 'NB THIS FORM IS INVALID WITHOUT THE OFFICIAL RUBBER STAMP OF THE EMPLOYER';
        Certified_correct_by_Company_Authorised_Officer_CaptionLbl: Label 'Certified correct by Company Authorised Officer.';
        CompanyInfo: Record "Company Information";
        Approver1: Code[20];
        i: Integer;
        ShowPreparedBy: Boolean;
        PreparedByCaption: Text;
        ApprovedByCaption: Text;
        UserSetupRec: Record "User Setup";
        UserSetupRecI: Record "User Setup";
        PreparedDate: DateTime;
        EmployeeRecI: Record Employee;

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

