report 50039 "Purchases Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Purchases Report.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = ORDER(Ascending) WHERE("Document Type" = CONST(Order));
            RequestFilterFields = Status;
            column(no; "Purchase Header"."No.")
            {
            }
            column(vendname; "Purchase Header"."Pay-to Name")
            {
            }
            column(pdate; "Purchase Header"."Posting Date")
            {
            }
            column(invoiceno; "Purchase Header"."Vendor Invoice No.")
            {
            }
            column(amount; "Purchase Header".Amount)
            {
            }
            column(amountvat; "Purchase Header"."Amount Including VAT")
            {
            }
            column(Status; "Purchase Header".Status)
            {
            }
            column(Posting_Description; "Purchase Header"."Posting Description")
            {
            }
            column(Start_Date; StartDate)
            {
            }
            column(End_Date; EndDate)
            {
            }
            column(CName; CompanyInfo.Name)
            {
            }
            column(CAddress; CompanyInfo.Address)
            {
            }
            column(CAddress2; CompanyInfo."Address 2")
            {
            }
            column(CCity; CompanyInfo.City)
            {
            }
            column(CPic; CompanyInfo.Picture)
            {
            }
            column(CEmail; CompanyInfo."E-Mail")
            {
            }
            column(CPhone; CompanyInfo."Phone No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                StartDate := "Purchase Header".GetRangeMin("Posting Date");
                EndDate := "Purchase Header".GetRangeMax("Posting Date");
                if "Purchase Header"."Posting Date" < StartDate then
                    CurrReport.Skip;
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
                }
                field("END DATE"; EndDate)
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

    trigger OnInitReport()
    begin
        //PrintDate:=TODAY;
        //PrintTime:=TIME;
    end;

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        StartDate: Date;
        EndDate: Date;
        CompanyInfo: Record "Company Information";
}

