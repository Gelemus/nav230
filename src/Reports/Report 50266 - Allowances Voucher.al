report 50266 "Allowances Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Allowances Voucher.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Imprest Header"; "Allowance Header")
        {
            DataItemTableView = SORTING("Cheque Type");
            RequestFilterFields = "Cheque Type";
            column(No; "Imprest Header"."No.")
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
            column(CompanyHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(NationalId; NationalId)
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
            dataitem("Imprest Line"; "Allowance Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(InvoiceDate; "Posting Date")
                {
                }
                column(ImprestCode; "Imprest Line"."Allowance Code")
                {
                }
                column(TaxAmount_ImprestLine; "Imprest Line"."Tax Amount")
                {
                }
                column(Amount; "Imprest Line"."Gross Amount")
                {
                }
                column(AmountLCY; "Imprest Line"."Gross Amount(LCY)")
                {
                }
                column(NetAmount_ImprestLine; "Imprest Line"."Net Amount")
                {
                }
                column(Description; "Imprest Line".Description)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if Bank.Get("Imprest Line"."Account No.") then begin
                        Payee := Bank.Name;
                    end;
                end;
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Status = FILTER(<> Canceled));
                column(SequenceNo; "Approval Entry"."Sequence No.")
                {
                }
                column(LastDateTimeModified; "Approval Entry"."Last Date-Time Modified")
                {
                }
                column(ApproverID; "Approval Entry"."Approver ID")
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
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
                "Imprest Header".CalcFields("Imprest Header".Amount);
                TotalAmount := "Imprest Header".Amount;
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, (TotalAmount), "Imprest Header"."Currency Code");

                if Bank.Get("Imprest Header"."Bank Account No.") then begin
                    BankName := Bank.Name;
                    BankAccountNo := Bank."Bank Account No.";
                end;
                //Get National Id

                NationalId := '';
                EmployeeRec.Get("Imprest Header"."Employee No.");
                NationalId := EmployeeRec."National ID";
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
        EmployeeRec: Record Employee;
        NationalId: Code[20];
}

