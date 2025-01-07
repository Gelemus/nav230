report 50219 "Casual Payment Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Casual Payment Report.rdl';
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
                column(AccountNo_ImprestLine; "Imprest Line"."Account No.")
                {
                }
                column(InvoiceDate; "Posting Date")
                {
                }
                column(ImprestCode; "Imprest Line"."Imprest Code")
                {
                }
                column(GlobalDimension2Code_ImprestLine; "Imprest Line"."Global Dimension 2 Code")
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
                column(TelephoneNo_ImprestLine; "Imprest Line"."Telephone No.")
                {
                }
                column(EmployeeName_ImprestLine; "Imprest Line"."Employee Name")
                {
                }
                column(WorkDoneonStandby_ImprestLine; "Imprest Line"."Work Done on Standby")
                {
                }
                column(DatePaid_ImprestLine; "Imprest Line"."Date Paid")
                {
                }
                column(IDNo_ImprestLine; "Imprest Line"."ID No.")
                {
                }
                column(DailyRate_ImprestLine; "Imprest Line"."Daily Rate")
                {
                }
                column(Day1_ImprestLine; "Imprest Line"."Day 1")
                {
                }
                column(Day2_ImprestLine; "Imprest Line"."Day 2")
                {
                }
                column(Day3_ImprestLine; "Imprest Line"."Day 3")
                {
                }
                column(Day4_ImprestLine; "Imprest Line"."Day 4")
                {
                }
                column(Day5_ImprestLine; "Imprest Line"."Day 5")
                {
                }
                column(Day6_ImprestLine; "Imprest Line"."Day 6")
                {
                }
                column(Day7_ImprestLine; "Imprest Line"."Day 7")
                {
                }
                column(TotalDays_ImprestLine; "Imprest Line"."Total Days")
                {
                }
                column(Names_ImprestLine; "Imprest Line".Names)
                {
                }
                column(CasualPayment_ImprestLine; "Imprest Line"."Casual Payment")
                {
                }
                column(NoofMetersOthers_ImprestLine; "Imprest Line"."No of Meters/Others")
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
                column(UserSetupRec_SignatureI_; UserSetupRecI.Signature)
                {
                }
                column(UserSetupRec_Signature_; UserSetupRec.Signature)
                {
                }
                column(EmployeeSignature2; TenantMedia.Content)
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
                            PreparedByCaption := 'Prepared By: ' + ' ' + EmployeeRecI."First Name" + ' ' + EmployeeRecI."Last Name";

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

