report 51177 "PAYE Supporting List"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/PAYE Supporting List.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("Global Dimension 1 Code") ORDER(Ascending);
            column(PayrollSetupEmployerPINNo; PayrollSetup."Employer PIN No.")
            {
            }
            column(EMPLOYERSNAMEPayrollSetupEmployerName; 'EMPLOYER''S NAME  ' + PayrollSetup."Employer Name")
            {
            }
            column(PayrollSetupEmployerName; PayrollSetup."Employer Name")
            {
            }
            column(Year; Year)
            {
            }
            column(EmployeeGlobalDimension1Code; Employee."Global Dimension 1 Code")
            {
            }
            column(ColumnD20; ColumnD / 20)
            {
            }
            column(ColumnL; ColumnL)
            {
            }
            column(ColumnL1; ColumnL)
            {
            }
            column(ColumnD201; ColumnD / 20)
            {
            }
            column(ColumnLINTPENALTY; ColumnL + "INT/PENALTY")
            {
            }
            column(INTPENALTY; "INT/PENALTY")
            {
            }
            column(Employee_No_; "No.")
            {
            }
            dataitem("Payroll Header"; "Payroll Header")
            {
                DataItemLink = "Employee no." = FIELD("No.");
                DataItemTableView = SORTING("Payroll ID", "Employee no.") ORDER(Ascending);
                column(ColumnL2; ColumnL)
                {
                }
                column(EmployeeFirstNameEmployeeMiddleNameEmployeeLastName; Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name")
                {
                }
                column(PinCode; PinCode)
                {
                }
                column(ColumnD202; ColumnD / 20)
                {
                }
                column(EmployeeNo; Employee."No.")
                {
                }
                column(Payroll_Header_Payroll_ID; "Payroll ID")
                {
                }
                column(Payroll_Header_Employee_no_; "Employee no.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ColumnD := ColumnD + "D (LCY)";
                    ColumnL := ColumnL + "L (LCY)";
                end;

                trigger OnPreDataItem()
                begin
                    SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                    SetRange("Payroll Year", Year);
                end;
            }

            trigger OnAfterGetRecord()
            var
                MembershipNos: Record "Membership Numbers";
            begin
                ColumnD := 0;
                ColumnL := 0;

                PayrollSetup.Get;
                PayeED := PayrollSetup."PAYE ED Code";
                MembershipNos.Get(Employee."No.", PayeED);
                PinCode := MembershipNos."Membership Number";
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
        if Year = 0 then Error('You must specify the Year on the options tab.');
        gsSegmentPayrollData;
    end;

    var
        Year: Integer;
        YearRec: Record Year;
        PayrollHeader: Record "Payroll Header";
        ColumnD: Decimal;
        ColumnL: Decimal;
        PayrollSetup: Record "Payroll Setups";
        "INT/PENALTY": Decimal;
        PinCode: Code[20];
        PayeED: Code[20];
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

