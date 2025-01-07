report 50126 "Tenant Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Tenant Invoice.rdl';

    dataset
    {
        dataitem("Payment Terms"; "Payment Terms")
        {
            column(InvoiceNo; CompanyInfo.Name)
            {
            }
            column(InvoiceDate; CompanyInfo.Name)
            {
            }
            column(TenantNo; CompanyInfo.Name)
            {
            }
            column(TenantName; CompanyInfo.Name)
            {
            }
            column(LeaseNo; CompanyInfo.Name)
            {
            }
            column(PropertyName; CompanyInfo.Name)
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
            column(TotalAmountExclVAT; CompanyInfo.Name)
            {
            }
            column(TotalVATAmount; CompanyInfo.Name)
            {
            }
            column(TotalAmountInclVAT; CompanyInfo.Name)
            {
            }
            dataitem(Currency; Currency)
            {
                //DataItemLink = "Invoice Rounding Precision"=FIELD(Field10);
                column(ChargeName; CompanyInfo.Name)
                {
                }
                column(Description; Description2)
                {
                }
                column(AmountExclVAT; CompanyInfo.Name)
                {
                }
                column(VATAmount; CompanyInfo.Name)
                {
                }
                column(AmountInclVAT; CompanyInfo.Name)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    /*IF Table50263."Manual Bill" THEN BEGIN
                      Description2:=FORMAT(Table50264."Property Transaction Type")+':'+Table50264.Description;
                    END ELSE BEGIN
                      IF Table50264."Property Transaction Type"=Table50264."Property Transaction Type"::"2" THEN BEGIN
                        Description2:=FORMAT(Table50264."Charge Name");
                      END ELSE BEGIN
                        Description2:=FORMAT(Table50264."Property Transaction Type")+':'+Table50263.Description;
                      END;
                    END;*/

                end;
            }

            trigger OnAfterGetRecord()
            begin
                //Table50263.CALCFIELDS("Amount Excl. VAT","VAT Amount","Amount Incl. VAT");
                /*
                IF PropertyLease.GET(Table50263."Lease No.") THEN BEGIN
                  ExpiryDate:=PropertyLease."Expiry Date";
                  ReviewDate:=PropertyLease."Next Review Date";
                
                  PropertyLeaseLine.RESET;
                  PropertyLeaseLine.SETRANGE("Lease No.",PropertyLease."No.");
                  IF PropertyLeaseLine.FINDFIRST THEN BEGIN
                
                  END;
                
                  Units:='';
                  LeaseUnits.RESET;
                  LeaseUnits.SETRANGE("Lease No.",PropertyLease."No.");
                  IF LeaseUnits.FINDSET THEN BEGIN
                    REPEAT
                      Units:=Units+LeaseUnits."Unit Code"+',';
                    UNTIL LeaseUnits.NEXT=0;
                    Units:=COPYSTR(Units,1,STRLEN(Units)-1);
                  END;
                
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
        Units: Code[50];
        ExpiryDate: Date;
        ReviewDate: Date;
        CompanyInfo: Record "Company Information";
        Description2: Text;
}

