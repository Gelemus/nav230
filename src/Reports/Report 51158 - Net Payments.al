report 51158 "Net Payments"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Net Payments.rdl';
    UseRequestPage = true;

    dataset
    {
        dataitem(Periods; Periods)
        {
            DataItemTableView = SORTING("Start Date") WHERE(Status = FILTER(Open | Posted));
            RequestFilterFields = "Period ID";
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(TitleText; TitleText)
            {
            }
            column(Description_______; Description + ' :')
            {
            }
            column(Periods_Status; Status)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Amount__LCY_Caption; Amount__LCY_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Total_Deduction__LCY_Caption; Total_Deduction__LCY_CaptionLbl)
            {
            }
            column(Total_Payable__LCY_Caption; Total_Payable__LCY_CaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
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
            dataitem(Employee; Employee)
            {
                RequestFilterFields = "No.", "Mode of Payment", Status;
                column(Employee_No_; "No.")
                {
                }
                column(BankBranchCode_Employee; Employee."Bank Branch Name")
                {
                }
                column(BankCode_Employee; Employee."Bank Code")
                {
                }
                column(BankAccountNo_Employee; Employee."Bank Account No")
                {
                }
                dataitem("Payroll Header"; "Payroll Header")
                {
                    DataItemLink = "Employee no." = FIELD("No.");
                    DataItemTableView = SORTING("Payroll ID", "Employee no.");
                    column(Amount; Amount)
                    {
                    }
                    column(Payroll_Header__Employee_no__; "Employee no.")
                    {
                    }
                    column(Payroll_Header__Total_Payable__LCY__; "Total Payable (LCY)")
                    {
                    }
                    column(Payroll_Header__Total_Deduction__LCY__; "Total Deduction (LCY)")
                    {
                    }
                    column(Name; Name)
                    {
                    }
                    column(Payroll_Header_Payroll_ID; "Payroll ID")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        "Payroll Header".CalcFields("Total Payable (LCY)", "Total Deduction (LCY)");
                        Amount := "Payroll Header"."Total Payable (LCY)" - "Payroll Header"."Total Deduction (LCY)";

                        "Payroll Header".CalcFields("Total Payable (LCY)", "Total Deduction (LCY)", "Total Rounding Pmts (LCY)",
                          "Total Rounding Ded (LCY)");
                        Amount := "Payroll Header"."Total Payable (LCY)" + "Payroll Header"."Total Rounding Pmts (LCY)" -
                                  ("Payroll Header"."Total Deduction (LCY)" + "Payroll Header"."Total Rounding Ded (LCY)");

                        if Amount < 0 then
                            if not OverdrawnOnly then
                                CurrReport.Skip
                            else
                                TotalAmount := TotalAmount + Amount
                        else if OverdrawnOnly then
                            CurrReport.Skip
                        else
                            TotalAmount := TotalAmount + Amount;

                        EmpCount := EmpCount + 1;

                        TotalPayable := TotalPayable + "Payroll Header"."Total Payable (LCY)";
                        TotalDeduction := TotalDeduction + "Payroll Header"."Total Deduction (LCY)";
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetRange("Payroll ID", Periods."Period ID");
                        SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    Name := Employee.FullName;
                end;

                trigger OnPreDataItem()
                begin
                    SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number);
                MaxIteration = 1;
                column(TotalAmount; TotalAmount)
                {
                }
                column(Total_Employees____FORMAT_EmpCount_; 'Total Employees ' + Format(EmpCount))
                {
                }
                column(TotalPayable; TotalPayable)
                {
                }
                column(TotalDeduction; TotalDeduction)
                {
                }
                column(Integer_Number; Number)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                TitleText := 'Net Payments For ' + Periods.Description;
                TotalAmount := 0;
                TotalPayable := 0;
                TotalDeduction := 0;
                EmpCount := 0;
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
                    field("Print only Over drawn"; OverdrawnOnly)
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
        Name: Text[60];
        Amount: Decimal;
        TotalAmount: Decimal;
        PayableAmount: Decimal;
        DeductionAmount: Decimal;
        TitleText: Text[60];
        OverdrawnOnly: Boolean;
        EmpCount: Integer;
        TotalPayable: Decimal;
        TotalDeduction: Decimal;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Amount__LCY_CaptionLbl: Label 'Amount (LCY)';
        NameCaptionLbl: Label 'Name';
        Total_Deduction__LCY_CaptionLbl: Label 'Total Deduction (LCY)';
        Total_Payable__LCY_CaptionLbl: Label 'Total Payable (LCY)';
        No_CaptionLbl: Label 'No.';

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

