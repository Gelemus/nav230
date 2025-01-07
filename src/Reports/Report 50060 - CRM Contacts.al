report 50060 "CRM Contacts"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/CRM Contacts.rdl';

    dataset
    {
        dataitem(Contact; Contact)
        {
            // RequestFilterFields = "No.",Field52137500,Name,Field52137501;
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
            column(No_Contact; Contact."No.")
            {
            }
            column(Name_Contact; Contact.Name)
            {
            }
            column(SearchName_Contact; Contact."Search Name")
            {
            }
            column(Name2_Contact; Contact."Name 2")
            {
            }
            column(Address_Contact; Contact.Address)
            {
            }
            column(Address2_Contact; Contact."Address 2")
            {
            }
            column(City_Contact; Contact.City)
            {
            }
            column(PhoneNo_Contact; Contact."Phone No.")
            {
            }
            column(TelexNo_Contact; Contact."Telex No.")
            {
            }
            column(TerritoryCode_Contact; Contact."Territory Code")
            {
            }
            column(CurrencyCode_Contact; Contact."Currency Code")
            {
            }
            column(LanguageCode_Contact; Contact."Language Code")
            {
            }
            column(SalespersonCode_Contact; Contact."Salesperson Code")
            {
            }
            column(CountryRegionCode_Contact; Contact."Country/Region Code")
            {
            }
            column(Comment_Contact; Contact.Comment)
            {
            }
            column(LastDateModified_Contact; Contact."Last Date Modified")
            {
            }
            column(FaxNo_Contact; Contact."Fax No.")
            {
            }
            column(TelexAnswerBack_Contact; Contact."Telex Answer Back")
            {
            }
            column(VATRegistrationNo_Contact; Contact."VAT Registration No.")
            {
                // }
                // column(Picture_Contact;Contact.Picture)
                // {
            }
            column(PostCode_Contact; Contact."Post Code")
            {
            }
            column(County_Contact; Contact.County)
            {
            }
            column(EMail_Contact; Contact."E-Mail")
            {
            }
            column(HomePage_Contact; Contact."Home Page")
            {
            }
            column(NoSeries_Contact; Contact."No. Series")
            {
            }
            column(Image_Contact; Contact.Image)
            {
            }
            column(PrivacyBlocked_Contact; Contact."Privacy Blocked")
            {
            }
            column(Minor_Contact; Contact.Minor)
            {
            }
            column(ParentalConsentReceived_Contact; Contact."Parental Consent Received")
            {
            }
            column(Type_Contact; Contact.Type)
            {
            }
            column(CompanyNo_Contact; Contact."Company No.")
            {
            }
            column(CompanyName_Contact; Contact."Company Name")
            {
            }
            column(LookupContactNo_Contact; Contact."Lookup Contact No.")
            {
            }
            column(FirstName_Contact; Contact."First Name")
            {
            }
            column(MiddleName_Contact; Contact."Middle Name")
            {
            }
            column(Surname_Contact; Contact.Surname)
            {
            }
            column(JobTitle_Contact; Contact."Job Title")
            {
            }
            column(Initials_Contact; Contact.Initials)
            {
            }
            column(ExtensionNo_Contact; Contact."Extension No.")
            {
            }
            column(MobilePhoneNo_Contact; Contact."Mobile Phone No.")
            {
            }
            column(Pager_Contact; Contact.Pager)
            {
            }
            column(OrganizationalLevelCode_Contact; Contact."Organizational Level Code")
            {
            }
            column(ExcludefromSegment_Contact; Contact."Exclude from Segment")
            {
            }
            column(DateFilter_Contact; Contact."Date Filter")
            {
            }
            column(NextTaskDate_Contact; Contact."Next Task Date")
            {
            }
            column(LastDateAttempted_Contact; Contact."Last Date Attempted")
            {
            }
            column(DateofLastInteraction_Contact; Contact."Date of Last Interaction")
            {
            }
            column(NoofJobResponsibilities_Contact; Contact."No. of Job Responsibilities")
            {
            }
            column(NoofIndustryGroups_Contact; Contact."No. of Industry Groups")
            {
            }
            column(NoofBusinessRelations_Contact; Contact."No. of Business Relations")
            {
            }
            column(NoofMailingGroups_Contact; Contact."No. of Mailing Groups")
            {
            }
            column(ExternalID_Contact; Contact."External ID")
            {
            }
            column(NoofInteractions_Contact; Contact."No. of Interactions")
            {
            }
            column(CostLCY_Contact; Contact."Cost (LCY)")
            {
            }
            column(DurationMin_Contact; Contact."Duration (Min.)")
            {
            }
            column(NoofOpportunities_Contact; Contact."No. of Opportunities")
            {
            }
            column(EstimatedValueLCY_Contact; Contact."Estimated Value (LCY)")
            {
            }
            column(CalcdCurrentValueLCY_Contact; Contact."Calcd. Current Value (LCY)")
            {
            }
            column(OpportunityEntryExists_Contact; Contact."Opportunity Entry Exists")
            {
            }
            column(TaskEntryExists_Contact; Contact."Task Entry Exists")
            {
            }
            column(SalespersonFilter_Contact; Contact."Salesperson Filter")
            {
            }
            column(CampaignFilter_Contact; Contact."Campaign Filter")
            {
            }
            column(ActionTakenFilter_Contact; Contact."Action Taken Filter")
            {
            }
            column(SalesCycleFilter_Contact; Contact."Sales Cycle Filter")
            {
            }
            column(SalesCycleStageFilter_Contact; Contact."Sales Cycle Stage Filter")
            {
            }
            column(ProbabilityFilter_Contact; Contact."Probability % Filter")
            {
            }
            column(CompletedFilter_Contact; Contact."Completed % Filter")
            {
            }
            column(EstimatedValueFilter_Contact; Contact."Estimated Value Filter")
            {
            }
            column(CalcdCurrentValueFilter_Contact; Contact."Calcd. Current Value Filter")
            {
            }
            column(ChancesofSuccessFilter_Contact; Contact."Chances of Success % Filter")
            {
            }
            column(TaskStatusFilter_Contact; Contact."Task Status Filter")
            {
            }
            column(TaskClosedFilter_Contact; Contact."Task Closed Filter")
            {
            }
            column(PriorityFilter_Contact; Contact."Priority Filter")
            {
            }
            column(TeamFilter_Contact; Contact."Team Filter")
            {
            }
            column(CloseOpportunityFilter_Contact; Contact."Close Opportunity Filter")
            {
            }
            column(CorrespondenceType_Contact; Contact."Correspondence Type")
            {
            }
            column(SalutationCode_Contact; Contact."Salutation Code")
            {
            }
            column(SearchEMail_Contact; Contact."Search E-Mail")
            {
            }
            column(LastTimeModified_Contact; Contact."Last Time Modified")
            {
            }
            column(EMail2_Contact; Contact."E-Mail 2")
            {
            }
            column(XrmId_Contact; Contact."Xrm Id")
            {
            }
            column(KRAPINNo_Contact; Contact."E-Mail 2")
            {
            }
            column(IDNumber_Contact; Contact."E-Mail 2")
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

