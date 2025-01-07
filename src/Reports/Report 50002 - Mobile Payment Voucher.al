report 50002 "Mobile Payment Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Mobile Payment Voucher.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Payment Header"; "Payment Header")
        {
            DataItemTableView = SORTING("No.") WHERE("Payment Mode" = CONST(MPESA));
            RequestFilterFields = "No.";
            column(No; "No.")
            {
            }
            column(ChequeNo; "Payment Header"."Reference No.")
            {
            }
            column(Payee; "Payment Header"."Payee Name")
            {
            }
            column(PaymentDate; "Posting Date")
            {
            }
            column(NumberText; NumberText[1])
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfoPic; CompanyInfo.Picture)
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebPage; CompanyInfo."Home Page")
            {
            }
            column(Bank; "Payment Header"."Bank Account No.")
            {
                IncludeCaption = true;
            }
            column(BankName; "Payment Header"."Bank Account Name")
            {
            }
            column(BankAccountNo; BankAccountNo)
            {
            }
            column(PayeeAddress; PayeeAddress)
            {
            }
            column(PreparedBy; PreparedBy)
            {
            }
            column(CheckedBy; CheckedBy)
            {
            }
            column(AuthorisedBy; AuthorizedBy)
            {
            }
            column(TotalAmount; TotalAmount)
            {
            }
            column(GrossAmount; "Total Amount")
            {
            }
            column(WithHoldingTaxAmount; "WithHolding Tax Amount")
            {
            }
            column(WHTPercentage; "WHT%")
            {
            }
            dataitem("Payment Line"; "Payment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Line No.", "Document No.", "Payment Code") ORDER(Ascending);
                column(InvoiceDate; InvoiceDate)
                {
                }
                column(InvoiceNo; InvoiceNo)
                {
                }
                column(NetAmount; "Net Amount")
                {
                }
                column(Amount; "Total Amount")
                {
                }
                column(Description; Description)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if Vendor.Get("Account No.") then begin
                        PayeeAddress := Vendor.Address;
                    end;
                    if PostedInvoice.Get("Applies-to Doc. No.") then begin
                        InvoiceNo := PostedInvoice."Vendor Invoice No.";
                        InvoiceDate := PostedInvoice."Posting Date";
                    end;

                    if "Withholding Tax Code" <> '' then begin
                        if FundsTaxCodes.Get("Withholding Tax Code") then
                            "WHT%" := Format(FundsTaxCodes.Percentage);
                    end;
                end;
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Status = CONST(Approved));
                column(SequenceNo; "Approval Entry"."Sequence No.")
                {
                }
                column(LastDateTimeModified; "Approval Entry"."Last Date-Time Modified")
                {
                }
                column(ApproverID; "Approval Entry"."Approver ID")
                {
                }
                column(SenderID; "Approval Entry"."Sender ID")
                {
                }
                dataitem(Employee; Employee)
                {
                    DataItemLink = "User ID" = FIELD("Approver ID");
                    column(EmployeeFirstName; Employee."First Name")
                    {
                    }
                    column(EmployeeMiddleName; Employee."Middle Name")
                    {
                    }
                    column(EmployeeLastName; Employee."Last Name")
                    {
                    }
                    column(EmployeeSignature; Employee."Employee Signature")
                    {
                    }
                }
            }

            trigger OnAfterGetRecord()
            begin
                TotalAmount := 0;
                CalcFields("Total Amount", "Net Amount", "WithHolding Tax Amount");
                TotalAmount := "Net Amount";
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, ("Net Amount"), "Currency Code");

                if Bank.Get("Bank Account No.") then begin
                    BankName := Bank.Name;
                    BankAccountNo := Bank."Bank Account No.";
                end;
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
        CheckReport: Report Check;
        NumberText: array[2] of Text[80];
        CompanyInfo: Record "Company Information";
        Bank: Record "Bank Account";
        BankAccountNo: Code[20];
        BankName: Text[100];
        PayeeAddress: Text[100];
        InvoiceDate: Date;
        InvoiceNo: Code[50];
        TotalAmount: Decimal;
        PurchaseInvoice: Record "Purch. Inv. Header";
        PreparedBy: Text;
        CheckedBy: Text;
        AuthorizedBy: Text;
        User: Record User;
        Vendor: Record Vendor;
        PostedInvoice: Record "Purch. Inv. Header";
        "WHT%": Text;
        FundsTaxCodes: Record "Funds Tax Code";
}

