report 50120 "Sales Invoice Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Sales Invoice Report.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            column(InvoiceNo; "No.")
            {
            }
            column(InvoiceDate; "Posting Date")
            {
            }
            column(TenantNo; "Sell-to Customer No.")
            {
            }
            column(TenantName; "Bill-to Name")
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
            column(LeaseUnits; Units)
            {
            }
            column(ExpiryDate; ExpiryDate)
            {
            }
            column(ReviewDate; ReviewDate)
            {
            }
            column(TotalAmountExclVAT; Amount)
            {
            }
            column(TotalVATAmount; "Amount Including VAT" - Amount)
            {
            }
            column(TotalAmountInclVAT; "Amount Including VAT")
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(ChargeName; "Document No.")
                {
                }
                column(Description; Description)
                {
                }
                column(AmountExclVAT; Amount)
                {
                }
                column(VATAmount; "Amount Including VAT" - Amount)
                {
                }
                column(AmountInclVAT; "Amount Including VAT")
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
        //CompanyInfo.CALCFIELDS(Picture,"Managing Agent");
    end;

    var
        Units: Code[50];
        ExpiryDate: Date;
        ReviewDate: Date;
        CompanyInfo: Record "Company Information";
        Description2: Text;
}

