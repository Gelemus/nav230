xmlport 50143 "JobQualificationCodes Export"
{
    Caption = 'JobQualificationCodes Export';
    UseDefaultNamespace = true;

    schema
    {
        textelement(root)
        {
            tableelement("HR Lookup Values"; "HR Lookup Values")
            {
                XmlName = 'JobQualificationCodesExport';
                fieldelement(A; "HR Lookup Values".Code)
                {
                }
                fieldelement(B; "HR Lookup Values".Description)
                {
                }
                fieldelement(C; "HR Lookup Values".Option)
                {
                }

            }
        }
    }





}




