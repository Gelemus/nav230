report 50070 "HR Leave Applications List"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/HR Leave Applications List.rdl';

    dataset
    {
        dataitem("HR Leave Application"; "HR Leave Application")
        {
            RequestFilterFields = Status, "Leave Type";
            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_Address; CI.Address)
            {
            }
            column(CI__Address; CI."Address 2")
            {
            }
            column(CI_City; CI.City)
            {
            }
            column(Country; CI."Country/Region Code")
            {
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
            }
            column(CI_TelephoneNo; CI."Telephone No.")
            {
            }
            column(CI_Email; CI."E-Mail")
            {
            }
            column(CI_Website; CI."Home Page")
            {
            }
            column(CI_Vision; Text0001)
            {
            }
            column(Lno; Lno)
            {
            }
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
            column(LeaveStartDate_HRLeaveApplication; "HR Leave Application"."Leave Start Date")
            {
            }
            column(DaysApplied_HRLeaveApplication; "HR Leave Application"."Days Applied")
            {
            }
            column(DaysApproved_HRLeaveApplication; "HR Leave Application"."Days Approved")
            {
            }
            column(LeaveEndDate_HRLeaveApplication; "HR Leave Application"."Leave End Date")
            {
            }
            column(LeaveReturnDate_HRLeaveApplication; "HR Leave Application"."Leave Return Date")
            {
            }
            column(SubstituteNo_HRLeaveApplication; "HR Leave Application"."Substitute No.")
            {
            }
            column(SubstituteName_HRLeaveApplication; "HR Leave Application"."Substitute Name")
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
            column(ShortcutDimension4Code_HRLeaveApplication; "HR Leave Application"."Shortcut Dimension 4 Code")
            {
            }
            column(ShortcutDimension5Code_HRLeaveApplication; "HR Leave Application"."Shortcut Dimension 5 Code")
            {
            }
            column(ShortcutDimension6Code_HRLeaveApplication; "HR Leave Application"."Shortcut Dimension 6 Code")
            {
            }
            column(ShortcutDimension7Code_HRLeaveApplication; "HR Leave Application"."Shortcut Dimension 7 Code")
            {
            }
            column(ShortcutDimension8Code_HRLeaveApplication; "HR Leave Application"."Shortcut Dimension 8 Code")
            {
            }
            column(ResponsibilityCenter_HRLeaveApplication; "HR Leave Application"."Responsibility Center")
            {
            }
            column(Status_HRLeaveApplication; "HR Leave Application".Status)
            {
            }
            column(Posted_HRLeaveApplication; "HR Leave Application".Posted)
            {
            }
            column(PostedBy_HRLeaveApplication; "HR Leave Application"."Posted By")
            {
            }
            column(DatePosted_HRLeaveApplication; "HR Leave Application"."Date Posted")
            {
            }
            column(TimePosted_HRLeaveApplication; "HR Leave Application"."Time Posted")
            {
            }
            column(UserID_HRLeaveApplication; "HR Leave Application"."User ID")
            {
            }
            column(NoSeries_HRLeaveApplication; "HR Leave Application"."No. Series")
            {
            }
            column(IncomingDocumentEntryNo_HRLeaveApplication; "HR Leave Application"."Incoming Document Entry No.")
            {
            }
            column(EmployeeCategory_HRLeaveApplication; "HR Leave Application"."Emplymt. Contract Code")
            {
            }
            column(ApprovedByName_HRLeaveApplication; "HR Leave Application"."Approved By Name")
            {
            }
            column(RequestLeaveAllowance_HRLeaveApplication; "HR Leave Application"."Request Leave Allowance")
            {
            }
            column(LeaveAllowanceAmount_HRLeaveApplication; "HR Leave Application"."Leave Allowance Amount")
            {
            }
            column(DetailsofExamination_HRLeaveApplication; "HR Leave Application"."Details of Examination")
            {
            }
            column(DateofExam_HRLeaveApplication; "HR Leave Application"."Date of Exam")
            {
            }
            column(SupervisorName_HRLeaveApplication; "HR Leave Application"."Supervisor Name")
            {
            }
            column(EmailAddress_HRLeaveApplication; "HR Leave Application"."E-mail Address")
            {
            }
            column(CellPhoneNumber_HRLeaveApplication; "HR Leave Application"."Cell Phone Number")
            {
            }
            column(CummAllocatedLeaveDays_HRLeaveApplication; "HR Leave Application"."Cumm. Allocated Leave Days")
            {
            }
            column(AllocatedDays_HRLeaveApplication; "HR Leave Application"."Allocated Days")
            {
            }
            column(LeaveDaysTaken_HRLeaveApplication; "HR Leave Application"."Leave Days Taken")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Lno := Lno + 1;
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

    trigger OnInitReport()
    begin
        CI.Get;
        CI.CalcFields(Picture);
    end;

    var
        CI: Record "Company Information";
        Lno: Integer;
        Text0001: Label '"Turning Ideas Into Wealth"';
}

