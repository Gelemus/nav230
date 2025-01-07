report 50144 "Loan Account Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Loan Account Invoice.rdl';

    dataset
    {
        dataitem("Tender Answers"; "Tender Answers")
        {
            RequestFilterFields = "Line No", "Date Update", "Created By";
            column(CName; CompanyInfo.Name)
            {
            }
            column(CAddress; CompanyInfo.Address)
            {
            }
            column(CPhone; CompanyInfo."Phone No.")
            {
            }
            column(CEmail; CompanyInfo."E-Mail")
            {
            }
            column(CVATNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(CPic; CompanyInfo.Picture)
            {
            }
            column(CBankName; CompanyInfo."Bank Name")
            {
            }
            column(CBankBranch; CompanyInfo."Bank Branch No.")
            {
            }
            column(CBankAccountNo; CompanyInfo."Bank Account No.")
            {
            }
            column(LoanProduct; LoanProduct)
            {
            }
            column(No_LoanAccountInvoice; "Tender Answers"."Line No")
            {
            }
            column(DocumentType_LoanAccountInvoice; "Tender Answers".Answer)
            {
            }
            column(DocumentDate_LoanAccountInvoice; "Tender Answers"."Date Created")
            {
            }
            column(PostingDate_LoanAccountInvoice; "Tender Answers"."Date Update")
            {
            }
            column(CustomerNo_LoanAccountInvoice; "Tender Answers"."Created By")
            {
            }
            column(CustomerName_LoanAccountInvoice; "Tender Answers"."Updated By")
            {
            }
            column(LoanAccountNo_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            column(LoanAccountName_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            column(CurrencyCode_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            column(CurrencyFactor_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            column(PrincipalArrears_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            column(PrincipalArrearsLCY_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            column(InterestArrears_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            column(InterestArrearsLCY_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            column(PenaltyInterestArrears_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            column(PenaltyInterestArrearsLCY_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            column(LoanFeeArrears_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            column(LoanFeeArrearsLCY_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            column(PrincipalAmount_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            column(PrincipalAmountLCY_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            column(InterestAmount_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            column(InterestAmountLCY_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            column(TotalAmount_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            column(TotalAmountLCY_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            column(GlobalDimension1Code_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            column(GlobalDimension2Code_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            column(ShortcutDimension3Code_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            column(ShortcutDimension4Code_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            column(ShortcutDimension5Code_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            column(ShortcutDimension6Code_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            column(ShortcutDimension7Code_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            column(ShortcutDimension8Code_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            column(ResponsibilityCenter_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            column(Description_LoanAccountInvoice; "Tender Answers"."Question Description")
            {
            }
            dataitem("Meeting Attendance"; "Meeting Attendance")
            {
                DataItemLink = "Meeting No" = FIELD("Question Description");
                column(ProductCategory_LoanAccounts; "Tender Answers"."Question Description")
                {
                }
                column(ProductCode_LoanAccounts; "Tender Answers"."Question Description")
                {
                }
                column(No_LoanAccounts; "Meeting Attendance"."Meeting No")
                {
                }
                column(DocumentDate_LoanAccounts; "Meeting Attendance"."Member No")
                {
                }
                column(CustomerRegistrationNo_LoanAccounts; "Meeting Attendance"."Committee Code")
                {
                }
                column(Name_LoanAccounts; "Meeting Attendance"."Committee Name")
                {
                }
                column(CustomerNo_LoanAccounts; "Meeting Attendance"."Meeting Date")
                {
                }
                column(CustomerName_LoanAccounts; "Meeting Attendance"."Meeting Name")
                {
                }
                column(CompanyRegistrationNo_LoanAccounts; "Meeting Attendance".Venue)
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

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        Units: Code[50];
        ExpiryDate: Date;
        ReviewDate: Date;
        CompanyInfo: Record "Company Information";
        Description2: Text;
        LoanProduct: Text;
        LoanAccount: Record "Meeting Attendance";
}

