codeunit 50052 "Tenancy  Account WS"
{

    trigger OnRun()
    begin
    end;

    var
        SERVERDIRECTORYPATH: Label 'C:\inetpub\wwwroot\HWWK\EmployeeData\';
        TxtCharsToKeep: Label 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        CompanyInformation: Record "Company Information";
        HumanResourcesSetup: Record "Human Resources Setup";
}

