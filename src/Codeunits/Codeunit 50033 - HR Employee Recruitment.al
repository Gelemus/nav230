codeunit 50033 "HR Employee Recruitment"
{

    trigger OnRun()
    begin
    end;

    var
        ProgressWindow: Dialog;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HRSetup: Record "Human Resources Setup";
        // SMTPMail: Codeunit "SMTP Mail";
        // SMTP: Record "SMTP Mail Setup";
        Txt070: Label 'Close requisition No.?';
        HREmployeeRefereeDetails: Record "HR Employee Referee Details";
        HRApplicantRefereeDetails: Record "HR Applicant Referee Details";
        HRJobs: Record "HR Jobs";
        LineNo: Integer;
        Text100: Label 'Employee Created Successfully. Employee assigned number is %1';
        HRJobApplicantQualification: Record "HR Job Applicant Qualification";
        EmployeeQualification: Record "Employee Qualification";
        Successemail: Label 'Emails successfully Sent!';
        "Purchases&PayablesSetup": Record "Purchases & Payables Setup";
        BringOriginalCertsTestimonialsMessage: Label '. Please bring your original academic and professional certificates and testimonials.';
        HREmployeeEmploymentHist: Record "HR Employee Employment Hist.";
        HRApplicantEmploymentHist: Record "HR Applicant Employment Hist";

    procedure LoadApplicantsToInterviewPannel(EmployeeRequisitionNo: Code[20]; JobNo: Code[20])
    var
        JobApplications: Record "HR Job Applications";
        JobApplicantResults: Record "HR Job Applicant Results";
    begin
        JobApplicantResults.Reset;
        JobApplicantResults.SetRange("Job Requistion No", EmployeeRequisitionNo);
        if JobApplicantResults.FindSet then
            JobApplicantResults.DeleteAll;

        JobApplications.Reset;
        JobApplications.SetRange("Employee Requisition No.", EmployeeRequisitionNo);
        JobApplications.SetRange(ShortListed, true);
        JobApplications.SetRange("Committee Shortlisted", true);
        JobApplications.SetRange("To be Interviewed", true);
        if JobApplications.FindSet then begin
            repeat
                JobApplicantResults.Init;
                JobApplicantResults."Job Applicant No" := JobApplications."No.";
                JobApplicantResults."Job No" := JobApplications."Job No.";
                JobApplicantResults."Job Requistion No" := JobApplications."Employee Requisition No.";
                JobApplicantResults.Surname := JobApplications.Surname;
                JobApplicantResults.Firstname := JobApplications.Firstname;
                JobApplicantResults.Middlename := JobApplications.Middlename;
                JobApplicantResults.Insert;
            until JobApplications.Next = 0;
        end;
    end;

    procedure TransferQualifiedApplicantDetailsToEmployee(JobApplications: Record "HR Job Applications")
    var
        Employees: Record Employee;
        EmployeeManagement: Codeunit "HR Employee Management";
        HRMandatoryDocChecklist: Record "HR Mandatory Doc. Checklist";
        HRApplicantEmploymentHist: Record "HR Applicant Employment Hist";
        HREmployeeEmploymentHist: Record "HR Employee Employment Hist.";
    begin
        JobApplications.TestField("Emplymt. Contract Code");
        JobApplications.TestField("National ID No.");
        JobApplications.TestField("PIN  No.");
        JobApplications.TestField("NHIF No.");
        JobApplications.TestField("NSSF No.");


        HRSetup.Get;

        Employees.Init;
        Employees."No." := NoSeriesMgt.GetNextNo(HRSetup."Employee Nos.", 0D, true);
        Employees."First Name" := JobApplications.Firstname;
        Employees."Middle Name" := JobApplications.Middlename;
        Employees."Last Name" := JobApplications.Surname;
        Employees."Birth Date" := JobApplications."Date of Birth";
        Employees.Gender := JobApplications.Gender;
        Employees."Person Living with Disability" := JobApplications."Person Living With Disability";
        Employees."Job No.-d" := JobApplications."Job No.";
        Employees."Job Grade-d" := JobApplications."Job Grade";
        Employees.Title := JobApplications."Job Title";
        HRJobs.Reset;
        HRJobs.SetRange(HRJobs."No.", JobApplications."Job No.");
        if HRJobs.FindFirst then begin
            Employees."Supervisor Job No." := HRJobs."Supervisor Job No.";
            Employees."Supervisor Job Title" := HRJobs."Supervisor Job Title";
        end;
        Employees."Emplymt. Contract Code" := JobApplications."Emplymt. Contract Code";
        Employees."HR Salary Notch" := JobApplications."HR Salary Notch";
        Employees."Global Dimension 1 Code" := JobApplications."Global Dimension 1 Code";
        Employees."Global Dimension 2 Code" := JobApplications."Global Dimension 2 Code";
        Employees."Shortcut Dimension 3 Code" := JobApplications."Shortcut Dimension 3 Code";
        Employees."Shortcut Dimension 4 Code" := JobApplications."Shortcut Dimension 4 Code";
        Employees."Marital Status-d" := JobApplications."Marital Status";
        Employees."National ID No.-d" := JobApplications."National ID No.";
        Employees."PIN No.-d" := JobApplications."PIN  No.";
        Employees."Huduma No." := JobApplications."Huduma No.";
        Employees."Passport No.-d" := JobApplications."Passport No.";
        Employees."NHIF No.-d" := JobApplications."NHIF No.";
        Employees."NSSF No.-d" := JobApplications."NSSF No.";
        Employees."Emplymt. Contract Code" := JobApplications."Emplymt. Contract Code";
        Employees."Post Code" := JobApplications."Post Code";
        Employees.City := JobApplications."City/Town";
        Employees."County Code" := JobApplications.County;
        Employees."County Name" := JobApplications."County Name";
        Employees.Citizenship := JobApplications.Citizenship;
        Employees.Religion := JobApplications.Religion;
        Employees."Ethnic Group" := JobApplications."Ethnic Group";
        Employees."SubCounty Code" := JobApplications.SubCounty;
        Employees."SubCounty Name" := JobApplications."SubCounty Name";
        Employees.Address := JobApplications."Postal Address";
        Employees."Address 2" := JobApplications."Residential Address";
        Employees."Phone No." := JobApplications."Mobile Phone No.";
        Employees."Mobile Phone No." := JobApplications."Alternative Phone No.";
        Employees."E-Mail" := JobApplications."Personal Email Address";
        Employees."On Probation" := true;
        Employees."Bank Code-d" := JobApplications."Bank Code";
        Employees."Bank Name" := JobApplications."Bank Name";
        Employees."Bank Branch Code-d" := JobApplications."Bank Branch Code";
        Employees."Bank Branch Name" := JobApplications."Bank Branch Name";
        Employees."Employment Date" := Today;
        Employees."Contract Start Date" := JobApplications."Contract Start Date";
        Employees."Probation Start Date" := JobApplications."Probation Start Date";
        Employees."Probation End date" := JobApplications."Probation End date";
        Employees.Insert;


        HRApplicantRefereeDetails.Reset;
        HRApplicantRefereeDetails.SetRange(HRApplicantRefereeDetails."Job Application  No.", JobApplications."No.");
        if HRApplicantRefereeDetails.FindSet then begin
            LineNo := 1;
            repeat

                HREmployeeRefereeDetails.Init;
                HREmployeeRefereeDetails."Line No." += LineNo;
                HREmployeeRefereeDetails."Employee No." := Employees."No.";
                HREmployeeRefereeDetails.Surname := HRApplicantRefereeDetails.Surname;
                HREmployeeRefereeDetails.Firstname := HRApplicantRefereeDetails.Firstname;
                HREmployeeRefereeDetails.Middlename := HRApplicantRefereeDetails.Middlename;
                HREmployeeRefereeDetails."Personal E-Mail Address" := HRApplicantRefereeDetails."Personal E-Mail Address";
                HREmployeeRefereeDetails."Mobile No." := HRApplicantRefereeDetails."Mobile No.";
                HREmployeeRefereeDetails."Postal Address" := HRApplicantRefereeDetails."Postal Address";
                HREmployeeRefereeDetails."Post Code" := HRApplicantRefereeDetails."Post Code";
                HREmployeeRefereeDetails."City/Town" := HRApplicantRefereeDetails."Applicant E-mail";
                HREmployeeRefereeDetails."Country/Region Code" := HRApplicantRefereeDetails."Country/Region Code";
                HREmployeeRefereeDetails."Residential Address" := HRApplicantRefereeDetails."Residential Address";
                HREmployeeRefereeDetails."Referee Category" := HRApplicantRefereeDetails."Referee Category";
                HREmployeeRefereeDetails.Insert;
            until HRApplicantRefereeDetails.Next = 0;
        end;
        HRJobApplicantQualification.Reset;
        HRJobApplicantQualification.SetRange(HRJobApplicantQualification."Job Application No.", JobApplications."No.");
        if HRJobApplicantQualification.FindSet then begin
            LineNo := 1;
            repeat

                EmployeeQualification.Init;
                EmployeeQualification."Line No." += LineNo;
                EmployeeQualification."Employee No." := Employees."No.";
                EmployeeQualification."Qualification Code" := HRJobApplicantQualification."Qualification Code";
                EmployeeQualification.Description := HRJobApplicantQualification."Qualification Name";
                EmployeeQualification."From Date" := HRJobApplicantQualification."Joining Date";
                EmployeeQualification."To Date" := HRJobApplicantQualification."Completion Date";
                EmployeeQualification.Award := HRJobApplicantQualification.Award;
                EmployeeQualification."Award Date" := HRJobApplicantQualification."Award Date";
                EmployeeQualification."Institution/Company" := HRJobApplicantQualification."Institution Name";
                EmployeeQualification.Insert;
            until HRJobApplicantQualification.Next = 0;
        end;
        HRApplicantEmploymentHist.Reset;
        HRApplicantEmploymentHist.SetRange(HRApplicantEmploymentHist."Job Application No.", JobApplications."No.");
        if HRApplicantEmploymentHist.FindSet then begin
            LineNo := 1;
            repeat

                HREmployeeEmploymentHist.Init;
                HREmployeeEmploymentHist."Line No." += LineNo;
                HREmployeeEmploymentHist."Employee No." := Employees."No.";
                HREmployeeEmploymentHist."E-mail" := HRApplicantEmploymentHist."E-mail";
                HREmployeeEmploymentHist."Employer Name/Organization" := HRApplicantEmploymentHist."Employer Name/Organization";
                HREmployeeEmploymentHist."Address of the Organization" := HRApplicantEmploymentHist."Address of the Organization";
                HREmployeeEmploymentHist."Job Designation/Position Held" := HRApplicantEmploymentHist."Job Designation/Position Held";
                HREmployeeEmploymentHist."From Date" := HRApplicantEmploymentHist."From Date";
                HREmployeeEmploymentHist."To Date" := HRApplicantEmploymentHist."To Date";
                HREmployeeEmploymentHist."Days/Years of service" := HRApplicantEmploymentHist."Days/Years of service";
                HREmployeeEmploymentHist."Gross Salary" := HRApplicantEmploymentHist."Gross Salary";
                HREmployeeEmploymentHist.Benefits := HRApplicantEmploymentHist.Benefits;
                HREmployeeEmploymentHist.Insert;
            until HRApplicantEmploymentHist.Next = 0;
        end;


        Message(Text100, Employees."No.");

        JobApplications."Employee Created" := true;
        /*IF JobApplications.MODIFY THEN BEGIN
          EmployeeManagement.SendEmailNotificationToICT(Employees."No.");
       END;*/

    end;

    procedure LoadInterviewPanelFromCommittee(InterviewAttendanceHeader: Record "Interview Attendance Header")
    var
        InterviewCommitteeDeptLine: Record "Interview Committee Dept Line";
        InterviewAttendanceLine: Record "Interview Attendance Line";
    begin
        InterviewAttendanceLine.Reset;
        InterviewAttendanceLine.SetRange("Interview No.", InterviewAttendanceHeader."Interview No");
        if InterviewAttendanceLine.FindSet then
            InterviewAttendanceLine.DeleteAll;

        InterviewCommitteeDeptLine.Reset;
        InterviewCommitteeDeptLine.SetRange(Code, InterviewAttendanceHeader."Interview Committee code");
        if InterviewCommitteeDeptLine.FindSet then begin
            repeat
                InterviewAttendanceLine.Init;
                InterviewAttendanceLine."Interview No." := InterviewAttendanceHeader."Interview No";
                InterviewAttendanceLine."Employee No." := InterviewCommitteeDeptLine."Employee No.";
                InterviewAttendanceLine."Employee Name" := InterviewCommitteeDeptLine."Employee Name";
                InterviewAttendanceLine."Employee Email" := InterviewCommitteeDeptLine."Employee Email";
                InterviewAttendanceLine.Insert;
            until InterviewCommitteeDeptLine.Next = 0;
        end;
    end;

    procedure SendEmailNotificationToICTOnPublishingJobAdvert(EmpReqNo: Code[20])
    var
        HRJobApplication: Record "HR Job Applications";
        HREmpRequisition: Record "HR Employee Requisitions";
        InterviewAttendanceLine: Record "Interview Attendance Line";
        JobName: Text;
        UserSetup: Record "User Setup";
        Employee: Record Employee;
        HREmployee: Record Employee;
    begin
        // Send Email Notification to ICT upon Publishing of Job Advert on the portal
        // SMTP.Get;
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."Receive ICT Notifications", true);
        if UserSetup.FindSet then begin
            repeat
                HREmpRequisition.Reset;
                HREmpRequisition.SetRange(HREmpRequisition."No.", EmpReqNo);
                if HREmpRequisition.FindFirst then begin
                    // SMTPMail.CreateMessage(SMTP."Sender Name",SMTP."Sender Email Address",UserSetup."E-Mail",'Publishing of Job Advertisement on the Website ','',true);
                    HREmployee.Reset;
                    HREmployee.SetRange(HREmployee."User ID", UserSetup."User ID");
                    if HREmployee.FindFirst then begin
                        // SMTPMail.AppendBody('Dear'+' '+HREmployee."First Name"+',');
                        // SMTPMail.AppendBody('<br><br>');
                        // SMTPMail.AppendBody('Please proceed to Publish Job Advertisement vacancy for the '+'  '+ HREmpRequisition."Job Title"+',' +' on the website as the Job advertisement has been posted on the recruitment portal.');
                        // SMTPMail.AppendBody('Thank you.');
                        // SMTPMail.AppendBody('<br><br>');
                        // SMTPMail.AppendBody(SMTP."Sender Name");
                        // SMTPMail.AppendBody('<br><br>');
                        // SMTPMail.AppendBody('This is a system generated mail. Please do not reply to this Email');
                        // SMTPMail.Send;
                    end;
                end;
            until UserSetup.Next = 0;
        end;
    end;

    procedure SendInterviewShortlistedApplicantEmail(JobNo: Code[20]; EmpReqNo: Code[20]; InterviewDateFrom: Date; InterviewTime: Text; InterviewLocation: Text; InterviewNo: Code[30]; InterviewDateTo: Date)
    var
        HRJobApplication: Record "HR Job Applications";
        HREmpRequisition: Record "HR Employee Requisitions";
        InterviewAttendanceLine: Record "Interview Attendance Line";
        JobName: Text;
    begin
        //SMTP.Get;
        JobName := '';
        HRJobApplication.Reset;
        HRJobApplication.SetRange("Employee Requisition No.", EmpReqNo);
        HRJobApplication.SetRange("Job No.", JobNo);
        HRJobApplication.SetRange(ShortListed, true);
        HRJobApplication.SetRange("To be Interviewed", true);
        HRJobApplication.SetFilter("Personal Email Address", '<>%1', '');
        if HRJobApplication.FindSet then begin
            JobName := HRJobApplication."Job Title";
            repeat
            // SMTPMail.CreateMessage(SMTP."Sender Name", SMTP."Sender Email Address", HRJobApplication."Personal Email Address", 'Interview Invitation ' + HRJobApplication."Job Title", '', true);
            // SMTPMail.AppendBody('Dear' + ' ' + HRJobApplication.Surname + ' ' + HRJobApplication.Middlename + ' ' + HRJobApplication.Firstname + ',');
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AppendBody('Thank you for applying for the position of ' + HRJobApplication."Job Title" + '.' + 'Following consideration of your application, we are pleased to inform you that you have been shortlisted for interview.');
            // SMTPMail.AppendBody('The Interview will take place on' + ' ' + Format(HRJobApplication."Interview Date", 0, 4) + ' ' + 'at' + ' ' + HRJobApplication."Interview Time" + ' at,' + HRJobApplication."Interview Location" + BringOriginalCertsTestimonialsMessage);
            // SMTPMail.AppendBody('Thank you.');
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AppendBody(SMTP."Sender Name");
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AppendBody('This is a system generated mail. Please do not reply to this Email');
            // SMTPMail.Send;
            until HRJobApplication.Next = 0;
        end;

        InterviewAttendanceLine.Reset;
        InterviewAttendanceLine.SetRange(InterviewAttendanceLine."Interview No.", InterviewNo);
        InterviewAttendanceLine.SetFilter(InterviewAttendanceLine."Employee Email", '<>%1', '');
        if InterviewAttendanceLine.FindSet then begin
            repeat
            // SMTPMail.CreateMessage(SMTP."Sender Name", SMTP."Sender Email Address", InterviewAttendanceLine."Employee Email", 'Interview Panel Invitation - ' + HRJobApplication."Job Title", '', true);
            // SMTPMail.AppendBody('Dear' + ' ' + InterviewAttendanceLine."Employee Name" + ',');
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AppendBody('I wish to inform you,that you have been nominated to be part of the interview panel for the shortlisted candidates to be interviewed.');
            // SMTPMail.AppendBody('The Interview will be conducted from' + ' ' + Format(InterviewDateFrom, 0, 4) + ' ' + ' to ' + ' ' + Format(InterviewDateTo, 0, 4) + ' ' + HRJobApplication."Interview Time" + ' at  the, ' + HRJobApplication."Interview Location");
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AppendBody('Thank you.');
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AppendBody(SMTP."Sender Name");
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AppendBody('This is a system generated mail. Please do not reply to this Email');
            // SMTPMail.Send;
            until InterviewAttendanceLine.Next = 0;
        end;
        Message(Successemail);
    end;

    procedure SendInterviewRejectedApplicantEmail(JobNo: Code[20]; EmpReqNo: Code[20])
    var
        HRJobApplication: Record "HR Job Applications";
    begin
        // SMTP.Get;
        HRJobApplication.Reset;
        HRJobApplication.SetRange("Employee Requisition No.", EmpReqNo);
        HRJobApplication.SetRange("Job No.", JobNo);
        HRJobApplication.SetRange("To be Interviewed", false);
        HRJobApplication.SetFilter("Email Address", '<>%1', '');
        if HRJobApplication.FindSet then begin
            repeat
            // SMTPMail.CreateMessage(SMTP."Sender Name", SMTP."Sender Email Address", HRJobApplication."Personal Email Address", 'Job Application Regret ' + HRJobApplication."Job Title", '', true);
            // SMTPMail.AppendBody('Dear' + ' ' + HRJobApplication.Surname + ' ' + HRJobApplication.Middlename + ' ' + HRJobApplication.Firstname + ',');
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AppendBody('Thank you for applying for the position of ,' + HRJobApplication."Job Title" + '.We really appreciate your interest and we thank you for the time and energy you invested in applying for the position.');
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AppendBody('After carefully reviewing your application, we regret to inform you that we will not progress your application to the next phase of our selection process.');
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AppendBody('We do encourage you to apply for open positions that you qualify for in future.');
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AppendBody('Thank you again for your application and best wishes.');
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AppendBody(SMTP."Sender Name");
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AppendBody('This is a system generated mail. Please do not reply to this Email');
            // SMTPMail.Send;
            until HRJobApplication.Next = 0;
        end;
        Message(Successemail);
    end;

    procedure CloseEmployeeRequisition(EmployeeRequisitionNo: Code[20])
    var
        JobApplications: Record "HR Job Applications";
        InterviewAttendanceHeader: Record "Interview Attendance Header";
        InterviewAttendanceLines: Record "Interview Attendance Line";
        EmployeeRequisition: Record "HR Employee Requisitions";
        JobApplicantResults: Record "HR Job Applicant Results";
    begin
        if Confirm(Txt070) = false then exit;
        //close job applications
        JobApplications.Reset;
        JobApplications.SetRange("Employee Requisition No.", EmployeeRequisitionNo);
        if JobApplications.FindSet then begin
            repeat
                JobApplications.Status := JobApplications.Status::Shortlisted;
                JobApplications.Modify;
            until JobApplications.Next = 0;
        end;

        //close interviews
        InterviewAttendanceHeader.Reset;
        InterviewAttendanceHeader.SetRange("Job Requisition No.", EmployeeRequisitionNo);
        if InterviewAttendanceHeader.FindSet then begin
            InterviewAttendanceHeader.Closed := true;
            InterviewAttendanceHeader.Modify;

            InterviewAttendanceLines.Reset;
            InterviewAttendanceLines.SetRange("Interview No.", InterviewAttendanceHeader."Interview No");
            if InterviewAttendanceLines.FindSet then begin
                repeat
                    InterviewAttendanceLines.Closed := true;
                    InterviewAttendanceLines.Modify;
                until InterviewAttendanceLines.Next = 0;
            end;
        end;

        //close requisition
        EmployeeRequisition.Reset;
        EmployeeRequisition.SetRange("No.", EmployeeRequisitionNo);
        if EmployeeRequisition.FindFirst then begin
            EmployeeRequisition.Status := EmployeeRequisition.Status::Closed;
            EmployeeRequisition.Modify;
        end;

        //close results
        JobApplicantResults.Reset;
        JobApplicantResults.SetRange("Job Requistion No", EmployeeRequisitionNo);
        if JobApplicantResults.FindSet then begin
            repeat
                JobApplicantResults.Closed := true;
                JobApplicantResults.Modify;
            until JobApplicantResults.Next = 0;
        end;
    end;

    procedure RankInterviewees(JobRequisitionNo: Code[20]; JobNo: Code[20])
    var
        JobApplicantResults: Record "HR Job Applicant Results";
        Position: Integer;
    begin
        Position := 1;
        JobApplicantResults.Reset;
        JobApplicantResults.SetRange("Job Requistion No", JobRequisitionNo);
        JobApplicantResults.SetRange("Job No", JobNo);
        JobApplicantResults.SetCurrentKey(Total);
        JobApplicantResults.SetAscending(Total, false);
        if JobApplicantResults.FindSet then begin
            ProgressWindow.Open('Ranking for applicant no. #1#######');
            repeat
                JobApplicantResults.Position := Position;
                JobApplicantResults.Modify;
                Position := Position + 1;
                ProgressWindow.Update(1, JobApplicantResults."Job Applicant No");
            until JobApplicantResults.Next = 0;
        end;
        ProgressWindow.Close;
    end;

    procedure ShortlistApplicants(EmployeeRequisitions: Record "HR Employee Requisitions")
    var
        HRJobApplications: Record "HR Job Applications";
        HRJobQualifications: Record "HR Job Qualifications";
        HRJobApplicantQualifications: Record "HR Job Applicant Qualification";
        HRJobRequirements: Record "HR Job Requirements";
        HRJobApplicantRequirements: Record "HR Job Applicant Requirement";
        JobApplicantShortlisting: Label 'Job Applicant Shortlisting is Successful.';
    begin
        //Check Mandatory Academic Qualifications
        HRJobApplications.Reset;
        HRJobApplications.SetRange(HRJobApplications."Employee Requisition No.", EmployeeRequisitions."No.");
        if HRJobApplications.FindSet then begin
            repeat
                HRJobQualifications.Reset;
                HRJobQualifications.SetRange("Job No.", HRJobApplications."Job No.");
                HRJobQualifications.SetRange(Mandatory, true);
                if HRJobQualifications.FindSet then begin
                    repeat
                        HRJobApplicantQualifications.Reset;
                        HRJobApplicantQualifications.SetRange("E-mail", HRJobApplications."Personal Email Address");
                        HRJobApplicantQualifications.SetRange("Qualification Code", HRJobQualifications."Qualification Code");
                        if HRJobApplicantQualifications.FindFirst then begin
                            HRJobApplications.ShortListed := true;
                            HRJobApplications."To be Interviewed" := true;
                            HRJobApplications.Status := HRJobApplications.Status::"Pending Approval";
                            HRJobApplications.Modify;
                        end else begin
                            HRJobApplications.ShortListed := false;
                            HRJobApplications."To be Interviewed" := false;
                            HRJobApplications.Status := HRJobApplications.Status::Approved;
                            HRJobApplications.Modify;
                            exit;
                        end;
                    until HRJobQualifications.Next = 0;
                end;
            until HRJobApplications.Next = 0;
        end;
        //Check Mandatory Requirements
        HRJobApplications.Reset;
        HRJobApplications.SetRange(HRJobApplications."Employee Requisition No.", EmployeeRequisitions."No.");
        if HRJobApplications.FindSet then begin
            repeat
                HRJobRequirements.Reset;
                HRJobRequirements.SetRange("Job No.", HRJobApplications."Job No.");
                HRJobRequirements.SetRange(Mandatory, true);
                if HRJobRequirements.FindSet then begin
                    repeat
                        HRJobApplicantRequirements.Reset;
                        HRJobApplicantRequirements.SetRange("E-mail", HRJobApplications."Personal Email Address");
                        HRJobApplicantRequirements.SetRange("Requirement Code", HRJobRequirements."Requirement Code");
                        if HRJobApplicantRequirements.FindFirst then begin
                            HRJobApplications.ShortListed := true;
                            HRJobApplications."To be Interviewed" := true;
                            HRJobApplications.Status := HRJobApplications.Status::"Pending Approval";
                            HRJobApplications.Modify;
                        end else begin
                            HRJobApplications.ShortListed := false;
                            HRJobApplications."To be Interviewed" := false;
                            HRJobApplications.Status := HRJobApplications.Status::Approved;
                            HRJobApplications.Modify;
                            exit;
                        end;
                    until HRJobRequirements.Next = 0;
                end;
            until HRJobApplications.Next = 0;
        end;
        Message(JobApplicantShortlisting);
    end;

    procedure CalculateResultsTotals(JobRequisitionNo: Code[20]; JobNo: Code[20])
    var
        JobApplicantResults: Record "HR Job Applicant Results";
        ResultsTotal: Decimal;
    begin
        JobApplicantResults.Reset;
        JobApplicantResults.SetRange("Job Requistion No", JobRequisitionNo);
        JobApplicantResults.SetRange("Job No", JobNo);
        if JobApplicantResults.FindSet then begin
            JobApplicantResults.CalcFields("EV 1");
            JobApplicantResults.CalcFields("EV 2");
            JobApplicantResults.CalcFields("EV 3");
            JobApplicantResults.CalcFields("EV 4");
            JobApplicantResults.CalcFields("EV 5");
            JobApplicantResults.CalcFields("EV 6");
            JobApplicantResults.CalcFields("EV 7");
            JobApplicantResults.CalcFields("EV 8");
            JobApplicantResults.CalcFields("EV 9");
            JobApplicantResults.CalcFields("EV 10");
            ProgressWindow.Open('Calculating Totals for applicant no. #1#######');
            repeat
                ResultsTotal := 0;
                ResultsTotal := JobApplicantResults."EV 1" + JobApplicantResults."EV 2" + JobApplicantResults."EV 3" + JobApplicantResults."EV 4" + JobApplicantResults."EV 5" +
                              JobApplicantResults."EV 6" + JobApplicantResults."EV 7" + JobApplicantResults."EV 8" + JobApplicantResults."EV 9" + JobApplicantResults."EV 10";
                JobApplicantResults.Total := ResultsTotal;
                JobApplicantResults.Modify;
                ProgressWindow.Update(1, JobApplicantResults."Job Applicant No");
            until JobApplicantResults.Next = 0;
        end;
        ProgressWindow.Close;
    end;

    procedure CreatePurchaseRequisitionForJobAdvertisement(EmpReqNo: Code[20])
    var
        HREmployeeRequisitions: Record "HR Employee Requisitions";
        PurchaseRequisitions: Record "Purchase Requisitions";
        PurchaseRequisitions2: Record "Purchase Requisitions";
    begin
        "Purchases&PayablesSetup".Get;
        HREmployeeRequisitions.Reset;
        HREmployeeRequisitions.SetRange(HREmployeeRequisitions."No.", EmpReqNo);
        if HREmployeeRequisitions.FindFirst then begin
            PurchaseRequisitions2.Reset;
            PurchaseRequisitions2.SetRange("Reference Document No.", HREmployeeRequisitions."No.");
            if not PurchaseRequisitions2.FindFirst then begin
                PurchaseRequisitions.Init;
                PurchaseRequisitions."No." := NoSeriesMgt.GetNextNo("Purchases&PayablesSetup"."Purchase Requisition Nos.", 0D, true);
                PurchaseRequisitions."Document Date" := Today;
                PurchaseRequisitions."Requested Receipt Date" := Today;
                PurchaseRequisitions."Reference Document No." := EmpReqNo;
                PurchaseRequisitions."Global Dimension 1 Code" := HREmployeeRequisitions."Global Dimension 1 Code";
                PurchaseRequisitions."Global Dimension 2 Code" := HREmployeeRequisitions."Global Dimension 2 Code";
                PurchaseRequisitions."Shortcut Dimension 3 Code" := HREmployeeRequisitions."Shortcut Dimension 3 Code";
                PurchaseRequisitions."Shortcut Dimension 4 Code" := HREmployeeRequisitions."Shortcut Dimension 4 Code";
                PurchaseRequisitions."Shortcut Dimension 5 Code" := HREmployeeRequisitions."Shortcut Dimension 5 Code";
                PurchaseRequisitions.Description := HREmployeeRequisitions."Emp. Requisition Description";
                if PurchaseRequisitions.Insert then begin
                    HREmployeeRequisitions."Purchase Requisition Created" := true;
                    HREmployeeRequisitions."Purchase Requisition No." := PurchaseRequisitions."No.";
                    HREmployeeRequisitions.Modify;
                end;
            end;
        end;
    end;

    procedure PublishJobAdvertisement(EmpReqNo: Code[20])
    var
        Txt080: Label 'Are you sure you want to Publish the Job Advertisement? Please note this will make the Job Advertisement to be visible on the portal for Applications.';
        Txt081: Label 'Are you sure you want to drop the Published Job Advertisement? Please note this will make the Job Advertisement not to be visible on the portal for Applications.';
        HREmployeeRequisitions: Record "HR Employee Requisitions";
    begin
        HREmployeeRequisitions.Reset;
        HREmployeeRequisitions.SetRange(HREmployeeRequisitions."No.", EmpReqNo);
        if HREmployeeRequisitions.FindFirst then begin
            HREmployeeRequisitions."Job Advert Published" := true;
            HREmployeeRequisitions."Job Advert Dropped" := false;
            HREmployeeRequisitions.Modify;
            SendEmailNotificationToICTOnPublishingJobAdvert(EmpReqNo);
            Message(Txt080);
        end;
    end;

    procedure DropJobAdvertisement(EmpReqNo: Code[20])
    var
        Txt080: Label 'Are you sure you want to Publish the Job Advertisement? Please note this will make the Job Advertisement to be visible on the portal for Applications.';
        Txt081: Label 'Are you sure you want to drop the Published Job Advertisement? Please note this will make the Job Advertisement not to be visible on the portal for Applications.';
        HREmployeeRequisitions: Record "HR Employee Requisitions";
    begin
        HREmployeeRequisitions.Reset;
        HREmployeeRequisitions.SetRange(HREmployeeRequisitions."No.", EmpReqNo);
        if HREmployeeRequisitions.FindFirst then begin
            HREmployeeRequisitions."Job Advert Published" := false;
            HREmployeeRequisitions."Job Advert Dropped" := true;
            HREmployeeRequisitions.Modify;
            Message(Txt081);
        end;
    end;
}

