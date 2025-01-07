report 50168 "Inv. Loan TermSheet"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Inv. Loan TermSheet.rdl';

    dataset
    {
        dataitem("Payment Terms"; "Payment Terms")
        {
            dataitem(Currency; Currency)
            {
                DataItemLink = Code = FIELD(Code);
                column(No_; "Payment Terms".Code)
                {
                }
                column(DocumentDate; "Payment Terms".Code)
                {
                }
                column(CustomerRegistrationN; "Payment Terms".Code)
                {
                }
                column(Name; "Payment Terms".Code)
                {
                }
                column(CustomerNo; "Payment Terms".Code)
                {
                }
                column(CustomerName; "Payment Terms".Code)
                {
                }
                column(CompanyRegistrationNo; "Payment Terms".Code)
                {
                }
                column(PinNo; "Payment Terms".Code)
                {
                }
                column(VATRegistration; "Payment Terms".Code)
                {
                }
                column(PostalCode; "Payment Terms".Code)
                {
                }
                column(Addres; "Payment Terms".Code)
                {
                }
                column(City; "Payment Terms".Code)
                {
                }
                column(PhysicalAddres; "Payment Terms".Code)
                {
                }
                column(PhoneNo; "Payment Terms".Code)
                {
                }
                column(PhoneNo2; "Payment Terms".Code)
                {
                }
                column(EmailAddress_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(AlternativeEmailAddress_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(HomePage_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(ContactPersonName_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(ContactPersonPhoneNo_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(ContactPersonEMail_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(CountyCode_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(SubCountyCode_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(ApplicationType_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(ProductCategory_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(ProductCode_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(CurrencyCode_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(AppliedAmount_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(AppliedAmountLCY_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(IndicativeAmount_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(IndicativeAmountLCY_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(ApprovedAmount; "Payment Terms".Code)
                {
                }
                column(ApprovedAmountLCY_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(VettingScore_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(ScreeningScore_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(AppraisalFeeAccountNo_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(AppraisalFeeReceived_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(AppraisalCompleted_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(GlobalDimension1Code_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(GlobalDimension2Code_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(ShortcutDimension3Code_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(ShortcutDimension4Code_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(ShortcutDimension5Code_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(ShortcutDimension6Code_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(ShortcutDimension7Code_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(ShortcutDimension8Code_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(ResponsibilityCenter_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(Description_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(CreatedBy_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(DateCreated_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(TimeCreated_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(Status_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(AppraisalFeesPayable_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(AppraisalFeesPayableLCY_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(Rejected_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(RejectedBy_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(DateRejected_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(TimeRejected_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(RejectionComments_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(ApplicationUserID_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(UserID_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(NoSeries_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(IncomingDocumentEntryNo_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(RepaymentFrequency; "Payment Terms".Code)
                {
                }
                column(RepaymentPeriod; "Payment Terms".Code)
                {
                }
                column(NoofInstallments; "Payment Terms".Code)
                {
                }
                column(PrincipalMoratoriumPeriod; "Payment Terms".Code)
                {
                }
                column(InterestMoratoriumPeriod; "Payment Terms".Code)
                {
                }
                column(RepaymentStartDate; "Payment Terms".Code)
                {
                }
                column(RepaymentEndDate; "Payment Terms".Code)
                {
                }
                column(RepaymentAmount; "Payment Terms".Code)
                {
                }
                column(AnnualBaseInterestRate; "Payment Terms".Code)
                {
                }
                column(AnnualInterestMarginRate; "Payment Terms".Code)
                {
                }
                column(ApplicationStatus; "Payment Terms".Code)
                {
                }
                column(Submitted_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(MarketingHeadNo_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(MarketingHeadName_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(MarketingHeadUserID_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(MarketingHeadRemarks_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(MarketingOfficerNo_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(MarketingOfficerName_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(MarketingOfficerUserID_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(MarketingOfficerRemarks_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(MarketingLevel_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(InvestmentHeadNo_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(InvestmentHeadName_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(InvestmentHeadUserID_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(InvestmentHeadRemarks_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(InvestmentOfficerNo_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(InvestmentOfficerName_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(InvestmentOfficerUserID_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(InvestmentOfficerRemarks_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(InvestmentLevel_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(CompanyNoofShares_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(AuthorisedShareCapital_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(Valueofthecompany_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(PaidupShareCapital_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(PreferenceShares_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(PreferenceSharesPrice_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(OfferPricePreferenceShare_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(OrdinaryShares_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(OrdinarySharesPrice_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(OfferPriceOrdinaryShare_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(EnquiryNo_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(LoanAccountNo_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(IndustryCode_InvestmentApplications; "Payment Terms".Code)
                {
                }
                column(SectorCode_InvestmentApplications; "Payment Terms".Code)
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
}

