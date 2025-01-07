codeunit 50037 "Employee Account WS"
{

    trigger OnRun()
    begin
    end;

    var
        Employee: Record Employee;
        SERVERDIRECTORYPATH: Label 'C:\inetpub\wwwroot\HWWK\EmployeeData\';
        TxtCharsToKeep: Label 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_';
        CompanyInformation: Record "Company Information";
        HumanResourcesSetup: Record "Human Resources Setup";

    procedure EmployeeExists("EmployeeNo.": Code[20]) EmployeeExist: Boolean
    begin
        EmployeeExist := false;
        Employee.Reset;
        if Employee.Get("EmployeeNo.") then begin
            EmployeeExist := true;
        end;
    end;

    procedure EmployeeAccountIsActive("EmployeeNo.": Code[20]) EmployeeAccountActive: Boolean
    begin
        EmployeeAccountActive := false;

        Employee.Reset;
        if Employee.Get("EmployeeNo.") then begin
            if Employee.Status = Employee.Status::Active then
                EmployeeAccountActive := true;
        end;
    end;

    procedure GetCleanedEmployeeNo("EmployeeNo.": Code[20]) "CleanedEmployeeNo.": Text
    begin
        "CleanedEmployeeNo." := '';
        "CleanedEmployeeNo." := DelChr("EmployeeNo.", '=', DelChr("EmployeeNo.", '=', TxtCharsToKeep));
    end;

    procedure GetEmployeeName("EmployeeNo.": Code[20]) EmployeeName: Text
    begin
        EmployeeName := '';

        Employee.Reset;
        if Employee.Get("EmployeeNo.") then begin
            EmployeeName := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
        end;
    end;

    procedure GetEmployeeGender("EmployeeNo.": Code[20]) EmployeeGender: Text
    begin
        EmployeeGender := '';

        Employee.Reset;
        if Employee.Get("EmployeeNo.") then begin
            EmployeeGender := Format(Employee.Gender);
        end;
    end;

    procedure GetEmployeeDateOfBirth("EmployeeNo.": Code[20]) BirthDay: Text
    var
        Age: Text;
        FucnDates: Codeunit Dates;
    begin
        BirthDay := '';
        Employee.Reset;
        if Employee.Get("EmployeeNo.") then begin
            BirthDay := Format(Employee."Birth Date");
        end;
    end;

    procedure GetEmployeeAge("EmployeeNo.": Code[20]) EmployeeAge: Text
    var
        Age: Text;
        FucnDates: Codeunit Dates;
    begin
        EmployeeAge := '';
        Employee.Reset;
        if Employee.Get("EmployeeNo.") then begin
            EmployeeAge := FucnDates.DetermineAge(Employee."Birth Date", Today);
        end;
    end;

    procedure GetEmployeeRetirementDate("EmployeeNo.": Code[20]) RetirementDate: Text
    var
        Age: Text;
        FucnDates: Codeunit Dates;
        HumanResourcesSetup: Record "Human Resources Setup";
    begin
        RetirementDate := '';
        Employee.Reset;
        if Employee.Get("EmployeeNo.") then begin
            HumanResourcesSetup.Get;
            RetirementDate := Format(CalcDate(HumanResourcesSetup."Retirement Age", Employee."Birth Date"));
        end;
    end;

    procedure GetEmployeeEmailAddress("EmployeeNo.": Code[20]) EmployeeEmailAddress: Text
    begin
        EmployeeEmailAddress := '';

        Employee.Reset;
        if Employee.Get("EmployeeNo.") then begin
            EmployeeEmailAddress := Employee."Company E-Mail";
        end;
    end;

    procedure GetEmployeeUserID("EmployeeNo.": Code[20]) EmployeeUserID: Text
    begin
        EmployeeUserID := '';

        Employee.Reset;
        if Employee.Get("EmployeeNo.") then begin
            EmployeeUserID := Employee."User ID";
        end;
    end;

    procedure CreateEmployeeDirectory("EmployeeNo.": Code[20])
    var
        CompanyDataDirectory: Text;
        EmployeeDataDirectory: Text;
        // [RunOnClient]
        //DirectoryHelper: DotNet Directory;
        DirectoryPath: Label '%1\%2\%3';
        EmployeeDirectoryPath: Text;
    begin
        CompanyInformation.Get;
        HumanResourcesSetup.Get;
        CompanyInformation.TestField(CompanyInformation."Company Data Directory Path");
        HumanResourcesSetup.TestField(HumanResourcesSetup."Employee Data Directory Name");
        CompanyDataDirectory := CompanyInformation."Company Data Directory Path";
        EmployeeDataDirectory := HumanResourcesSetup."Employee Data Directory Name";

        EmployeeDirectoryPath := StrSubstNo(DirectoryPath, CompanyDataDirectory, EmployeeDataDirectory, GetCleanedEmployeeNo("EmployeeNo."));

        // if not DirectoryHelper.Exists(EmployeeDirectoryPath) then begin
        //   DirectoryHelper.CreateDirectory(EmployeeDirectoryPath);
        // end;
    end;

    procedure LoginEmployee("EmployeeNo.": Code[20]; Password: Text) LoginSuccessful: Boolean
    begin
        LoginSuccessful := false;

        Employee.Reset;
        if Employee.Get("EmployeeNo.") then begin
            if (Employee."Portal Password" = Password) then
                LoginSuccessful := true;
        end;
    end;

    procedure IsEmployeeDefaultPassword("EmployeeNo.": Code[20]) IsDefaultPassword: Boolean
    begin
        IsDefaultPassword := false;

        Employee.Reset;
        if Employee.Get("EmployeeNo.") then begin
            if Employee."Default Portal Password" then
                IsDefaultPassword := true;
        end;
    end;

    procedure SetPasswordResetToken("EmployeeNo.": Code[20]; PasswordResetToken: Text[250]) TokenSetSuccessfully: Boolean
    begin
        TokenSetSuccessfully := false;

        Employee.Reset;
        if Employee.Get("EmployeeNo.") then begin
            Employee.PasswordResetToken := PasswordResetToken;
            Employee.PasswordResetTokenExpiry := CreateDateTime(CalcDate('+1D', Today), Time);
            if Employee.Modify then
                TokenSetSuccessfully := true;
        end;
    end;

    procedure GetPasswordResetToken("EmployeeNo.": Code[20]) PasswordResetToken: Text[250]
    begin
        PasswordResetToken := '';

        Employee.Reset;
        if Employee.Get("EmployeeNo.") then begin
            PasswordResetToken := Employee.PasswordResetToken;
        end;
    end;

    procedure IsPasswordResetTokenExpired("EmployeeNo.": Code[20]; PasswordResetToken: Text[250]) TokenExpired: Boolean
    begin
        TokenExpired := false;
        Employee.Reset;
        if Employee.Get("EmployeeNo.") then begin
            if (CurrentDateTime > Employee.PasswordResetTokenExpiry) then
                TokenExpired := true;
        end;
    end;

    procedure SendPasswordResetLink("EmployeeNo.": Code[20]; EmailMessage: Text) LinkSendSuccessful: Boolean
    var
        // SMTPMailSetup: Record "SMTP Mail Setup";
        // SMTPMail: Codeunit "SMTP Mail";
        EmailSubject: Label 'New Password Setup';
        EmailSalutation: Label '<p>Dear %1,</p>';
        EmailSpacing: Label '<br>';
        EmailFooter: Label 'Sincerely,<br>%1, ICT Division';
        EmailFooter2: Label '<hr><p><i>This message was sent from an unmonitored email address. Please do not reply to this message.</i></p>';
        Email: Text;
        Text_0001: Label 'No official email address found, contact ICT division for assistance';
    begin
        LinkSendSuccessful := false;
        Employee.Reset;
        if Employee.Get("EmployeeNo.") then begin
            if Employee."Company E-Mail" <> '' then begin
                CompanyInformation.Get;
                // SMTPMailSetup.Get;
                // SMTPMail.CreateMessage(CompanyInformation.Name,SMTPMailSetup."User ID",Employee."Company E-Mail",EmailSubject,'',true);
                // SMTPMail.AppendBody(StrSubstNo(EmailSalutation,GetEmployeeName("EmployeeNo.")));
                // SMTPMail.AppendBody(EmailSpacing);
                // SMTPMail.AppendBody(EmailMessage);
                // SMTPMail.AppendBody(EmailSpacing);
                // SMTPMail.AppendBody(StrSubstNo(EmailFooter,CompanyInformation.Name));
                // SMTPMail.AppendBody(EmailFooter2);
                // LinkSendSuccessful:=SMTPMail.TrySend();
            end else
                Error(Text_0001);
        end;
    end;

    procedure ResetEmployeePortalPassword("EmployeeNo.": Code[20]; NewPassword: Text[250]) PasswordResetSuccessful: Boolean
    begin
        PasswordResetSuccessful := false;
        Employee.Reset;
        if Employee.Get("EmployeeNo.") then begin
            Employee."Portal Password" := NewPassword;
            Employee."Default Portal Password" := false;
            Employee.PasswordResetTokenExpiry := CreateDateTime(CalcDate('-1D', Today), Time);
            if Employee.Modify then
                PasswordResetSuccessful := true;
        end;
    end;
}

