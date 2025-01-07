xmlport 50015 "HR Emp Proff Bodies  Import"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("HR Employee Prof. Membership";"HR Employee Prof. Membership")
            {
                XmlName = 'HREmployeeProffessionalBodiesDetailsImport';
                fieldelement(A;"HR Employee Prof. Membership"."Line No.")
                {
                }
                fieldelement(B;"HR Employee Prof. Membership"."Employee No.")
                {
                }
                fieldelement(C;"HR Employee Prof. Membership"."Professional Body Name")
                {
                }
                fieldelement(D;"HR Employee Prof. Membership"."Membership No.")
                {
                }
                fieldelement(E;"HR Employee Prof. Membership"."Practising Cert/License No")
                {
                }
                fieldelement(F;"HR Employee Prof. Membership"."Expiry Date")
                {
                }
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
        Message('Employee Proffsesional Bodies Details Import completed!');
    end;
}

