codeunit 50023 "HR Job Management WS"
{

    trigger OnRun()
    begin
    end;

    var
        SERVERDIRECTORYPATH: Label 'C:\inetpub\wwwroot\HWWK\EmployeeData\';
        TxtCharsToKeep: Label 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        HROnlineApplicant: Record "HR  Online Applicant";
        HRJobApplication: Record "HR Job Applications";
        HRJobApplication2: Record "HR Job Applications";
        Dates: Codeunit Dates;
        HRJobs: Record "HR Jobs";
        HRJobLookupValues: Record "HR Job Lookup Value";
        HRJobApplicantQualifications: Record "HR Job Online Qualifications";
        HRApplicantEmploymentHist: Record "HR Online Employment Hist.";
        HRApplicantWorkExperience: Record "HR Job Online Requirements";
        Employee: Record Employee;
        FileName: Text;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        HRJobQualifications: Record "HR Job Qualifications";
        HRJobApplicantDataDirectory: Text;
        HRTrainingNeedsHeader: Record "HR Training Needs Header";
        HRTrainingNeedsLine: Record "HR Training Needs Line";
        HRApplicantRefereeLine: Record "HR Online Referee Details";
        CompanyDataDirectory: Text;
        CompanyInformation: Record "Company Information";
        HumanResourcesSetup: Record "Human Resources Setup";
        HRJobsData: Text;
        HRApplicantAccountWS: Codeunit "HR Applicant Account WS";

    procedure CreateHROnlineApplicantDirectory(EmailAddress: Text[100])
    var
        CompanyDataDirectory: Text;
        HROnlineApplicantDataDirectory: Text;
        // [RunOnClient]
        // DirectoryHelper: DotNet Directory;
        DirectoryPath: Label '%1\%2\%3';
        HROnlineApplicantDirectoryPath: Text;
    begin
        CompanyInformation.Get;
        HumanResourcesSetup.Get;
        CompanyInformation.TestField(CompanyInformation."Company Data Directory Path");
        HumanResourcesSetup.TestField(HumanResourcesSetup."HR Job Applicant Data Dir.Name");
        CompanyDataDirectory := CompanyInformation."Company Data Directory Path";
        HROnlineApplicantDataDirectory := HumanResourcesSetup."HR Job Applicant Data Dir.Name";

        HROnlineApplicantDirectoryPath := StrSubstNo(DirectoryPath, CompanyDataDirectory, HROnlineApplicantDataDirectory, EmailAddress);

        // if not DirectoryHelper.Exists(HROnlineApplicantDirectoryPath) then begin
        //   DirectoryHelper.CreateDirectory(HROnlineApplicantDirectoryPath);
        //end;
    end;

    procedure CheckOpenJobApplicationExists(EmailAddress: Code[20]) OpeNJobApplicantionExist: Boolean
    begin
        OpeNJobApplicantionExist := false;
        HRJobApplication.Reset;
        HRJobApplication.SetRange(HRJobApplication."Email Address", EmailAddress);
        HRJobApplication.SetRange(HRJobApplication.Status, HRJobApplication.Status::Open);
        if HRJobApplication.FindFirst then begin
            OpeNJobApplicantionExist := true;
        end;
    end;

    procedure GetJobApplicationNo(EmailAddress: Text[100]) JobApplicationNo: Code[30]
    begin
        JobApplicationNo := '';
        HRJobApplication.Reset;
        HRJobApplication.SetRange(HRJobApplication."Personal Email Address", EmailAddress);
        HRJobApplication.SetRange(HRJobApplication.Status, HRJobApplication.Status::Open);
        if HRJobApplication.FindFirst then begin
            JobApplicationNo := HRJobApplication."No.";
        end;
    end;

    procedure CheckHRJobApplicationQualificationExist(EmailAddress: Text[100]) QualificationsLinesExist: Boolean
    begin
        QualificationsLinesExist := false;
        HRJobApplicantQualifications.Reset;
        HRJobApplicantQualifications.SetRange(HRJobApplicantQualifications."E-mail", EmailAddress);
        if HRJobApplicantQualifications.FindFirst then begin
            QualificationsLinesExist := true;
        end;
    end;

    procedure CreateHRJobApplicationQualificationLine(EmailAddress: Text[100]; QualificationCode: Code[50]; QualificationName: Text[100]; InstitutionName: Code[100]; QualificationCadre: Code[50]; GraduationYear: Date) JobQualificationsLineCreated: Boolean
    begin
        JobQualificationsLineCreated := false;
        HRJobApplicantQualifications.Init;
        HRJobApplicantQualifications."E-mail" := EmailAddress;
        HRJobApplicantQualifications."Qualification Code" := QualificationCode;
        HRJobApplicantQualifications."Qualification Name" := QualificationName;
        HRJobApplicantQualifications.Validate(HRJobApplicantQualifications."Qualification Code");
        // HRJobApplicantQualifications."Joining Date":=FromYear;
        // HRJobApplicantQualifications."Completion Date":=ToYear;
        HRJobApplicantQualifications."Institution Name" := InstitutionName;
        HRJobApplicantQualifications.Award := QualificationCadre;
        HRJobApplicantQualifications."Award Date" := GraduationYear;
        if HRJobApplicantQualifications.Insert then begin
            JobQualificationsLineCreated := true;
        end;
    end;

    procedure ModifyHRJobApplicationQualificationLine("Line No.": Integer; EmailAddress: Text[100]; QualificationCode: Code[50]; QualificationName: Text[100]; InstitutionName: Code[100]; QualificationCadre: Code[50]; GraduationYear: Date) JobQualificationsLineModified: Boolean
    begin
        JobQualificationsLineModified := false;
        HRJobApplicantQualifications.Reset;
        HRJobApplicantQualifications.SetRange("Line No.", "Line No.");
        HRJobApplicantQualifications.SetRange("E-mail", EmailAddress);
        if HRJobApplicantQualifications.FindFirst then begin
            HRJobApplicantQualifications."Qualification Code" := QualificationCode;
            HRJobApplicantQualifications."Qualification Name" := QualificationName;
            HRJobApplicantQualifications.Validate(HRJobApplicantQualifications."Qualification Code");
            // HRJobApplicantQualifications."Joining Date":=FromYear;
            // HRJobApplicantQualifications."Completion Date":=ToYear;
            HRJobApplicantQualifications."Institution Name" := InstitutionName;
            HRJobApplicantQualifications.Award := QualificationCadre;
            HRJobApplicantQualifications."Award Date" := GraduationYear;
            if HRJobApplicantQualifications.Modify then begin
                JobQualificationsLineModified := true;
            end;
        end;
    end;

    procedure DeleteHRJobApplicationQualificationLine("LineNo.": Integer; EmailAddress: Text[100]) JobQualificationLineDeleted: Boolean
    begin
        JobQualificationLineDeleted := false;
        HRJobApplicantQualifications.Reset;
        HRJobApplicantQualifications.SetRange(HRJobApplicantQualifications."Line No.", "LineNo.");
        HRJobApplicantQualifications.SetRange(HRJobApplicantQualifications."E-mail", EmailAddress);
        if HRJobApplicantQualifications.FindFirst then begin
            if HRJobApplicantQualifications.Delete then begin
                JobQualificationLineDeleted := true;
            end;
        end;
    end;

    procedure ValidateHRJobApplicationQualificationLines(EmailAddress: Text[100]) JobQualificationLinesError: Text
    var
        "JobQualificationLineNo.": Integer;
    begin
        JobQualificationLinesError := '';
        "JobQualificationLineNo." := 0;
        HRJobApplicantQualifications.Reset;
        HRJobApplicantQualifications.SetRange(HRJobApplicantQualifications."E-mail", EmailAddress);
        if HRJobApplicantQualifications.FindSet then begin
            repeat
                "JobQualificationLineNo." := "JobQualificationLineNo." + 1;
                if HRJobApplicantQualifications."E-mail" = '' then begin
                    JobQualificationLinesError := 'Email address. missing on line no.' + Format("JobQualificationLineNo.") + ', it should not cannot be zero or empty';
                    break;
                end;
            until HRJobApplicantQualifications.Next = 0;
        end;
    end;

    procedure CheckMandatoryAcademicRequirements(EmailAddress: Text[100]; "EmployeeRequisitionNo.": Code[20]) RequirementsMet: Boolean
    var
        HRJobRequirements: Record "HR Job Requirements";
        HRJobApplicantRequirements: Record "HR Job Online Requirements";
        EmployeeRequisitions: Record "HR Employee Requisitions";
    begin
        RequirementsMet := false;
        EmployeeRequisitions.Get("EmployeeRequisitionNo.");
        //Check Mandatory Academic Qualifications
        HRJobQualifications.Reset;
        HRJobQualifications.SetRange("Job No.", EmployeeRequisitions."Job No.");
        HRJobQualifications.SetRange(Mandatory, true);
        if HRJobQualifications.FindSet then begin
            repeat
                HRJobApplicantQualifications.Reset;
                HRJobApplicantQualifications.SetRange("E-mail", EmailAddress);
                HRJobApplicantQualifications.SetRange("Qualification Code", HRJobQualifications."Qualification Code");
                if HRJobApplicantQualifications.FindFirst then begin
                    RequirementsMet := true;
                end else begin
                    RequirementsMet := false;
                    exit(RequirementsMet);
                end;
            until HRJobQualifications.Next = 0;
            exit(RequirementsMet);
        end;
    end;

    procedure CheckJobMandatoryRequirements(EmailAddress: Text[100]; "EmployeeRequisitionNo.": Code[20]) RequirementsMet: Boolean
    var
        HRJobRequirements: Record "HR Job Requirements";
        HRJobApplicantRequirements: Record "HR Job Online Requirements";
        EmployeeRequisitions: Record "HR Employee Requisitions";
    begin
        RequirementsMet := false;
        EmployeeRequisitions.Get("EmployeeRequisitionNo.");
        //Check Mandatory Requirements
        HRJobRequirements.Reset;
        HRJobRequirements.SetRange("Job No.", EmployeeRequisitions."Job No.");
        HRJobRequirements.SetRange(Mandatory, true);
        if HRJobRequirements.FindSet then begin
            repeat
                HRJobApplicantRequirements.Reset;
                HRJobApplicantRequirements.SetRange("E-mail", EmailAddress);
                HRJobApplicantRequirements.SetRange("Requirement Code", HRJobRequirements."Requirement Code");
                if HRJobApplicantRequirements.FindFirst then begin
                    RequirementsMet := true;
                end else begin
                    RequirementsMet := false;
                    exit(RequirementsMet);
                end;
            until HRJobRequirements.Next = 0;
        end else begin
            RequirementsMet := true;
        end;
        exit(RequirementsMet);
    end;

    procedure CreateApplicantWorkExperienceLine(EmailAddress: Text[100]; ExperienceType: Code[50]; Description: Text[250]; "No. Of Years": Integer) ApplicantWorkExperienceCreated: Boolean
    var
        Text0001: Label 'Kwera';
    begin
        ApplicantWorkExperienceCreated := false;
        HRApplicantWorkExperience.Init;
        HRApplicantWorkExperience."E-mail" := EmailAddress;
        HRApplicantWorkExperience."Requirement Code" := ExperienceType;
        HRApplicantWorkExperience.Description := Description;
        HRApplicantWorkExperience."No. of Years" := "No. Of Years";
        if HRApplicantWorkExperience.Insert then
            ApplicantWorkExperienceCreated := true;
    end;

    procedure ModifyApplicantWorkExperienceLine(LineNo: Integer; EmailAddress: Text[100]; ExperienceType: Code[50]; Description: Text[250]; "No. Of Years": Integer) HRApplicantWorkExperienceLineModified: Boolean
    begin
        HRApplicantWorkExperienceLineModified := false;
        HRApplicantWorkExperience.Reset;
        HRApplicantWorkExperience.SetRange(HRApplicantWorkExperience."Line No", LineNo);
        HRApplicantWorkExperience.SetRange("E-mail", EmailAddress);
        if HRApplicantWorkExperience.FindFirst then begin
            HRApplicantWorkExperience."Requirement Code" := ExperienceType;
            HRApplicantWorkExperience.Description := Description;
            HRApplicantWorkExperience."No. of Years" := "No. Of Years";
            if HRApplicantWorkExperience.Modify then begin
                HRApplicantWorkExperienceLineModified := true;
            end;
        end;
    end;

    procedure DeleteApplicantWorkExperienceLine("LineNo.": Integer; EmailAddress: Text[100]) HRApplicantWorkExperienceLineDeleted: Boolean
    begin
        HRApplicantWorkExperienceLineDeleted := false;
        HRApplicantWorkExperience.Reset;
        HRApplicantWorkExperience.SetRange(HRApplicantWorkExperience."Line No", "LineNo.");
        HRApplicantWorkExperience.SetRange(HRApplicantWorkExperience."E-mail", EmailAddress);
        if HRApplicantWorkExperience.FindFirst then begin
            if HRApplicantWorkExperience.Delete then begin
                HRApplicantWorkExperienceLineDeleted := true;
            end;
        end;
    end;

    procedure CreateProfessionalCertificationLine(EmailAddress: Text[100]; Description: Text[250]) ProfessionalCertificationCreated: Boolean
    var
        Text0001: Label 'Kwera';
    begin
        ProfessionalCertificationCreated := false;
        HRApplicantWorkExperience.Init;
        HRApplicantWorkExperience."E-mail" := EmailAddress;
        HRApplicantWorkExperience."Requirement Code" := 'OTHER';
        HRApplicantWorkExperience.Description := Description;
        if HRApplicantWorkExperience.Insert then
            ProfessionalCertificationCreated := true;
    end;

    procedure ModifyProfessionalCertificationLine(LineNo: Integer; EmailAddress: Text[100]; Description: Text[250]) ProfessionalCertificationLineModified: Boolean
    begin
        ProfessionalCertificationLineModified := false;
        HRApplicantWorkExperience.Reset;
        HRApplicantWorkExperience.SetRange(HRApplicantWorkExperience."Line No", LineNo);
        HRApplicantWorkExperience.SetRange("E-mail", EmailAddress);
        if HRApplicantWorkExperience.FindFirst then begin
            HRApplicantWorkExperience."Requirement Code" := 'OTHER';
            HRApplicantWorkExperience.Description := Description;
            if HRApplicantWorkExperience.Modify then begin
                ProfessionalCertificationLineModified := true;
            end;
        end;
    end;

    procedure DeleteProfessionalCertificationLine("LineNo.": Integer; EmailAddress: Text[100]) ProfessionalCertificationLineDeleted: Boolean
    begin
        ProfessionalCertificationLineDeleted := false;
        HRApplicantWorkExperience.Reset;
        HRApplicantWorkExperience.SetRange(HRApplicantWorkExperience."Line No", "LineNo.");
        HRApplicantWorkExperience.SetRange(HRApplicantWorkExperience."E-mail", EmailAddress);
        if HRApplicantWorkExperience.FindFirst then begin
            if HRApplicantWorkExperience.Delete then begin
                ProfessionalCertificationLineDeleted := true;
            end;
        end;
    end;

    procedure ValidateApplicantWorkExperienceLines(EmailAddress: Text[100]) HRApplicantWkExpLineError: Text
    var
        "HRApplicantWkExpLineNo.": Integer;
    begin
        HRApplicantWkExpLineError := '';
        "HRApplicantWkExpLineNo." := 0;
        HRApplicantWorkExperience.Reset;
        HRApplicantWorkExperience.SetRange(HRApplicantWorkExperience."E-mail", EmailAddress);
        if HRApplicantWorkExperience.FindSet then begin
            repeat
                "HRApplicantWkExpLineNo." := "HRApplicantWkExpLineNo." + 1;
                if HRApplicantWorkExperience."E-mail" = '' then begin
                    HRApplicantWkExpLineError := 'Email address. missing on line no.' + Format("HRApplicantWkExpLineNo.") + ', it should not cannot be zero or empty';
                    break;
                end;
            until HRApplicantWorkExperience.Next = 0;
        end;
    end;

    procedure CreateApplicantEmploymentHistLine(EmailAddress: Text[100]; EmployerName: Code[50]; EmploymentFromDate: Date; EmploymentToDate: Date; Designation: Text; Salary: Decimal) EmploymentHistoryCreated: Boolean
    begin
        EmploymentHistoryCreated := false;
        HROnlineApplicant.Reset;
        HROnlineApplicant.SetRange("Email Address", EmailAddress);
        if HROnlineApplicant.FindFirst then begin
            HRApplicantEmploymentHist.Init;
            HRApplicantEmploymentHist."E-mail" := HROnlineApplicant."Email Address";
            HRApplicantEmploymentHist."Employer Name/Organization" := EmployerName;
            //HRApplicantEmploymentHist."Address of the Organization":=EmployerAddress;
            HRApplicantEmploymentHist."From Date" := EmploymentFromDate;
            HRApplicantEmploymentHist."To Date" := EmploymentToDate;
            HRApplicantEmploymentHist.Validate(HRApplicantEmploymentHist."To Date");
            HRApplicantEmploymentHist."Job Designation/Position Held" := Designation;
            HRApplicantEmploymentHist."Gross Salary" := Salary;
            if HRApplicantEmploymentHist.Insert then begin
                EmploymentHistoryCreated := true;
            end;
        end
    end;

    procedure ModifyApplicantEmploymentHistLine(LineNo: Integer; EmailAddress: Text[100]; EmployerName: Code[50]; EmploymentFromDate: Date; EmploymentToDate: Date; Designation: Text; Salary: Decimal) HRApplicantEmpHistLineModified: Boolean
    begin
        HRApplicantEmpHistLineModified := false;
        HRApplicantEmploymentHist.Reset;
        HRApplicantEmploymentHist.SetRange(HRApplicantEmploymentHist."Line No", LineNo);
        HRApplicantEmploymentHist.SetRange("E-mail", EmailAddress);
        if HRApplicantEmploymentHist.FindFirst then begin
            HRApplicantEmploymentHist."Employer Name/Organization" := EmployerName;
            //HRApplicantEmploymentHist."Address of the Organization":=EmployerAddress;
            HRApplicantEmploymentHist."From Date" := EmploymentFromDate;
            HRApplicantEmploymentHist."To Date" := EmploymentToDate;
            HRApplicantEmploymentHist."Job Designation/Position Held" := Designation;
            HRApplicantEmploymentHist."Gross Salary" := Salary;
            if HRApplicantEmploymentHist.Modify then begin
                HRApplicantEmpHistLineModified := true;
            end;
        end;
    end;

    procedure DeleteApplicantEmploymentHistLine("LineNo.": Integer; EmailAddress: Text[100]) ApplicantEmploymentHistLineDeleted: Boolean
    begin
        ApplicantEmploymentHistLineDeleted := false;
        HRApplicantEmploymentHist.Reset;
        HRApplicantEmploymentHist.SetRange(HRApplicantEmploymentHist."Line No", "LineNo.");
        HRApplicantEmploymentHist.SetRange(HRApplicantEmploymentHist."E-mail", EmailAddress);
        if HRApplicantEmploymentHist.FindFirst then begin
            if HRApplicantEmploymentHist.Delete then begin
                ApplicantEmploymentHistLineDeleted := true;
            end;
        end;
    end;

    procedure ValidateApplicantEmploymentHistLines(EmailAddress: Text[100]) ApplicantEmploymentHistLineError: Text
    var
        "ApplicantEmploymentHistLineNo.": Integer;
    begin
        ApplicantEmploymentHistLineError := '';
        "ApplicantEmploymentHistLineNo." := 0;
        HRApplicantEmploymentHist.Reset;
        HRApplicantEmploymentHist.SetRange(HRApplicantEmploymentHist."E-mail", EmailAddress);
        if HRApplicantEmploymentHist.FindSet then begin
            repeat
                "ApplicantEmploymentHistLineNo." := "ApplicantEmploymentHistLineNo." + 1;
                if HRApplicantEmploymentHist."E-mail" = '' then begin
                    ApplicantEmploymentHistLineError := 'Email address. missing on line no.' + Format("ApplicantEmploymentHistLineNo.") + ', it should not cannot be empty';
                    break;
                end;
            until HRApplicantWorkExperience.Next = 0;
        end;
    end;

    procedure CreateProfessionalRefereeLine(EmailAddress: Text[100]; FirstName: Code[30]; MiddleName: Code[30]; Surname: Code[30]; RefereeEmail: Text[100]; Address: Text[100]; PostalCode: Code[50]; PhysicalAddress: Text[100]) ProfessionalRefereeLineCreated: Boolean
    begin
        ProfessionalRefereeLineCreated := false;
        HRApplicantRefereeLine.Init;
        HRApplicantRefereeLine."Applicant E-mail" := EmailAddress;
        HRApplicantRefereeLine.Firstname := FirstName;
        HRApplicantRefereeLine.Middlename := MiddleName;
        HRApplicantRefereeLine.Surname := Surname;
        HRApplicantRefereeLine."Personal E-Mail Address" := RefereeEmail;
        HRApplicantRefereeLine."Postal Address" := Address;
        HRApplicantRefereeLine."Post Code" := PostalCode;
        HRApplicantRefereeLine."Residential Address" := PhysicalAddress;
        HRApplicantRefereeLine."Referee Category" := HRApplicantRefereeLine."Referee Category"::Professional;
        if HRApplicantRefereeLine.Insert then begin
            ProfessionalRefereeLineCreated := true;
        end;
    end;

    procedure ModifyProfessionalRefereeLine(LineNo: Integer; EmailAddress: Text[100]; FirstName: Code[30]; MiddleName: Code[30]; Surname: Code[30]; RefereeEmail: Text[100]; Address: Text[100]; PostalCode: Code[50]; PhysicalAddress: Text[100]) ProfessionalRefereeLineModified: Boolean
    begin
        ProfessionalRefereeLineModified := false;
        HRApplicantRefereeLine.Reset;
        HRApplicantRefereeLine.SetRange(HRApplicantRefereeLine."Line No.", LineNo);
        HRApplicantRefereeLine.SetRange("Applicant E-mail", EmailAddress);
        if HRApplicantRefereeLine.FindFirst then begin
            HRApplicantRefereeLine."Applicant E-mail" := EmailAddress;
            HRApplicantRefereeLine.Firstname := FirstName;
            HRApplicantRefereeLine.Middlename := MiddleName;
            HRApplicantRefereeLine.Surname := Surname;
            HRApplicantRefereeLine."Personal E-Mail Address" := RefereeEmail;
            HRApplicantRefereeLine."Postal Address" := Address;
            HRApplicantRefereeLine."Post Code" := PostalCode;
            HRApplicantRefereeLine."Residential Address" := PhysicalAddress;
            HRApplicantRefereeLine."Referee Category" := HRApplicantRefereeLine."Referee Category"::Professional;
            if HRApplicantRefereeLine.Modify then begin
                ProfessionalRefereeLineModified := true;
            end;
        end;
    end;

    procedure DeleteProfessionalRefereeLine("LineNo.": Integer; EmailAddress: Text[100]) ProfessionalRefereeLineDeleted: Boolean
    begin
        ProfessionalRefereeLineDeleted := false;
        HRApplicantRefereeLine.Reset;
        HRApplicantRefereeLine.SetRange(HRApplicantRefereeLine."Line No.", "LineNo.");
        HRApplicantRefereeLine.SetRange(HRApplicantRefereeLine."Applicant E-mail", EmailAddress);
        if HRApplicantRefereeLine.FindFirst then begin
            if HRApplicantRefereeLine.Delete then begin
                ProfessionalRefereeLineDeleted := true;
            end;
        end;
    end;

    procedure CreatePersonalRefereeLine(EmailAddress: Text[100]; FirstName: Code[30]; MiddleName: Code[30]; Surname: Code[30]; RefereeEmail: Text[100]; Address: Text[100]; PostalCode: Text[250]; PhysicalAddress: Text[100]) PersonalRefereeLineCreated: Boolean
    begin
        PersonalRefereeLineCreated := false;
        HRApplicantRefereeLine.Init;
        HRApplicantRefereeLine."Applicant E-mail" := EmailAddress;
        HRApplicantRefereeLine.Firstname := FirstName;
        HRApplicantRefereeLine.Middlename := MiddleName;
        HRApplicantRefereeLine.Surname := Surname;
        HRApplicantRefereeLine."Personal E-Mail Address" := RefereeEmail;
        HRApplicantRefereeLine."Postal Address" := Address;
        HRApplicantRefereeLine."Post Code" := PostalCode;
        HRApplicantRefereeLine."Residential Address" := PhysicalAddress;
        HRApplicantRefereeLine."Referee Category" := HRApplicantRefereeLine."Referee Category"::Personal;
        if HRApplicantRefereeLine.Insert then begin
            PersonalRefereeLineCreated := true;
        end;
    end;

    procedure ModifyPersonalRefereeLine(LineNo: Integer; EmailAddress: Text[100]; FirstName: Code[30]; MiddleName: Code[30]; Surname: Code[30]; RefereeEmail: Text[100]; Address: Text[250]; PostalCode: Text[250]; PhysicalAddress: Text[100]) PersonalRefereeLineModified: Boolean
    begin
        PersonalRefereeLineModified := false;
        HRApplicantRefereeLine.Reset;
        HRApplicantRefereeLine.SetRange(HRApplicantRefereeLine."Line No.", LineNo);
        HRApplicantRefereeLine.SetRange("Applicant E-mail", EmailAddress);
        if HRApplicantRefereeLine.FindFirst then begin
            HRApplicantRefereeLine."Applicant E-mail" := EmailAddress;
            HRApplicantRefereeLine.Firstname := FirstName;
            HRApplicantRefereeLine.Middlename := MiddleName;
            HRApplicantRefereeLine.Surname := Surname;
            HRApplicantRefereeLine."Personal E-Mail Address" := RefereeEmail;
            HRApplicantRefereeLine."Postal Address" := Address;
            HRApplicantRefereeLine."Post Code" := PostalCode;
            HRApplicantRefereeLine."Residential Address" := PhysicalAddress;
            HRApplicantRefereeLine."Referee Category" := HRApplicantRefereeLine."Referee Category"::Personal;
            if HRApplicantRefereeLine.Modify then begin
                PersonalRefereeLineModified := true;
            end;
        end;
    end;

    procedure DeletePersonalRefereeLine("LineNo.": Integer; EmailAddress: Text[100]) PersonalRefereeLineDeleted: Boolean
    begin
        PersonalRefereeLineDeleted := false;
        HRApplicantRefereeLine.Reset;
        HRApplicantRefereeLine.SetRange(HRApplicantRefereeLine."Line No.", "LineNo.");
        HRApplicantRefereeLine.SetRange(HRApplicantRefereeLine."Applicant E-mail", EmailAddress);
        if HRApplicantRefereeLine.FindFirst then begin
            if HRApplicantRefereeLine.Delete then begin
                PersonalRefereeLineDeleted := true;
            end;
        end;
    end;

    procedure CheckJobApplicationLowerAgeLimit(EmailAddress: Text[100]) LimitedAge: Boolean
    begin
        LimitedAge := false;
        HumanResourcesSetup.Get;

        HROnlineApplicant.Reset;
        HROnlineApplicant.SetRange(HROnlineApplicant."Email Address", EmailAddress);
        if HROnlineApplicant.FindFirst then begin
            if Dates.DetermineAge_Years(HROnlineApplicant."Date of Birth", Today) < HumanResourcesSetup."Job App. Lower Age Limit" then
                LimitedAge := true;
        end;


        /*HumanResourcesSetup.GET;
        IF Dates.DetermineAge_Years(DateOfBirth,TODAY) < HumanResourcesSetup."Job App. Lower Age Limit" THEN
          LimitedAge:=TRUE ELSE
          LimitedAge:=FALSE;*/

    end;

    procedure CheckJobApplicationHigherAgeLimit(EmailAddress: Text[100]) LimitedAge: Boolean
    begin
        LimitedAge := false;
        HumanResourcesSetup.Get;

        HROnlineApplicant.Reset;
        HROnlineApplicant.SetRange(HROnlineApplicant."Email Address", EmailAddress);
        if HROnlineApplicant.FindFirst then begin
            if Dates.DetermineAge_Years(HROnlineApplicant."Date of Birth", Today) > HumanResourcesSetup."Job App. Upper Age Limit" then
                LimitedAge := true;
        end;
        /*HumanResourcesSetup.GET;
        IF Dates.DetermineAge_Years(DateOfBirth,TODAY) > HumanResourcesSetup."Job App. Upper Age Limit" THEN
          LimitedAge:=TRUE ELSE
          LimitedAge:=FALSE;*/

    end;

    procedure CheckSubmittedJobApplicationExists(EmailAddress: Text[100]; EmployeeRequisitionNo: Code[20]) SubmittedApplicationExist: Boolean
    var
        error0001: Label 'A similar application for %1 exist. Please find a different vacancy to apply.';
    begin
        SubmittedApplicationExist := false;
        HRJobApplication.Reset;
        HRJobApplication.SetRange(HRJobApplication."Email Address", EmailAddress);
        HRJobApplication.SetRange(HRJobApplication."Employee Requisition No.", EmployeeRequisitionNo);
        if HRJobApplication.FindFirst then begin
            SubmittedApplicationExist := true;
        end;
    end;

    procedure CreateJobApplication(EmployeeRequisitionNo: Code[50]; EmailAddress: Text[100]) JobApplicationCreated: Boolean
    var
        HRJobQualifications: Record "HR Job Qualifications";
        HREmployeeRequisitions: Record "HR Employee Requisitions";
        HRJobOnlineRequirements: Record "HR Job Online Requirements";
        HRJobApplicantRequirements: Record "HR Job Online Requirements";
        error0001: Label '% 1 not found';
        HRJobOnlineQualifications: Record "HR Job Online Qualifications";
        HRJobApplicantQualification: Record "HR Job Applicant Qualification";
        HRJobApplicantRequirement: Record "HR Job Applicant Requirement";
        HROnlineEmploymentHist: Record "HR Online Employment Hist.";
        HRApplicantEmploymentHist: Record "HR Applicant Employment Hist";
        HROnlineRefereeDetails: Record "HR Online Referee Details";
        HRApplicantRefereeDetails: Record "HR Applicant Referee Details";
    begin
        JobApplicationCreated := false;

        HROnlineApplicant.Get(EmailAddress);

        //Check similar application exist
        CheckSubmittedJobApplicationExists(HROnlineApplicant."Email Address", EmployeeRequisitionNo);

        /*//Check cover letter attached
        HRApplicantAccountWS.CheckCoverLetterAttached(HROnlineApplicant."Email Address");
        
        //Check Cv attached
        HRApplicantAccountWS.CheckCurriculumVitaeAttached(HROnlineApplicant."Email Address");*/

        HumanResourcesSetup.Get;

        HROnlineApplicant.Reset;
        HROnlineApplicant.SetRange("Email Address", EmailAddress);
        if HROnlineApplicant.FindFirst then begin
            HRJobApplication.Init;
            HRJobApplication."Email Address" := HROnlineApplicant."Email Address";
            HRJobApplication."Employee Requisition No." := EmployeeRequisitionNo;
            HRJobApplication."No." := NoSeriesMgt.GetNextNo(HumanResourcesSetup."Job Application Nos.", 0D, true);
            HRJobApplication.Validate(HRJobApplication."Employee Requisition No.");
            HRJobApplication.Firstname := HROnlineApplicant.Firstname;
            HRJobApplication.Middlename := HROnlineApplicant.Middlename;
            HRJobApplication.Surname := HROnlineApplicant.Surname;
            HRJobApplication."Personal Email Address" := HROnlineApplicant."Email Address";
            HRJobApplication."Date of Birth" := HROnlineApplicant."Date of Birth";
            HRJobApplication."National ID No." := HROnlineApplicant."National ID No.";
            HRJobApplication."Residential Address" := HROnlineApplicant.Address;
            HRJobApplication.Gender := HROnlineApplicant.Gender;
            HRJobApplication."County Name" := HROnlineApplicant."County Name";
            HRJobApplication."Ethnic Group" := HROnlineApplicant."Ethnic Group";
            HRJobApplication."Marital Status" := HROnlineApplicant."Marital Status";
            HRJobApplication.Religion := HROnlineApplicant.Religion;
            HRJobApplication.Citizenship := HROnlineApplicant.Citizenship;
            HRJobApplication."Mobile Phone No." := HROnlineApplicant."Mobile Phone No.";
            HRJobApplication."Person Living With Disability" := HROnlineApplicant."Person With Disability";
            HRJobApplication."Application Date" := Today;
            if HRJobApplication.Insert then begin
                HRJobApplication2.Reset;
                HRJobApplication2.SetRange(HRJobApplication2."No.", HRJobApplication."No.");
                if HRJobApplication2.FindFirst then begin
                    HRJobApplication2.Status := HRJobApplication2.Status::Submitted;
                    HRJobApplication2.ShortListed := true;
                    HRJobApplication2."Application Date" := Today;
                    HRJobApplication2.Modify;
                end;
                JobApplicationCreated := true;
            end;
        end;

        //Job Application Qualifications
        HRJobOnlineQualifications.Reset;
        HRJobOnlineQualifications.SetRange(HRJobOnlineQualifications."E-mail", EmailAddress);
        if HRJobOnlineQualifications.FindSet then begin
            repeat
                HRJobApplicantQualification.Init;
                HRJobApplicantQualification."Line No." := 0;
                HRJobApplicantQualification."Job Application No." := HRJobApplication."No.";
                HRJobApplicantQualification."Qualification Code" := HRJobOnlineQualifications."Qualification Code";
                HRJobApplicantQualification."Qualification Name" := HRJobOnlineQualifications."Qualification Name";
                HRJobApplicantQualification."Joining Date" := HRJobOnlineQualifications."Joining Date";
                HRJobApplicantQualification."Completion Date" := HRJobOnlineQualifications."Completion Date";
                HRJobApplicantQualification.Award := HRJobOnlineQualifications.Award;
                HRJobApplicantQualification."Award Date" := HRJobOnlineQualifications."Award Date";
                HRJobApplicantQualification."E-mail" := HRJobOnlineQualifications."E-mail";
                HRJobApplicantQualification.Insert;
            until HRJobOnlineQualifications.Next = 0;
        end;

        //applicant employment history
        HROnlineEmploymentHist.Reset;
        HROnlineEmploymentHist.SetRange(HROnlineEmploymentHist."E-mail", EmailAddress);
        if HROnlineEmploymentHist.FindSet then begin
            repeat
                HRApplicantEmploymentHist."Line No" := 0;
                HRApplicantEmploymentHist."Job Application No." := HRJobApplication."No.";
                HRApplicantEmploymentHist."Employer Name/Organization" := HROnlineEmploymentHist."Employer Name/Organization";
                HRApplicantEmploymentHist."Address of the Organization" := HROnlineEmploymentHist."Address of the Organization";
                HRApplicantEmploymentHist."Job Designation/Position Held" := HROnlineEmploymentHist."Job Designation/Position Held";
                HRApplicantEmploymentHist."From Date" := HROnlineEmploymentHist."From Date";
                HRApplicantEmploymentHist."To Date" := HROnlineEmploymentHist."To Date";
                HRApplicantEmploymentHist."Days/Years of service" := HROnlineEmploymentHist."Days/Years of service";
                HRApplicantEmploymentHist."Gross Salary" := HROnlineEmploymentHist."Gross Salary";
                HRApplicantEmploymentHist.Benefits := HROnlineEmploymentHist.Benefits;
                HRApplicantEmploymentHist."E-mail" := HROnlineEmploymentHist."E-mail";
                HRApplicantEmploymentHist.Insert;
            until HROnlineEmploymentHist.Next = 0;
        end;

        // applicant referees
        HROnlineRefereeDetails.Reset;
        HROnlineRefereeDetails.SetRange(HROnlineRefereeDetails."Applicant E-mail", EmailAddress);
        if HROnlineRefereeDetails.FindSet then begin
            repeat
                HRApplicantRefereeDetails."Line No." := 0;
                HRApplicantRefereeDetails."Job Application  No." := HRJobApplication."No.";
                HRApplicantRefereeDetails.Surname := HROnlineRefereeDetails.Surname;
                HRApplicantRefereeDetails.Firstname := HROnlineRefereeDetails.Firstname;
                HRApplicantRefereeDetails.Middlename := HROnlineRefereeDetails.Middlename;
                HRApplicantRefereeDetails."Personal E-Mail Address" := HROnlineRefereeDetails."Personal E-Mail Address";
                HRApplicantRefereeDetails."Postal Address" := HROnlineRefereeDetails."Postal Address";
                HRApplicantRefereeDetails."Post Code" := HROnlineRefereeDetails."Post Code";
                HRApplicantRefereeDetails."Residential Address" := HROnlineRefereeDetails."Residential Address";
                HRApplicantRefereeDetails."Referee Category" := HROnlineRefereeDetails."Referee Category";
                HRApplicantRefereeDetails.Verified := false;
                HRApplicantRefereeDetails."Applicant E-mail" := HROnlineRefereeDetails."Applicant E-mail";
                HRApplicantRefereeDetails.County := HROnlineRefereeDetails.County;
                HRApplicantRefereeDetails."Mobile No." := HROnlineRefereeDetails."Mobile No.";
                HRApplicantRefereeDetails."Country/Region Code" := HROnlineRefereeDetails."Country/Region Code";
                HRApplicantRefereeDetails.Insert;
            until HROnlineRefereeDetails.Next = 0;
        end;

        HRJobOnlineRequirements.Reset;
        HRJobOnlineRequirements.SetRange(HRJobOnlineRequirements."E-mail", EmailAddress);
        if HRJobOnlineRequirements.FindSet then begin
            repeat
                HRJobApplicantRequirement.Init;
                HRJobApplicantRequirement."Line No" := 0;
                HRJobApplicantRequirement."Job Application No." := HRJobApplication."No.";
                HRJobApplicantRequirement."Requirement Code" := HRJobOnlineRequirements."Requirement Code";
                HRJobApplicantRequirement.Description := HRJobOnlineRequirements.Description;
                HRJobApplicantRequirement."No. of Years" := HRJobOnlineRequirements."No. of Years";
                HRJobApplicantRequirement."E-mail" := HRJobOnlineRequirements."E-mail";
                HRJobApplicantRequirement.Insert;
            until HRJobOnlineRequirements.Next = 0;
        end;

    end;

    procedure InitializeDirectoryPaths()
    var
        CompanyInformation: Record "Company Information";
        HumanResourcesSetup: Record "Human Resources Setup";
    begin
        CompanyInformation.Get;
        HumanResourcesSetup.Get;
        CompanyDataDirectory := CompanyInformation."Company Data Directory Path";
        HRJobsData := HumanResourcesSetup."HR Jobs Data";
    end;

    procedure PreviewJobDetailsReport(EmailAddress: Text[100]; EmpRequisitionNo: Code[20]) JobDetailsPreviewed: Boolean
    var
        HRJobsDataFilePath: Label '%1\%2HRJobsReport.pdf';
        HREmployeeRequisitions: Record "HR Employee Requisitions";
        HRApplicantAccountWS: Codeunit "HR Applicant Account WS";
    begin
        JobDetailsPreviewed := false;
        InitializeDirectoryPaths();
        EmailAddress := HRApplicantAccountWS.GetHROnlineEmailAddress(EmailAddress);
        FileName := StrSubstNo(HRJobsDataFilePath, CompanyDataDirectory, HRJobsData);
        // if Exists(FileName) then begin
        //     Erase(FileName);
        //end;

        // HREmployeeRequisitions.Reset;
        // HREmployeeRequisitions.SetRange(HREmployeeRequisitions."No.", EmpRequisitionNo);
        // if HREmployeeRequisitions.FindFirst then begin
        //     REPORT.SaveAsPdf(REPORT::"HR Job Advert", FileName, HREmployeeRequisitions);
        //     JobDetailsPreviewed := true;
        // end;
    end;
}

