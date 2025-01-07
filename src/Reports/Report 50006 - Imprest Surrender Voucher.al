report 50006 "Imprest Surrender Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Imprest Surrender Voucher.rdl';
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
                DataItemTableView = WHERE(Status = FILTER(Approved));
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
                column(ShowPreparedBy_; ShowPreparedBy)
                {
                }
                column(ApprovedByCaption_; ApprovedByCaption)
                {
                }
                column(PreparedByCaption_; PreparedByCaption)
                {
                }
                column(PreparedDate; PreparedDate)
                {
                }
                column(UserSetupRec_SignatureI_; TenantMedia.Content)
                {
                }
                column(UserSetupRec_Signature_; TenantMedia.Content)
                {
                }
                dataitem(Employee; Employee)
                {
                    DataItemLink = "User ID" = FIELD("Approver ID");
                    column(FirstName_Employee; Employee."First Name")
                    {
                    }
                    column(MiddleName_Employee; Employee."Middle Name")
                    {
                    }
                    column(LastName_Employee; Employee."Last Name")
                    {
                    }
                    column(EmployeeSignature; Employee."Employee Signature")
                    {
                    }
                    column(JobTitle_Employee; Employee."Job Title")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    i := i + 1;
                    if i = 1 then begin
                        ShowPreparedBy := true;
                        PreparedDate := "Approval Entry"."Date-Time Sent for Approval";
                        EmployeeRecI.Reset;
                        EmployeeRecI.SetRange("User ID", "Approval Entry"."Sender ID");
                        if EmployeeRecI.FindFirst then begin
                            PreparedByCaption := 'Prepared By: ' + EmployeeRecI."Job Title" + ' ' + EmployeeRecI."First Name" + ' ' + EmployeeRecI."Last Name";

                            TenantMedia.Reset;
                            if EmployeeRecI."Employee Signature".HasValue then begin
                                TenantMedia.Get(EmployeeRecI."Employee Signature".MediaId);
                                TenantMedia.CalcFields(Content);
                            end;
                        end;
                        UserSetupRec.Reset;

                        UserSetupRecI.SetRange("User ID", "Approval Entry"."Sender ID");
                        if UserSetupRecI.FindFirst then
                            UserSetupRecI.CalcFields(Signature);

                        ApprovedByCaption := 'Confirmed By: ';

                        UserSetupRec.Reset;

                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);

                    end
                    else
                        ShowPreparedBy := false;
                    if i = 2 then begin
                        ApprovedByCaption := 'Verified By:  ';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end
                    else if i = 3 then begin
                        ApprovedByCaption := 'Authorized By:  ';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end
                    else if i = 4 then begin
                        ApprovedByCaption := 'Approved By:  ';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end;
                end;
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

            trigger OnPreDataItem()
            begin
                PreparedBy := UserId;
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

