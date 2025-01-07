report 50028 "FD Bid Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/FD Bid Analysis.rdl';

    dataset
    {
        dataitem("FD Processing"; "FD Processing")
        {
            dataitem("Fixed Deposit Bids"; "Fixed Deposit Bids")
            {
                DataItemLink = "Document No" = FIELD("Document No.");
                column(CompanyInfoName; CompanyInfo.Name)
                {
                }
                column(CompanyInfoAddress; CompanyInfo.Address)
                {
                }
                column(CompanyInfoPicture; CompanyInfo.Picture)
                {
                }
                column(DocumentNo_FixedDepositBids; "Fixed Deposit Bids"."Document No")
                {
                }
                column(BankAccount_FixedDepositBids; "Fixed Deposit Bids"."Bank Account")
                {
                }
                column(BankAccountName_FixedDepositBids; "Fixed Deposit Bids"."Bank Account Name")
                {
                }
                column(Amount_FixedDepositBids; "Fixed Deposit Bids".Amount)
                {
                }
                column(DesiredRate_FixedDepositBids; "Fixed Deposit Bids"."Desired Rate")
                {
                }
                column(FDDuration_FixedDepositBids; "Fixed Deposit Bids"."FD Duration")
                {
                }
                column(Rate_FixedDepositBids; "Fixed Deposit Bids".Rate)
                {
                }
                column(ExpectedInterest; ExpectedInterest)
                {
                }
                column(BankRank; BankRank)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    ExpectedInterest := Round((("Fixed Deposit Bids".Amount * "Fixed Deposit Bids".Rate / 100) / 12))//*"Fixed Deposit Bids"."FD Duration",1);
                    //FXDINterest:=ROUND(((Bal*Rate/100)/365)*RIntDays,0.05,'=')
                end;
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
        CompanyInfo: Record "Company Information";
        ExpectedInterest: Decimal;
        BankRank: Integer;
}

