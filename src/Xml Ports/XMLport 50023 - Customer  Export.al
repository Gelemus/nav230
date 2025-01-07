xmlport 50023 "Customer  Export"
{
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(Customerroot)
        {
            tableelement(Customer;Customer)
            {
                AutoUpdate = true;
                XmlName = 'Customer';
                fieldelement(No;Customer."No.")
                {
                }
                fieldelement(Name;Customer.Name)
                {
                }
                fieldelement(Address;Customer.Address)
                {
                }
                fieldelement(City;Customer.City)
                {
                }
                fieldelement(PhoneNo;Customer."Phone No.")
                {
                }
                fieldelement(CustomerPostingGroup;Customer."Customer Posting Group")
                {
                }
                fieldelement(Email;Customer."E-Mail")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //"Bank Acc. Statement Linevb".VALIDATE("Bank Acc. Statement Linevb"."Document No.");
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

    trigger OnPostXmlPort()
    begin
        Message('Bank Statement Import completed!');
    end;
}

