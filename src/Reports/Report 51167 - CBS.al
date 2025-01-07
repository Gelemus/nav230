report 51167 CBS
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/CBS.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
            column(MaleTotals6; MaleTotals[6])
            {
            }
            column(MaleTotals5; MaleTotals[5])
            {
            }
            column(MaleTotals4; MaleTotals[4])
            {
            }
            column(MaleTotals3; MaleTotals[3])
            {
            }
            column(MaleTotals2; MaleTotals[2])
            {
            }
            column(MaleTotals1; MaleTotals[1])
            {
            }
            column(FemaleTotals6; FemaleTotals[6])
            {
            }
            column(FemaleTotals5; FemaleTotals[5])
            {
            }
            column(FemaleTotals4; FemaleTotals[4])
            {
            }
            column(FemaleTotals3; FemaleTotals[3])
            {
            }
            column(FemaleTotals2; FemaleTotals[2])
            {
            }
            column(FemaleTotals1; FemaleTotals[1])
            {
            }
            column(MaleTotals1MaleTotals2MaleTotals3MaleTotals4MaleTotals5MaleTotals6; MaleTotals[1] + MaleTotals[2] + MaleTotals[3] + MaleTotals[4] + MaleTotals[5] + MaleTotals[6])
            {
            }
            column(FemaleTotals1FemaleTotals2FemaleTotals3FemaleTotals4FemaleTotals5FemaleTotals6; FemaleTotals[1] + FemaleTotals[2] + FemaleTotals[3] + FemaleTotals[4] + FemaleTotals[5] + FemaleTotals[6])
            {
            }
            column(FemaleTotals1MaleTotals1; FemaleTotals[1] + MaleTotals[1])
            {
            }
            column(FemaleTotals2MaleTotals2; FemaleTotals[2] + MaleTotals[2])
            {
            }
            column(FemaleTotals3MaleTotals3; FemaleTotals[3] + MaleTotals[3])
            {
            }
            column(FemaleTotals4MaleTotals4; FemaleTotals[4] + MaleTotals[4])
            {
            }
            column(FemaleTotals5MaleTotals5; FemaleTotals[5] + MaleTotals[5])
            {
            }
            column(FemaleTotals6MaleTotals6; FemaleTotals[6] + MaleTotals[6])
            {
            }
            column(DataItem1101951050; FemaleTotals[1] + FemaleTotals[2] + FemaleTotals[3] + FemaleTotals[4] + FemaleTotals[5] + FemaleTotals[6] + MaleTotals[1] + MaleTotals[2] + MaleTotals[3] + MaleTotals[4] + MaleTotals[5] + MaleTotals[6])
            {
            }
            column(Employee_No_; "No.")
            {
            }
            dataitem("Payroll Header"; "Payroll Header")
            {
                DataItemLink = "Employee no." = FIELD("No.");
                column(HEADER1; HEADER[1])
                {
                }
                column(HEADER2; HEADER[2])
                {
                }
                column(HEADER3; HEADER[3])
                {
                }
                column(HEADER4; HEADER[4])
                {
                }
                column(HEADER5; HEADER[5])
                {
                }
                column(HEADER6; HEADER[6])
                {
                }
                column(TOTAL; 'TOTAL')
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ColumnD := ColumnD + "D (LCY)";
                    ColumnL := ColumnL + "M (LCY)";
                end;

                trigger OnPostDataItem()
                begin
                    i := 0;
                    LookUpLines.Reset;
                    LookUpLines.SetRange("Table ID", PayrollSetup."Income Brackets Rate");
                    if LookUpLines.Find('-') then
                        repeat
                            i := i + 1;
                            HEADER[i] := Format(LookUpLines."Lower Amount (LCY)") + ' - ' + Format(LookUpLines."Upper Amount (LCY)");
                            if ((ColumnD / 20 >= LookUpLines."Lower Amount (LCY)") and (ColumnD / 20 <= LookUpLines."Upper Amount (LCY)")) then begin
                                if Employee.Gender = Employee.Gender::Male then
                                    MaleTotals[i] := MaleTotals[i] + 1
                                else
                                    FemaleTotals[i] := FemaleTotals[i] + 1;
                            end;
                        until LookUpLines.Next = 0;
                end;

                trigger OnPreDataItem()
                begin
                    SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                    PayrollHeader.SetRange("Payroll Year", Year);
                    PayrollHeader.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ColumnD := 0;
                ColumnL := 0;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                CurrReport.CreateTotals(ColumnD, ColumnL);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control2)
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
        if Year = 0 then Error(' You must specify the Year under the options tab');
        PayrollSetup.Get(gvAllowedPayrolls."Payroll Code");
    end;

    var
        Year: Integer;
        YearRec: Record Year;
        PayrollHeader: Record "Payroll Header";
        ColumnD: Decimal;
        ColumnL: Decimal;
        PayrollSetup: Record "Payroll Setups";
        "INT/PENALTY": Decimal;
        MaleTotals: array[6] of Integer;
        LookUpLines: Record "Lookup Table Lines";
        FemaleTotals: array[6] of Integer;
        i: Integer;
        HEADER: array[6] of Text[30];
        gvAllowedPayrolls: Record "Allowed Payrolls";

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

