codeunit 50061 "Invst. User Mgmt."
{

    trigger OnRun()
    begin
    end;

    var
        Employee: Record Employee;

    procedure GetMarketingHeadOfDepartmentUserID("ApplicationNo.": Code[20]) UserID: Code[50]
    begin
        /*UserID:='';
        InvestmentApplication.RESET;
        InvestmentApplication.GET("ApplicationNo.");
        InvestmentApplication.TESTFIELD(InvestmentApplication."Industry Code");
        InvestmentApplication.TESTFIELD(InvestmentApplication."Sector Code");
        
        InvestmentSector.RESET;
        InvestmentSector.GET(InvestmentApplication."Industry Code",InvestmentApplication."Sector Code");
        InvestmentSector.TESTFIELD(InvestmentSector."Marketing HOD Job No.");
        
        Employee.RESET;
        Employee.SETRANGE(Employee."Job No.",InvestmentSector."Marketing HOD Job No.");
        Employee.SETRANGE(Employee.Status,Employee.Status::Active);
        IF Employee.FINDFIRST THEN BEGIN
          Employee.TESTFIELD(Employee."User ID");
          UserID:=Employee."User ID";
        END;*/

    end;

    procedure GetInvestmentHeadOfDepartmentUserID("ApplicationNo.": Code[20]) UserID: Code[50]
    begin
        /*UserID:='';
        InvestmentApplication.RESET;
        InvestmentApplication.GET("ApplicationNo.");
        InvestmentApplication.TESTFIELD(InvestmentApplication."Industry Code");
        InvestmentApplication.TESTFIELD(InvestmentApplication."Sector Code");
        
        InvestmentSector.RESET;
        InvestmentSector.GET(InvestmentApplication."Industry Code",InvestmentApplication."Sector Code");
        InvestmentSector.TESTFIELD(InvestmentSector."Investment HOD Job No.");
        
        Employee.RESET;
        Employee.SETRANGE(Employee."Job No.",InvestmentSector."Investment HOD Job No.");
        Employee.SETRANGE(Employee.Status,Employee.Status::Active);
        IF Employee.FINDFIRST THEN BEGIN
          Employee.TESTFIELD(Employee."User ID");
          UserID:=Employee."User ID";
        END;*/

    end;

    procedure GetResearchHeadOfDepartmentUserID("ApplicationNo.": Code[20]) UserID: Code[50]
    begin
        /*UserID:='';
        InvestmentApplication.RESET;
        InvestmentApplication.GET("ApplicationNo.");
        InvestmentApplication.TESTFIELD(InvestmentApplication."Industry Code");
        InvestmentApplication.TESTFIELD(InvestmentApplication."Sector Code");
        
        InvestmentSector.RESET;
        InvestmentSector.GET(InvestmentApplication."Industry Code",InvestmentApplication."Sector Code");
        InvestmentSector.TESTFIELD(InvestmentSector."Research HOD Job No.");
        
        Employee.RESET;
        Employee.SETRANGE(Employee."Job No.",InvestmentSector."Research HOD Job No.");
        Employee.SETRANGE(Employee.Status,Employee.Status::Active);
        IF Employee.FINDFIRST THEN BEGIN
          Employee.TESTFIELD(Employee."User ID");
          UserID:=Employee."User ID";
        END;*/

    end;

    procedure GetRiskHeadOfDepartmentUserID("ApplicationNo.": Code[20]) UserID: Code[50]
    begin
        /*UserID:='';
        InvestmentApplication.RESET;
        InvestmentApplication.GET("ApplicationNo.");
        InvestmentApplication.TESTFIELD(InvestmentApplication."Industry Code");
        InvestmentApplication.TESTFIELD(InvestmentApplication."Sector Code");
        
        InvestmentSector.RESET;
        InvestmentSector.GET(InvestmentApplication."Industry Code",InvestmentApplication."Sector Code");
        InvestmentSector.TESTFIELD(InvestmentSector."Risk HOD Job No.");
        
        Employee.RESET;
        Employee.SETRANGE(Employee."Job No.",InvestmentSector."Risk HOD Job No.");
        Employee.SETRANGE(Employee.Status,Employee.Status::Active);
        IF Employee.FINDFIRST THEN BEGIN
          Employee.TESTFIELD(Employee."User ID");
          UserID:=Employee."User ID";
        END;*/

    end;

    procedure GetLegalHeadOfDepartmentUserID("ApplicationNo.": Code[20]) UserID: Code[50]
    begin
        /*UserID:='';
        InvestmentApplication.RESET;
        InvestmentApplication.GET("ApplicationNo.");
        InvestmentApplication.TESTFIELD(InvestmentApplication."Industry Code");
        InvestmentApplication.TESTFIELD(InvestmentApplication."Sector Code");
        
        InvestmentSector.RESET;
        InvestmentSector.GET(InvestmentApplication."Industry Code",InvestmentApplication."Sector Code");
        InvestmentSector.TESTFIELD(InvestmentSector."Legal HOD Job No.");
        
        Employee.RESET;
        Employee.SETRANGE(Employee."Job No.",InvestmentSector."Legal HOD Job No.");
        Employee.SETRANGE(Employee.Status,Employee.Status::Active);
        IF Employee.FINDFIRST THEN BEGIN
          Employee.TESTFIELD(Employee."User ID");
          UserID:=Employee."User ID";
        END;
        */

    end;
}

