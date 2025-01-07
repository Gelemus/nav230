report 50183 "Account Completion Certificate"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Account Completion Certificate.rdl';

    dataset
    {
        dataitem("Payment Terms"; "Payment Terms")
        {
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
            column(Certificate_Date; CertificateDate)
            {
            }
            column(No_AccountClosure; "Payment Terms".Code)
            {
            }
            column(Code_PaymentTerms; "Payment Terms".Code)
            {
            }
            column(DocumentDate_AccountClosure; "Payment Terms".Code)
            {
            }
            column(CustomerRegistrationNo_AccountClosure; "Payment Terms".Code)
            {
            }
            column(Name_AccountClosure; "Payment Terms".Code)
            {
            }
            column(CustomerNo_AccountClosure; "Payment Terms".Code)
            {
            }
            column(CustomerName_AccountClosure; "Payment Terms".Code)
            {
            }
            column(CompanyRegistrationNo_AccountClosure; "Payment Terms".Code)
            {
            }
            column(PinNo_AccountClosure; "Payment Terms".Code)
            {
            }
            column(VATRegistrationNo_AccountClosure; "Payment Terms".Code)
            {
            }
            column(PostalCode_AccountClosure; "Payment Terms".Code)
            {
            }
            column(Address_AccountClosure; "Payment Terms".Code)
            {
            }
            column(City_AccountClosure; "Payment Terms".Code)
            {
            }
            column(PhysicalAddress_AccountClosure; "Payment Terms".Code)
            {
            }
            column(PhoneNo_AccountClosure; "Payment Terms".Code)
            {
            }
            column(PhoneNo2_AccountClosure; "Payment Terms".Code)
            {
            }
            column(EmailAddress_AccountClosure; "Payment Terms".Code)
            {
            }
            column(AlternativeEmailAddress_AccountClosure; "Payment Terms".Code)
            {
            }
            column(HomePage_AccountClosure; "Payment Terms".Code)
            {
            }
            column(AccountNo_AccountClosure; "Payment Terms".Code)
            {
            }
            column(ApplicationNo_AccountClosure; "Payment Terms".Code)
            {
            }
            column(ProductCategory_AccountClosure; "Payment Terms".Code)
            {
            }
            column(ProductCode_AccountClosure; "Payment Terms".Code)
            {
            }
            column(CurrencyCode_AccountClosure; "Payment Terms".Code)
            {
            }
            column(AppliedAmount_AccountClosure; "Payment Terms".Code)
            {
            }
            column(AppliedAmountLCY_AccountClosure; "Payment Terms".Code)
            {
            }
            column(ApprovedAmount_AccountClosure; "Payment Terms".Code)
            {
            }
            column(ApprovedAmountLCY_AccountClosure; "Payment Terms".Code)
            {
            }
            column(DisbursedAmount_AccountClosure; "Payment Terms".Code)
            {
            }
            column(DisbursedAmountLCY_AccountClosure; "Payment Terms".Code)
            {
            }
            column(UndisbursedAmount_AccountClosure; "Payment Terms".Code)
            {
            }
            column(UndisbursedAmountLCY_AccountClosure; "Payment Terms".Code)
            {
            }
            column(AnnualBaseInterestRate_AccountClosure; "Payment Terms".Code)
            {
            }
            column(AnnualInterestMarginRate_AccountClosure; "Payment Terms".Code)
            {
            }
            column(RepaymentFrequency_AccountClosure; "Payment Terms".Code)
            {
            }
            column(RepaymentPeriod_AccountClosure; "Payment Terms".Code)
            {
            }
            column(NoofInstallments_AccountClosure; "Payment Terms".Code)
            {
            }
            column(PrincipalMoratoriumPeriod_AccountClosure; "Payment Terms".Code)
            {
            }
            column(InterestMoratoriumPeriod_AccountClosure; "Payment Terms".Code)
            {
            }
            column(RepaymentStartDate_AccountClosure; "Payment Terms".Code)
            {
            }
            column(RepaymentEndDate_AccountClosure; "Payment Terms".Code)
            {
            }
            column(RepaymentAmount_AccountClosure; "Payment Terms".Code)
            {
            }
            column(RiskClassification_AccountClosure; "Payment Terms".Code)
            {
            }
            column(GlobalDimension1Code_AccountClosure; "Payment Terms".Code)
            {
            }
            column(GlobalDimension2Code_AccountClosure; "Payment Terms".Code)
            {
            }
            column(ShortcutDimension3Code_AccountClosure; "Payment Terms".Code)
            {
            }
            column(ShortcutDimension4Code_AccountClosure; "Payment Terms".Code)
            {
            }
            column(ShortcutDimension5Code_AccountClosure; "Payment Terms".Code)
            {
            }
            column(ShortcutDimension6Code_AccountClosure; "Payment Terms".Code)
            {
            }
            column(ShortcutDimension7Code_AccountClosure; "Payment Terms".Code)
            {
            }
            column(ShortcutDimension8Code_AccountClosure; "Payment Terms".Code)
            {
            }
            column(ResponsibilityCenter_AccountClosure; "Payment Terms".Code)
            {
            }
            column(Description_AccountClosure; "Payment Terms".Code)
            {
            }
            column(Type_AccountClosure; "Payment Terms".Code)
            {
            }
            column(Option_AccountClosure; "Payment Terms".Code)
            {
            }
            column(CreatedBy_AccountClosure; "Payment Terms".Code)
            {
            }
            column(DateCreated_AccountClosure; "Payment Terms".Code)
            {
            }
            column(TimeCreated_AccountClosure; "Payment Terms".Code)
            {
            }
            column(Status_AccountClosure; "Payment Terms".Code)
            {
            }
            column(Rejected_AccountClosure; "Payment Terms".Code)
            {
            }
            column(RejectedBy_AccountClosure; "Payment Terms".Code)
            {
            }
            column(DateRejected_AccountClosure; "Payment Terms".Code)
            {
            }
            column(TimeRejected_AccountClosure; "Payment Terms".Code)
            {
            }
            column(RejectionComments_AccountClosure; "Payment Terms".Code)
            {
            }
            column(UserID_AccountClosure; "Payment Terms".Code)
            {
            }
            column(NoSeries_AccountClosure; "Payment Terms".Code)
            {
            }
            column(IncomingDocumentEntryNo_AccountClosure; "Payment Terms".Code)
            {
            }
            column(DateFilter_AccountClosure; "Payment Terms".Code)
            {
            }
            column(DisbursementAccountNo_AccountClosure; "Payment Terms".Code)
            {
            }
            column(AccountBalance_AccountClosure; "Payment Terms".Code)
            {
            }
            column(ArrearsDateFilter_AccountClosure; "Payment Terms".Code)
            {
            }
            column(PrincipalInArrears_AccountClosure; "Payment Terms".Code)
            {
            }
            column(InterestInArrears_AccountClosure; "Payment Terms".Code)
            {
            }
            column(PenaltyInterestInArrears_AccountClosure; "Payment Terms".Code)
            {
            }
            column(LoanFeeInArrears_AccountClosure; "Payment Terms".Code)
            {
            }
            column(NonDueDateFilter_AccountClosure; "Payment Terms".Code)
            {
            }
            column(NonDuePrincipal_AccountClosure; "Payment Terms".Code)
            {
            }
            column(NonDueInterest_AccountClosure; "Payment Terms".Code)
            {
            }
            column(InterestAccruedCurrentMonth_AccountClosure; "Payment Terms".Code)
            {
            }
            column(PenaltyArrearsDateFilter_AccountClosure; "Payment Terms".Code)
            {
            }
            column(CurrentAccountPayoff_AccountClosure; "Payment Terms".Code)
            {
            }
            column(EnquiryNo_AccountClosure; "Payment Terms".Code)
            {
            }
            column(IndustryCode_AccountClosure; "Payment Terms".Code)
            {
            }
            column(SectorCode_AccountClosure; "Payment Terms".Code)
            {
            }

            trigger OnAfterGetRecord()
            begin
                LNo := LNo + 1;
                CertificateDate := Today;
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
        CI: Record "Company Information";
        LNo: Integer;
        CertificateDate: Date;
        Text0001: Label 'TURNING IDEAS INTO WEALTH';
}

