report 50108 "Oil Requistion  Report."
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Oil Requistion  Report.rdl';

    dataset
    {
        dataitem(Registry; Registry)
        {
            DataItemTableView = WHERE("Document Type" = FILTER("Oil Requistion"));
            RequestFilterFields = "Posting Date";
            column(No; Registry.No)
            {
            }
            column(Cheque_No; Registry."Cheque No")
            {
            }
            column(Posting_Date; Registry."Posting Date")
            {
            }
            column(Amount; Registry.Amount)
            {
            }
            column(Person_Picking; Registry."Name of Person Picking")
            {
            }
            column(UserId; Registry."USER ID")
            {
            }
            column(Time_Submitted; Registry."Time Submitted")
            {
            }
            column(Pic; CompanyInfo.Picture)
            {
            }
            column(Cheque_Name; Registry."Cheque Name")
            {
            }
            column(Account_No; Registry."Account No")
            {
            }
            column(Bank_Name; Registry."Bank to Deposit")
            {
            }
            column(Incoming_Mails; Registry."Incoming Mails")
            {
            }
            column(Letter_Content; Registry."Content of Letter")
            {
            }
            column(Letter_Sent_Posta; Registry."Letter sent via Posta")
            {
            }
            column(Employee_No; Registry."Employee No")
            {
            }
            column(Employee_Name; Registry."Employee Name")
            {
            }
            column(MotorCyle_No; Registry."Motor Cycle No")
            {
            }
            column(Motor_Description; Registry."Motor Cycle Description")
            {
            }
            column(Oil_Type; Registry."Marked To")
            {
            }
            column(Qty; Registry.Quantity)
            {
            }
            column(Person_Receiving; Registry."Name of Person Receiving")
            {
            }
            column(File_No; Registry."File No")
            {
            }
            column(Registration_No; Registry."Motor Registration No")
            {
            }

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);
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

    var
        CompanyInfo: Record "Company Information";
}

