report 52352 "Employees On Leave As At Today"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Employees On Leave As At Today.rdl';

    dataset
    {
        dataitem("HR Leave Application"; "HR Leave Application")
        {
            RequestFilterFields = "Leave Type", "Global Dimension 1 Code", "Global Dimension 2 Code";
            column(No_HRLeaveApplication; "HR Leave Application"."No.")
            {
            }
            column(DocumentDate_HRLeaveApplication; "HR Leave Application"."Document Date")
            {
            }
            column(PostingDate_HRLeaveApplication; "HR Leave Application"."Posting Date")
            {
            }
            column(EmployeeNo_HRLeaveApplication; "HR Leave Application"."Employee No.")
            {
            }
            column(EmployeeName_HRLeaveApplication; "HR Leave Application"."Employee Name")
            {
            }
            column(LeaveType_HRLeaveApplication; "HR Leave Application"."Leave Type")
            {
            }
            column(LeavePeriod_HRLeaveApplication; "HR Leave Application"."Leave Period")
            {
            }
            column(LeaveBalance_HRLeaveApplication; "HR Leave Application"."Leave Balance")
            {
            }
            column(LeaveStartDate_HRLeaveApplication; Format("HR Leave Application"."Leave Start Date"))
            {
            }
            column(DaysApplied_HRLeaveApplication; "HR Leave Application"."Days Applied")
            {
            }
            column(DaysApproved_HRLeaveApplication; "HR Leave Application"."Days Approved")
            {
            }
            column(LeaveEndDate_HRLeaveApplication; Format("HR Leave Application"."Leave End Date"))
            {
            }
            column(LeaveReturnDate_HRLeaveApplication; Format("HR Leave Application"."Leave Return Date"))
            {
            }
            column(RelieverNo_HRLeaveApplication; "HR Leave Application"."Substitute No.")
            {
            }
            column(RelieverName_HRLeaveApplication; "HR Leave Application"."Substitute Name")
            {
            }
            column(Designation_HRLeaveApplication; "HR Leave Application"."Position Title")
            {
            }
            column(ReasonforLeave_HRLeaveApplication; "HR Leave Application"."Reason for Leave")
            {
            }
            column(GlobalDimension1Code_HRLeaveApplication; "HR Leave Application"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_HRLeaveApplication; "HR Leave Application"."Global Dimension 2 Code")
            {
            }
            column(ShortcutDimension3Code_HRLeaveApplication; "HR Leave Application"."Shortcut Dimension 3 Code")
            {
            }
            column(Status_HRLeaveApplication; "HR Leave Application".Status)
            {
            }
            column(Posted_HRLeaveApplication; "HR Leave Application".Posted)
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
            column(Periodfilter; Periodfilter)
            {
            }
            dataitem("HR Leave Ledger Entries"; "HR Leave Ledger Entries")
            {
                DataItemLink = "Employee No." = FIELD("Employee No.");
                RequestFilterFields = "Entry Type";
            }

            trigger OnPreDataItem()
            begin
                SetFilter("HR Leave Application"."Leave Start Date", '<0D', StartDate);
                SetFilter("HR Leave Application"."Leave End Date", '>0D', EndDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; StartDate)
                {
                }
                field("End Date"; EndDate)
                {
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

        if (StartDate = 0D) or (EndDate = 0D) then
            Error('Please Input Date Filters');
        Periodfilter := Format(StartDate) + '..' + Format(EndDate);
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
        StartDate: Date;
        EndDate: Date;
        Periodfilter: Text;
}

