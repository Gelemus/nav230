report 50068 "Collated Training Needs report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Collated Training Needs report.rdl';
    Caption = 'HR Collated Training Needs report';

    dataset
    {
        dataitem("HR Training Needs Header"; "HR Training Needs Header")
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
            column(No; LNo)
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
            column(CI_Visions; Text0001)
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(No_HRTrainingNeedsHeader; "No.")
            {
            }
            column(EmployeeNo_HRTrainingNeedsHeader; "Employee No.")
            {
            }
            column(JobNo_HRTrainingNeedsHeader; "Job No.")
            {
            }
            column(JobTitle_HRTrainingNeedsHeader; "Job Title")
            {
            }
            column(CalendarYear_HRTrainingNeedsHeader; "Calendar Year")
            {
            }
            column(Description_HRTrainingNeedsHeader; Description)
            {
            }
            dataitem("HR Training Needs Line"; "HR Training Needs Line")
            {
                DataItemLink = "No." = FIELD("No.");
                column(EmployeeNo_HRTrainingNeedsLine; "Employee No.")
                {
                }
                column(EmployeeName_HRTrainingNeedsLine; "Employee Name")
                {
                }
                column(DevelopmentNeeds_HRTrainingNeedsLine; "Development Needs")
                {
                }
                column(InterventionRequired_HRTrainingNeedsLine; "Intervention Required")
                {
                }
                column(Objectives_HRTrainingNeedsLine; Objectives)
                {
                }
                column(Description_HRTrainingNeedsLine; Description)
                {
                }
                column(ProposedTrainingProvider_HRTrainingNeedsLine; "Proposed Training Provider")
                {
                }
                column(ProposedPeriod_HRTrainingNeedsLine; "Proposed Period")
                {
                }
                column(EstimatedCost_HRTrainingNeedsLine; "Estimated Cost")
                {
                }
                column(TrainingLocationVenue_HRTrainingNeedsLine; "HR Training Needs Line"."Training Location & Venue")
                {
                }
                column(TrainingScheduledDate_HRTrainingNeedsLine; "HR Training Needs Line"."Training Scheduled Date")
                {
                }
                column(TrainingScheduledDateTo_HRTrainingNeedsLine; "HR Training Needs Line"."Training Scheduled Date To")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                LNo := LNo + 1;
            end;
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

    trigger OnPreReport()
    begin
        CI.Get;
        CI.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        LNo: Integer;
        Text0001: Label '"Turning Ideas Into Wealth"';
        CI: Record "Company Information";
}

