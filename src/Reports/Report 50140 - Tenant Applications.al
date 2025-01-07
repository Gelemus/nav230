report 50140 "TenantApplications"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Tenant Applications.rdl';

    dataset
    {
        dataitem("Payment Terms"; "Payment Terms")
        {
            //RequestFilterFields = Field50,Field43;
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
            column(ApplicationNo_TenantApplication; "Payment Terms".Code)
            {
            }
            column(Name_TenantApplication; "Payment Terms".Code)
            {
            }
            column(SearchName_TenantApplication; "Payment Terms".Code)
            {
            }
            column(Name2_TenantApplication; "Payment Terms".Code)
            {
            }
            column(Address_TenantApplication; "Payment Terms".Code)
            {
            }
            column(Address2_TenantApplication; "Payment Terms".Code)
            {
            }
            column(City_TenantApplication; "Payment Terms".Code)
            {
            }
            column(Contact_TenantApplication; "Payment Terms".Code)
            {
            }
            column(PhoneNo_TenantApplication; "Payment Terms".Code)
            {
            }
            column(TelexNo_TenantApplication; "Payment Terms".Code)
            {
            }
            column(TenantAccountNo_TenantApplication; "Payment Terms".Code)
            {
            }
            column(GlobalDimension1Code_TenantApplication; "Payment Terms".Code)
            {
            }
            column(GlobalDimension2Code_TenantApplication; "Payment Terms".Code)
            {
            }
            column(CustomerPostingGroup_TenantApplication; "Payment Terms".Code)
            {
            }
            column(CurrencyCode_TenantApplication; "Payment Terms".Code)
            {
            }
            column(Amount_TenantApplication; "Payment Terms".Code)
            {
            }
            column(Comment_TenantApplication; "Payment Terms".Code)
            {
            }
            column(Blocked_TenantApplication; "Payment Terms".Code)
            {
            }
            column(BilltoCustomerNo_TenantApplication; "Payment Terms".Code)
            {
            }
            column(LastModifiedDateTime_TenantApplication; "Payment Terms".Code)
            {
            }
            column(LastDateModified_TenantApplication; "Payment Terms".Code)
            {
            }
            column(DateFilter_TenantApplication; "Payment Terms".Code)
            {
            }
            column(GlobalDimension1Filter_TenantApplication; "Payment Terms".Code)
            {
            }
            column(GlobalDimension2Filter_TenantApplication; "Payment Terms".Code)
            {
            }
            column(GenBusPostingGroup_TenantApplication; "Payment Terms".Code)
            {
            }
            column(Picture_TenantApplication; "Payment Terms".Code)
            {
            }
            column(EMail_TenantApplication; "Payment Terms".Code)
            {
            }
            column(HomePage_TenantApplication; "Payment Terms".Code)
            {
            }
            column(NoSeries_TenantApplication; "Payment Terms".Code)
            {
            }
            column(VATBusPostingGroup_TenantApplication; "Payment Terms".Code)
            {
            }
            column(KRAPINNo_TenantApplication; "Payment Terms".Code)
            {
            }
            column(VATAccountNo_TenantApplication; "Payment Terms".Code)
            {
            }
            column(UserID_TenantApplication; "Payment Terms".Code)
            {
            }
            column(DocumentDate_TenantApplication; "Payment Terms".Code)
            {
            }
            column(DocumentTime_TenantApplication; "Payment Terms".Code)
            {
            }
            column(HrsofBusiness_TenantApplication; "Payment Terms".Code)
            {
            }
            column(Status_TenantApplication; "Payment Terms".Code)
            {
            }
            column(Property_TenantApplication; "Payment Terms".Code)
            {
            }
            column(PropertyDescription_TenantApplication; "Payment Terms".Code)
            {
            }
            column(FloorNo_TenantApplication; "Payment Terms".Code)
            {
            }
            column(BlockNo_TenantApplication; "Payment Terms".Code)
            {
            }
            column(UnitNo_TenantApplication; "Payment Terms".Code)
            {
            }
            column(AreaRequiredSqFeet_TenantApplication; "Payment Terms".Code)
            {
            }
            column(PurposeofSpace_TenantApplication; "Payment Terms".Code)
            {
            }
            column(ProductsServicesOffered_TenantApplication; "Payment Terms".Code)
            {
            }
            column(NumberofPersonell_TenantApplication; "Payment Terms".Code)
            {
            }
            column(AnySpecialRequirements_TenantApplication; "Payment Terms".Code)
            {
            }
            column(BankCode_TenantApplication; "Payment Terms".Code)
            {
            }
            column(BankName_TenantApplication; "Payment Terms".Code)
            {
            }
            column(BankBranchCode_TenantApplication; "Payment Terms".Code)
            {
            }
            column(BankBranchName_TenantApplication; "Payment Terms".Code)
            {
            }
            column(BankAccountName_TenantApplication; "Payment Terms".Code)
            {
            }
            column(BankAccountNo_TenantApplication; "Payment Terms".Code)
            {
            }
            column(TypeofCompany_TenantApplication; "Payment Terms".Code)
            {
            }
            column(RegistrationIncoporationDate_TenantApplication; "Payment Terms".Code)
            {
            }
            column(CompanyRegistrationNo_TenantApplication; "Payment Terms".Code)
            {
            }
            column(HudumaNo_TenantApplication; "Payment Terms".Code)
            {
            }
            column(IncomingDocumentEntryNo_TenantApplication; "Payment Terms".Code)
            {
            }
            column(TenantCreated_TenantApplication; "Payment Terms".Code)
            {
            }
            column(DateCreated_TenantApplication; "Payment Terms".Code)
            {
            }
            column(PostCode_TenantApplication; "Payment Terms".Code)
            {
            }
            column(County_TenantApplication; "Payment Terms".Code)
            {
            }
            column(CountryRegionCode_TenantApplication; "Payment Terms".Code)
            {
            }
            column(ContactName_TenantApplication; "Payment Terms".Code)
            {
            }
            column(ContactPhoneNo_TenantApplication; "Payment Terms".Code)
            {
            }
            column(ContactEmail_TenantApplication; "Payment Terms".Code)
            {
            }
            column(UnitType_TenantApplication; "Payment Terms".Code)
            {
            }
            column(PasswordResetToken_TenantApplication; "Payment Terms".Code)
            {
            }
            column(PasswordResetTokenExpiry_TenantApplication; "Payment Terms".Code)
            {
            }
            column(PortalPassword_TenantApplication; "Payment Terms".Code)
            {
            }
            column(DefaultPortalPassword_TenantApplication; "Payment Terms".Code)
            {
            }
            column(SubmittedPortal_TenantApplication; "Payment Terms".Code)
            {
            }
            column(Approver_TenantApplication; "Payment Terms".Code)
            {
            }
            column(Receipted_TenantApplication; "Payment Terms".Code)
            {
            }
            column(ReceiptDate_TenantApplication; "Payment Terms".Code)
            {
            }
            column(ReceiptNo_TenantApplication; "Payment Terms".Code)
            {
            }
            column(CommenceDate_TenantApplication; "Payment Terms".Code)
            {
            }
            column(ExpiryDate_TenantApplication; "Payment Terms".Code)
            {
            }
            column(LeaseCategory_TenantApplication; "Payment Terms".Code)
            {
            }
            column(Comments_TenantApplication; "Payment Terms".Code)
            {
            }
            column(OldAccountNo_TenantApplication; "Payment Terms".Code)
            {
            }
            column(TotalAmountExclVAT_TenantApplication; "Payment Terms".Code)
            {
            }
            column(TotalVATAmount_TenantApplication; "Payment Terms".Code)
            {
            }
            column(TotalAmountIncVAT_TenantApplication; "Payment Terms".Code)
            {
            }
            column(TotalRentAmount_TenantApplication; "Payment Terms".Code)
            {
            }
            column(TotalDepositAmount_TenantApplication; "Payment Terms".Code)
            {
            }
            column(TotalServiceCharge_TenantApplication; "Payment Terms".Code)
            {
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture)
    end;

    var
        CompanyInfo: Record "Company Information";
}

