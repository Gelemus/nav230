xmlport 50001 "Postal Codes Import"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Post Code";"Post Code")
            {
                XmlName = 'Paybill';
                fieldelement(A;"Post Code".Code)
                {
                }
                fieldelement(B;"Post Code".City)
                {
                }
                fieldelement(C;"Post Code"."Country/Region Code")
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

