report 50063 "Marketing Plan List"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Marketing Plan List.rdl';

    dataset
    {
        dataitem("Employee Account Invoice2"; "Employee Account Invoice2")
        {
            //RequestFilterFields = "Loan Account No.",Field14,Field24,Field14;
            column(LN1; LN1)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(pic; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_Phone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Fax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Email; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfo_Web; CompanyInfo."Home Page")
            {
            }
            column(No_MarketingPlan; "Employee Account Invoice2"."Loan Account No.")
            {
            }
            column(Description_MarketingPlan; "Employee Account Invoice2"."Loan Account Name")
            {
            }
            column(Date_MarketingPlan; "Employee Account Invoice2"."Currency Code")
            {
            }
            column(CampaignsCount_MarketingPlan; "Employee Account Invoice2"."Currency Factor")
            {
            }
            column(Budget_MarketingPlan; "Employee Account Invoice2"."Loan Account Name")
            {
            }
            column(BudgetVoteAccount_MarketingPlan; "Employee Account Invoice2"."Loan Account Name")
            {
            }
            column(BudgetAmount_MarketingPlan; "Employee Account Invoice2"."Loan Account Name")
            {
            }
            column(ActivitiesTotalBudget_MarketingPlan; "Employee Account Invoice2"."Loan Account Name")
            {
            }
            column(TotalActEstimatedCost_MarketingPlan; "Employee Account Invoice2"."Loan Account Name")
            {
            }
            column(TotalActActualCost_MarketingPlan; "Employee Account Invoice2"."Loan Account Name")
            {
            }
            column(UserId_MarketingPlan; "Employee Account Invoice2"."User ID")
            {
            }
            column(CreationDate_MarketingPlan; "Employee Account Invoice2"."Loan Account Name")
            {
            }
            column(Status_MarketingPlan; "Employee Account Invoice2".Status)
            {
            }
            column(NoSeries_MarketingPlan; "Employee Account Invoice2"."No. Series")
            {
            }
            column(MarketingPlanYear_MarketingPlan; "Employee Account Invoice2"."Loan Account Name")
            {
            }

            trigger OnAfterGetRecord()
            begin
                LN1 := LN1 + 1;
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture)
    end;

    var
        CompanyInfo: Record "Company Information";
        LN1: Integer;
}

