report 50206 "Employee Board Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Employee Board Statement.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
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
            column(No_Employee; Employee."No.")
            {
            }
            column(FirstName_Employee; Employee.FullName)
            {
            }
            column(MiddleName_Employee; Employee."Middle Name")
            {
            }
            column(LastName_Employee; Employee."Last Name")
            {
            }
            dataitem("Employee Ledger Entry"; "Employee Ledger Entry")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                column(PostingDate_EmployeeLedgerEntry; "Employee Ledger Entry"."Posting Date")
                {
                }
                column(DocumentNo_EmployeeLedgerEntry; "Employee Ledger Entry"."Document No.")
                {
                }
                column(Description_EmployeeLedgerEntry; "Employee Ledger Entry".Description)
                {
                }
                column(Amount_EmployeeLedgerEntry; "Employee Ledger Entry".Amount)
                {
                }
                column(RemainingAmount_EmployeeLedgerEntry; "Employee Ledger Entry"."Remaining Amount")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if ImprestHeader.Get("Employee Ledger Entry"."Document No.") then
                        if (ImprestHeader.Type <> ImprestHeader.Type::Imprest) and (ImprestHeader.Type <> ImprestHeader.Type::"Board Allowance") then
                            CurrReport.Skip;
                    if ImprestSurrenderHeader.Get("Employee Ledger Entry"."Document No.") then
                        if ImprestHeader.Get(ImprestSurrenderHeader."Imprest No.") then
                            if (ImprestHeader.Type <> ImprestHeader.Type::Imprest) and (ImprestHeader.Type <> ImprestHeader.Type::"Board Allowance") then
                                CurrReport.Skip;
                end;
            }
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
        UserSetup.Get(UserId);
        if not UserSetup."View Petty Cash" then
            Error('You DO NOT have permission to view this report');
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        ImprestHeader: Record "Imprest Header";
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
        UserSetup: Record "User Setup";
}

