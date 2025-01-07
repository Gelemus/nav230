codeunit 50035 "Employee Portal Services Mgt."
{

    trigger OnRun()
    begin
    end;

    var
        Employee: Record Employee;
        SERVERDIRECTORYPATH: Label 'C:\inetpub\wwwroot\HWWK\EmployeeData\';
        TxtCharsToKeep: Label 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        CompanyInformation: Record "Company Information";
        HumanResourcesSetup: Record "Human Resources Setup";

    procedure EmployeeExists("EmployeeNo.": Code[20]) EmployeeExist: Boolean
    begin
        EmployeeExist:=false;
        if Employee.Get("EmployeeNo.") then begin
          EmployeeExist:=true;
        end;
    end;

    procedure EmployeeAccountIsActive("EmployeeNo.": Code[20]) EmployeeAccountActive: Boolean
    begin
        EmployeeAccountActive:=false;
        if Employee.Get("EmployeeNo.") then begin
          if Employee.Status=Employee.Status::Active then
            EmployeeAccountActive:=true;
        end;
    end;

    procedure GetCleanedEmployeeNo("EmployeeNo.": Code[20]) "CleanedEmployeeNo.": Text
    begin
        "CleanedEmployeeNo.":='';
        "CleanedEmployeeNo.":=DelChr("EmployeeNo.",'=',DelChr("EmployeeNo.",'=',TxtCharsToKeep));
    end;

    procedure GetEmployeeName("EmployeeNo.": Code[20]) EmployeeName: Text
    begin
        EmployeeName:='';
        if Employee.Get("EmployeeNo.") then begin
          EmployeeName:=Employee."First Name"+' '+Employee."Middle Name"+' '+Employee."Last Name";
        end;
    end;

    procedure GetEmployeeEmailAddress("EmployeeNo.": Code[20]) EmployeeEmailAddress: Text
    begin
        EmployeeEmailAddress:='';
        if Employee.Get("EmployeeNo.") then begin
          EmployeeEmailAddress:=Employee."E-Mail";
        end;
    end;

    procedure CreateEmployeeDirectory("EmployeeNo.": Code[20])
    var
        CompanyDataDirectory: Text;
        EmployeeDataDirectory: Text;
        // [RunOnClient]
        // DirectoryHelper: DotNet Directory;
        DirectoryPath: Label '%1\%2\%3';
        EmployeeDirectoryPath: Text;
    begin
        CompanyInformation.Get;
        HumanResourcesSetup.Get;
        CompanyInformation.TestField(CompanyInformation."Company Data Directory Path");
        HumanResourcesSetup.TestField(HumanResourcesSetup."Employee Data Directory Name");
        CompanyDataDirectory:=CompanyInformation."Company Data Directory Path";
        EmployeeDataDirectory:=HumanResourcesSetup."Employee Data Directory Name";

        EmployeeDirectoryPath:=StrSubstNo(DirectoryPath,CompanyDataDirectory,EmployeeDataDirectory,GetCleanedEmployeeNo("EmployeeNo."));

        // if not DirectoryHelper.Exists(EmployeeDirectoryPath) then begin
        //   DirectoryHelper.CreateDirectory(EmployeeDirectoryPath);
        // end;
    end;

    procedure LoginEmployee("EmployeeNo.": Code[20];Password: Text) LoginSuccessful: Boolean
    begin
        LoginSuccessful:=false;
        if Employee.Get("EmployeeNo.") then begin
          if (Employee."Portal Password"=Password) then
            LoginSuccessful:=true;
        end;
    end;

    procedure IsEmployeeDefaultPassword("EmployeeNo.": Code[20]) IsDefaultPassword: Boolean
    begin
        IsDefaultPassword:=false;
        if Employee.Get("EmployeeNo.") then begin
          if Employee."Default Portal Password" then
            IsDefaultPassword:=true;
        end;
    end;

    procedure SetPasswordResetToken("EmployeeNo.": Code[20];PasswordResetToken: Text[250]) TokenSetSuccessfully: Boolean
    begin
        TokenSetSuccessfully:=false;
        if Employee.Get("EmployeeNo.") then begin
          Employee.PasswordResetToken:=PasswordResetToken;
          Employee.PasswordResetTokenExpiry:=CreateDateTime(CalcDate('+1D',Today),Time);
          if Employee.Modify then
            TokenSetSuccessfully:=true;
        end;
    end;

    procedure GetPasswordResetToken("EmployeeNo.": Code[20]) PasswordResetToken: Text[250]
    begin
        PasswordResetToken:='';
        if Employee.Get("EmployeeNo.") then begin
          PasswordResetToken:=Employee.PasswordResetToken;
        end;
    end;

    procedure IsPasswordResetTokenExpired("EmployeeNo.": Code[20];PasswordResetToken: Text[250]) TokenExpired: Boolean
    begin
        TokenExpired:=false;
        if Employee.Get("EmployeeNo.") then begin
          if (CurrentDateTime>Employee.PasswordResetTokenExpiry) then
            TokenExpired:=true;
        end;
    end;

    procedure SendPasswordResetLink("EmployeeNo.": Code[20];EmailMessage: Text) LinkSendSuccessful: Boolean
    var
        // SMTPMailSetup: Record "SMTP Mail Setup";
        // SMTPMail: Codeunit "SMTP Mail";
        EmailSubject: Label 'Employee Account Password Reset';
        EmailSalutation: Label '<p>Dear %1,</p>';
        EmailSpacing: Label '<br><br>';
        EmailFooter: Label 'Sincerely,<br>%1, ICT Department';
        EmailFooter2: Label '<hr><p><i>This message was sent from an unmonitored email address. Please do not reply to this message.</i></p>';
    begin
        LinkSendSuccessful:=false;
        if Employee.Get("EmployeeNo.") then begin
          CompanyInformation.Get;
          // SMTPMailSetup.Get;

          // SMTPMail.CreateMessage(CompanyInformation.Name,SMTPMailSetup."User ID",Employee."E-Mail",EmailSubject,'',true);
          // SMTPMail.AppendBody(StrSubstNo(EmailSalutation,GetEmployeeName("EmployeeNo.")));
          // SMTPMail.AppendBody(EmailSpacing);
          // SMTPMail.AppendBody(EmailMessage);
          // SMTPMail.AppendBody(EmailSpacing);
          // SMTPMail.AppendBody(StrSubstNo(EmailFooter,CompanyInformation.Name));
          // SMTPMail.AppendBody(EmailFooter2);
          //LinkSendSuccessful:=SMTPMail.TrySend();
        end;
    end;

    procedure ResetEmployeePortalPassword("EmployeeNo.": Code[20];NewPassword: Text[250]) PasswordResetSuccessful: Boolean
    begin
        PasswordResetSuccessful:=false;
        if Employee.Get("EmployeeNo.") then begin
          Employee."Portal Password":=NewPassword;
          Employee."Default Portal Password":=false;
          Employee.PasswordResetTokenExpiry:=CreateDateTime(CalcDate('-1D',Today),Time);
          if Employee.Modify then
            PasswordResetSuccessful:=true;
        end;
    end;
}

