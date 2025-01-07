xmlport 50142 "JobApplicationDocumentsExport"
{
    Caption = 'Job ApplicationDocuments Export';
    UseDefaultNamespace = true;


    schema
    {
        textelement(root)
        {
            tableelement("Job Application Documents"; "Job Application Documents")
            {
                XmlName = 'JobApplicationDocumentsExport';
                fieldelement(A; "Job Application Documents".LineNo)
                {
                }

                fieldelement(B; "Job Application Documents"."Job Application No")
                {
                }
                fieldelement(C; "Job Application Documents"."Document Description")
                {
                }
                fieldelement(D; "Job Application Documents"."Actual File Name")
                {
                }

            }
        }
    }





}




