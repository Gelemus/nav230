report 51175 "Update Report Detail"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Update Report Detail.rdl';

    dataset
    {
        dataitem(Periods; Periods)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Period ID";
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
                DataItemTableView = SORTING("ED Code") WHERE("Calculation Group" = CONST(Payments));
                column(COMPANYNAME; CompanyName)
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
                column(Periods_Description; Periods.Description)
                {
                }
                column(ED_Definitions__ED_Code_; "ED Code")
                {
                }
                column(Amount; Amount)
                {
                }
                column(ED_Definitions_Description; Description)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(Update_Report_DetailCaption; Update_Report_DetailCaptionLbl)
                {
                }
                column(As_AtCaption; As_AtCaptionLbl)
                {
                }
                column(PAYMENTSCaption; PAYMENTSCaptionLbl)
                {
                }
                column(CODECaption; CODECaptionLbl)
                {
                }
                column(AmountCaption; AmountCaptionLbl)
                {
                }
                column(DescriptionCaption; DescriptionCaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Amount := 0;

                    gvPayrollLines.Reset;
                    gvPayrollLines.SetRange("ED Code", "ED Definitions"."ED Code");
                    gvPayrollLines.SetRange("Payroll ID", Periods."Period ID");
                    gvPayrollLines.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");

                    if gvPayrollLines.Find('-') then
                        repeat
                            Amount := Amount + gvPayrollLines.Amount;
                            gvPayments := gvPayments + gvPayrollLines.Amount;
                        until gvPayrollLines.Next = 0;

                    if Amount = 0 then CurrReport.Skip;
                end;

                trigger OnPreDataItem()
                var
                    lvStartDate: Date;
                    lvString: Text[30];
                    lvMonth: Integer;
                    lvYear: Integer;
                begin
                    Amount := 0;
                    gvPayments := 0;
                end;
            }
            dataitem("ED Definitions2"; "ED Definitions")
            {
                DataItemTableView = SORTING("ED Code") ORDER(Ascending) WHERE("Calculation Group" = CONST(Deduction));
                column(ED_Definitions2__ED_Code_; "ED Code")
                {
                }
                column(ED_Definitions2_Description; Description)
                {
                }
                column(Amount_Control1000000022; Amount)
                {
                }
                column(gvPayments; gvPayments)
                {
                }
                column(gvDeductions; gvDeductions)
                {
                }
                column(gvPAYE; gvPAYE)
                {
                }
                column(gvPayments____gvDeductions___gvPAYE_; gvPayments - (gvDeductions + gvPAYE))
                {
                }
                column(DEDUCTIONSCaption; DEDUCTIONSCaptionLbl)
                {
                }
                column(CODECaption_Control1000000026; CODECaption_Control1000000026Lbl)
                {
                }
                column(DescriptionCaption_Control1000000027; DescriptionCaption_Control1000000027Lbl)
                {
                }
                column(AmountCaption_Control1000000028; AmountCaption_Control1000000028Lbl)
                {
                }
                column(Gross_PaymentsCaption; Gross_PaymentsCaptionLbl)
                {
                }
                column(Total_DeductionsCaption; Total_DeductionsCaptionLbl)
                {
                }
                column(Total_PAYECaption; Total_PAYECaptionLbl)
                {
                }
                column(NettCaption; NettCaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                var
                    lvPayrollSetup: Record "Payroll Setups";
                begin
                    Amount := 0;

                    gvPayrollLines.Reset;
                    gvPayrollLines.SetRange("ED Code", "ED Definitions2"."ED Code");
                    gvPayrollLines.SetRange("Payroll ID", Periods."Period ID");
                    gvPayrollLines.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");

                    if gvPayrollLines.Find('-') then
                        repeat
                            //Dont include PAYE among the deductions
                            lvPayrollSetup.Get(gvAllowedPayrolls."Payroll Code");
                            if gvPayrollLines."ED Code" = lvPayrollSetup."PAYE ED Code" then begin
                                gvPAYE := gvPAYE + gvPayrollLines.Amount;
                                CurrReport.Skip;
                            end;

                            Amount := Amount + gvPayrollLines.Amount;
                            gvDeductions := gvDeductions + gvPayrollLines.Amount;
                        until gvPayrollLines.Next = 0;

                    if Amount = 0 then CurrReport.Skip;
                end;

                trigger OnPreDataItem()
                var
                    lvStartDate: Date;
                    lvMonth: Integer;
                    lvYear: Integer;
                begin
                    Amount := 0;
                    gvPAYE := 0;
                    gvDeductions := 0;
                end;
            }

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
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
    end;

    var
        Amount: Decimal;
        EdDescription: Text[30];
        gvPayrollLines: Record "Payroll Lines";
        gvPrevPeriod: Code[10];
        gvPeriods: Record Periods;
        gvPAYE: Decimal;
        gvPayments: Decimal;
        gvDeductions: Decimal;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Update_Report_DetailCaptionLbl: Label 'Update Report Detail';
        As_AtCaptionLbl: Label 'As At';
        PAYMENTSCaptionLbl: Label 'PAYMENTS';
        CODECaptionLbl: Label 'CODE';
        AmountCaptionLbl: Label 'Amount';
        DescriptionCaptionLbl: Label 'Description';
        DEDUCTIONSCaptionLbl: Label 'DEDUCTIONS';
        CODECaption_Control1000000026Lbl: Label 'CODE';
        DescriptionCaption_Control1000000027Lbl: Label 'Description';
        AmountCaption_Control1000000028Lbl: Label 'Amount';
        Gross_PaymentsCaptionLbl: Label 'Gross Payments';
        Total_DeductionsCaptionLbl: Label 'Total Deductions';
        Total_PAYECaptionLbl: Label 'Total PAYE';
        NettCaptionLbl: Label 'Nett';

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

