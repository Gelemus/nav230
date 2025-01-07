report 51170 "Cash Payment List-Advances"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Cash Payment List-Advances.rdl';

    dataset
    {
        dataitem(Periods; Periods)
        {
            DataItemTableView = SORTING("Start Date") WHERE(Status = FILTER(Open | Posted));
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
            dataitem(Employee; Employee)
            {
                PrintOnlyIfDetail = false;
                column(Branch_Code_from_multiple_dim__; 'Branch Code from multiple dim?')
                {
                }
                column(Employee_Paystation; Paystation)
                {
                }
                column(CurrReport_PAGENO; CurrReport.PageNo)
                {
                }
                column(TitleText; TitleText)
                {
                }
                column(Employee__No__; "No.")
                {
                }
                column(Employee_Name; Name)
                {
                }
                column(Employee_Amount; Amount)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS10002; SHS10002)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS5002; SHS5002)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS2002; SHS2002)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS1002; SHS1002)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS502; SHS502)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS202; SHS202)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS102; SHS102)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS52; SHS52)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS12; SHS12)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS052; SHS052)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS012; SHS012)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(Employee_Amount_Control1101951004; Amount)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(Total_for_____FORMAT__EmpCount________Paystation_____Employees_; 'Total for : ' + Format(EmpCount) + ' ' + Paystation + ' Employees')
                {
                }
                column(SHS012_Control1101951029; SHS012)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS10002_Control1101951030; SHS10002)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS5002_Control1101951031; SHS5002)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS2002_Control1101951032; SHS2002)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS1002_Control1101951033; SHS1002)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS502_Control1101951034; SHS502)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS202_Control1101951035; SHS202)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS102_Control1101951036; SHS102)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS52_Control1101951037; SHS52)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS12_Control1101951038; SHS12)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS052_Control1101951039; SHS052)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(Employee_Amount_Control16; Amount)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS012_Control1101951040; SHS012)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS10002_Control1101951041; SHS10002)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS5002_Control1101951042; SHS5002)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS2002_Control1101951043; SHS2002)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS1002_Control1101951044; SHS1002)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS502_Control1101951045; SHS502)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS202_Control1101951046; SHS202)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS102_Control1101951047; SHS102)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS52_Control1101951048; SHS52)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS12_Control1101951049; SHS12)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(SHS052_Control1101951050; SHS052)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(Grand_Total_for_____FORMAT_COUNT______Employees_; 'Grand Total for : ' + Format(Count) + ' Employees')
                {
                }
                column(Employee__No__Caption; FieldCaption("No."))
                {
                }
                column(Employee_NameCaption; Employee_NameCaptionLbl)
                {
                }
                column(Employee_AmountCaption; Employee_AmountCaptionLbl)
                {
                }
                column(SHS_1000Caption; SHS_1000CaptionLbl)
                {
                }
                column(SHS_500Caption; SHS_500CaptionLbl)
                {
                }
                column(SHS_200Caption; SHS_200CaptionLbl)
                {
                }
                column(SHS_100Caption; SHS_100CaptionLbl)
                {
                }
                column(SHS_50Caption; SHS_50CaptionLbl)
                {
                }
                column(SHS_20Caption; SHS_20CaptionLbl)
                {
                }
                column(SHS_10Caption; SHS_10CaptionLbl)
                {
                }
                column(SHS_5Caption; SHS_5CaptionLbl)
                {
                }
                column(SHS_1Caption; SHS_1CaptionLbl)
                {
                }
                column(V50_CENTSCaption; V50_CENTSCaptionLbl)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(V10_CENTSCaption; V10_CENTSCaptionLbl)
                {
                }
                column(SignatureCaption; SignatureCaptionLbl)
                {
                }
                column(EmptyStringCaption; EmptyStringCaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Name := Employee.FullName;
                    //EmpCount := EmpCount + 1;

                    if Header.Get(Periods."Period ID", Employee."No.") then begin
                        Header.CalcFields("Mid Month Advance Code");
                        Header.CalcFields("Advance (LCY)");
                        Amount := Header."Advance (LCY)";
                        TotalAmount := TotalAmount + Amount;
                        if Amount > 0 then
                            CountCoin(Amount)
                        else begin
                            SHS10002 := 0;
                            SHS5002 := 0;
                            SHS2002 := 0;
                            SHS1002 := 0;
                            SHS502 := 0;
                            SHS202 := 0;
                            SHS102 := 0;
                            SHS52 := 0;
                            SHS12 := 0;
                            SHS052 := 0;
                            SHS012 := 0;
                        end;
                    end;
                    if Amount <= 0 then CurrReport.Skip;

                    //AMI
                    EmpCount := EmpCount + 1;
                end;

                trigger OnPreDataItem()
                begin
                    SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                    CurrReport.CreateTotals(Amount, SHS10002, SHS5002, SHS2002, SHS1002, SHS502, SHS202, SHS102, SHS52, SHS12);
                    CurrReport.CreateTotals(SHS052, SHS012, EmpCount);

                    //AMI
                    EmpCount := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TotalAmount := 0;
                TitleText := 'Mid Month Advances Payment List for ' + Periods.Description;
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

    trigger OnPreReport()
    begin
        gsSegmentPayrollData;
    end;

    var
        Header: Record "Payroll Header";
        Name: Text[60];
        Amount: Decimal;
        TotalAmount: Decimal;
        TitleText: Text[90];
        SHS10002: Decimal;
        SHS5002: Decimal;
        SHS2002: Decimal;
        SHS1002: Decimal;
        SHS502: Decimal;
        SHS202: Decimal;
        SHS102: Decimal;
        SHS52: Decimal;
        SHS12: Decimal;
        SHS052: Decimal;
        SHS012: Decimal;
        SHS1000: Decimal;
        SHS500: Decimal;
        SHS200: Decimal;
        SHS100: Decimal;
        SHS50: Decimal;
        SHS20: Decimal;
        SHS10: Decimal;
        SHS5: Decimal;
        SHS1: Decimal;
        SHS05: Decimal;
        SHS01: Decimal;
        EmpCount: Decimal;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        Employee_NameCaptionLbl: Label 'Name';
        Employee_AmountCaptionLbl: Label 'Amount';
        SHS_1000CaptionLbl: Label 'SHS 1000';
        SHS_500CaptionLbl: Label 'SHS 500';
        SHS_200CaptionLbl: Label 'SHS 200';
        SHS_100CaptionLbl: Label 'SHS 100';
        SHS_50CaptionLbl: Label 'SHS 50';
        SHS_20CaptionLbl: Label 'SHS 20';
        SHS_10CaptionLbl: Label 'SHS 10';
        SHS_5CaptionLbl: Label 'SHS 5';
        SHS_1CaptionLbl: Label 'SHS 1';
        V50_CENTSCaptionLbl: Label '50 CENTS';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        V10_CENTSCaptionLbl: Label '10 CENTS';
        SignatureCaptionLbl: Label 'Signature';
        EmptyStringCaptionLbl: Label '...........................................';

    procedure CountCoin(DecAmount: Decimal)
    var
        IntAmount: Integer;
        RestAmount: Integer;
        Amount2: Decimal;
    begin
        Amount2 := DecAmount * 100;
        IntAmount := Round(Amount2, 10, '<');

        SHS10002 := IntAmount div 100000;
        SHS1000 := SHS1000 + IntAmount div 100000;
        RestAmount := IntAmount mod 100000;

        SHS5002 := RestAmount div 50000;
        SHS500 := SHS500 + RestAmount div 50000;
        RestAmount := RestAmount mod 50000;

        SHS2002 := RestAmount div 20000;
        SHS200 := SHS200 + RestAmount div 20000;
        RestAmount := RestAmount mod 20000;

        SHS1002 := RestAmount div 10000;
        SHS100 := SHS100 + RestAmount div 10000;
        RestAmount := RestAmount mod 10000;

        SHS502 := RestAmount div 5000;
        SHS50 := SHS50 + RestAmount div 5000;
        RestAmount := RestAmount mod 5000;

        SHS202 := RestAmount div 2000;
        SHS20 := SHS20 + RestAmount div 2000;
        RestAmount := RestAmount mod 2000;

        SHS102 := RestAmount div 1000;
        SHS10 := SHS10 + RestAmount div 1000;
        RestAmount := RestAmount mod 1000;

        SHS52 := RestAmount div 500;
        SHS5 := SHS5 + RestAmount div 500;
        RestAmount := RestAmount mod 500;

        SHS12 := RestAmount div 100;
        SHS1 := SHS1 + RestAmount div 100;
        RestAmount := RestAmount mod 100;

        SHS052 := 0;
        //SHS052 := RestAmount DIV 50;
        SHS05 := SHS05 + RestAmount div 50;
        RestAmount := RestAmount mod 50;

        SHS012 := 0;
        //SHS012 := RestAmount DIV 10;
        SHS01 := SHS01 + RestAmount div 10;
        RestAmount := RestAmount mod 10;
    end;

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

