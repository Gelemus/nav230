report 51173 "Yearly Earnings/Deductions Sch"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Yearly EarningsDeductions Sch.rdl';

    dataset
    {
        dataitem(Periods; Periods)
        {
            DataItemTableView = SORTING("Start Date") ORDER(Ascending);
            RequestFilterFields = "Period Year";
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
            dataitem("Payroll Lines"; "Payroll Lines")
            {
                DataItemLink = "Payroll ID" = FIELD("Period ID");
                DataItemTableView = SORTING("Payroll ID", "Employee No.", "ED Code") ORDER(Ascending);
                column(USERID; UserId)
                {
                }
                column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
                {
                }
                column(COMPANYNAME; CompanyName)
                {
                }
                column(TitleText; TitleText)
                {
                }
                column(Payroll_Lines_Amount; Amount)
                {
                }
                column(Payroll_Lines__Employee_No__; "Employee No.")
                {
                }
                column(Payroll_Lines_Amount_Control11; Amount)
                {
                }
                column(Name; Name)
                {
                }
                column(Payroll_Lines_Quantity; Quantity)
                {
                }
                column(Payroll_Lines_Rate; Rate)
                {
                }
                column(Payroll_Lines_Amount_Control1; Amount)
                {
                }
                column(Payroll_Lines_Amount_Control31; Amount)
                {
                }
                column(CurrReport_PAGENO; CurrReport.PageNo)
                {
                }
                column(Sub_Total_B_FCaption; Sub_Total_B_FCaptionLbl)
                {
                }
                column(AmountCaption; AmountCaptionLbl)
                {
                }
                column(NameCaption; NameCaptionLbl)
                {
                }
                column(No_Caption; No_CaptionLbl)
                {
                }
                column(Payroll_Lines__Employee_No__Caption; Payroll_Lines__Employee_No__CaptionLbl)
                {
                }
                column(Payroll_Lines_Amount_Control11Caption; FieldCaption(Amount))
                {
                }
                column(NameCaption_Control3; NameCaption_Control3Lbl)
                {
                }
                column(Payroll_Lines_RateCaption; FieldCaption(Rate))
                {
                }
                column(Payroll_Lines_QuantityCaption; FieldCaption(Quantity))
                {
                }
                column(Payroll_Lines_Amount_Control1Caption; Payroll_Lines_Amount_Control1CaptionLbl)
                {
                }
                column(Sub_Total_C_FCaption; Sub_Total_C_FCaptionLbl)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(Payroll_Lines_Entry_No_; "Entry No.")
                {
                }
                column(Payroll_Lines_Payroll_ID; "Payroll ID")
                {
                }

                trigger OnPreDataItem()
                begin
                    SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                    SetRange("ED Code", EDCode);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //IF NOT TestCalc.TestCalculated("Period ID") THEN
                // ERROR('Not all Payrolls are calculated for period %1.',"Period ID"); //080611 SNG Commented out

                TitleText := EDDef.Description + ' List for ' + Description;
            end;

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

    trigger OnInitReport()
    begin
        if ACTION::LookupOK = PAGE.RunModal(PAGE::"ED Definitions List", EDDef) then
            EDCode := EDDef."ED Code"
        else
            Error('No E/D was selected');

        gsSegmentPayrollData;
    end;

    var
        Employee: Record Employee;
        EDDef: Record "ED Definitions";
        TestCalc: Codeunit "Payroll Posting";
        Name: Text[92];
        TitleText: Text[100];
        EDCode: Code[20];
        gvAllowedPayrolls: Record "Allowed Payrolls";
        Sub_Total_B_FCaptionLbl: Label 'Sub Total B/F';
        AmountCaptionLbl: Label 'Amount';
        NameCaptionLbl: Label 'Name';
        No_CaptionLbl: Label 'No.';
        Payroll_Lines__Employee_No__CaptionLbl: Label 'No.';
        NameCaption_Control3Lbl: Label 'Name';
        Payroll_Lines_Amount_Control1CaptionLbl: Label 'Total Amount';
        Sub_Total_C_FCaptionLbl: Label 'Sub Total C/F';
        CurrReport_PAGENOCaptionLbl: Label 'Page';

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

