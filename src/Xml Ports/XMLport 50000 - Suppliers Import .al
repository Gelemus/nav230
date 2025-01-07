xmlport 50000 "Suppliers Import"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement(Vendor; Vendor)
            {
                XmlName = 'Paybill';
                fieldelement(A; Vendor."No.")
                {
                }
                fieldelement(B; Vendor.Name)
                {
                }
                fieldelement(C; Vendor."Search Name")
                {
                }
                fieldelement(D; Vendor.Address)
                {
                }
                fieldelement(E; Vendor.City)
                {
                }
                fieldelement(F; Vendor.Contact)
                {
                }
                fieldelement(g; Vendor."Phone No.")
                {
                }
                fieldelement(h; Vendor."Telex No.")
                {
                }
                fieldelement(i; Vendor."Post Code")
                {
                }
                fieldelement(j; Vendor.County)
                {
                }
                fieldelement(k; Vendor."E-Mail")
                {
                }
                fieldelement(l; Vendor.County)
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

