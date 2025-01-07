xmlport 50012 "HR Relative  Import"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("HR Employee Relative";"HR Employee Relative")
            {
                XmlName = 'HREmployeeRelativeImport';
                fieldelement(A;"HR Employee Relative"."Line No.")
                {
                }
                fieldelement(B;"HR Employee Relative"."Employee No.")
                {
                }
                fieldelement(C;"HR Employee Relative"."Relative Code")
                {
                }
                fieldelement(D;"HR Employee Relative".Surname)
                {
                }
                fieldelement(E;"HR Employee Relative".Firstname)
                {
                }
                fieldelement(F;"HR Employee Relative".Middlename)
                {
                }
                fieldelement(G;"HR Employee Relative"."Date of Birth")
                {
                }
                fieldelement(H;"HR Employee Relative".Age)
                {
                }
                fieldelement(I;"HR Employee Relative".Type)
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
        Message('Employee Relative Import completed!');
    end;
}

