xmlport 50014 "HR Emp Qualification  Import"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Employee Qualification";"Employee Qualification")
            {
                XmlName = 'HREmployeeQualificationDetailsImport';
                fieldelement(A;"Employee Qualification"."Line No.")
                {
                }
                fieldelement(B;"Employee Qualification"."Employee No.")
                {
                }
                fieldelement(C;"Employee Qualification"."Qualification Code")
                {
                }
                fieldelement(D;"Employee Qualification".Description)
                {
                }
                fieldelement(E;"Employee Qualification"."From Date")
                {
                }
                fieldelement(F;"Employee Qualification"."To Date")
                {
                }
                fieldelement(G;"Employee Qualification"."Institution/Company")
                {
                }
                fieldelement(H;"Employee Qualification".Award)
                {
                }
                fieldelement(I;"Employee Qualification"."Award Date")
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
        Message('Employee Qualification Details Import completed!');
    end;
}

