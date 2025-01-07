report 51156 "ED Totals Per Period"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/ED Totals Per Period.rdl';

    dataset
    {
        dataitem(Periods; Periods)
        {
            DataItemTableView = SORTING("Start Date") WHERE(Status = FILTER(Open | Posted));
            RequestFilterFields = "Period ID";
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CompPicture; CompInfo.Picture)
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
                DataItemTableView = WHERE("ED Code" = FILTER(<> '14000' & <> '16000' & <> '32000' & <> '33000'));
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
                column(Amount1; Amount1)
                {
                }
                column(Amount2; Amount2)
                {
                }
                column(TotalNetPay; TotalNetPay)
                {
                }
                column(TOTAL_NET_PAYCaption; TOTAL_NET_PAYCaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Name := "ED Definitions".Description;
                    Lines.SetRange("ED Code", "ED Definitions"."ED Code");
                    Lines.CalcSums(Amount);
                    Amount := Lines.Amount;

                    if (Amount = 0) and (SkipZeroAmountEDs) then CurrReport.Skip;
                    //Separating EDs
                    if "Calculation Group" = "Calculation Group"::None then CurrReport.Skip;

                    if "Calculation Group" = "Calculation Group"::Payments then begin
                        Amount1 := Amount;

                    end else begin
                        if "Calculation Group" = "Calculation Group"::Deduction then
                            Amount2 := -Amount;

                    end;
                    //Calculate Total Net Pay
                    if "Calculation Group" = "Calculation Group"::Payments then begin
                        TotalNetPay := TotalNetPay + Amount;
                        RTCAmount := -Amount
                    end else begin
                        if "Calculation Group" = "Calculation Group"::Deduction then
                            TotalNetPay := TotalNetPay - Amount;
                        RTCAmount := Amount;
                    end;

                    if "Calculation Group" = "Calculation Group"::Payments then Amount := -Amount;
                end;

                trigger OnPreDataItem()
                begin
                    Lines.SetCurrentKey("Payroll ID", "ED Code", "Payroll Code");
                    Lines.SetRange("Payroll ID", Periods."Period ID");
                    Lines.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TitleText := 'E/D Totals for ' + Periods.Description;
                CompInfo.Get;
                CompInfo.CalcFields(Picture);
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
        gsSegmentPayrollData
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
        Amount1: Decimal;
        Amount2: Decimal;
        CompInfo: Record "Company Information";

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

