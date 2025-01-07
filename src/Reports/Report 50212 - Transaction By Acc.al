report 50212 "Transaction By Acc"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Transaction By Acc.rdl';

    dataset
    {
        dataitem("Payment Header"; "Payment Header")
        {
            RequestFilterFields = "Payment Mode";
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(BankAccountNo_PaymentHeader; "Payment Header"."Bank Account No.")
            {
            }
            column(No_PaymentHeader; "Payment Header"."No.")
            {
            }
            column(BankAccountBalance_PaymentHeader; "Payment Header"."Bank Account Balance")
            {
            }
            column(PostingDate_PaymentHeader; "Payment Header"."Posting Date")
            {
            }
            column(PayeeNo_PaymentHeader; "Payment Header"."Payee No.")
            {
            }
            column(PayeeName_PaymentHeader; "Payment Header"."Payee Name")
            {
            }
            column(TotalAmount_PaymentHeader; "Payment Header"."Total Amount")
            {
            }
            column(TotalAmountLCY_PaymentHeader; "Payment Header"."Total Amount(LCY)")
            {
            }
            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(GLAccountNo_GLEntry; "G/L Entry"."G/L Account No.")
                {
                }
                column(DocumentNo_GLEntry; "G/L Entry"."Document No.")
                {
                }
                column(Description_GLEntry; "G/L Entry".Description)
                {
                }
                column(Amount_GLEntry; "G/L Entry".Amount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if "G/L Entry".Amount < 0 then
                        CurrReport.Skip;
                end;
            }

            trigger OnPreDataItem()
            begin
                "Payment Header".SetRange("Payment Header".Status, "Payment Header".Status::Posted);
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
        CompanyInformation.Get;
        CompanyInformation.CalcFields(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
}

