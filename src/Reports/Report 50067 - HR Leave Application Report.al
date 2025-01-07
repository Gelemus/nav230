report 50067 "HR Leave Application Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/HR Leave Application Report.rdl';

    dataset
    {
        dataitem("HR Leave Application"; "HR Leave Application")
        {
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Document Number';
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
            column(COMPANYNAME; CompanyName)
            {
            }
            column(EmployeeNo_HRLeaveApplication; "Employee No.")
            {
                IncludeCaption = true;
            }
            column(ApprovedBy; "HR Leave Application"."Approved By Name")
            {
            }
            column(EmpName; "HR Leave Application"."Employee Name")
            {
            }
            column(DaysApplied_HRLeaveApplication; "Days Applied")
            {
                IncludeCaption = true;
            }
            column(ApplicationCode_HRLeaveApplication; "HR Leave Application"."No.")
            {
                IncludeCaption = true;
            }
            column(RequestLeaveAllowance_HRLeaveApplication; "Request Leave Allowance")
            {
                IncludeCaption = true;
            }
            column(LeaveAllowanceAmount_HRLeaveApplication; "Leave Allowance Amount")
            {
                IncludeCaption = true;
            }
            column(NumberofPreviousAttempts_HRLeaveApplication; "Request Leave Allowance")
            {
                IncludeCaption = true;
            }
            column(DetailsofExamination_HRLeaveApplication; "Details of Examination")
            {
                IncludeCaption = true;
            }
            column(DateofExam_HRLeavseApplication; "Date of Exam")
            {
                IncludeCaption = true;
            }
            column(Reliever_HRLeaveApplication; "HR Leave Application"."Substitute No.")
            {
                IncludeCaption = true;
            }
            column(RelieverName_HRLeaveApplication; "HR Leave Application"."Substitute Name")
            {
                IncludeCaption = true;
            }
            column(Supervisor; "HR Leave Application"."Supervisor Name")
            {
            }
            column(StartDate_HRLeaveApplication; "Leave Start Date")
            {
                IncludeCaption = true;
            }
            column(EndDate; "HR Leave Application"."Leave End Date")
            {
            }
            column(ReturnDate_HRLeaveApplication; "HR Leave Application"."Leave Return Date")
            {
                IncludeCaption = true;
            }
            column(LeaveType_HRLeaveApplication; "HR Leave Application"."Leave Type")
            {
                IncludeCaption = true;
            }
            column(LeavPeriod; "HR Leave Application"."Leave Period")
            {
            }
            column(JobTittle_HRLeaveApplication; "HR Leave Application"."Emplymt. Contract Code")
            {
                IncludeCaption = true;
            }
            column(ApplicationDate_HRLeaveApplication; "HR Leave Application"."Leave Start Date")
            {
                IncludeCaption = true;
            }
            column(EmailAddress_HRLeaveApplication; "E-mail Address")
            {
                IncludeCaption = true;
            }
            column(CellPhoneNumber_HRLeaveApplication; "Cell Phone Number")
            {
                IncludeCaption = true;
            }
            column(Approveddays_HRLeaveApplication; "HR Leave Application"."Days Approved")
            {
            }
            column(CummLDays; "HR Leave Application"."Cumm. Allocated Leave Days")
            {
            }
            column(AllocatedDays; "HR Leave Application"."Allocated Days")
            {
            }
            column(LDaysTaken; "HR Leave Application"."Leave Days Taken")
            {
            }
            column(Remainingdays; "HR Leave Application"."Leave Balance")
            {
            }
            column(LeaveDaysCarriedfwd; LeaveDaysCarriedfwd)
            {
            }
            column(LeaveCarryOver_HRLeaveApplication; "HR Leave Application"."Leave Carry Over")
            {
            }
            dataitem(Employee; Employee)
            {
                DataItemLink = "No." = FIELD("Employee No.");
                column(EmpNo; Employee."No.")
                {
                }
                column(LeaveTaken; Employee."Total Leave Taken")
                {
                }
                column(LeaveDaysRema; Employee."Leave Balance")
                {
                }
                column(AllocLeavDays; Employee."Allocated Leave Days")
                {
                }
                column(JobTitle_Employee; Employee."Job Title")
                {
                }
                column(EMail_Employee; Employee."E-Mail")
                {
                }
                column(MobilePhoneNo_Employee; Employee."Mobile Phone No.")
                {
                }
                column(EmployementCategory_Employee; Employee."Age-d")
                {
                }
                column(AllocatedLeaveDays_Employee; Employee."Allocated Leave Days")
                {
                }
                column(LeaveBalance_Employee; Employee."Leave Balance")
                {
                }
            }
            dataitem("Approval Comment Line"; "Approval Comment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.") ORDER(Ascending);
                column(ApprovedDays_ApprovalCommentLine; "Approval Comment Line"."Approved Days")
                {
                    IncludeCaption = true;
                }
                column(ApprovedStartDate_ApprovalCommentLine; "Approval Comment Line"."Approved Start Date")
                {
                    IncludeCaption = true;
                }
                column(ApprovedReturnDate_ApprovalCommentLine; "Approval Comment Line"."Approved Return Date")
                {
                    IncludeCaption = true;
                }
                column(Reason_ApprovalCommentLine; "Approval Comment Line".Reason)
                {
                    IncludeCaption = true;
                }
                column(LeaveAllowanceGranted_ApprovalCommentLine; "Approval Comment Line"."Leave allowance Granted")
                {
                    IncludeCaption = true;
                }
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Status = FILTER(<> Canceled));
                column(SequenceNo; "Approval Entry"."Sequence No.")
                {
                }
                column(LastDateTimeModified; "Approval Entry"."Last Date-Time Modified")
                {
                }
                column(ApproverID; "Approval Entry"."Approver ID")
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(SenderID; "Approval Entry"."Sender ID")
                {
                }
                column(ShowPreparedBy_; ShowPreparedBy)
                {
                }
                column(ApprovedByCaption_; ApprovedByCaption)
                {
                }
                column(PreparedByCaption_; PreparedByCaption)
                {
                }
                column(PreparedDate; PreparedDate)
                {
                }
                column(UserSetupRec_SignatureI_; UserSetupRecI.Signature)
                {
                }
                column(UserSetupRec_Signature_; UserSetupRec.Signature)
                {
                }
                dataitem(Employee2; Employee)
                {
                    DataItemLink = "User ID" = FIELD("Approver ID");
                    column(FirstName_Employee; Employee2."First Name")
                    {
                    }
                    column(MiddleName_Employee; Employee2."Middle Name")
                    {
                    }
                    column(LastName_Employee; Employee2."Last Name")
                    {
                    }
                    column(EmployeeSignature; Employee2."Employee Signature")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    i := i + 1;
                    if i = 1 then begin
                        ShowPreparedBy := true;
                        PreparedDate := "Approval Entry"."Date-Time Sent for Approval";
                        EmployeeRecI.Reset;
                        EmployeeRecI.SetRange("User ID", "Approval Entry"."Sender ID");
                        if EmployeeRecI.FindFirst then begin
                            PreparedByCaption := 'Applicant: ' + ' ' + EmployeeRecI."First Name" + ' ' + EmployeeRecI."Last Name";

                        end;
                        UserSetupRec.Reset;

                        UserSetupRecI.SetRange("User ID", "Approval Entry"."Sender ID");
                        if UserSetupRecI.FindFirst then
                            UserSetupRecI.CalcFields(Signature);

                        ApprovedByCaption := 'Approved By: ';

                        UserSetupRec.Reset;

                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);

                    end
                    else
                        ShowPreparedBy := false;
                    if i = 2 then begin
                        ApprovedByCaption := 'Approved By: ';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end
                    else if i = 3 then begin
                        ApprovedByCaption := 'Approved By: ';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                HrEmp.Reset;
                HrEmp.SetRange(HrEmp."No.", "HR Leave Application"."Employee No.");
                if HrEmp.Get('-') then begin
                    EmpNo := HrEmp."No.";
                    LTaken := HrEmp."Total Leave Taken";
                    LBal := HrEmp."Leave Balance";
                    Lper := HrEmp."Leave Period Filter";
                end;

                //LeaveDaysCarriedfwd:="HR Leave Application"."Leave Balance"-"HR Leave Application"."Days Applied";
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
        CI.Get;
        CI.CalcFields(CI.Picture);
    end;

    var
        CI: Record "Company Information";
        HrEmp: Record Employee;
        EmpNo: Code[10];
        LTaken: Decimal;
        LBal: Decimal;
        Lper: Text;
        LAllocation: Decimal;
        SName: Text;
        leaveApp: Page "Leave Application Card";
        LeaveDaysCarriedfwd: Integer;
        Text0001: Label '"Empowered Healthy Communities"';
        Approver1: Code[20];
        i: Integer;
        ShowPreparedBy: Boolean;
        PreparedByCaption: Text;
        ApprovedByCaption: Text;
        UserSetupRec: Record "User Setup";
        UserSetupRecI: Record "User Setup";
        PreparedDate: DateTime;
        EmployeeRecI: Record Employee;
}

