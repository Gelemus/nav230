report 50115 "Payroll Reconciliation-All ED"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Payroll Reconciliation-All ED.rdl';

    dataset
    {
        dataitem(Periods; Periods)
        {
            DataItemTableView = SORTING("Start Date") WHERE(Status = FILTER(Open | Posted));
            RequestFilterFields = "Period ID";
            column(COMPANYNAME; CompanyName)
            {
            }
            column(TitleText; TitleText)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(DESCRIPTIONCaption; DESCRIPTIONCaptionLbl)
            {
            }
            column(ED_CODECaption; ED_CODECaptionLbl)
            {
            }
            column(AMOUNT_KSHSCaption; AMOUNT_KSHSCaptionLbl)
            {
            }
            column(Periods_Period_ID; "Period ID")
            {
            }
            column(Periods_Period_Month; "Period Month")
            {
            }
            column(Periods_Period_Year; "Period Year")
            {
            }
            column(Periods_Payroll_Code; "Payroll Code")
            {
            }
            dataitem("ED Definitions"; "ED Definitions")
            {
                DataItemTableView = SORTING("Calculation Group", Priority) ORDER(Ascending) WHERE("ED Code" = FILTER(<> '14000' & <> '16000' & <> '32000' & <> '33000' & <> '50500'), "Calculation Group" = FILTER(Payments | Deduction | "Employer Contributions"));
                RequestFilterFields = "ED Code";
                column(Amount; Amount)
                {
                }
                column(Name; Name)
                {
                }
                column(ED_Definitions__ED_Code_; "ED Code")
                {
                }
                column(RTCAmount; RTCAmount)
                {
                }
                column(TotalNetPay; TotalNetPay)
                {
                }
                column(TOTAL_NET_PAYCaption; TOTAL_NET_PAYCaptionLbl)
                {
                }
                column(PreviousAmt; PreviousAmt)
                {
                }
                column(Variance; Variance)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Name := "ED Definitions".Description;
                    Lines.SetRange("ED Code", "ED Definitions"."ED Code");
                    Lines.CalcSums(Amount);
                    Amount := Lines.Amount;

                    //Previous month
                    GPrevPeriodEndDate := Periods."Start Date" - 1;
                    GPrevMonth := Date2DMY(GPrevPeriodEndDate, 2);
                    GPrevPeriodYear := Date2DMY(GPrevPeriodEndDate, 3);
                    GPeriodText := Format(GPrevMonth) + '-' + Format(GPrevPeriodYear);
                    Period.SetRange("Period ID", GPeriodText);
                    Period.SetFilter("Payroll Code", Periods."Payroll Code");
                    if Period.FindFirst then
                        GPrevPeriod := Period."Period ID";

                    Lines2.SetCurrentKey("Payroll ID", "ED Code", "Payroll Code");
                    Lines2.SetRange("Payroll ID", Period."Period ID");
                    Lines2.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                    Lines2.SetRange("ED Code", "ED Definitions"."ED Code");
                    Lines2.CalcSums(Amount);
                    PreviousAmt := Lines2.Amount;

                    if ((Amount = 0) and (PreviousAmt = 0)) and (SkipZeroAmountEDs) then CurrReport.Skip;
                    Variance := Amount - PreviousAmt;
                    /*
                    //Calculate Total Net Pay
                    IF "Calculation Group" = "Calculation Group"::Payments THEN BEGIN
                      TotalNetPay := TotalNetPay + Amount ;
                       RTCAmount:=-Amount
                    END ELSE  BEGIN
                    IF "Calculation Group" = "Calculation Group"::Deduction THEN
                      TotalNetPay := TotalNetPay - Amount;
                       RTCAmount:=Amount;
                    END;
                    
                    IF "Calculation Group" = "Calculation Group"::Payments THEN Amount:=-Amount;
                    */

                end;

                trigger OnPreDataItem()
                begin
                    if ((gvAllowedPayrolls."Payroll Code" = 'ABMCASUAL') or (gvAllowedPayrolls."Payroll Code" = 'ABMRREAL') or
                      (gvAllowedPayrolls."Payroll Code" = 'ABMJNR') or (gvAllowedPayrolls."Payroll Code" = 'ABMSUP')) then
                        SetRange("Payroll Code", 'ABMCASUAL');
                    if ((gvAllowedPayrolls."Payroll Code" = 'ABMMGT') or (gvAllowedPayrolls."Payroll Code" = 'ABMEXEC')) then
                        SetRange("Payroll Code", 'ABMMGT');
                    if ((gvAllowedPayrolls."Payroll Code" = 'CEKLSUP') or (gvAllowedPayrolls."Payroll Code" = 'CEKLJNR')) then
                        SetRange("Payroll Code", 'CEKLSUP');
                    if (gvAllowedPayrolls."Payroll Code" = 'CEKLMGT') then
                        SetRange("Payroll Code", 'CEKLMGT');
                    if (gvAllowedPayrolls."Payroll Code" = 'CETZ') then
                        SetRange("Payroll Code", 'CETZ');
                    if (gvAllowedPayrolls."Payroll Code" = 'CETZMGT') then
                        SetRange("Payroll Code", 'CETZMGT');
                    if ((gvAllowedPayrolls."Payroll Code" = 'JNR') or (gvAllowedPayrolls."Payroll Code" = 'MGT') or
                    (gvAllowedPayrolls."Payroll Code" = 'TEMP')) then
                        SetRange("Payroll Code", 'JNR');
                    Lines.SetCurrentKey("Payroll ID", "ED Code", "Payroll Code");
                    Lines.SetRange("Payroll ID", Periods."Period ID");
                    Lines.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                end;
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
                            PreparedByCaption := 'Prepared By: Payroll Administrator: ' + ' ' + EmployeeRecI."First Name" + ' ' + EmployeeRecI."Last Name";

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
                    /* IF i=2 THEN
                     BEGIN
                     ApprovedByCaption:='Confirmed By: ACCOUNTANT:';
                     UserSetupRec.RESET;
                     UserSetupRec.SETRANGE("User ID","Approval Entry"."Approver ID");
                     IF UserSetupRec.FINDFIRST THEN
                       UserSetupRec.CALCFIELDS(Signature);
                       END
                   ELSE IF i=3 THEN
                     BEGIN
                     ApprovedByCaption:='Verified By: CM:';
                     UserSetupRec.RESET;
                     UserSetupRec.SETRANGE("User ID","Approval Entry"."Approver ID");
                     IF UserSetupRec.FINDFIRST THEN
                       UserSetupRec.CALCFIELDS(Signature);
                       END
                   ELSE*/
                    if i = 2 then begin
                        ApprovedByCaption := 'Approved By: GM FINANCE: ';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end;

                end;
            }

            trigger OnAfterGetRecord()
            begin
                TitleText := 'E/D Reconciliation for ' + Periods.Description;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                if Periods.GetFilter(Periods."Period ID") = '' then Error('Specify the Period ID');
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
                    field("Skip Zero Amount ED's"; SkipZeroAmountEDs)
                    {
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
    end;

    var
        Period: Record Periods;
        Lines: Record "Payroll Lines";
        TestCalc: Codeunit "Payroll Posting";
        Name: Text[92];
        TitleText: Text[60];
        PeriodCode: Code[10];
        Amount: Decimal;
        TotalNetPay: Decimal;
        SkipZeroAmountEDs: Boolean;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        RTCAmount: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        DESCRIPTIONCaptionLbl: Label 'DESCRIPTION';
        ED_CODECaptionLbl: Label 'ED CODE';
        AMOUNT_KSHSCaptionLbl: Label 'Earnings';
        TOTAL_NET_PAYCaptionLbl: Label 'TOTAL NET PAY';
        PreviousAmt: Decimal;
        Variance: Decimal;
        Lines2: Record "Payroll Lines";
        GPrevMonth: Integer;
        GPrevPeriodYear: Integer;
        GPrevPeriod: Code[10];
        GPrevPeriodEndDate: Date;
        GPeriodText: Text[30];
        Description: Option " ","Nawasco Gen","KCG 858S";
        CardNo: Option " ","157364","157362";
        BF: Decimal;
        CF: Decimal;
        AmountLoaded: Decimal;
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

