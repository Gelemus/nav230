report 51178 "Lump Sum Payment Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Lump Sum Payment Details.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            column(FORMATTODAY04; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CurrReportPAGENO; CurrReport.PageNo)
            {
            }
            column(USERID_Employee; UserId)
            {
            }
            column(No_Employee; "No.")
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(TerminationDate_Employee; "Termination Date")
            {
            }
            dataitem("Payroll Header"; "Payroll Header")
            {
                DataItemLink = "Employee no." = FIELD("No.");
                DataItemTableView = SORTING("Employee no.", "Payroll Year", "Payroll Month") ORDER(Ascending);
                PrintOnlyIfDetail = true;
                RequestFilterFields = "Payroll Year";
                column(Payroll_Header_Payroll_ID; "Payroll ID")
                {
                }
                column(Payroll_Header_Employee_no_; "Employee no.")
                {
                }
                dataitem("Lump Sum Payments"; "Payroll Lines")
                {
                    DataItemLink = "Payroll ID" = FIELD("Payroll ID"), "Employee No." = FIELD("Employee no.");
                    DataItemTableView = SORTING("Payroll ID", "Employee No.", "Calculation Group", "ED Code", Rounding) ORDER(Ascending) WHERE("LumpSum Line" = CONST(true), "Calculation Group" = CONST(Payments));
                    column(EDCode_LumpSumPayments; "ED Code")
                    {
                    }
                    column(Text_LumpSumPayments; Text)
                    {
                    }
                    column(Amount_LumpSumPayments; Amount)
                    {
                    }
                    column(Amount_LumpSumPayments1; Amount)
                    {
                    }
                    column(Lump_Sum_Payments_Entry_No_; "Entry No.")
                    {
                    }
                    column(Lump_Sum_Payments_Payroll_ID; "Payroll ID")
                    {
                    }
                    column(Lump_Sum_Payments_Employee_No_; "Employee No.")
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                    end;
                }
                dataitem("Tax Deducted"; "Payroll Lines")
                {
                    DataItemLink = "Payroll ID" = FIELD("Payroll ID"), "Employee No." = FIELD("Employee no.");
                    DataItemTableView = SORTING("Payroll ID", "Employee No.", "Calculation Group", "ED Code", Rounding) ORDER(Ascending) WHERE("LumpSum Line" = CONST(true), "Calculation Group" = CONST(Deduction));
                    column(Amount_TaxDeducted; Amount)
                    {
                    }
                    column(Text_TaxDeducted; Text)
                    {
                    }
                    column(EDCode_TaxDeducted; "ED Code")
                    {
                    }
                    column(GEPALumpSum_TaxDeducted; "GE PA Lump Sum")
                    {
                    }
                    column(PAYEEarlierPaidLumpSum_TaxDeducted; "PAYE Earlier Paid Lump Sum")
                    {
                    }
                    column(Amount_TaxDeducted1; Amount)
                    {
                    }
                    column(Tax_Deducted_Entry_No_; "Entry No.")
                    {
                    }
                    column(Tax_Deducted_Payroll_ID; "Payroll ID")
                    {
                    }
                    column(Tax_Deducted_Employee_No_; "Employee No.")
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                    end;
                }

                trigger OnPreDataItem()
                begin
                    SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                EmployeeName := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
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
        EmployeeName: Text[50];
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

