xmlport 50139 "Job Application Export"
{
    Caption = 'JobApplication Export';
    UseDefaultNamespace = true;


    schema
    {
        textelement(root)
        {
            tableelement("HR_Job_Applications"; "HR Job Applications")
            {
                XmlName = 'JobApplicationExport';
                fieldelement(A; "HR_Job_Applications"."No.")
                {
                }
                fieldelement(B; "HR_Job_Applications"."Application Date")
                {
                }
                fieldelement(C; "HR_Job_Applications"."Job No.")
                {
                }
                fieldelement(D; "HR_Job_Applications"."Job Title")
                {
                }
                fieldelement(E; "HR_Job_Applications"."Employee Requisition No.")
                {
                }
                fieldelement(F; "HR_Job_Applications".Surname)
                {
                }
                fieldelement(g; "HR_Job_Applications".Firstname)
                {
                }
                fieldelement(h; "HR_Job_Applications".Middlename)
                {
                }
                fieldelement(i; "HR_Job_Applications".Gender)
                {
                }
                fieldelement(j; "HR_Job_Applications"."Date of Birth")
                {
                }
                fieldelement(k; "HR_Job_Applications".Age)
                {
                }
                fieldelement(l; "HR_Job_Applications"."Postal Address")
                {
                }
                fieldelement(m; "HR_Job_Applications".Citizenship)
                {
                }
                fieldelement(n; "HR_Job_Applications"."Driving Licence No.")
                {
                }
                fieldelement(o; "HR_Job_Applications"."Mobile Phone No.")
                {
                }
                fieldelement(p; "HR_Job_Applications"."Alternative Phone No.")
                {
                }
                fieldelement(l; "HR_Job_Applications".Country)
                {
                }
                fieldelement(l; "HR_Job_Applications"."Personal Email Address")
                {
                }
                fieldelement(q; "HR_Job_Applications"."SubCounty Name")
                {
                }
                fieldelement(r; "HR_Job_Applications".SubCounty)
                {
                }
                fieldelement(s; "HR_Job_Applications"."County Name")
                {
                }
                fieldelement(t; "HR_Job_Applications"."City/Town")
                {
                }
                fieldelement(u; "HR_Job_Applications"."Residential Address")
                {
                    // }                a
                    // fieldelement(p; "HR_Job_Applications"."City/Town")
                    // {
                    // }
                    // fieldelement(w; "HR_Job_Applications"."Status")
                    // {
                    // }
                    // fieldelement(x; "HR_Job_Applications".National ID No)
                    // {
                    // }
                    // fieldelement(y; "HR_Job_Applications".Ethnic Group)
                    // {
                    // }
                    // fieldelement(z; "HR_Job_Applications".Expected Salary)
                    // {
                    // }
                    // fieldelement(p1; "HR_Job_Applications".Religion)
                    // {
                    // }
                    // fieldelement(p2; "HR_Job_Applications".Marital Status)
                    // {
                    // }
                    // fieldelement(p3; "HR_Job_Applications".Years of Experience)
                    // {
                    // }
                    // fieldelement(p4; "HR_Job_Applications"."O Level Grade")
                    // {
                    // }
                }
            }
        }
    }





}




