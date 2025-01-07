xmlport 50013 "HR Employee Referee  Import"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("HR Employee Referee Details";"HR Employee Referee Details")
            {
                XmlName = 'HREmployeeRefereeDetailsImport';
                fieldelement(A;"HR Employee Referee Details"."Line No.")
                {
                }
                fieldelement(B;"HR Employee Referee Details"."Employee No.")
                {
                }
                fieldelement(C;"HR Employee Referee Details".Surname)
                {
                }
                fieldelement(D;"HR Employee Referee Details".Firstname)
                {
                }
                fieldelement(E;"HR Employee Referee Details".Middlename)
                {
                }
                fieldelement(F;"HR Employee Referee Details"."Personal E-Mail Address")
                {
                }
                fieldelement(G;"HR Employee Referee Details"."Postal Address")
                {
                }
                fieldelement(H;"HR Employee Referee Details"."Post Code")
                {
                }
                fieldelement(I;"HR Employee Referee Details"."Residential Address")
                {
                }
                fieldelement(J;"HR Employee Referee Details"."Country/Region Code")
                {
                }
                fieldelement(K;"HR Employee Referee Details"."Mobile No.")
                {
                }
                fieldelement(L;"HR Employee Referee Details"."Referee Category")
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
        Message('Employee Referee Details Import completed!');
    end;
}

