report 50250 "Employee Leave Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Employee Leave Summary.rdl';

    dataset
    {
        dataitem("Employee Leave Type"; "Employee Leave Type")
        {
            RequestFilterFields = "Employee No.", "Leave Type", "Leave Balance";
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
            column(BalanceBroughtForward; BalanceBroughtForward)
            {
            }
            column(LeaveAccrued; LeaveAccrued)
            {
            }
            column(LeaveTaken; LeaveTaken)
            {
            }
            column(BalanceCarryForward; BalanceCarryForward)
            {
            }
            column(PeriodDate; PeriodDate)
            {
            }
            column(LeaveBalance_EmployeeLeaveType; BalanceCarryForward)
            {
            }
            column(AllocationDays_EmployeeLeaveType; "Employee Leave Type"."Allocation Days")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Firstname := '';
                Middlename := '';
                Lastname := '';
                EmployeeName := 'TT';
                BalanceBroughtForward := 0;
                BalanceCarryForward := 0;
                LeaveTaken := 0;
                LeaveAccrued := 0;

                if EmployeeR.Get("Employee Leave Type"."Employee No.") then begin
                    Firstname := EmployeeR."First Name";
                    Middlename := EmployeeR."Middle Name";
                    Lastname := EmployeeR."Last Name";
                    EmployeeName := Firstname + ' ' + Middlename + ' ' + Lastname;
                    LeaveCalendar := EmployeeR."Leave Calendar";

                    HRLeaveLedgerEntries.Reset;
                    HRLeaveLedgerEntries.SetRange("Employee No.", EmployeeR."No.");
                    HRLeaveLedgerEntries.SetRange("Leave Type", "Employee Leave Type"."Leave Type");
                    HRLeaveLedgerEntries.SetRange("Leave Period", "Employee Leave Type"."Current Period");
                    HRLeaveLedgerEntries.SetFilter("Posting Date", '<%1', CalcDate('-CM', PeriodDate));
                    if HRLeaveLedgerEntries.FindSet then
                        repeat
                            BalanceBroughtForward += HRLeaveLedgerEntries.Days;
                        //MESSAGE('%1',HRLeaveLedgerEntries.Days);
                        until HRLeaveLedgerEntries.Next = 0;

                    HRLeaveLedgerEntries.Reset;
                    HRLeaveLedgerEntries.SetRange("Employee No.", EmployeeR."No.");
                    HRLeaveLedgerEntries.SetRange("Leave Type", "Employee Leave Type"."Leave Type");
                    HRLeaveLedgerEntries.SetFilter("Posting Date", '%1..%2', CalcDate('-CM', PeriodDate), CalcDate('CM', PeriodDate));
                    if HRLeaveLedgerEntries.FindSet then
                        repeat begin
                            if HRLeaveLedgerEntries.Days > 0 then
                                LeaveAccrued += HRLeaveLedgerEntries.Days
                            else if HRLeaveLedgerEntries.Days < 0 then
                                LeaveTaken += HRLeaveLedgerEntries.Days;
                        end
                        until HRLeaveLedgerEntries.Next = 0;
                    LeaveAccrued := LeaveAccrued + BalanceBroughtForward;
                    BalanceCarryForward := LeaveAccrued + LeaveTaken;

                end
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field(Date; PeriodDate)
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);

        //IF (StartDate=0D) OR (EndDate=0D) THEN
        //ERROR('Please Input Date Filters');



        //Periodfilter:=FORMAT(StartDate)+'..'+FORMAT(EndDate);
        if PeriodDate = 0D then Error('Please Input Date Filter');
    end;

    var
        CompanyInfo: Record "Company Information";
        EmployeeREC: Record Employee;
        Firstname: Text;
        Middlename: Text;
        Lastname: Text;
        EmployeeName: Text;
        EmployeeCategory: Code[30];
        LeaveCalendar: Code[30];
        EmpNO: Code[30];
        EmployeeR: Record Employee;
        PeriodDate: Date;
        HRLeaveLedgerEntries: Record "HR Leave Ledger Entries";
        HRLeaveLedgerEntries1: Record "HR Leave Ledger Entries";
        HRLeaveLedgerEntries2: Record "HR Leave Ledger Entries";
        BalanceBroughtForward: Decimal;
        LeaveAccrued: Decimal;
        LeaveTaken: Decimal;
        BalanceCarryForward: Decimal;
        StartDate: Date;
        EndDate: Date;
        Periodfilter: Text;
}

