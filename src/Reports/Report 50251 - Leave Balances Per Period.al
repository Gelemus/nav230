report 50251 "Leave Balances Per Period"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Leave Balances Per Period.rdl';

    dataset
    {
        dataitem("HR Leave Ledger Entries"; "HR Leave Ledger Entries")
        {
            RequestFilterFields = "Employee No.", "Leave Type";
            column(EmployeeName; EmployeeName)
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
            column(PeriodDate; PeriodDate)
            {
            }
            column(LeaveCalendar; LeaveCalendar)
            {
            }
            column(DocumentNo_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Document No.")
            {
            }
            column(PostingDate_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Posting Date")
            {
            }
            column(EntryType_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Entry Type")
            {
            }
            column(EmployeeNo_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Employee No.")
            {
            }
            column(LeaveType_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Leave Type")
            {
            }
            column(LeavePeriod_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Leave Period")
            {
            }
            column(Days_HRLeaveLedgerEntries; "HR Leave Ledger Entries".Days)
            {
            }
            column(LeaveStartDate_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Leave Start Date")
            {
            }
            column(LeaveEndDate_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Leave End Date")
            {
            }
            column(Description_HRLeaveLedgerEntries; "HR Leave Ledger Entries".Description)
            {
            }
            column(UserID_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."User ID")
            {
            }
            column(LeaveYear_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Leave Year")
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Firstname := '';
                Middlename := '';
                Lastname := '';
                EmployeeName := '';
                if EmployeeR.Get("HR Leave Ledger Entries"."Employee No.") then begin
                    Firstname := EmployeeR."First Name";
                    Middlename := EmployeeR."Middle Name";
                    Lastname := EmployeeR."Last Name";
                    EmployeeName := Firstname + ' ' + Middlename + ' ' + Lastname;
                    PeriodDate := "HR Leave Ledger Entries"."Posting Date";
                end;

                SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                StartDate := "HR Leave Ledger Entries".GetRangeMin("Posting Date");
                EndDate := "HR Leave Ledger Entries".GetRangeMax("Posting Date");
                if "HR Leave Ledger Entries".Days = 0 then
                    CurrReport.Skip;
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
                    field("Start Date"; StartDate)
                    {
                        Caption = 'Start Date';
                        Enabled = false;
                    }
                    field("End Date"; EndDate)
                    {
                        Caption = 'End Date';
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

        if /*(StartDate=0D) OR*/ (EndDate = 0D) then
            Error('Please Input Date Filters');

        if "HR Leave Ledger Entries"."Leave Type" = '' then
            ERROR('Please Specify Leave Type');

        //Periodfilter:=FORMAT(StartDate)+'..'+FORMAT(EndDate);
        //IF PeriodDate=0D THEN ERROR('Please Input Date Filter');

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

