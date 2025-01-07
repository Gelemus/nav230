codeunit 50053 "Tenant  Account WS"
{

    trigger OnRun()
    begin
    end;

    var
        Customer: Record Customer;
        SERVERDIRECTORYPATH: Label 'C:\inetpub\wwwroot\HWWK\EmployeeData\';
        TxtCharsToKeep: Label 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        CompanyInformation: Record "Company Information";
        HumanResourcesSetup: Record "Human Resources Setup";

    procedure CustomerExists("CustomerNo.": Code[20]) CustomerExist: Boolean
    begin
        CustomerExist:=false;
        Customer.Reset;
        if Customer.Get("CustomerNo.") then begin
          CustomerExist:=true;
        end;
    end;

    procedure CustomerAccountIsActive("CustomerNo.": Code[20]) CustomerAccountActive: Boolean
    begin
        /*CustomerAccountActive:=FALSE;
        
        Customer.RESET;
        IF Customer.GET("CustomerNo.") THEN BEGIN
          IF Customer.Status=Customer.Status::Active THEN
            CustomerAccountActive:=TRUE;
        END;*/

    end;

    procedure GetCleanedCustomerNo("CustomerNo.": Code[20]) "CleanedCustomerNo.": Text
    begin
        "CleanedCustomerNo.":='';
        "CleanedCustomerNo.":=DelChr("CustomerNo.",'=',DelChr("CustomerNo.",'=',TxtCharsToKeep));
    end;

    procedure GetCustomerName("CustomerNo.": Code[20]) CustomerName: Text
    begin
        CustomerName:='';

        Customer.Reset;
        if Customer.Get("CustomerNo.") then begin
          CustomerName:=Customer.Name;
        end;
    end;

    procedure GetCustomerGender("CustomerNo.": Code[20]) CustomerGender: Text
    begin
        /*CustomerGender:='';
        
        Customer.RESET;
        IF Customer.GET("CustomerNo.") THEN BEGIN
          CustomerGender:=FORMAT(Customer.Gender);
        END;*/

    end;

    procedure GetCustomereEmailAddress("CustomerNo.": Code[20]) CustomerEmailAddress: Text
    begin
        CustomerEmailAddress:='';

        Customer.Reset;
        if Customer.Get("CustomerNo.") then begin
          CustomerEmailAddress:=Customer."E-Mail";
        end;
    end;

    procedure GetCustomerUserID("CustomerNo.": Code[20]) CustomerUserID: Text
    begin
        /*CustomerUserID:='';
        
        Customer.RESET;
        IF Customer.GET("CustomerNo.") THEN BEGIN
          CustomerUserID:=Customer."User ID";
        END;
        */

    end;

    procedure LoginCustomer("CustomerNo.": Code[20];Password: Text) LoginSuccessful: Boolean
    begin
        LoginSuccessful:=false;

        Customer.Reset;
        if Customer.Get("CustomerNo.") then begin
          if (Customer."Portal Password"=Password) then
            LoginSuccessful:=true;
        end;
    end;

    procedure IsCustomerDefaultPassword("CustomerNo.": Code[20]) IsDefaultPassword: Boolean
    begin
        IsDefaultPassword:=false;

        Customer.Reset;
        if Customer.Get("CustomerNo.") then begin
          if Customer."Default Portal Password" then
            IsDefaultPassword:=true;
        end;
    end;

    procedure SetPasswordResetToken("CustomerNo.": Code[20];PasswordResetToken: Text[250]) TokenSetSuccessfully: Boolean
    begin
        TokenSetSuccessfully:=false;

        Customer.Reset;
        if Customer.Get("CustomerNo.") then begin
          Customer.PasswordResetToken:=PasswordResetToken;
          Customer.PasswordResetTokenExpiry:=CreateDateTime(CalcDate('+1D',Today),Time);
          if Customer.Modify then
            TokenSetSuccessfully:=true;
        end;
    end;

    procedure GetPasswordResetToken("CustomerNo.": Code[20]) PasswordResetToken: Text[250]
    begin
        PasswordResetToken:='';

        Customer.Reset;
        if Customer.Get("CustomerNo.") then begin
          PasswordResetToken:=Customer.PasswordResetToken;
        end;
    end;

    procedure IsPasswordResetTokenExpired("CustomerNo.": Code[20];PasswordResetToken: Text[250]) TokenExpired: Boolean
    begin
        TokenExpired:=false;
        Customer.Reset;
        if Customer.Get("CustomerNo.") then begin
          if (CurrentDateTime>Customer.PasswordResetTokenExpiry) then
            TokenExpired:=true;
        end;
    end;

    procedure SendPasswordResetLink("CustomerNo.": Code[20];EmailMessage: Text) LinkSendSuccessful: Boolean
    var
        // SMTPMailSetup: Record "SMTP Mail Setup";
        // SMTPMail: Codeunit "SMTP Mail";
        EmailSubject: Label 'Customer Account Password Reset';
        EmailSalutation: Label '<p>Dear %1,</p>';
        EmailSpacing: Label '<br>';
        EmailFooter: Label 'Sincerely,<br>%1, ICT Department';
        EmailFooter2: Label '<hr><p><i>This message was sent from an unmonitored email address. Please do not reply to this message.</i></p>';
    begin
        LinkSendSuccessful:=false;
        Customer.Reset;
        if Customer.Get("CustomerNo.") then begin
          CompanyInformation.Get;
          // SMTPMailSetup.Get;
          // SMTPMail.CreateMessage(CompanyInformation.Name,SMTPMailSetup."User ID",Customer."E-Mail",EmailSubject,'',true);
          // SMTPMail.AppendBody(StrSubstNo(EmailSalutation,GetCustomerName("CustomerNo.")));
          // SMTPMail.AppendBody(EmailSpacing);
          // SMTPMail.AppendBody(EmailMessage);
          // SMTPMail.AppendBody(EmailSpacing);
          // SMTPMail.AppendBody(StrSubstNo(EmailFooter,CompanyInformation.Name));
          // SMTPMail.AppendBody(EmailFooter2);
          // LinkSendSuccessful:=SMTPMail.TrySend();
        end;
    end;

    procedure ResetCustomerPortalPassword("CustomerNo.": Code[20];NewPassword: Text[250]) PasswordResetSuccessful: Boolean
    begin
        PasswordResetSuccessful:=false;
        Customer.Reset;
        if Customer.Get("CustomerNo.") then begin
          Customer."Portal Password":=NewPassword;
          Customer."Default Portal Password":=false;
          Customer.PasswordResetTokenExpiry:=CreateDateTime(CalcDate('-1D',Today),Time);
          if Customer.Modify then
            PasswordResetSuccessful:=true;
        end;
    end;
}

