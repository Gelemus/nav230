report 50713 "Employee  Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Employee  Details.rdl';

    dataset
    {
        dataitem("HR Leave Ledger Entries"; "HR Leave Ledger Entries")
        {
            column(LineNo_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Line No.")
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
            column(HRLocation_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."HR Location")
            {
            }
            column(HRDepartment_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."HR Department")
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
            column(GlobalDimension1Code_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Global Dimension 2 Code")
            {
            }
            column(ShortcutDimension3Code_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Shortcut Dimension 4 Code")
            {
            }
            column(ShortcutDimension5Code_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Shortcut Dimension 5 Code")
            {
            }
            column(ShortcutDimension6Code_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Shortcut Dimension 6 Code")
            {
            }
            column(ShortcutDimension7Code_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Shortcut Dimension 7 Code")
            {
            }
            column(ShortcutDimension8Code_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Shortcut Dimension 8 Code")
            {
            }
            column(ResponsibilityCenter_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Responsibility Center")
            {
            }
            column(UserID_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."User ID")
            {
            }
            column(NoSeries_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."No. Series")
            {
            }
            column(LeaveYear_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Leave Year")
            {
            }
            column(LeaveAllocation_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Leave Allocation")
            {
            }
            column(Days2_HRLeaveLedgerEntries; "HR Leave Ledger Entries".Days2)
            {
            }
            column(LeaveYear2_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Leave Year 2")
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

            trigger OnAfterGetRecord()
            begin
                Firstname := '';
                Middlename := '';
                Lastname := '';
                EmployeeName := '';

                Employee.Reset;
                Employee.SetRange(Employee."No.", "HR Leave Ledger Entries"."Employee No.");
                if Employee.FindFirst then begin
                    Firstname := Employee."First Name";
                    Middlename := Employee."Middle Name";
                    Lastname := Employee."Last Name";
                    EmployeeName := Firstname + ' ' + Middlename + ' ' + Lastname;
                    LeaveCalendar := Employee."Leave Calendar";
                    Department := Employee."Global Dimension 1 Code";
                    Section := Employee."Global Dimension 2 Code";
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

