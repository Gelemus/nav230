report 50129 "Rental Debtor Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Rental Debtor Summary.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = WHERE("Customer Posting Group" = FILTER('TENANT'));
            column(No; Customer."No.")
            {
            }
            column(Name; Customer.Name)
            {
            }
            column(BalanceBF; "BalanceB/F")
            {
            }
            column(TotalDebits; TotalDebits)
            {
            }
            column(TotalCredits; TotalCredits)
            {
            }
            column(BalanceCF; "BalanceC/F")
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
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
            column(CManagingAgentPic; CompanyInfo."Managing Agent")
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
            column(PeriodFilter; PeriodFilter)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "BalanceB/F" := 0;
                TotalDebits := 0;
                TotalCredits := 0;
                "BalanceC/F" := 0;

                if StartDate <> 0D then begin
                    CustLedger.Reset;
                    CustLedger.SetRange(CustLedger."Customer No.", Customer."No.");
                    CustLedger.SetRange(CustLedger."Posting Date", 0D, CalcDate('-1D', StartDate));
                    //  CustLedger.SETRANGE(CustLedger."Skip in Statement",FALSE);
                    CustLedger.SetRange(CustLedger.Reversed, false);
                    if CustLedger.FindSet then begin
                        repeat
                            CustLedger.CalcFields(CustLedger.Amount, CustLedger."Amount (LCY)");
                            "BalanceB/F" := "BalanceB/F" + CustLedger."Amount (LCY)";
                        until CustLedger.Next = 0;
                    end;
                end;

                CustLedger.Reset;
                CustLedger.SetRange(CustLedger."Customer No.", Customer."No.");
                if StartDate = 0D then begin
                    CustLedger.SetRange(CustLedger."Posting Date", 0D, EndDate);
                end else begin
                    CustLedger.SetRange(CustLedger."Posting Date", StartDate, EndDate);
                end;
                //CustLedger.SETRANGE(CustLedger."Skip in Statement",FALSE);
                CustLedger.SetRange(CustLedger.Reversed, false);
                if CustLedger.FindSet then begin
                    repeat
                        CustLedger.CalcFields(CustLedger.Amount, CustLedger."Amount (LCY)");
                        if CustLedger."Amount (LCY)" > 0 then
                            TotalDebits := TotalDebits + CustLedger."Amount (LCY)";
                        if CustLedger."Amount (LCY)" < 0 then
                            TotalCredits := TotalCredits + CustLedger."Amount (LCY)";
                    until CustLedger.Next = 0;
                end;

                CustLedger.Reset;
                CustLedger.SetRange(CustLedger."Customer No.", Customer."No.");
                CustLedger.SetRange(CustLedger."Posting Date", 0D, EndDate);
                //CustLedger.SETRANGE(CustLedger."Skip in Statement",FALSE);
                CustLedger.SetRange(CustLedger.Reversed, false);
                if CustLedger.FindSet then begin
                    repeat
                        CustLedger.CalcFields(CustLedger.Amount, CustLedger."Amount (LCY)");
                        "BalanceC/F" := "BalanceC/F" + CustLedger."Amount (LCY)";
                    until CustLedger.Next = 0;
                end;
            end;

            trigger OnPreDataItem()
            begin
                Customer.SetRange(Customer.Blocked, Customer.Blocked::" ");
                if EndDate = 0D then
                    EndDate := Today;

                if StartDate = 0D then
                    PeriodFilter := '..' + Format(EndDate)
                else
                    PeriodFilter := Format(StartDate) + '..' + Format(EndDate);
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
        CompanyInfo.CalcFields(Picture);
    end;

    var
        "BalanceB/F": Decimal;
        TotalDebits: Decimal;
        TotalCredits: Decimal;
        "BalanceC/F": Decimal;
        CustLedger: Record "Cust. Ledger Entry";
        StartDate: Date;
        EndDate: Date;
        CompanyInfo: Record "Company Information";
        PeriodFilter: Text;
}

