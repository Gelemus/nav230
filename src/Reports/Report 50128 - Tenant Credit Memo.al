report 50128 "Tenant Credit Memo"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Tenant Credit Memo.rdl';

    dataset
    {
        dataitem("Payment Terms"; "Payment Terms")
        {
            column(No; Currency.Code)
            {
            }
            column(ReferenceInvoiceNo; "Payment Terms".Code)
            {
            }
            column(InvoiceDate; "Payment Terms".Code)
            {
            }
            column(TenantNo; "Payment Terms".Code)
            {
            }
            column(TenantName; "Payment Terms".Code)
            {
            }
            column(LeaseNo; "Payment Terms".Code)
            {
            }
            column(PropertyName; "Payment Terms".Code)
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
            column(LeaseUnits; "Payment Terms".Code)
            {
            }
            column(ExpiryDate; ExpiryDate)
            {
            }
            column(ReviewDate; ReviewDate)
            {
            }
            column(TotalAmountExclVAT; "Payment Terms".Code)
            {
            }
            column(TotalVATAmount; "Payment Terms".Code)
            {
            }
            column(TotalAmountInclVAT; "Payment Terms".Code)
            {
            }
            dataitem(Currency; Currency)
            {
                //DataItemLink = Field11=FIELD(Field10);
                column(ChargeName; "Payment Terms".Code)
                {
                }
                column(Description; Description2)
                {
                }
                column(AmountExclVAT; "Payment Terms".Code)
                {
                }
                column(VATAmount; "Payment Terms".Code)
                {
                }
                column(AmountInclVAT; "Payment Terms".Code)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    /*IF Table50265."Manual Bill" THEN BEGIN
                      Description2:=FORMAT(Table50266."Property Transaction Type")+':'+Table50266.Description;
                    END ELSE BEGIN
                      IF Table50266."Property Transaction Type"=Table50266."Property Transaction Type"::"2" THEN BEGIN
                        Description2:=FORMAT(Table50266."Charge Name");
                      END ELSE BEGIN
                        Description2:=FORMAT(Table50266."Property Transaction Type")+':'+Table50265.Description;
                      END;
                    END;*/

                end;
            }

            trigger OnAfterGetRecord()
            begin
                /*CALCFIELDS("Amount Excl. VAT","VAT Amount","Amount Incl. VAT");
                
                IF PropertyLease.GET("Lease No.") THEN BEGIN
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
        CompanyInfo.CalcFields(Picture, "Managing Agent");
    end;

    var
        Units: Code[50];
        ExpiryDate: Date;
        ReviewDate: Date;
        CompanyInfo: Record "Company Information";
        Description2: Text;
}

