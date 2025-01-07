report 50059 "CRM Feedback"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/CRM Feedback.rdl';

    dataset
    {
        dataitem("Employee App. Repay. Schedule"; "Employee App. Repay. Schedule")
        {
            RequestFilterFields = "Application No.", "Loan Disbursement No.";
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
            column(No_FeedBack; "Employee App. Repay. Schedule"."Application No.")
            {
            }
            column(DocumentDate_FeedBack; "Employee App. Repay. Schedule"."Loan Disbursement No.")
            {
            }
            column(Description_FeedBack; "Employee App. Repay. Schedule"."Employee No.")
            {
            }
            column(Names_FeedBack; "Employee App. Repay. Schedule"."Employee No.")
            {
            }
            column(Email_FeedBack; "Employee App. Repay. Schedule"."Employee No.")
            {
            }
            column(PhoneNo_FeedBack; "Employee App. Repay. Schedule"."Employee No.")
            {
            }
            column(UserID_FeedBack; "Employee App. Repay. Schedule"."Employee No.")
            {
            }
            column(Status_FeedBack; "Employee App. Repay. Schedule"."Employee No.")
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

