xmlport 50010 "HR Employee Biodata Import"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement(Employee;Employee)
            {
                XmlName = 'HREmployeeBiodataImport';
                fieldelement(A;Employee."No.")
                {
                }
                fieldelement(B;Employee."First Name")
                {
                }
                fieldelement(C;Employee."Middle Name")
                {
                }
                fieldelement(D;Employee."Last Name")
                {
                }
                fieldelement(E;Employee.Gender)
                {
                }
                fieldelement(F;Employee."Birth Date")
                {
                }
                fieldelement(G;Employee."Job No.-d")
                {
                }
                fieldelement(H;Employee.Title)
                {
                }
                fieldelement(I;Employee."Job Grade-d")
                {
                }
                fieldelement(J;Employee.Address)
                {
                }
                fieldelement(K;Employee."Post Code")
                {
                }
                fieldelement(L;Employee.City)
                {
                }
                fieldelement(M;Employee."Phone No.")
                {
                }
                fieldelement(N;Employee."Mobile Phone No.")
                {
                }
                fieldelement(O;Employee."E-Mail")
                {
                }
                fieldelement(P;Employee."Country/Region Code")
                {
                }
                fieldelement(Q;Employee."Employment Date")
                {
                }
                fieldelement(R;Employee.Status)
                {
                }
                fieldelement(S;Employee."Global Dimension 1 Code")
                {
                }
                fieldelement(T;Employee."Global Dimension 2 Code")
                {
                }
                fieldelement(U;Employee."Company E-Mail")
                {
                }
                fieldelement(V;Employee."Marital Status-d")
                {
                }
                fieldelement(W;Employee."Birth Certificate No.")
                {
                }
                fieldelement(X;Employee."National ID No.-d")
                {
                }
                fieldelement(Y;Employee."PIN No.-d")
                {
                }
                fieldelement(Z;Employee."NSSF No.-d")
                {
                }
                fieldelement(AB;Employee."NHIF No.-d")
                {
                }
                fieldelement(AC;Employee."Passport No.-d")
                {
                }
                fieldelement(AD;Employee."Driving Licence No.")
                {
                }
                fieldelement(AE;Employee."Emplymt. Contract Code")
                {
                }
                fieldelement(AF;Employee."Bank Code-d")
                {
                }
                fieldelement(AG;Employee."Bank Name")
                {
                }
                fieldelement(AH;Employee."Bank Branch Code-d")
                {
                }
                fieldelement(AI;Employee."Bank Branch Name")
                {
                }
                fieldelement(AJ;Employee."Bank Account No.")
                {
                }
                fieldelement(AK;Employee."Contract Start Date")
                {
                }
                fieldelement(AL;Employee.Citizenship)
                {
                }
                fieldelement(AM;Employee.Religion)
                {
                }
                fieldelement(AN;Employee."County Code")
                {
                }
                fieldelement(AO;Employee."County Name")
                {
                }
                fieldelement(AP;Employee."SubCounty Code")
                {
                }
                fieldelement(AQ;Employee."SubCounty Name")
                {
                }
                fieldelement(AR;Employee."Employment Date")
                {
                }
                fieldelement(AS;Employee."Contract Expiry Date")
                {
                }
                fieldelement(AT;Employee."Person Living with Disability")
                {
                }
                fieldelement(AU;Employee."Ethnic Group")
                {
                }
                fieldelement(AV;Employee."Huduma No.")
                {
                }
                fieldelement(AW;Employee."HR Salary Notch")
                {
                }
                fieldelement(AX;Employee."Supervisor Job No.")
                {
                }
                fieldelement(AY;Employee."Supervisor Job Title")
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
        Message('Employee Biodata Import completed!');
    end;
}

