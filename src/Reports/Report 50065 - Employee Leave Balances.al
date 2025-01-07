report 50065 "Employee Leave Balances"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Employee Leave Balances.rdl';

    dataset
    {
        dataitem("Employee Leave Type"; "Employee Leave Type")
        {
            RequestFilterFields = "Employee No.", "Leave Type", "Leave Balance", "Current Period";
            column(EmployeeNo; "Employee Leave Type"."Employee No.")
            {
            }
            column(Firstname; Firstname)
            {
            }
            column(Middlename; Middlename)
            {
            }
            column(Lastname; Lastname)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(LeaveType; "Employee Leave Type"."Leave Type")
            {
            }
            column(LeaveBalance; "Employee Leave Type"."Leave Balance")
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
            column(LeaveCalendar; LeaveCalendar)
            {
            }
            column(Department; Department)
            {
            }
            column(Section; Section)
            {
            }
            column(LeaveDaysTaken; LeaveDaysTaken)
            {
            }
            column(AllocationDays_EmployeeLeaveType; "Employee Leave Type"."Allocation Days")
            {
            }
            column(Dayscarryforward; Dayscarryforward)
            {
            }
            column(CurrentPeriod_EmployeeLeaveType; "Employee Leave Type"."Current Period")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Firstname := '';
                Middlename := '';
                Lastname := '';
                EmployeeName := '';

                Employee.Reset;
                Employee.SetRange(Employee."No.", "Employee No.");
                if Employee.FindFirst then begin
                    Firstname := Employee."First Name";
                    Middlename := Employee."Middle Name";
                    Lastname := Employee."Last Name";
                    EmployeeName := Firstname + ' ' + Middlename + ' ' + Lastname;
                    LeaveCalendar := Employee."Leave Calendar";
                    Department := Employee."Global Dimension 1 Code";
                    Section := Employee."Global Dimension 2 Code";
                end;
                LeaveDaysTaken := 0;
                Dayscarryforward := 0;
                EmployeeLeaveLedger.SetRange("Employee No.", "Employee Leave Type"."Employee No.");
                EmployeeLeaveLedger.SetRange("Entry Type", EmployeeLeaveLedger."Entry Type"::"Negative Adjustment");
                EmployeeLeaveLedger.SetRange("Leave Type", "Employee Leave Type"."Leave Type");
                EmployeeLeaveLedger.SetRange("Leave Period", "Employee Leave Type"."Current Period");

                if EmployeeLeaveLedger.FindSet then begin
                    repeat
                        LeaveDaysTaken := LeaveDaysTaken + EmployeeLeaveLedger.Days;
                        LeaveDaysTaken := EmployeeLeaveLedger.Days;



                        if EmployeeLeaveLedger."Entry Type" = EmployeeLeaveLedger."Entry Type"::"Carry forward" then
                            Dayscarryforward := Dayscarryforward + EmployeeLeaveLedger.Days;

                    until EmployeeLeaveLedger.Next = 0;
                end;
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        Employee: Record Employee;
        Firstname: Text;
        Middlename: Text;
        Lastname: Text;
        EmployeeName: Text;
        EmployeeCategory: Code[30];
        LeaveCalendar: Code[30];
        Department: Code[50];
        Section: Code[50];
        LeaveDaysTaken: Decimal;
        EmployeeLeaveLedger: Record "HR Leave Ledger Entries";
        Dayscarryforward: Integer;
}

