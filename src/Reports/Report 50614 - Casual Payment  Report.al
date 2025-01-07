report 50614 "Casual Payment  Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Casual Payment  Report.rdl';
    PreviewMode = Normal;

    dataset
    {
        dataitem("Imprest Header"; "Imprest Header")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE("Document Type" = FILTER("Casuals Payment"));
            RequestFilterFields = "No.", Status, "Posting Date";
            column(JobSpecifications_ImprestHeader; "Imprest Header"."Job Specifications")
            {
            }
            column(Status_ImprestHeader; "Imprest Header".Status)
            {
            }
            column(No; "Imprest Header"."No.")
            {
            }
            column(Description_ImprestHeader; "Imprest Header".Description)
            {
            }
            column(ChequeNo; "Imprest Header"."Reference No.")
            {
            }
            column(Payee; "Imprest Header"."Employee Name")
            {
            }
            column(PaymentDate; "Imprest Header"."Posting Date")
            {
            }
            column(Bank; "Imprest Header"."Bank Account No.")
            {
            }
            column(BankName; "Imprest Header"."Bank Account Name")
            {
            }
            column(PhoneNo; "Imprest Header"."Phone No.")
            {
            }
            column(Department; "Imprest Header"."Global Dimension 1 Code")
            {
            }
            column(Section; "Imprest Header"."Shortcut Dimension 3 Code")
            {
            }
            column(Amount_ImprestHeader; "Imprest Header".Amount)
            {
            }
            column(NumberText; NumberText[1])
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(DateFrom_ImprestHeader; "Imprest Header"."Date From")
            {
            }
            column(DateTo_ImprestHeader; "Imprest Header"."Date To")
            {
            }
            column(CompanyHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CasualRequisition_ImprestHeader; "Imprest Header"."Casual Requisition")
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
            column(CompanyWebPage; CompanyInfo."Home Page")
            {
            }
            column(CompanyEmail2_; CompanyInfo."E-Mail 2")
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
            dataitem("Imprest Line"; "Imprest Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE("Casual Payment" = FILTER(true));
                column(Names_ImprestLine; "Imprest Line".Names)
                {
                }
                column(GrossAmount_ImprestLine; "Imprest Line"."Gross Amount")
                {
                }
                column(Quantity_ImprestLine; "Imprest Line".Quantity)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                TotalAmount := 0;
                "Imprest Header".CalcFields("Imprest Header".Amount);
                TotalAmount := "Imprest Header".Amount;
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, (TotalAmount), "Imprest Header"."Currency Code");

                if Bank.Get("Imprest Header"."Bank Account No.") then begin
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
        Payee: Text;
        i: Integer;
        ShowPreparedBy: Boolean;
        PreparedByCaption: Text;
        ApprovedByCaption: Text;
        UserSetupRec: Record "User Setup";
        UserSetupRecI: Record "User Setup";
        PreparedDate: DateTime;
        EmployeeRecI: Record Employee;
        TenantMedia: Record "Tenant Media";
}

