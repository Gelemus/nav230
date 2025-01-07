report 51144 "Salary Advance"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Salary Advance.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Salary Advance"; "Salary Advance")
        {
            DataItemTableView = SORTING(ID);
            RequestFilterFields = ID;
            column(ContractEndDate_SalaryAdvance; "Salary Advance"."Contract End Date")
            {
            }
            column(DivisionName; "Salary Advance"."Global Dimension 1 Code")
            {
            }
            column(UnitCodeName; "Salary Advance"."Global Dimension 2 Code")
            {
            }
            column(GlobalDimension1Code_SalaryAdvance; "Salary Advance"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_SalaryAdvance; "Salary Advance"."Global Dimension 2 Code")
            {
            }
            column(ID_SalaryAdvance; "Salary Advance".ID)
            {
            }
            column(Employee_SalaryAdvance; "Salary Advance".Employee)
            {
            }
            column(FirstName_SalaryAdvance; "Salary Advance"."First Name")
            {
            }
            column(LastName_SalaryAdvance; "Salary Advance"."Last Name")
            {
            }
            column(PaymentDate_SalaryAdvance; "Salary Advance"."Payment Date")
            {
            }
            column(StartPeriod_SalaryAdvance; "Salary Advance"."Start Period")
            {
            }
            column(InstallmentAmount_SalaryAdvance; "Salary Advance"."Installment Amount")
            {
            }
            column(Principal_SalaryAdvance; "Salary Advance".Principal)
            {
            }
            column(Description_SalaryAdvance; "Salary Advance".Description)
            {
            }
            column(PurposeofSalaryAdvance_SalaryAdvance; "Salary Advance"."Purpose of Salary Advance")
            {
            }
            column(PayrollCode_SalaryAdvance; "Salary Advance"."Payroll Code")
            {
            }
            column(DocumentDate_SalaryAdvance; "Salary Advance"."Document Date")
            {
            }
            column(BasicPay_SalaryAdvance; "Salary Advance"."Basic Pay")
            {
            }
            column(V13BasicPay_SalaryAdvance; "Salary Advance"."1/3 Basic Pay")
            {
            }
            column(NetPay_SalaryAdvance; "Salary Advance"."Net Pay")
            {
            }
            column(NetPayafterAdvance_SalaryAdvance; "Salary Advance"."Net Pay after Advance")
            {
            }
            column(TermsofEmployement_SalaryAdvance; "Salary Advance"."Terms of Employement")
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
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD(ID);
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
                            PreparedByCaption := 'Applicant: ' + ' ' + EmployeeRecI."Job Title" + ' ' + EmployeeRecI."First Name" + ' ' + EmployeeRecI."Last Name";
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

                        ApprovedByCaption := 'Head of Department: ';

                        UserSetupRec.Reset;

                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);

                    end
                    else
                        ShowPreparedBy := false;
                    if i = 2 then begin
                        ApprovedByCaption := 'Payroll Officer:  ';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end
                    else if i = 3 then begin
                        ApprovedByCaption := 'GM-Human Capital & Administration:  ';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end
                    else if i = 4 then begin
                        ApprovedByCaption := 'GM-Finance:  ';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end;
                    if UserSetupRec."User ID" <> UserSetupRec."User ID" then
                        CurrReport.Skip;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                /*TotalAmount:=0;
                //"Imprest Header".CALCFIELDS("Imprest Header".Amount);
                TotalAmount:="Imprest Header".Amount;
                CheckReport.InitTextVariable();
                //CheckReport.FormatNoText(NumberText,(TotalAmount),"Imprest Header"."Currency Code");
                
                IF Bank.GET("Imprest Header"."Bank Account No.") THEN BEGIN
                  BankName:=Bank.Name;
                  BankAccountNo:=Bank."Bank Account No.";
                END;
                */

                //added on 16/02/2022
                DivisionName := '';
                UnitCodeName := '';

                DimensioValues.Reset;
                DimensioValues.SetRange("Dimension Code", 'DIVISION');
                DimensioValues.SetRange(Code, "Salary Advance"."Global Dimension 1 Code");
                if DimensioValues.FindSet then begin
                    DivisionName := DimensioValues.Name;
                end;

                DimensioValues2.Reset;
                DimensioValues2.SetRange("Dimension Code", 'UNIT CODE');
                DimensioValues2.SetRange(Code, "Salary Advance"."Global Dimension 1 Code");
                if DimensioValues2.FindSet then begin
                    UnitCodeName := DimensioValues2.Name;
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
        DimensioValues: Record "Dimension Value";
        DivisionName: Text[250];
        UnitCodeName: Text[250];
        DimensioValues2: Record "Dimension Value";
        TenantMedia: Record "Tenant Media";
}

