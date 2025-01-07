report 50076 "HR Medical Scheme Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/HR Medical Scheme Report.rdl';

    dataset
    {
        dataitem("HR Medical Scheme"; "HR Medical Scheme")
        {
            column(CName; CompanyInfo.Name)
            {
            }
            column(CAddress; CompanyInfo.Address)
            {
            }
            column(CAddress2; CompanyInfo."Address 2")
            {
            }
            column(CCity; CompanyInfo.City)
            {
            }
            column(CPic; CompanyInfo.Picture)
            {
            }
            column(CEmail; CompanyInfo."E-Mail")
            {
            }
            column(CPhone; CompanyInfo."Phone No.")
            {
            }
            column(CWebsite; CompanyInfo."Home Page")
            {
            }
            column(CVision; Text0001)
            {
            }
            column(Lno; Lno)
            {
            }
            column(No_HRMedicalScheme; "HR Medical Scheme"."No.")
            {
            }
            column(MedicalSchemeDescription_HRMedicalScheme; "HR Medical Scheme"."Medical Scheme Description")
            {
            }
            column(Provider_HRMedicalScheme; "HR Medical Scheme".Provider)
            {
            }
            column(ProviderName_HRMedicalScheme; "HR Medical Scheme"."Provider Name")
            {
            }
            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_Address; CI.Address)
            {
            }
            column(CI__Address; CI."Address 2")
            {
            }
            column(CI_City; CI.City)
            {
            }
            column(Country; CI."Country/Region Code")
            {
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
            }
            column(CI_TelephoneNo; CI."Telephone No.")
            {
            }
            column(CI_Email; CI."E-Mail")
            {
            }
            column(CI_Website; CI."Home Page")
            {
            }
            column(CI_Vision; Text0001)
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            dataitem("HR Medical Scheme Members"; "HR Medical Scheme Members")
            {
                DataItemLink = "Scheme No" = FIELD("No.");
                column(SchemeNo_HRMedicalSchemeMembers; "HR Medical Scheme Members"."Scheme No")
                {
                }
                column(EmployeeNo_HRMedicalSchemeMembers; "HR Medical Scheme Members"."Employee No")
                {
                }
                column(EmployeeName_HRMedicalSchemeMembers; "HR Medical Scheme Members"."Employee Name")
                {
                }
                column(MedicalSchemeDescription_HRMedicalSchemeMembers; "HR Medical Scheme Members"."Medical Scheme Description")
                {
                }
                column(FamilySize_HRMedicalSchemeMembers; "HR Medical Scheme Members"."Family Size")
                {
                }
                column(CoverOption_HRMedicalSchemeMembers; "HR Medical Scheme Members"."Cover Option")
                {
                }
                column(InPatientBenfit_HRMedicalSchemeMembers; "HR Medical Scheme Members"."In Patient Benfit")
                {
                }
                column(OutpatientBenefit_HRMedicalSchemeMembers; "HR Medical Scheme Members"."Out patient Benefit")
                {
                }
                column(Status_HRMedicalSchemeMembers; "HR Medical Scheme Members".Status)
                {
                }
                column(PrincipalNo_HRMedicalSchemeMembers; "HR Medical Scheme Members"."Principal No")
                {
                }
                column(DependantName_HRMedicalSchemeMembers; "HR Medical Scheme Members"."Dependant Name")
                {
                }
                column(DateofBirth_HRMedicalSchemeMembers; "HR Medical Scheme Members"."Date of Birth")
                {
                }
                column(Relation_HRMedicalSchemeMembers; "HR Medical Scheme Members".Age)
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

    labels
    {
    }

    trigger OnInitReport()
    begin
        CI.Get;
        CI.CalcFields(Picture);
    end;

    var
        Lno: Integer;
        Text0001: Label '"Empowered Healthy Communities"';
        CompanyInfo: Record "Company Information";
        CI: Record "Company Information";
}

