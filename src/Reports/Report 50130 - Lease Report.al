report 50130 "Lease Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Lease Report.rdl';

    dataset
    {
        dataitem("Payment Terms"; "Payment Terms")
        {
            //  RequestFilterFields = Field10,Field34,Field35,Field36,Field26,Field18,Field63;
            column(LeaseNo; "Payment Terms".Code)
            {
            }
            column(Description; "Payment Terms".Code)
            {
            }
            column(PropertyName; "Payment Terms".Code)
            {
            }
            column(TenantNo; "Payment Terms".Code)
            {
            }
            column(TenantName; "Payment Terms".Code)
            {
            }
            column(Status; "Payment Terms".Code)
            {
            }
            column(LeaseClass; "Payment Terms".Code)
            {
            }
            column(ExpiryDate; "Payment Terms".Code)
            {
            }
            column(CommenceDate; "Payment Terms".Code)
            {
            }
            column(Units; Units)
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

            trigger OnAfterGetRecord()
            begin
                Units := '';
                /*LeaseUnits.RESET;
                LeaseUnits.SETRANGE("Lease No.",Table50261."No.");
                IF LeaseUnits.FINDSET THEN BEGIN
                  REPEAT
                    Units:=Units+FORMAT(LeaseUnits."Unit Code")+',';
                  UNTIL LeaseUnits.NEXT=0;
                END;*/

            end;
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
        Units: Text[200];
}

