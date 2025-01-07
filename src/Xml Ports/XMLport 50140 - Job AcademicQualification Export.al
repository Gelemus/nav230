xmlport 50140 "JobAcademicQualificationExport"
{
    Caption = 'Job AcademicQualification Export';
    UseDefaultNamespace = true;


    schema
    {
        textelement(root)
        {
            tableelement("HR Job Applicant Qualification"; "HR Job Applicant Qualification")
            {
                XmlName = 'JobAcademicQualificationExport';
                fieldelement(A; "HR Job Applicant Qualification"."Line No.")
                {
                }
                fieldelement(B; "HR Job Applicant Qualification"."Job Application No.")
                {
                }
                fieldelement(C; "HR Job Applicant Qualification"."Qualification Code")
                {
                }
                fieldelement(D; "HR Job Applicant Qualification"."Qualification Name")
                {
                }
                fieldelement(E; "HR Job Applicant Qualification"."Joining Date")
                {
                }
                fieldelement(F; "HR Job Applicant Qualification"."Completion Date")
                {
                }
                fieldelement(g; "HR Job Applicant Qualification"."Institution Name")
                {
                }
                fieldelement(h; "HR Job Applicant Qualification".Award)
                {
                }
                fieldelement(i; "HR Job Applicant Qualification"."Award Date")
                {
                }
                fieldelement(j; "HR Job Applicant Qualification"."E-mail")
                {
                }
                // fieldelement(k; "HR Job Applicant Qualification".Professional Qualification)//add the field
                // {
                // }
                // // fieldelement(l; "HR Job Applicant Qualification".Year of Registration)///add the field
                // {
                // }


            }
        }
    }





}




