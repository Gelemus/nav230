report 50109 "Card Load Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Card Load Report.rdl';

    dataset
    {
        dataitem("Card  Ledger Entries"; "Card  Ledger Entries")
        {
            RequestFilterFields = "Card no", "Date Filter", "Loading Date";
            column(CardNo; "Card  Ledger Entries"."Card no")
            {
            }
            column(Card_Discription; "Card  Ledger Entries"."Card Description")
            {
            }
            column(Balance_BF; "Card  Ledger Entries"."Balance BF")
            {
            }
            column(Amount_Loaded; "Card  Ledger Entries"."Amount Loaded")
            {
            }
            column(Balance_CF; "Card  Ledger Entries"."Balance BF" + "Card  Ledger Entries"."Amount Loaded")
            {
            }
            column(Load_Date; "Card  Ledger Entries"."Loading Date")
            {
            }
            column(Amount_Spent; "Card  Ledger Entries"."Amount Spent")
            {
            }
            column(Pic; CompanyInfo.Picture)
            {
            }
            column(DateFilter_CardLedgerEntries; DateFilter)
            {
            }

            trigger OnAfterGetRecord()
            begin
                /*SETFILTER("Date Filter",'%1..%2',StartDate,EndDate);
                SETRANGE("Date Filter",Veh."Filling Date");
                  StartDate := "Card  Ledger Entries".GETRANGEMIN("Date Filter");
                  EndDate := "Card  Ledger Entries".GETRANGEMAX("Date Filter");
                IF "Card  Ledger Entries"."Date Filter"< StartDate THEN
                  CurrReport.SKIP;
                */

                //"Card  Ledger Entries".COPYFILTER("Card  Ledger Entries"."Loading Date",DateFilter)
                DateFilter := "Card  Ledger Entries".GetFilter("Card  Ledger Entries"."Loading Date");

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("START DATE"; StartDate)
                {
                    Visible = false;
                }
                field("END DATE"; EndDate)
                {
                    Visible = false;
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
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        StartDate: Date;
        EndDate: Date;
        Veh: Record "Vehicle Filling";
        DateFilter: Text;
}

