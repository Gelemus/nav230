report 50030 "Fixed Deposits Lists"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Fixed Deposits Lists.rdl';

    dataset
    {
        dataitem("FD Processing"; "FD Processing")
        {
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
            column(DocumentNo_FDProcessing; "FD Processing"."Document No.")
            {
            }
            column(FDAmount_FDProcessing; "FD Processing"."FD Amount")
            {
            }
            column(FDAccount_FDProcessing; "FD Processing"."FD Account")
            {
            }
            column(FDAccountName_FDProcessing; "FD Processing"."FD Account Name")
            {
            }
            column(FDMaturityDate_FDProcessing; "FD Processing"."FD Maturity Date")
            {
            }
            column(FixedDepositStatus_FDProcessing; "FD Processing"."Fixed Deposit Status")
            {
            }
            column(FixedDepositStartDate_FDProcessing; "FD Processing"."Fixed Deposit Start Date")
            {
            }
            column(FixedDuration_FDProcessing; "FD Processing"."Fixed Duration")
            {
            }
            column(ExpectedMaturityDate_FDProcessing; "FD Processing"."Expected Maturity Date")
            {
            }
            column(Interestrate_FDProcessing; "FD Processing"."Interest rate")
            {
            }
            column(InterestEarned_FDProcessing; "FD Processing"."Interest Earned")
            {
            }
            column(LastInterestEarnedDate_FDProcessing; "FD Processing"."Last Interest Earned Date")
            {
            }
            column(ExpectedInterestOnTermDep_FDProcessing; "FD Processing"."Expected Interest On Term Dep")
            {
            }
            column(UntranferedInterest_FDProcessing; "FD Processing"."Untranfered Interest")
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

