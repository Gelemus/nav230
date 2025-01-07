xmlport 50005 "Bank Transactions Import"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Bank Acc. Statement Linevb";"Bank Acc. Statement Linevb")
            {
                XmlName = 'Paybill';
                fieldelement(A;"Bank Acc. Statement Linevb"."Bank Account No.")
                {
                }
                fieldelement(B;"Bank Acc. Statement Linevb"."Statement No.")
                {
                }
                fieldelement(C;"Bank Acc. Statement Linevb"."Transaction Date")
                {
                }
                fieldelement(D;"Bank Acc. Statement Linevb"."Document No.")
                {
                }
                fieldelement(E;"Bank Acc. Statement Linevb"."Transaction Text")
                {
                }
                fieldelement(F;"Bank Acc. Statement Linevb"."Statement Amount")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    "Bank Acc. Statement Linevb".Validate("Bank Acc. Statement Linevb"."Document No.");
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

