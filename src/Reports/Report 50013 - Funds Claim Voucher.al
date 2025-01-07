report 50013 "Funds Claim Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Funds Claim Voucher.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Funds Claim Header"; "Funds Claim Header")
        {
            column(No_FundsClaimHeader; "Funds Claim Header"."No.")
            {
            }
            column(ReferenceNo_FundsClaimHeader; "Funds Claim Header"."Reference No.")
            {
            }
            column(PayeeName_FundsClaimHeader; "Funds Claim Header"."Payee Name")
            {
            }
            column(PostingDate_FundsClaimHeader; "Funds Claim Header"."Posting Date")
            {
            }
            column(BankAccountNo_FundsClaimHeader; "Funds Claim Header"."Bank Account No.")
            {
            }
            column(BankAccountName_FundsClaimHeader; "Funds Claim Header"."Bank Account Name")
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
            dataitem("Funds Claim Line"; "Funds Claim Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(PostingDate_FundsClaimLine; "Funds Claim Line"."Posting Date")
                {
                }
                column(FundsClaimCode_FundsClaimLine; "Funds Claim Line"."Funds Claim Code")
                {
                }
                column(Amount_FundsClaimLine; "Funds Claim Line".Amount)
                {
                }
                column(AmountLCY_FundsClaimLine; "Funds Claim Line"."Amount(LCY)")
                {
                }
                column(Description_FundsClaimLine; "Funds Claim Line".Description)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if Bank.Get("Funds Claim Line"."Account No.") then begin
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
                "Funds Claim Header".CalcFields("Funds Claim Header".Amount);
                TotalAmount := "Funds Claim Header".Amount;
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, (TotalAmount), "Funds Claim Header"."Currency Code");

                if Bank.Get("Funds Claim Header"."Bank Account No.") then begin
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

