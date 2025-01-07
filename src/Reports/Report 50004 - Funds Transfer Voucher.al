report 50004 "Funds Transfer Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Funds Transfer Voucher.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Funds Transfer Header"; "Funds Transfer Header")
        {
            DataItemTableView = SORTING("Cheque Type");
            RequestFilterFields = "Cheque Type";
            column(No; "No.")
            {
            }
            column(ChequeNo; "Reference No.")
            {
            }
            column(Payee; Payee)
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
            column(Bank; "Funds Transfer Header"."Bank Account No.")
            {
                IncludeCaption = true;
            }
            column(BankName; "Funds Transfer Header"."Bank Account Name")
            {
            }
            column(TransferTo_FundsTransferHeader; "Funds Transfer Header"."Transfer To")
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
            dataitem("Funds Transfer Line"; "Funds Transfer Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(InvoiceDate; "Posting Date")
                {
                }
                column(InvoiceNo; "Funds Transfer Line"."Document No.")
                {
                }
                column(NetAmount; "Funds Transfer Line".Amount)
                {
                }
                column(Amount; "Funds Transfer Line"."Amount(LCY)")
                {
                }
                column(AccountName_FundsTransferLine; "Funds Transfer Line"."Account Name")
                {
                }
                column(Description; "Funds Transfer Line".Description)
                {
                }
                column(MoneyTransferDescription_FundsTransferLine; "Funds Transfer Line"."Money Transfer Description")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if Bank.Get("Funds Transfer Line"."Account No.") then begin
                        Payee := Bank.Name;
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

                TotalAmount := "Funds Transfer Header"."Amount To Transfer";
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, (TotalAmount), "Funds Transfer Header"."Currency Code");

                if Bank.Get("Funds Transfer Header"."Bank Account No.") then begin
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
}

