codeunit 50020 "Approval WS"
{

    trigger OnRun()
    begin
    end;

    [Scope('Personalization')]
    procedure GetCustomerList(var CustomerExport: XMLport "Customer  Export")
    begin
    end;

    [Scope('Personalization')]
    procedure CreateCustomer(CustNo: Code[20];CustName: Text;CustAddress: Text;Custcity: Code[20];CustPhoneNo: Code[20];CustomerPostingGroup: Code[20];CustEmail: Text) ReturnValue: Text
    var
        Customer: Record Customer;
    begin
        Customer.Init;
        Customer.Validate("No.",CustName);
        Customer.Validate(Name,CustName);
        Customer.Validate(Address,CustAddress);
        Customer.Validate(City,Custcity);
        Customer.Validate("Phone No.",CustPhoneNo);
        Customer.Validate("Customer Posting Group",CustomerPostingGroup);
        Customer.Validate("E-Mail",CustEmail);
        if Customer.Insert then
          ReturnValue:='200: Customer '+CustNo+' Created Successfully'
        else
          ReturnValue:=GetLastErrorCode+'-'+GetLastErrorText;
    end;
}

