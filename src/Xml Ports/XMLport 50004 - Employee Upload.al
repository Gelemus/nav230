xmlport 50004 "Employee Upload"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement(Employee;Employee)
            {
                AutoUpdate = true;
                XmlName = 'Paybill';
                fieldelement(A;Employee."No.")
                {
                }
                fieldelement(B;Employee."Job Grade-d")
                {
                }
                fieldelement(c;Employee."HR Salary Notch")
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

