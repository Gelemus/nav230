codeunit 50059 "Customer Registration Mgmt."
{

    trigger OnRun()
    begin
    end;

    var
        "NoSeriesMgt.": Codeunit NoSeriesManagement;
        Customer: Record Customer;
        Customer2: Record Customer;

    procedure CreateCustomerAccount("CustomerRegistrationNo.": Code[20];"ApplicationNo.": Code[20])
    var
        "CustomerNo.": Code[20];
    begin
        /*"CustomerNo.":='';
        
        InvestmentGeneralSetup.GET;
        InvestmentGeneralSetup.TESTFIELD(InvestmentGeneralSetup."Customer Nos.");
        
        CustomerRegistration.RESET;
        CustomerRegistration.GET("CustomerRegistrationNo.");
        
        InvestmentApplication.RESET;
        InvestmentApplication.GET("ApplicationNo.");
        
        Customer2.RESET;
        Customer2.SETRANGE(Customer2."Customer Registration No.",CustomerRegistration."No.");
        IF NOT Customer2.FINDFIRST THEN BEGIN
          "CustomerNo.":="NoSeriesMgt.".GetNextNo(InvestmentGeneralSetup."Customer Nos.",0D,TRUE);
          Customer.INIT;
          Customer."No.":="CustomerNo.";
          Customer.Name:=COPYSTR(CustomerRegistration.Name,1,50);
          Customer.Address:=CustomerRegistration.Address;
          Customer.City:=CustomerRegistration.City;
          Customer."Address 2":=CustomerRegistration."Physical Address";
          Customer."Phone No.":=CustomerRegistration."Phone No.";
          Customer."Telex No.":=CustomerRegistration."Company Registration No.";
          Customer."E-Mail":=CustomerRegistration."Email Address";
          Customer."Home Page":=CustomerRegistration."Home Page";
          Customer."VAT Registration No.":=CustomerRegistration."Pin No.";
          Customer."Global Dimension 1 Code":=CustomerRegistration."Global Dimension 1 Code";
          Customer."Global Dimension 2 Code":=CustomerRegistration."Global Dimension 2 Code";
          Customer."Account Type":=Customer."Account Type"::"2";
          Customer."Customer Registration No." :=CustomerRegistration."No.";
          IF Customer.INSERT THEN BEGIN
            CustomerRegistration."Customer No.":="CustomerNo.";
            CustomerRegistration."Customer Name":=COPYSTR(CustomerRegistration.Name,1,50);
            CustomerRegistration.MODIFY;
        
            InvestmentApplication."Customer No.":="CustomerNo.";
            InvestmentApplication."Customer Name":=COPYSTR(CustomerRegistration.Name,1,50);
            InvestmentApplication.MODIFY;
        
            MESSAGE('Customer account for '+CustomerRegistration.Name+' successfully created. Customer no. '+"CustomerNo."+' allocated.');
          END;
        END ELSE BEGIN
          IF CustomerRegistration."Customer No."='' THEN BEGIN
            CustomerRegistration."Customer No.":=Customer2."No.";
            CustomerRegistration."Customer Name":=Customer2.Name;
            CustomerRegistration.MODIFY;
          END;
          IF InvestmentApplication."Customer No."='' THEN BEGIN
            InvestmentApplication."Customer No.":=Customer2."No.";
            InvestmentApplication."Customer Name":=Customer2.Name;
            InvestmentApplication.MODIFY;
          END;
        END;*/

    end;
}

