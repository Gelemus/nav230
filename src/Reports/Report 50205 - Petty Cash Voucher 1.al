report 50205 "Petty Cash Voucher 1"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Petty Cash Voucher 1.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Imprest Header"; "Imprest Header")
        {
            DataItemTableView = SORTING("Cheque Type");
            RequestFilterFields = "Cheque Type";
            column(No; "Imprest Header"."No.")
            {
            }
            column(ChequeNo; "Imprest Header"."Reference No.")
            {
            }
            column(Description_ImprestHeader; "Imprest Header".Description)
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
            column(PurchaseRequisitionNo_ImprestHeader; "Imprest Header"."Purchase Requisition No")
            {
            }
            column(PhoneNo; "Imprest Header"."Phone No.")
            {
            }
            column(Department; "Imprest Header"."Global Dimension 1 Code")
            {
            }
            column(Section; "Imprest Header"."Global Dimension 2 Code")
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
                column(DocumentNo_ImprestLine; "Imprest Line"."Document No.")
                {
                }
                column(InvoiceDate; "Posting Date")
                {
                }
                column(ImprestCode; "Imprest Line"."Imprest Code")
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
                column(AccountNo_ImprestLine; "Imprest Line"."Account No.")
                {
                }
                column(Description_ImprestLine; "Imprest Line".Description)
                {
                }
                column(GlobalDimension2Code_ImprestLine; "Imprest Line"."Global Dimension 2 Code")
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
                column(UserSetupRec_Signature_; UserSetupRec.Signature)
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

                        ApprovedByCaption := 'Recommended By: ';

                        UserSetupRec.Reset;

                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);

                    end
                    else
                        ShowPreparedBy := false;
                    if i = 2 then begin
                        ApprovedByCaption := 'Approved By:  ';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end;
                    /*
                ELSE IF i=3 THEN
                  BEGIN
                  ApprovedByCaption:='Authorized By: GM ';
                  UserSetupRec.RESET;
                  UserSetupRec.SETRANGE("User ID","Approval Entry"."Approver ID");
                  IF UserSetupRec.FINDFIRST THEN
                    UserSetupRec.CALCFIELDS(Signature);
                    END
                ELSE IF i=4 THEN
                  BEGIN
                  ApprovedByCaption:='Approved By: CEO ';
                  UserSetupRec.RESET;
                  UserSetupRec.SETRANGE("User ID","Approval Entry"."Approver ID");
                  IF UserSetupRec.FINDFIRST THEN
                    UserSetupRec.CALCFIELDS(Signature);
                    END;
                */

                end;
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

