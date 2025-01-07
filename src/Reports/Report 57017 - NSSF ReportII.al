report 57017 "NSSF ReportII"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/NSSF ReportII.rdl';

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
            // column(DataItem1102754028;Name______________________________________________________________________________________________________________CaptionLbl)
            // {
            // }
            // column(DataItem1102754029;Signature______________________________________________________________________________________________________________CaptioLbl)
            // {
            // }
            // column(DataItem1102754030;Designation______________________________________________________________________________________________________________CaptLbl)
            // {
            // }
            // column(DataItem1102754031;Date______________________________________________________________________________________________________________CaptionLbl)
            // {
            // }
            // column(DataItem1102754032;Date______________________________________________________________________________________________________________Caption_ConLbl)
            // {
            // }
            // column(DataItem1102754033;Peeled_By_____________________________________________________________________________________________________________CaptionLbl)
            // {
            // }
            // column(DataItem1102754034;Checked______________________________________________________________________________________________________________CaptionLbl)
            // {
            // }
            // column(DataItem1102754035;Date______________________________________________________________________________________________________________Caption_000Lbl)
            // {
            // }
            // column(DataItem1102754036;Date______________________________________________________________________________________________________________Caption_001Lbl)
            // {
            // }
            // column(DataItem1102754037;Received_by______________________________________________________________________________________________________________CaptLbl)
            // {
            // }
            // column(For_Official_use_onlyCaption;For_Official_use_onlyCaptionLbl)
            // {
            // }
            // column(DataItem1102754039;Checked_by______________________________________________________________________________________________________________CaptiLbl)
            // {
            // }
            // column(DataItem1102754040;Date______________________________________________________________________________________________________________Caption_002Lbl)
            // {
            // }
            // column(DataItem1102754041;Date______________________________________________________________________________________________________________Caption_003Lbl)
            // {
            // }
            // column(DataItem1102754042;Punched______________________________________________________________________________________________________________CaptionLbl)
            // {
            // }
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
                DataItemTableView = SORTING("No.") WHERE(Status = CONST(Active));
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
                    EmployeeRec.SetRange("ED Code Filter", PayrollSetup."NSSF ED Code");
                    EmployeeRec.CalcFields(Amount, "Membership No.");

                    if EmployeeRec.Amount <= 0 then CurrReport.Skip;

                    PeriodAmountArray[1] := EmployeeRec.Amount;
                    TotalAmountArray[1] := TotalAmountArray[1] + EmployeeRec.Amount;
                    PeriodAmountArray[3] := PeriodAmountArray[3] + PeriodAmountArray[1] + PeriodAmountArray[2];
                    TotalAmountArray[3] := TotalAmountArray[3] + PeriodAmountArray[1];

                    EmployeeRec.SetRange("ED Code Filter", PayrollSetup."NSSF Company Contribution");
                    EmployeeRec.CalcFields(Amount);

                    PeriodAmountArray[2] := EmployeeRec.Amount;//200;
                    TotalAmountArray[2] := TotalAmountArray[2] + EmployeeRec.Amount;//200;
                    PeriodAmountArray[3] := PeriodAmountArray[3] + PeriodAmountArray[2];
                    TotalAmountArray[3] := TotalAmountArray[3] + PeriodAmountArray[2];

                    EmployeeRec.SetRange("ED Code Filter", PayrollSetup."Pension 3 ED Code");
                    EmployeeRec.CalcFields(Amount);

                    PeriodAmountArray[4] := EmployeeRec.Amount;
                    TotalAmountArray[4] := TotalAmountArray[4] + EmployeeRec.Amount;
                    PeriodAmountArray[3] := PeriodAmountArray[3] + PeriodAmountArray[4];
                    TotalAmountArray[3] := TotalAmountArray[3] + PeriodAmountArray[4];

                    EmployeeRec.SetRange("ED Code Filter", PayrollSetup."Pension 3 Employer ED Code");
                    EmployeeRec.CalcFields(Amount);

                    PeriodAmountArray[5] := EmployeeRec.Amount;
                    TotalAmountArray[5] := TotalAmountArray[5] + EmployeeRec.Amount;
                    PeriodAmountArray[3] := PeriodAmountArray[3] + PeriodAmountArray[5];
                    TotalAmountArray[3] := TotalAmountArray[3] + PeriodAmountArray[5];

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
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number);
                MaxIteration = 1;
            }
            dataitem("Approval Comment Line"; "Approval Comment Line")
            {
                DataItemLink = "Document No." = FIELD("Document No");
                DataItemTableView = SORTING("Entry No.") ORDER(Ascending);
                column(ApprovedDays_ApprovalCommentLine; "Approval Comment Line"."Approved Days")
                {
                    IncludeCaption = true;
                }
                column(ApprovedStartDate_ApprovalCommentLine; "Approval Comment Line"."Approved Start Date")
                {
                    IncludeCaption = true;
                }
                column(ApprovedReturnDate_ApprovalCommentLine; "Approval Comment Line"."Approved Return Date")
                {
                    IncludeCaption = true;
                }
                column(Reason_ApprovalCommentLine; "Approval Comment Line".Reason)
                {
                    IncludeCaption = true;
                }
                column(LeaveAllowanceGranted_ApprovalCommentLine; "Approval Comment Line"."Leave allowance Granted")
                {
                    IncludeCaption = true;
                }
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("Document No");
                DataItemTableView = WHERE(Status = FILTER(Approved));
                column(SequenceNo; "Approval Entry"."Sequence No.")
                {
                }
                column(LastDateTimeModified; "Approval Entry"."Last Date-Time Modified")
                {
                }
                column(ApproverID; "Approval Entry"."Approver ID")
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(SenderID; "Approval Entry"."Sender ID")
                {
                }
                column(ShowPreparedBy_; ShowPreparedBy)
                {
                }
                column(ApprovedByCaption_; ApprovedByCaption)
                {
                }
                column(PreparedByCaption_; PreparedByCaption)
                {
                }
                column(PreparedDate; PreparedDate)
                {
                }
                column(UserSetupRec_SignatureI_; UserSetupRecI.Signature)
                {
                }
                column(UserSetupRec_Signature_; UserSetupRec.Signature)
                {
                }
                dataitem(Employee2; Employee)
                {
                    DataItemLink = "User ID" = FIELD("Approver ID");
                    column(FirstName_Employee; Employee2."First Name")
                    {
                    }
                    column(MiddleName_Employee; Employee2."Middle Name")
                    {
                    }
                    column(LastName_Employee; Employee2."Last Name")
                    {
                    }
                    column(EmployeeSignature; Employee2."Employee Signature")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    i := i + 1;
                    if i = 1 then begin
                        ShowPreparedBy := true;
                        PreparedDate := "Approval Entry"."Date-Time Sent for Approval";
                        EmployeeRecI.Reset;
                        EmployeeRecI.SetRange("User ID", "Approval Entry"."Sender ID");
                        if EmployeeRecI.FindFirst then begin
                            PreparedByCaption := 'Prepared By: Payroll Accountant: ' + ' ' + EmployeeRecI."First Name" + ' ' + EmployeeRecI."Last Name";

                        end;
                        UserSetupRec.Reset;

                        UserSetupRecI.SetRange("User ID", "Approval Entry"."Sender ID");
                        if UserSetupRecI.FindFirst then
                            UserSetupRecI.CalcFields(Signature);

                        ApprovedByCaption := 'Checked By: HRO';

                        UserSetupRec.Reset;

                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);

                    end
                    else
                        ShowPreparedBy := false;
                    if i = 2 then begin
                        ApprovedByCaption := 'Verified By: FM';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end
                    else if i = 3 then begin
                        ApprovedByCaption := 'Approved By: MD ';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end;
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
        PeriodAmountArray: array[5] of Decimal;
        TotalAmountArray: array[5] of Decimal;
        Counter: Integer;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        TotalCounter: Integer;
        PeriodFilter: Text[150];
        RtcCounter: Integer;
        Employee_ContributionCaptionLbl: Label 'Employee Contribution';
        NameCaptionLbl: Label 'Name';
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
        // Name______________________________________________________________________________________________________________CaptionLbl: Label 'Name...................................................................';
        // Signature______________________________________________________________________________________________________________CaptioLbl: Label 'Signature.......................................';
        // Designation______________________________________________________________________________________________________________CaptLbl: Label 'Designation....................................';
        // Date______________________________________________________________________________________________________________CaptionLbl: Label 'Date.............................................';
        // Date______________________________________________________________________________________________________________Caption_ConLbl: Label 'Date.............';
        // Peeled_By_____________________________________________________________________________________________________________CaptionLbl: Label 'Peeled By................';
        // Checked______________________________________________________________________________________________________________CaptionLbl: Label 'Checked.............';
        // Date______________________________________________________________________________________________________________Caption_000Lbl: Label 'Date..............';
        // Date______________________________________________________________________________________________________________Caption_001Lbl: Label 'Date........................';
        // Received_by______________________________________________________________________________________________________________CaptLbl: Label 'Received by...................................................';
        // For_Official_use_onlyCaptionLbl: Label 'For Official use only';
        // Checked_by______________________________________________________________________________________________________________CaptiLbl: Label 'Checked by............';
        // Date______________________________________________________________________________________________________________Caption_002Lbl: Label 'Date...................';
        // Date______________________________________________________________________________________________________________Caption_003Lbl: Label 'Date................';
        // Punched______________________________________________________________________________________________________________CaptionLbl: Label 'Punched...............................';
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

