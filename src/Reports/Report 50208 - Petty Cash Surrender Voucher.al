report 50208 "Petty Cash Surrender Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Petty Cash Surrender Voucher.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Imprest Surrender Header"; "Imprest Surrender Header")
        {
            column(No; "Imprest Surrender Header"."No.")
            {
            }
            column(ImprestNo; "Imprest Surrender Header"."Imprest No.")
            {
            }
            column(Payee; "Imprest Surrender Line"."Account Name")
            {
            }
            column(EmployeeName_ImprestSurrenderHeader; "Imprest Surrender Header"."Employee Name")
            {
            }
            column(PaymentDate; "Imprest Surrender Header"."Posting Date")
            {
            }
            column(GlobalDimension1Code_ImprestSurrenderHeader; "Imprest Surrender Header"."Global Dimension 1 Code")
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
            column(Description_ImprestSurrenderHeader; "Imprest Surrender Header".Description)
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
            column(CheqNo; CheqNo)
            {
            }
            column(ActualSpent_ImprestSurrenderHeader; "Imprest Surrender Header"."Actual Spent")
            {
            }
            column(Difference_ImprestSurrenderHeader; "Imprest Surrender Header".Difference)
            {
            }
            column(Amount_ImprestSurrenderHeader; "Imprest Surrender Header".Amount)
            {
            }
            dataitem("Imprest Surrender Line"; "Imprest Surrender Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(InvoiceDate; "Imprest Surrender Line"."Posting Date")
                {
                }
                column(ImprestCode; "Imprest Surrender Line"."Imprest Code")
                {
                }
                column(Amount; "Imprest Surrender Line"."Gross Amount")
                {
                }
                column(AccountName_ImprestSurrenderLine; "Imprest Surrender Line"."Account Name")
                {
                }
                column(AmountLCY; "Imprest Surrender Line"."Gross Amount(LCY)")
                {
                }
                column(Description; "Imprest Surrender Line".Description)
                {
                }
                column(ActualSpent_ImprestSurrenderLine; "Imprest Surrender Line"."Actual Spent")
                {
                }
                column(Difference_ImprestSurrenderLine; "Imprest Surrender Line".Difference)
                {
                }
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
                CheqNo := '';
                PaymentLineRec.Reset;

                PaymentLineRec.SetRange("Payee Type", PaymentLineRec."Payee Type"::Imprest);
                PaymentLineRec.SetRange("Payee No.", "Imprest Surrender Header"."Imprest No.");
                if PaymentLineRec.FindFirst then begin
                    PaymentHeaderRec.Reset;
                    PaymentHeaderRec.SetRange("No.", PaymentLineRec."Document No.");
                    if PaymentHeaderRec.FindFirst then
                        CheqNo := PaymentHeaderRec."Cheque No.";
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
        ImprestSurrender: Record "Imprest Surrender Header";
        PreparedBy: Text;
        CheckedBy: Text;
        AuthorizedBy: Text;
        User: Record User;
        Emp: Record Employee;
        PostedImp: Record "Imprest Header";
        Payee: Text;
        PaymentHeaderRec: Record "Payment Header";
        CheqNo: Code[50];
        PaymentLineRec: Record "Payment Line";
}

