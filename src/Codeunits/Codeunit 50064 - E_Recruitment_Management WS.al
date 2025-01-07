namespace spaBC.spaBC;
using Microsoft.Purchases.Setup;
using Microsoft.HumanResources.Employee;
using Microsoft.Purchases.Vendor;
using Microsoft.HumanResources.Setup;
using Microsoft.Projects.Project.Job;
using System.EMail;
using Microsoft.Purchases.Document;
using System.Automation;
using Microsoft.Foundation.NoSeries;

codeunit 50064 "E_Recruitment Management WS"
{
    trigger OnRun()
    begin

    end;

    var
        EmployeeRequisition: Record "HR Employee Requisitions";
        JobApplication: Record "HR Job Applications";
        ApplicantAcademicQualification: Record "HR Job Applicant Qualification";
        ApplicantEmployementHistory: Record "HR Applicant Employment Hist";
        JobApplicationDocument: Record "Job Application Documents";
        PurchaseRequisition: Record "Purchase Requisitions";
        PurchaseRequisitionLine: Record "Purchase Requisition Line";
        PayablesSetup: Record "Purchases & Payables Setup";
        Employee: Record Employee;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ProcurementApprovalManager: Codeunit "Procurement Approval Manager";
        PurchaseRequisitions2: Record "Purchase Requisitions";
        ApprovalEntry: Record "Approval Entry";
        TenderLine: Record "Tender Lines";
        TenderHeader: Record "Tender Header";
        SupplierProfile: Record "Supplier Profile";
        TenderPrequalification: Record "Tender Lines";
        SupplierProfileDoc: Record "Supplier Profile Documents";
        RequestHeader: Record "Request for Quotation Header";
        RequestLines: Record "Request for Quotation Line";
        QuoteHeader: Record "Purchase Header";
        QuoteLines: Record "Purchase Line";
        TenderQuestions: Record "Tender Questions";
        TenderBankInfo: Record "Tender Bank Info";
        TenderDirectors: Record "Tender Directors";
        TenderAnswers: Record "Tender Answers";
        TenderPersonnel: Record "Tender Personnel";
        TenderExperience: Record "Tender Experience";
        TenderFinancialCapability: Record "Tender Financial Capability";
        TenderLitigation: Record "Tender Litigation";
        EvaluationCriteria: Record "Evaluation Criteria";
        TenderEvaluators: Record "Tender Evaluators";
        TenderEvaluationHeader: Record "Tender Evaluation";
        TenderEvaluationLine: Record "Tender Evaluation Line";
        QuoteStatus: Record "Purchase Header";
        LitigationQuestionsHeader: Record "Litigation Question Setup.";
        LitigationAnswersHeader: Record "Litigation Answer Setup";
        TenderEvaluationLineII: Record "Tender Evaluation Line";
        LineNo: Integer;
        Vendors: Record Vendor;
        //TenderRequiredDocument: Record Ten
        VendorsII: Record Vendor;
        SupplierProfileDocII: Record "Supplier Profile Documents";
        TenderAnswersII: Record "Tender Answers";
        EvaluationCriteriaII: Record "Evaluation Criteria";
        SpecificationAttribute: Record "Specification Attributes";
        //SMTP:    Record "SMTP Mail Setup";
        //SMTPMail    Codeunit SMTP Mail
        Subject: Text;
        Body: Text;
        Body2: Text;
        Approvals: Codeunit "Custom Workflow Mgmt";

    [Scope('Personalization')]
    procedure CreateJobApplication(var JobNo: Code[20]; JobTitle: Text; EmployeeRequisitionNo: Text; Surname: Text; FirstName: Text; MiddleName: Text; Gender: Option "Male","Female"; DateOfBirth: Date; Age: Text; PostalAddress: Text; ResidentialAddress: Text; City: code[30]; ReturnValue: Text[100]);
    var
        Projects: Record Job;
        HRSetup: Record "Human Resources Setup";
        "DocNo.": Code[10];
        NationalIDNo: Code[30];
        CityOrTown: Text[50];
        CountyCode: Code[30];
        CountyName: Text[50];
        SubCountyCode: Code[30];
        SubCountyName: text[50];
        Country: code[30];
        Declaration: Boolean;
        AlternativePhoneNo: code[50];
        MobilePhoneNo: code[50];
        PersonalEmailAddress: Text[50];
        DrivingLicenceNo: Code[30];
        Citizenship: Code[30];
        Religion: Code[30];
        EthnicGroup: Code[30];
        MaritalStatus: Option "Single","Married";
        ExpectedSalary: Decimal;
        YearOfExperience: Integer;
        OLevelGrade: Code[30];
    begin
        ReturnValue := '';
        JobApplication.RESET;
        JobApplication.SETRANGE(JobApplication."Employee Requisition No.", EmployeeRequisitionNo);
        JobApplication.SETRANGE(JobApplication."National ID No.", NationalIDNo);
        IF JobApplication.FINDFIRST THEN BEGIN
            ERROR('Already Applied');
            //ReturnValue := 'Already Applied';
        END ELSE
            HRSetup.GET;
        "DocNo." := NoSeriesMgt.GetNextNo(HRSetup."Job Application Nos.", 0D, TRUE);
        JobApplication.INIT;
        JobApplication."No." := "DocNo.";//'10';
        JobApplication."Application Date" := TODAY;
        JobApplication."Job No." := JobNo;
        JobApplication."Job Title" := JobTitle;
        JobApplication."Employee Requisition No." := EmployeeRequisitionNo;
        JobApplication.VALIDATE(JobApplication."Employee Requisition No.");
        JobApplication.Surname := Surname;
        JobApplication.Firstname := FirstName;
        JobApplication.Middlename := MiddleName;
        JobApplication.Gender := Gender;
        JobApplication."Date of Birth" := DateOfBirth;
        JobApplication.Age := Age;
        JobApplication."Postal Address" := PostalAddress;
        JobApplication."Residential Address" := ResidentialAddress;
        JobApplication."City/Town" := CityOrTown;
        JobApplication.County := CountyCode;
        JobApplication."County Name" := CountyName;
        JobApplication.SubCounty := SubCountyCode;
        JobApplication."SubCounty Name" := SubCountyName;
        JobApplication.Country := Country;
        JobApplication."Alternative Phone No." := AlternativePhoneNo;
        JobApplication."Mobile Phone No." := MobilePhoneNo;
        JobApplication."Personal Email Address" := PersonalEmailAddress;
        JobApplication."Driving Licence No." := DrivingLicenceNo;
        JobApplication.Citizenship := Citizenship;
        JobApplication."National ID No." := NationalIDNo;
        JobApplication."Ethnic Group" := EthnicGroup;
        JobApplication.Religion := Religion;
        JobApplication."Marital Status" := MaritalStatus;
        JobApplication."Expected Salary" := ExpectedSalary;//add the field to the table
        JobApplication."Years of Experience" := YearOfExperience;//add the field to the table
        JobApplication."O Level Grade" := OLevelGrade;//add the field to the table
        JobApplication."Declaration" := Declaration;////add the field to the table
        IF JobApplication.INSERT THEN BEGIN
            ReturnValue := ('Job Application created Successfully') + "DocNo.";
            //ApprovalsMgmt.OnSendHRJobApplicationForApproval(JobApplication);
        END ELSE
            ReturnValue := '400:Failed ' + GETLASTERRORCODE + '-' + GETLASTERRORTEXT;
        //Send an Application Confirmation Email to the applicant
        // SMTP.GET;
        // Subject := 'Application Confirmation';
        // SMTPMail.CreateMessage(SMTP."Sender Name", SMTP."Sender Email Address",
        //             PersonalEmailAddress,
        //             Subject, '', TRUE);
        // SMTPMail.AppendBody('Dear' + ' ' + JobApplication.Firstname + ' ' + 'Your application for' + ' ' + JobTitle + ' ' + 'has been successfuly received.Shortlisted candidates shall be contacted.');
        // SMTPMail.AppendBody('<br>');
        // SMTPMail.AppendBody(Body2);
        // SMTPMail.AppendBody('<br>');
        // SMTPMail.AppendBody('Regards,');
        // SMTPMail.AppendBody('<br><br>');
        // SMTPMail.AppendBody('This is a system generated mail. Please do not reply.');
        // SMTPMail.Send;

    end;

    [Scope('Personalization')]
    procedure ModifyJobApplication(var No: Code[50]; JobNo: Code[20]; JobTitle: Text; EmployeeRequisitionNo: Text; Surname: Text; FirstName: Text; MiddleName: Text; Gender: Option "Male","Female"; DateOfBirth: Date; Age: Text; PostalAddress: Text; ResidentialAddres: Code[50]; ReturnValue: Text[50])
    var
        Projects: Record Job;
        HRSetup: Record "Human Resources Setup";
        "DocNo.": Code[10];
        NationalIDNo: Code[30];
        CityOrTown: Text[50];
        CountyCode: Code[30];
        CountyName: Text[50];
        SubCountyCode: Code[30];
        SubCountyName: text[50];
        Country: code[30];
        Declaration: Boolean;
        AlternativePhoneNo: code[50];
        MobilePhoneNo: code[50];
        PersonalEmailAddress: Text[50];
        DrivingLicenceNo: Code[30];
        Citizenship: Code[30];
        Religion: Code[30];
        EthnicGroup: Code[30];
        MaritalStatus: Option "Single","Married";
        ExpectedSalary: Decimal;
        YearOfExperience: Integer;
        OLevelGrade: Code[30];
        ResidentialAddress: code[50];
    begin

        ReturnValue := '';
        JobApplication.GET(No);
        JobApplication."Application Date" := TODAY;
        JobApplication."Job No." := JobNo;
        JobApplication."Job Title" := JobTitle;
        JobApplication."Employee Requisition No." := EmployeeRequisitionNo;
        JobApplication.Surname := Surname;
        JobApplication.Firstname := FirstName;
        JobApplication.Middlename := MiddleName;
        JobApplication.Gender := Gender;
        JobApplication."Date of Birth" := DateOfBirth;
        JobApplication.Age := Age;
        JobApplication."Postal Address" := PostalAddress;
        JobApplication."Residential Address" := ResidentialAddress;//add to the table
        JobApplication."City/Town" := CityOrTown;
        JobApplication.County := CountyCode;
        JobApplication."County Name" := CountyName;
        JobApplication.SubCounty := SubCountyCode;
        JobApplication."SubCounty Name" := SubCountyName;
        JobApplication.Country := Country;
        JobApplication."Alternative Phone No." := AlternativePhoneNo;
        JobApplication."Mobile Phone No." := MobilePhoneNo;
        JobApplication."Personal Email Address" := PersonalEmailAddress;
        JobApplication."Driving Licence No." := DrivingLicenceNo;
        JobApplication.Citizenship := Citizenship;
        JobApplication."National ID No." := NationalIDNo;
        JobApplication."Ethnic Group" := EthnicGroup;
        JobApplication.Religion := Religion;
        JobApplication."Marital Status" := MaritalStatus;
        JobApplication."Expected Salary" := ExpectedSalary;///add to the table
        JobApplication."Years of Experience" := YearOfExperience;///add to the table
        IF JobApplication.MODIFY THEN
            ReturnValue := '200: Record ' + No + ' Updated Successfully'
        ELSE
            ReturnValue := '400: Failed ' + GETLASTERRORCODE + '-' + GETLASTERRORTEXT;
    end;

    [Scope('Personalization')]
    procedure GetAppliedJobApplications(var JobApplicationExport: XMLport "Job Application Export"; NationalIDNo: Text[30])
    begin
        JobApplication.RESET;
        JobApplication.SETRANGE("National ID No.", NationalIDNo);
        //JobApplication.SETRANGE("No.","DocNo.");//added
        IF JobApplication.FINDFIRST THEN;
        JobApplicationExport.SETTABLEVIEW(JobApplication);
    end;

    [Scope('Personalization')]
    procedure CreateAcademicQualification(var JobApplicationNo: Code[20]; QualificationCode: Code[1000]; YearOfRegistration: Decimal; QualificationName: Text; JoiningDate: Date; CompletionDate: Date; InstitutionName: Text; Award: Text; AwardDate: Date; Email: Text; IsProfessionQualification: Boolean; ReturnValue: Text[50])
    var
        myInt: Integer;
    begin

        ReturnValue := '';
        ApplicantAcademicQualification.INIT;
        ApplicantAcademicQualification."Job Application No." := JobApplicationNo;//'10';
        ApplicantAcademicQualification."Qualification Code" := QualificationCode;
        ApplicantAcademicQualification."Qualification Name" := QualificationName;
        ApplicantAcademicQualification."Joining Date" := JoiningDate;
        ApplicantAcademicQualification."Completion Date" := CompletionDate;
        ApplicantAcademicQualification."Institution Name" := InstitutionName;
        ApplicantAcademicQualification.Award := Award;
        ApplicantAcademicQualification."Award Date" := AwardDate;
        ApplicantAcademicQualification."E-mail" := Email;
        ApplicantAcademicQualification."Professional Qualification" := IsProfessionQualification;//add the field to the table
        ApplicantAcademicQualification."Year of Registration" := YearOfRegistration;
        IF ApplicantAcademicQualification.INSERT THEN
            ReturnValue := '200: Record ' + FORMAT(ApplicantAcademicQualification."Line No.") + ' Created Successfully'
        ELSE
            ReturnValue := '400: Failed' + GETLASTERRORCODE + '-' + GETLASTERRORTEXT;

    end;

    [Scope('Personalization')]
    procedure ModifyAcademicQualification(var LineNo: Integer; JobApplicationNo: Code[20]; QualificationCode: Code[1000]; QualificationName: Text; JoiningDate: Date; CompletionDate: Date; InstitutionName: Text; Award: Text; AwardDate: Date; Email: Text; IsProfessionQualification: Boolean; YearOfRegistration: Integer; ReturnValue: Text[50])
    begin
        ReturnValue := '';
        ApplicantAcademicQualification.GET(LineNo, JobApplicationNo);
        ApplicantAcademicQualification."Job Application No." := JobApplicationNo;//'10';
        ApplicantAcademicQualification."Qualification Code" := QualificationCode;
        ApplicantAcademicQualification."Qualification Name" := QualificationName;
        ApplicantAcademicQualification."Joining Date" := JoiningDate;
        ApplicantAcademicQualification."Completion Date" := CompletionDate;
        ApplicantAcademicQualification."Institution Name" := InstitutionName;
        ApplicantAcademicQualification.Award := Award;
        ApplicantAcademicQualification."Award Date" := AwardDate;
        ApplicantAcademicQualification."E-mail" := Email;
        ApplicantAcademicQualification."Professional Qualification" := IsProfessionQualification;//add to the table
        ApplicantAcademicQualification."Year of Registration" := YearOfRegistration;//add to the table
        IF ApplicantAcademicQualification.MODIFY THEN
            ReturnValue := '200: Record ' + FORMAT(LineNo) + ' Updated Successfully'
        ELSE
            ReturnValue := '400: failed' + GETLASTERRORCODE + '-' + GETLASTERRORTEXT;

    end;

    [Scope('Personalization')]
    procedure GetAcademicQualification(var JobAcademicQualificationExport: XmlPort JobAcademicQualificationExport; JobNo: Code[50])
    begin
        ApplicantAcademicQualification.RESET;
        ApplicantAcademicQualification.SETRANGE("Job Application No.", JobNo);
        IF ApplicantAcademicQualification.FINDFIRST THEN;
        JobAcademicQualificationExport.SETTABLEVIEW(ApplicantAcademicQualification);
    end;

    [Scope('Personalization')]
    procedure DeleteJobApplication(JobNo: Code[20]; ReturnValue: Text)
    begin
        ReturnValue := '';
        JobApplication.RESET;
        JobApplication.SETRANGE("Job No.", JobNo);
        IF JobApplication.FINDFIRST THEN BEGIN
            JobApplication.DELETE;
            ReturnValue := '200: Deleted Successfully'
        END ELSE
            ReturnValue := '400: Record Not found' + GETLASTERRORCODE + '-' + GETLASTERRORTEXT;
    end;

    [Scope('Personalization')]
    procedure DeleteAcademicQualification(LineNo: Integer; ReturnValue: Text)
    begin
        ReturnValue := '';
        ApplicantAcademicQualification.RESET;
        ApplicantAcademicQualification.SETRANGE("Line No.", LineNo);
        IF ApplicantAcademicQualification.FINDFIRST THEN BEGIN
            ApplicantAcademicQualification.DELETE;
            ReturnValue := '200: Deleted Successfully'
        END ELSE
            ReturnValue := '400: Record Not found' + GETLASTERRORCODE + '-' + GETLASTERRORTEXT;
    end;

    [Scope('Personalization')]
    local procedure CreateEmploymentHistory(JobApplicationNo: Code[20]; Organization: Text; OrganizationAddress: Text; PositionHeld: Text; FromDate: Date; ToDate: Date; YearsOfService: Text; GrossSalary: Decimal; Benefits: Text; Email: Text; JobDescription: Text[100]; ReturnValue: Text[100])
    begin
        ReturnValue := '';
        //"DocNo.":= NoSeriesMgt.GetNextNo(JobSetup."Job Nos.",0D,TRUE);
        ApplicantEmployementHistory.INIT;
        ApplicantEmployementHistory."Job Application No." := JobApplicationNo;//'10';
        ApplicantEmployementHistory."Employer Name/Organization" := Organization;
        ApplicantEmployementHistory."Job Designation/Position Held" := PositionHeld;
        ApplicantEmployementHistory."From Date" := FromDate;
        ApplicantEmployementHistory."To Date" := ToDate;
        ApplicantEmployementHistory."Days/Years of service" := YearsOfService;
        ApplicantEmployementHistory."Gross Salary" := GrossSalary;
        ApplicantEmployementHistory.Benefits := Benefits;
        ApplicantEmployementHistory."E-mail" := Email;
        ApplicantEmployementHistory."Job Held Description" := JobDescription;//add the field 
        IF ApplicantEmployementHistory.INSERT then begin
            ReturnValue := '200: Record ' + FORMAT(ApplicantEmployementHistory."Line No") + ' Created Successfully'
        end ELSE
            ReturnValue := '400: failed' + GETLASTERRORCODE + '-' + GETLASTERRORTEXT;
    end;

    [Scope('Personalization')]
    procedure ModifyEmploymentHistory(LineNo: Integer; JobApplicationNo: Code[20]; Organization: Text; OrganizationAddress: Text; PositionHeld: Text; FromDate: Date; ToDate: Date; YearsOfService: Text; GrossSalary: Decimal; Benefits: Text; Email: Text; ReturnValue: text[50])
    begin
        ReturnValue := '';
        ApplicantEmployementHistory.GET(LineNo, JobApplicationNo);
        ApplicantEmployementHistory."Job Application No." := JobApplicationNo;//'10';
        ApplicantEmployementHistory."Employer Name/Organization" := Organization;
        ApplicantEmployementHistory."Job Designation/Position Held" := PositionHeld;
        ApplicantEmployementHistory."From Date" := FromDate;
        ApplicantEmployementHistory."To Date" := ToDate;
        ApplicantEmployementHistory."Days/Years of service" := YearsOfService;
        ApplicantEmployementHistory."Gross Salary" := GrossSalary;
        ApplicantEmployementHistory.Benefits := Benefits;
        ApplicantEmployementHistory."E-mail" := Email;
        IF ApplicantEmployementHistory.MODIFY THEN
            ReturnValue := '200: Record Updated Successfully'
        ELSE
            ReturnValue := '400:' + GETLASTERRORCODE + '-' + GETLASTERRORTEXT;
    end;

    [Scope('Personalization')]
    procedure GetEmploymentHistory(var JobEmploymentHistoryExport: XMLport "JobEmploymentHistoryExport"; JobNo: Code[20])
    begin
        ApplicantEmployementHistory.Reset;
        ApplicantEmployementHistory.SETRANGE("Job Application No.", JobNo);
        if ApplicantEmployementHistory.FINDFIRST Then
            JobEmploymentHistoryExport.SETTABLEVIEW(ApplicantEmployementHistory);
    end;

    [Scope('Personalization')]
    procedure DeleteEmploymentHistory(LineNo: Integer; ReturnValue: Text[50])
    begin
        ReturnValue := '';
        ApplicantEmployementHistory.RESET;
        ApplicantEmployementHistory.SETRANGE("Line No", LineNo);
        IF ApplicantEmployementHistory.FINDFIRST THEN BEGIN
            ApplicantEmployementHistory.DELETE;
            ReturnValue := '200: Deleted Successfully'
        END ELSE
            ReturnValue := '400: Record Not found' + GETLASTERRORCODE + '-' + GETLASTERRORTEXT;
    end;


    [Scope('Personalization')]
    procedure SubmitJobApplication(JobNo: Code[20]; ReturnValue: Text[50])
    begin
        ReturnValue := '';
        JobApplication.RESET;
        JobApplication.SETRANGE("No.", JobNo);
        IF JobApplication.FINDFIRST THEN BEGIN
            JobApplication.Status := JobApplication.Status::Submitted;
            IF JobApplication.MODIFY THEN
                ReturnValue := '200: Submitted Successfully'
            ELSE
                ReturnValue := '400: Failed' + GETLASTERRORCODE + '-' + GETLASTERRORTEXT;
        end;
    end;


    [Scope('Personalization')]
    procedure GetQualificationCodeList(VAR JobQualifitionCodesExport: XMLport "JobQualificationCodes Export")
    begin

    end;

    [Scope('Personalization')]
    procedure GetJobApplicationDocuments(VAR JobApplicationDocumentsExport: XMLport "JobApplicationDocumentsExport"; JobNo: Code[20])
    begin
        JobApplicationDocument.RESET;
        JobApplicationDocument.SETRANGE("Job Application No", JobNo);
        IF JobApplicationDocument.FINDFIRST THEN;
        JobApplicationDocumentsExport.SETTABLEVIEW(JobApplicationDocument);

    end;

    [Scope('Personalization')]
    procedure CreateJobApplicationDocument(JobApplicationNo: Code[20]; DocumentDescription: Text[100]; ActualFileName: Text[100]; ReturnValue: Text)
    begin
        ReturnValue := '';
        JobApplicationDocument."Job Application No" := JobApplicationNo;//'10';
        JobApplicationDocument."Document Description" := DocumentDescription;
        JobApplicationDocument."Actual File Name" := ActualFileName;
        IF JobApplicationDocument.INSERT THEN
            ReturnValue := '200: Record ' + FORMAT(JobApplicationDocument.LineNo) + ' Created Successfully'
        ELSE
            ReturnValue := '400: Failed' + GETLASTERRORCODE + '-' + GETLASTERRORTEXT;
    end;

    [Scope('Personalization')]
    procedure DeleteJobApplicationDocument(LineNo: Integer; ReturnValue: Text[100])
    begin
        ReturnValue := '';
        JobApplicationDocument.RESET;
        JobApplicationDocument.SETRANGE(LineNo, LineNo);
        IF JobApplicationDocument.FINDFIRST THEN BEGIN
            JobApplicationDocument.DELETE;
            ReturnValue := '200: Deleted Successfully'
        END ELSE
            ReturnValue := '400: Record Not found' + GETLASTERRORCODE + '-' + GETLASTERRORTEXT;
    end;
}


