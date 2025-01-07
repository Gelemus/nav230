report 50182 "Account Closure Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Account Closure Details.rdl';

    dataset
    {
        dataitem("Payment Terms"; "Payment Terms")
        {
            RequestFilterFields = "Code";
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
            column(AccountBalance_AccountClosure; "Payment Terms".Code)
            {
            }
            column(Code_PaymentTerms; "Payment Terms".Code)
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
            column(ProductCategory_AccountClosure; "Payment Terms".Code)
            {
            }
            column(ProductCode_AccountClosure; "Payment Terms".Code)
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
            column(No_AccountClosure; "Payment Terms".Code)
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
            column(Type_AccountClosure; "Payment Terms".Code)
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

