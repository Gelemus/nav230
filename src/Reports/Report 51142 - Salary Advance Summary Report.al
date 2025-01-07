report 51142 "Salary Advance Summary Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Salary Advance Summary Report.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Salary Advance"; "Salary Advance")
        {
            DataItemTableView = SORTING(ID) WHERE(Status = CONST(Approved), "Paid to Employee" = CONST(true));
            RequestFilterFields = "Start Period";
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
            column(Payee; Payee)
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
            column(Installments_SalaryAdvance; "Salary Advance".Installments)
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

            trigger OnAfterGetRecord()
            begin
                EmployeeRecI.Reset;
                EmployeeRecI.SetRange(EmployeeRecI."No.", "Salary Advance".Employee);
                if EmployeeRecI.FindSet then begin
                    Payee := EmployeeRecI."First Name" + ' ' + EmployeeRecI."Middle Name" + ' ' + EmployeeRecI."Last Name";
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

