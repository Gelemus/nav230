codeunit 50022 "HR Applicant Account WS"
{

    trigger OnRun()
    begin
    end;

    var
        HROnlineApplicant: Record "HR  Online Applicant";
        SERVERDIRECTORYPATH: Label 'C:\inetpub\wwwroot\HWWK\EmployeeData\';
        TxtCharsToKeep: Label 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

    procedure HROnlineApplicantEmailExist(EmailAddress: Text[100]) EmailExists: Boolean
    begin
        EmailExists := false;
        HROnlineApplicant.Reset;

        if HROnlineApplicant.Get(EmailAddress) then begin
            EmailExists := true;
        end;
    end;

    procedure CreateApplicantProfile(FirstName: Text[50]; Surname: Text[50]; EmailAddress: Text[100]) OnlineApplicantRegistered: Boolean
    var
        CurriculumVitae: Record "Curriculum Vitae";
        CoverLetter: Record "Cover Letter";
        HROnlineApplicant2: Record "HR  Online Applicant";
    begin
        OnlineApplicantRegistered := false;
        HROnlineApplicant.Init;
        HROnlineApplicant.Firstname := FirstName;
        HROnlineApplicant.Surname := Surname;
        HROnlineApplicant."Email Address" := EmailAddress;
        if HROnlineApplicant.Insert then begin
            OnlineApplicantRegistered := true;
        end;

        InsertRequiredApplicationDocuments(EmailAddress);
    end;

    procedure ModifyApplicantProfile(EmailAddress: Text[100]; MiddleName: Text[50]; DOB: Date; IDNO: Code[20]; PostCode: Code[20]; PostalAddress: Text[100]; PhysicalAddress: Text[100]; Gender: Text[50]; City: Text[50]; Country: Text[50]; County: Text[50]; SubCounty: Text[50]; Citizenship: Text[50]; OtherCitizenship: Text[50]; MobilePhoneNo: Code[20]; AlternativeMobileNo: Code[20]; PersonWithDisability: Code[10]) HROnlineApplicantModified: Boolean
    begin
        HROnlineApplicantModified := false;
        HROnlineApplicant.Reset;
        HROnlineApplicant.SetRange(HROnlineApplicant."Email Address", EmailAddress);
        if HROnlineApplicant.FindFirst then begin
            HROnlineApplicant."Email Address" := HROnlineApplicant."Email Address";
            HROnlineApplicant.Firstname := HROnlineApplicant.Firstname;
            HROnlineApplicant.Middlename := MiddleName;
            HROnlineApplicant.Surname := HROnlineApplicant.Surname;
            HROnlineApplicant."Date of Birth" := DOB;
            HROnlineApplicant.Validate(HROnlineApplicant."Date of Birth");
            HROnlineApplicant."National ID No." := IDNO;
            HROnlineApplicant.Address := PostalAddress;
            HROnlineApplicant."Post Code" := PostCode;
            HROnlineApplicant.Address2 := PhysicalAddress;
            case Gender of
                'Male':
                    HROnlineApplicant.Gender := HROnlineApplicant.Gender::Male;
            end;
            case Gender of
                'Female':
                    HROnlineApplicant.Gender := HROnlineApplicant.Gender::Female;
            end;
            HROnlineApplicant.City := City;
            HROnlineApplicant.Country := Country;
            HROnlineApplicant.County := County;
            HROnlineApplicant."County Name" := County;
            HROnlineApplicant.SubCounty := SubCounty;
            HROnlineApplicant."SubCounty Name" := SubCounty;
            HROnlineApplicant.Citizenship := Citizenship;
            HROnlineApplicant."Other Citizenship" := OtherCitizenship;
            HROnlineApplicant."Mobile Phone No." := MobilePhoneNo;
            HROnlineApplicant."Home Phone No." := AlternativeMobileNo;
            case PersonWithDisability of
                'No':
                    HROnlineApplicant."Person With Disability" := HROnlineApplicant."Person With Disability"::No;
            end;
            case Gender of
                'Yes':
                    HROnlineApplicant."Person With Disability" := HROnlineApplicant."Person With Disability"::Yes;
            end;
            Message(Format(PersonWithDisability));
            if HROnlineApplicant.Modify then begin
                HROnlineApplicantModified := true;
            end;
        end;
    end;

    procedure GetFirstName(EmailAddress: Text[100]) Fname: Text
    begin
        Fname := '';
        HROnlineApplicant.Reset;
        if HROnlineApplicant.Get(EmailAddress) then begin
            Fname := HROnlineApplicant.Firstname;
        end;
    end;

    procedure GetSurname(EmailAddress: Text[100]) Sname: Text
    begin
        Sname := '';
        HROnlineApplicant.Reset;
        if HROnlineApplicant.Get(EmailAddress) then begin
            Sname := HROnlineApplicant.Surname;
        end;
    end;

    procedure GetDateOfBirth(EmailAddress: Text[100]) BirthDay: Text[30]
    begin
        BirthDay := '';
        HROnlineApplicant.Reset;
        if HROnlineApplicant.Get(BirthDay) then begin
            BirthDay := Format(HROnlineApplicant."Date of Birth");
        end;
    end;

    procedure GetHROnlineEmailAddress(EmailAddress: Text[100]) HROnlineEmail: Text
    begin
        HROnlineEmail := '';
        HROnlineApplicant.Reset;
        if HROnlineApplicant.Get(EmailAddress) then begin
            HROnlineEmail := HROnlineApplicant."Email Address";
        end;
    end;

    procedure GetHROnlineApplicantName(EmailAddress: Text[100]) HROnlineApplicantName: Text
    begin
        HROnlineApplicantName := '';
        HROnlineApplicant.Reset;
        if HROnlineApplicant.Get(EmailAddress) then begin
            HROnlineApplicantName := HROnlineApplicant.Firstname + ' ' + HROnlineApplicant.Middlename + ' ' + HROnlineApplicant.Surname;
        end;
    end;

    procedure GetHROnlineApplicantGender(EmailAddress: Text[100]) HROnlineApplicantGender: Text
    begin
        HROnlineApplicantGender := '';

        HROnlineApplicant.Reset;
        if HROnlineApplicant.Get(EmailAddress) then begin
            HROnlineApplicantGender := Format(HROnlineApplicant.Gender);
        end;
    end;

    procedure LoginHROnlineApplicant(EmailAddress: Text[100]; Password: Text) LoginSuccessful: Boolean
    begin
        LoginSuccessful := false;

        HROnlineApplicant.Reset;
        if HROnlineApplicant.Get(EmailAddress) then begin
            if (HROnlineApplicant."Portal Password" = Password) then
                LoginSuccessful := true;
        end;
    end;

    procedure IsHROnlineApplicantDefaultPassword(EmailAddress: Text[100]) IsDefaultPassword: Boolean
    begin
        IsDefaultPassword := false;

        HROnlineApplicant.Reset;
        if HROnlineApplicant.Get(EmailAddress) then begin
            if HROnlineApplicant."Default Portal Password" then
                IsDefaultPassword := true;
        end;
    end;

    procedure SetPasswordResetToken(EmailAddress: Text[100]; PasswordResetToken: Text[250]) TokenSetSuccessfully: Boolean
    begin
        TokenSetSuccessfully := false;
        HROnlineApplicant.Reset;
        if HROnlineApplicant.Get(EmailAddress) then begin
            HROnlineApplicant.PasswordResetToken := PasswordResetToken;
            HROnlineApplicant.PasswordResetTokenExpiry := CreateDateTime(CalcDate('+1D', Today), Time);
            if HROnlineApplicant.Modify then
                TokenSetSuccessfully := true;
        end;
    end;

    procedure GetPasswordResetToken(EmailAddress: Text[100]) PasswordResetToken: Text[250]
    begin
        PasswordResetToken := '';

        HROnlineApplicant.Reset;
        if HROnlineApplicant.Get(EmailAddress) then begin
            PasswordResetToken := HROnlineApplicant.PasswordResetToken;
        end;
    end;

    procedure IsPasswordResetTokenExpired(EmailAddress: Text[100]; PasswordResetToken: Text[250]) TokenExpired: Boolean
    begin
        TokenExpired := false;
        HROnlineApplicant.Reset;
        if HROnlineApplicant.Get(EmailAddress) then begin
            if (CurrentDateTime > HROnlineApplicant.PasswordResetTokenExpiry) then
                TokenExpired := true;
        end;
    end;

    procedure SendPasswordResetLink(EmailAddress: Text[100]; EmailMessage: Text) LinkSendSuccessful: Boolean
    var
        // SMTPMailSetup: Record "SMTP Mail Setup";
        // SMTPMail: Codeunit "SMTP Mail";
        EmailSubject: Label 'New Password Setup.';
        EmailSalutation: Label '<p>Dear %1,</p>';
        EmailSpacing: Label '<br>';
        EmailFooter: Label 'Sincerely,<br>%1, ICT Division';
        EmailFooter2: Label '<hr><p><i>This message was sent from an unmonitored email address. Please do not reply to this message.</i></p>';
        CompanyInformation: Record "Company Information";
    begin
        LinkSendSuccessful := false;
        HROnlineApplicant.Reset;
        if HROnlineApplicant.Get(EmailAddress) then begin
            CompanyInformation.Get;
            // SMTPMailSetup.Get;
            // SMTPMail.CreateMessage(CompanyInformation.Name,SMTPMailSetup."User ID",HROnlineApplicant."Email Address",EmailSubject,'',true);
            // SMTPMail.AppendBody(StrSubstNo(EmailSalutation,GetHROnlineApplicantName(EmailAddress)));
            // SMTPMail.AppendBody(EmailMessage);
            // SMTPMail.AppendBody(EmailSpacing);
            // SMTPMail.AppendBody(StrSubstNo(EmailFooter,CompanyInformation.Name));
            // SMTPMail.AppendBody(EmailFooter2);
            // LinkSendSuccessful:=SMTPMail.TrySend();
        end;
    end;

    procedure ResetHROnlineApplicantPortalPassword(EmailAdddress: Text[100]; NewPassword: Text[250]) PasswordResetSuccessful: Boolean
    begin
        PasswordResetSuccessful := false;
        HROnlineApplicant.Reset;
        if HROnlineApplicant.Get(EmailAdddress) then begin
            HROnlineApplicant."Portal Password" := NewPassword;
            HROnlineApplicant."Default Portal Password" := false;
            HROnlineApplicant.PasswordResetTokenExpiry := CreateDateTime(CalcDate('-1D', Today), Time);
            if HROnlineApplicant.Modify then
                PasswordResetSuccessful := true;
        end;
    end;

    procedure InsertRequiredApplicationDocuments(EmailAddress: Code[80]) ApplicationDocumentsInserted: Boolean
    var
        CurriculumVitae: Record "Curriculum Vitae";
        CoverLetter: Record "Cover Letter";
        Text123: Label 'The Email is %1';
    begin

        ApplicationDocumentsInserted := false;
        //curriculum vitae
        CurriculumVitae.Init;
        CurriculumVitae."Email Address" := HROnlineApplicant."Email Address";
        CurriculumVitae."Document Code" := UpperCase('Curriculum Vitae');
        CurriculumVitae."Document Description" := UpperCase('Curriculum Vitae');
        CurriculumVitae."Document Attached" := false;
        CurriculumVitae.Insert;

        //cover letter
        CoverLetter.Init;
        CoverLetter."Email Address" := HROnlineApplicant."Email Address";
        CoverLetter."Document Code" := UpperCase('Cover Letter');
        CoverLetter."Document Description" := UpperCase('Cover Letter');
        CoverLetter."Document Attached" := false;
        CoverLetter.Insert;

        ApplicationDocumentsInserted := true;
    end;

    procedure ModifyCurriculumVitaeLocalURL(EmailAddress: Code[80]; DocumentCode: Code[50]; LocalURL: Text[250]) ApplicationDocumentModified: Boolean
    var
        CurriculumVitae: Record "Curriculum Vitae";
        FromString: Text;
        ToString: Text;
    begin
        ApplicationDocumentModified := false;
        CurriculumVitae.Reset;
        CurriculumVitae.SetRange(CurriculumVitae."Email Address", EmailAddress);
        CurriculumVitae.SetRange(CurriculumVitae."Document Code", DocumentCode);
        if CurriculumVitae.FindFirst then begin
            CurriculumVitae."Local File URL" := LocalURL;
            CurriculumVitae."Document Attached" := true;
            FromString := '\';
            ToString := '/';
            CurriculumVitae."Local File URL" := ConvertStr(CurriculumVitae."Local File URL", FromString, ToString);
            if CurriculumVitae.Modify then
                ApplicationDocumentModified := true;
        end;
    end;

    procedure ModifyCoverLetterLocalURL(EmailAddress: Code[80]; DocumentCode: Code[50]; LocalURL: Text[250]) ApplicationDocumentModified: Boolean
    var
        CoverLetter: Record "Cover Letter";
        FromString: Text;
        ToString: Text;
    begin
        ApplicationDocumentModified := false;
        CoverLetter.Reset;
        CoverLetter.SetRange(CoverLetter."Email Address", EmailAddress);
        CoverLetter.SetRange(CoverLetter."Document Code", DocumentCode);
        if CoverLetter.FindFirst then begin
            CoverLetter."Local File URL" := LocalURL;
            CoverLetter."Document Attached" := true;
            FromString := '\';
            ToString := '/';
            CoverLetter."Local File URL" := ConvertStr(CoverLetter."Local File URL", FromString, ToString);
            if CoverLetter.Modify then
                ApplicationDocumentModified := true;
        end;
    end;

    procedure CheckCurriculumVitaeAttached(EmailAddress: Code[80]) CurriculumVitaeAttached: Boolean
    var
        CurriculumVitae: Record "Curriculum Vitae";
    begin
        CurriculumVitaeAttached := false;
        CurriculumVitae.Reset;
        CurriculumVitae.SetRange(CurriculumVitae."Email Address", EmailAddress);
        if CurriculumVitae.FindSet then begin
            repeat
                if CurriculumVitae."Local File URL" = '' then
                    Error(CurriculumVitae."Document Description" + ' has not been attached. This is a mandatory document at application.');
            until CurriculumVitae.Next = 0;
            CurriculumVitaeAttached := true;
        end;
    end;

    procedure CheckCoverLetterAttached(EmailAddress: Code[80]) CoverLetterAttached: Boolean
    var
        CoverLetter: Record "Cover Letter";
    begin
        CoverLetterAttached := false;
        CoverLetter.Reset;
        CoverLetter.SetRange(CoverLetter."Email Address", EmailAddress);
        if CoverLetter.FindSet then begin
            repeat
                if CoverLetter."Local File URL" = '' then
                    Error(CoverLetter."Document Description" + ' has not been attached. This is a mandatory document at application.');
            until CoverLetter.Next = 0;
            CoverLetterAttached := true;
        end;
    end;

    procedure DeleteCurrilumVitae(EmailAddress: Code[80]) CurriculumVitaeDeleted: Boolean
    var
        CurriculumVitae: Record "Curriculum Vitae";
    begin
        CurriculumVitaeDeleted := false;
        CurriculumVitae.Reset;
        CurriculumVitae.SetRange(CurriculumVitae."Email Address", EmailAddress);
        if CurriculumVitae.FindSet then begin
            CurriculumVitae.DeleteAll;
            CurriculumVitaeDeleted := true;
        end;
    end;

    procedure DeleteCoverLetter(EmailAddress: Code[80]) CoverLetterDeleted: Boolean
    var
        CoverLetter: Record "Cover Letter";
    begin
        CoverLetterDeleted := false;
        CoverLetter.Reset;
        CoverLetter.SetRange(CoverLetter."Email Address", EmailAddress);
        if CoverLetter.FindSet then begin
            CoverLetter.DeleteAll;
            CoverLetterDeleted := true;
        end;
    end;
}

