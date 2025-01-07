report 52353 UpdateGlAccounts
{
    // DefaultLayout = RDLC;
    //RDLCLayout = 'src/Layouts/UpdateGlAccounts.rdl';
    ProcessingOnly = true;
    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {

            trigger OnAfterGetRecord()
            begin

                FromGL := '6100-005';
                ToGL := '6150-000';
                //IF Postingdate=0D THEN CurrReport.SKIP;
                //IF DocumentNo='' THEN CurrReport.SKIP;


                if "G/L Entry"."Document Type" = "G/L Entry"."Document Type"::Invoice then begin

                    SaleInvoiceLines.Reset;
                    SaleInvoiceLines.SetRange("Document No.", "G/L Entry"."Document No.");
                    SaleInvoiceLines.SetRange("No.", FromGL);
                    if SaleInvoiceLines.FindFirst then begin
                        repeat
                            i += 1;
                            SaleInvoiceLines."No." := ToGL;
                            SaleInvoiceLines.Modify;
                        until SaleInvoiceLines.Next = 0;
                        //MESSAGE('present');

                    end;

                end else if "G/L Entry"."Document Type" = "G/L Entry"."Document Type"::"Credit Memo" then begin

                    CredmemoLines.Reset;
                    CredmemoLines.SetRange("Document No.", "G/L Entry"."Document No.");
                    CredmemoLines.SetRange("No.", FromGL);
                    if CredmemoLines.FindFirst then begin
                        repeat
                            i += 1;
                            CredmemoLines."No." := ToGL;
                            CredmemoLines.Modify;
                        until CredmemoLines.Next = 0;
                        //MESSAGE('present');

                    end;
                end;

                "G/L Entry"."G/L Account No." := ToGL;
                "G/L Entry".Modify;
            end;

            trigger OnPreDataItem()
            begin
                "G/L Entry".SetRange("G/L Account No.", '6100-005');
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

    trigger OnPostReport()
    begin
        Message('Done');
    end;

    var
        ReceiptHeader: Record "Receipt Header";
        GLEntry: Record "G/L Entry";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        DocumentNo: Code[20];
        Postingdate: Date;
        DocumentNo2: Code[20];
        i: Integer;
        SaleInvoiceLines: Record "Sales Invoice Line";
        CredmemoLines: Record "Sales Cr.Memo Line";
        ToGL: Code[20];
        FromGL: Code[20];
}

