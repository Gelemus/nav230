report 50029 "Fixed Deposits Period Interest"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Fixed Deposits Period Interest.rdl';

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
            column(InterestAmount; InterestAmount)
            {
            }
            column(STARTDATE; StartDate)
            {
            }
            column(ENDDATE; EndDate)
            {
            }

            trigger OnAfterGetRecord()
            begin
                InterestAmount := 0;

                InterestBuffer.Reset;
                InterestBuffer.SetRange(InterestBuffer."Document No.", "FD Processing"."Document No.");
                InterestBuffer.SetRange(InterestBuffer."Interest Date", StartDate, EndDate);
                if InterestBuffer.FindSet then begin
                    repeat
                        InterestAmount := InterestAmount + InterestBuffer."Interest Amount";
                    until InterestBuffer.Next = 0;
                end;
            end;

            trigger OnPreDataItem()
            begin
                if (StartDate = 0D) or (EndDate = 0D) then
                    Error('The Start/End Date cannot be empty.');

                if EndDate < StartDate then
                    Error('The End Date cannot be earlier than the Start Date.');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; StartDate)
                {
                }
                field("End Date"; EndDate)
                {
                }
            }
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
        StartDate: Date;
        EndDate: Date;
        InterestBuffer: Record "Interest Buffer";
        InterestAmount: Decimal;
}

