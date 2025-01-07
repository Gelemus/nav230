report 50058 "CRM Complaints"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/CRM Complaints.rdl';

    dataset
    {
        dataitem("Employee Loan Disbursement"; "Employee Loan Disbursement")
        {
            RequestFilterFields = "No.", "Document Date", Status;
            column(LN1; LN1)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(pic; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_Phone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Fax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Email; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfo_Web; CompanyInfo."Home Page")
            {
            }
            column(No_Complaints; "Employee Loan Disbursement"."No.")
            {
            }
            column(DocumentDate_Complaints; "Employee Loan Disbursement"."Document Date")
            {
            }
            column(Description_Complaints; "Employee Loan Disbursement"."Loan No.")
            {
            }
            column(ActionTaken_Complaints; "Employee Loan Disbursement"."Employee No.")
            {
            }
            column(Names_Complaints; "Employee Loan Disbursement"."Employee No.")
            {
            }
            column(EmailAddress_Complaints; "Employee Loan Disbursement"."Employee No.")
            {
            }
            column(ClosingRemarks_Complaints; "Employee Loan Disbursement"."Loan Product Code")
            {
            }
            column(ClosedBy_Complaints; "Employee Loan Disbursement"."Loan Product Description")
            {
            }
            column(DateClosed_Complaints; "Employee Loan Disbursement"."Applied Amount")
            {
            }
            column(TimeClosed_Complaints; "Employee Loan Disbursement"."Approved Amount")
            {
            }
            column(ComplaintsEmailBody_Complaints; "Employee Loan Disbursement"."Disbursement Date")
            {
            }
            column(UserID_Complaints; "Employee Loan Disbursement"."Global Dimension 1 Code")
            {
            }
            column(Status_Complaints; "Employee Loan Disbursement".Status)
            {
            }
            column(ComplaintChannel_Complaints; "Employee Loan Disbursement"."Employee No.")
            {
            }
            column(RootCause_Complaints; "Employee Loan Disbursement"."Employee No.")
            {
            }
            column(CorrectiveAction_Complaints; "Employee Loan Disbursement"."Employee No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                LN1 := LN1 + 1;
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
        CompanyInfo.CalcFields(Picture)
    end;

    var
        CompanyInfo: Record "Company Information";
        LN1: Integer;
}

