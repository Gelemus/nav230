report 51219 "NSSF Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/NSSF Report.rdl';

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
            column(Signature; Signature_CaptioLbl)
            {
            }
            column(DataItem1102754030; Designation_CaptLbl)
            {
            }
            column(DataItem1102754031; Date_CaptionLbl)
            {
            }
            column(DataItem1102754032; Date_Caption_ConLbl)
            {
            }
            column(DataItem1102754033; Peeled_By_CaptionLbl)
            {
            }
            column(DataItem1102754034; Checked_CaptionLbl)
            {
            }
            column(DataItem1102754035; Date_Caption_000Lbl)
            {
            }
            column(DataItem1102754036; Date_Caption_001Lbl)
            {
            }
            column(DataItem1102754037; Received_by_CaptLbl)
            {
            }
            column(For_Official_use_onlyCaption; For_Official_use_onlyCaptionLbl)
            {
            }
            column(DataItem1102754039; Checked_by_CaptiLbl)
            {
            }
            column(DataItem1102754040; Date_Caption_002Lbl)
            {
            }
            column(DataItem1102754041; Date_Caption_003Lbl)
            {
            }
            column(DataItem1102754042; Punched_CaptionLbl)
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
                column(Other_Names; "Other Names")
                {
                }
                column(Contribition_Type; "Contribution Type")
                {
                }
                column(Income_Type; "Income Type")
                {
                }
                column(Income; Income)
                {
                }
                column(PIN_Employee; Employee.PIN)
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
                column(FORMAT_EmployeeRec__Membership_No___; Format(EmployeeRec."NSSF No."))
                {
                }
                column(RtcCounter; RtcCounter)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Clear(PeriodAmountArray);
                    Name := Employee."Last Name";
                    "Other Names" := Employee."First Name" + ' ' + Employee."Middle Name";
                    "Contribution Type" := 199;
                    Income := 3334;
                    "Income Type" := 1;
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
                    PeriodAmountArray[2] := 200;//EmployeeRec.Amount;
                    TotalAmountArray[2] := TotalAmountArray[2] + 200;//EmployeeRec.Amount;
                    PeriodAmountArray[3] := PeriodAmountArray[3] + PeriodAmountArray[2];
                    TotalAmountArray[3] := TotalAmountArray[3] + PeriodAmountArray[2];
                    Counter := Counter + 1;
                    RtcCounter += 1;
                end;

                trigger OnPostDataItem()
                begin
                    TotalCounter := Counter;
                end;

                trigger OnPreDataItem()
                begin
                    //SETRANGE("Payroll Code", gvAllowedPayrolls."Payroll Code");

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

                        ApprovedByCaption := 'Checked By: GM HR:';

                        UserSetupRec.Reset;

                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);

                    end
                    else
                        ShowPreparedBy := false;
                    if i = 2 then begin
                        ApprovedByCaption := 'Confirmed By: HOD Finance:';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end
                    else if i = 3 then begin
                        ApprovedByCaption := 'Authorised By: MD:';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end;/*
                    ELSE IF i=4 THEN
                      BEGIN
                      ApprovedByCaption:='Approved By: MD: ';
                      UserSetupRec.RESET;
                      UserSetupRec.SETRANGE("User ID","Approval Entry"."Approver ID");
                      IF UserSetupRec.FINDFIRST THEN
                        UserSetupRec.CALCFIELDS(Signature);
                        END;
                    */

                end;
            }

            trigger OnAfterGetRecord()
            begin
                TitleText := /*'NSSF Contributions for ' + */Periods."Period ID";//Description;

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
        PeriodAmountArray: array[3] of Decimal;
        TotalAmountArray: array[3] of Decimal;
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
        Name_CaptionLbl: Label 'Name...................................................................';
        Signature_CaptioLbl: Label 'Signature.......................................';
        Designation_CaptLbl: Label 'Designation....................................';
        Date_CaptionLbl: Label 'Date.............................................';
        Date_Caption_ConLbl: Label 'Date.............';
        Peeled_By_CaptionLbl: Label 'Peeled By................';
        Checked_CaptionLbl: Label 'Checked.............';
        Date_Caption_000Lbl: Label 'Date..............';
        Date_Caption_001Lbl: Label 'Date........................';
        Received_by_CaptLbl: Label 'Received by...................................................';
        For_Official_use_onlyCaptionLbl: Label 'For Official use only';
        Checked_by_CaptiLbl: Label 'Checked by............';
        Date_Caption_002Lbl: Label 'Date...................';
        Date_Caption_003Lbl: Label 'Date................';
        Punched_CaptionLbl: Label 'Punched...............................';
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
        "Other Names": Text[100];
        "Contribution Type": Integer;
        Income: Integer;
        "Income Type": Integer;

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

