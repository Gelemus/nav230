report 50258 "User Time Register Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/User Time Register Report.rdl';

    dataset
    {
        dataitem("User Time Register"; "User Time Register")
        {
            DataItemTableView = SORTING("User ID", Date) ORDER(Ascending);
            RequestFilterFields = "User ID", Date;
            column(Name; CompanyInfo.Name)
            {
            }
            column(UserID_UserTimeRegister; "User Time Register"."User ID")
            {
            }
            column(Date_UserTimeRegister; "User Time Register".Date)
            {
            }
            column(Minutes_UserTimeRegister; "User Time Register".Minutes)
            {
            }
            column(Names; Names)
            {
            }
            column(Hours; Hours)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Employee.Reset;
                Employee.SetRange(Employee."User ID", "User Time Register"."User ID");
                if Employee.FindSet then begin
                    Names := Employee."Full Name";//Employee."First Name"+''+Employee."Middle Name"+''+Employee."Last Name";
                    Hours := "User Time Register".Minutes / 60;
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
        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(Picture)
    end;

    var
        CompanyInfo: Record "Company Information";
        Names: Text;
        Employee: Record Employee;
        Hours: Decimal;
}

