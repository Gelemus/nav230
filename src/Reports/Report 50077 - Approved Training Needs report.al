report 50077 "Approved Training Needs report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Approved Training Needs report.rdl';
    Caption = 'HR Collated Training Needs report';

    dataset
    {
        dataitem("Approved Training Needs Header"; "Approved Training Needs Header")
        {
            RequestFilterFields = "No.";
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
            column(No_ApprovedTrainingNeedsHeader; "No.")
            {
            }
            column(Description_ApprovedTrainingNeedsHeader; Description)
            {
            }
            column(CalendarYear_ApprovedTrainingNeedsHeader; "Calendar Year")
            {
            }
            dataitem("Approved Training Needs Line"; "Approved Training Needs Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = WHERE("Approved By Management" = CONST(true));
                column(EmployeeNo_ApprovedTrainingNeedsLine; "Employee No.")
                {
                }
                column(EmployeeName_ApprovedTrainingNeedsLine; "Employee Name")
                {
                }
                column(OfficialMail_ApprovedTrainingNeedsLine; "Official Mail")
                {
                }
                column(DevelopmentNeeds_ApprovedTrainingNeedsLine; "Development Needs")
                {
                }
                column(InterventionRequired_ApprovedTrainingNeedsLine; "Intervention Required")
                {
                }
                column(Objectives_ApprovedTrainingNeedsLine; Objectives)
                {
                }
                column(Description_ApprovedTrainingNeedsLine; Description)
                {
                }
                column(ProposedTrainingProvider_ApprovedTrainingNeedsLine; "Proposed Training Provider")
                {
                }
                column(ProposedPeriod_ApprovedTrainingNeedsLine; "Proposed Period")
                {
                }
                column(ApprovedByManagement_ApprovedTrainingNeedsLine; "Approved By Management")
                {
                }
                column(CalendarYear_ApprovedTrainingNeedsLine; "Calendar Year")
                {
                }
                column(TrainingLocationVenue_ApprovedTrainingNeedsLine; "Training Location & Venue")
                {
                }
                column(TrainingScheduledDate_ApprovedTrainingNeedsLine; "Training Scheduled Date")
                {
                }
                column(TrainingScheduledDateTo_ApprovedTrainingNeedsLine; "Training Scheduled Date To")
                {
                }
                column(EstimatedCost_ApprovedTrainingNeedsLine; "Estimated Cost")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    LNo := LNo + 1;
                end;
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

