xmlport 50133 "NdovuPay Payments Export"
{
    DefaultNamespace = 'urn:microsoft-dynamics-schemas/codeunit/FundManagementWS';
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(NdovuPayPaymentsRoot)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            tableelement("Payment Header";"Payment Header")
            {
                MinOccurs = Zero;
                XmlName = 'NdovuPayPayments';
                fieldelement(PvNo;"Payment Header"."No.")
                {
                }
                fieldelement(Amount;"Payment Header"."Total Amount")
                {
                }
                tableelement("Payment Line";"Payment Line")
                {
                    LinkFields = "Document No."=FIELD("No.");
                    LinkTable = "Payment Header";
                    MinOccurs = Zero;
                    XmlName = 'PaymentLines';
                    fieldelement(DocumentNo;"Payment Line"."Document No.")
                    {
                    }
                    fieldelement(LineNo;"Payment Line"."Line No.")
                    {
                    }
                    fieldelement(AccountType;"Payment Line"."Account Type")
                    {
                    }
                    fieldelement(AccountNo;"Payment Line"."Account No.")
                    {
                    }
                    fieldelement(AccountName;"Payment Line"."Account Name")
                    {
                    }
                    fieldelement(NetAmount;"Payment Line"."Net Amount")
                    {
                    }
                    fieldelement(Description;"Payment Line".Description)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    /*Employee.GET("Store Requisition Header"."Employee No.");
                    EmployeeName:=Employee."First Name"+' '+Employee."Last Name";*/

                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    var
        Employee: Record Employee;
}

