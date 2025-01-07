report 50061 "Campaigns List"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Campaigns List.rdl';

    dataset
    {
        dataitem(Campaign; Campaign)
        {
            //RequestFilterFields = "No.",Field52137003,Field52137004,Field52137000,Field52137001,Field52137002;
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
            column(No_Campaign; Campaign."No.")
            {
            }
            column(Description_Campaign; Campaign.Description)
            {
            }
            column(StartingDate_Campaign; Campaign."Starting Date")
            {
            }
            column(EndingDate_Campaign; Campaign."Ending Date")
            {
            }
            column(SalespersonCode_Campaign; Campaign."Salesperson Code")
            {
            }
            column(Comment_Campaign; Campaign.Comment)
            {
            }
            column(LastDateModified_Campaign; Campaign."Last Date Modified")
            {
            }
            column(NoSeries_Campaign; Campaign."No. Series")
            {
            }
            column(GlobalDimension1Code_Campaign; Campaign."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_Campaign; Campaign."Global Dimension 2 Code")
            {
            }
            column(StatusCode_Campaign; Campaign."Status Code")
            {
            }
            column(TargetContactsContacted_Campaign; Campaign."Target Contacts Contacted")
            {
            }
            column(ContactsResponded_Campaign; Campaign."Contacts Responded")
            {
            }
            column(DurationMin_Campaign; Campaign."Duration (Min.)")
            {
            }
            column(CostLCY_Campaign; Campaign."Cost (LCY)")
            {
            }
            column(NoofOpportunities_Campaign; Campaign."No. of Opportunities")
            {
            }
            column(EstimatedValueLCY_Campaign; Campaign."Estimated Value (LCY)")
            {
            }
            column(CalcdCurrentValueLCY_Campaign; Campaign."Calcd. Current Value (LCY)")
            {
            }
            column(DateFilter_Campaign; Campaign."Date Filter")
            {
            }
            column(ActionTakenFilter_Campaign; Campaign."Action Taken Filter")
            {
            }
            column(SalesCycleFilter_Campaign; Campaign."Sales Cycle Filter")
            {
            }
            column(SalesCycleStageFilter_Campaign; Campaign."Sales Cycle Stage Filter")
            {
            }
            column(ProbabilityFilter_Campaign; Campaign."Probability % Filter")
            {
            }
            column(CompletedFilter_Campaign; Campaign."Completed % Filter")
            {
            }
            column(ContactFilter_Campaign; Campaign."Contact Filter")
            {
            }
            column(ContactCompanyFilter_Campaign; Campaign."Contact Company Filter")
            {
            }
            column(EstimatedValueFilter_Campaign; Campaign."Estimated Value Filter")
            {
            }
            column(CalcdCurrentValueFilter_Campaign; Campaign."Calcd. Current Value Filter")
            {
            }
            column(ChancesofSuccessFilter_Campaign; Campaign."Chances of Success % Filter")
            {
            }
            column(TaskStatusFilter_Campaign; Campaign."Task Status Filter")
            {
            }
            column(TaskClosedFilter_Campaign; Campaign."Task Closed Filter")
            {
            }
            column(PriorityFilter_Campaign; Campaign."Priority Filter")
            {
            }
            column(TeamFilter_Campaign; Campaign."Team Filter")
            {
            }
            column(SalespersonFilter_Campaign; Campaign."Salesperson Filter")
            {
            }
            column(OpportunityEntryExists_Campaign; Campaign."Opportunity Entry Exists")
            {
            }
            column(TaskEntryExists_Campaign; Campaign."Task Entry Exists")
            {
            }
            column(CloseOpportunityFilter_Campaign; Campaign."Close Opportunity Filter")
            {
            }
            column(Activated_Campaign; Campaign.Activated)
            {
            }
            column(Budget_Campaign; Campaign.Activated)
            {
            }
            column(BudgetAmount_Campaign; Campaign.Activated)
            {
            }
            column(TaskEstimatedAmount_Campaign; Campaign.Activated)
            {
            }
            column(Status_Campaign; Campaign.Activated)
            {
            }
            column(DocumentDate_Campaign; Campaign.Activated)
            {
            }
            column(UserID_Campaign; Campaign.Activated)
            {
            }
            column(IncomingDocumentEntryNo_Campaign; Campaign.Activated)
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

