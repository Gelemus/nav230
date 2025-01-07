report 50270 "Employee Family Details Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Employee Family Details Report.rdl';

    dataset
    {
        dataitem("HR Employee Relative"; "HR Employee Relative")
        {
            DataItemTableView = SORTING("Employee No.", "Line No.") ORDER(Ascending);
            RequestFilterFields = "Employee No.", Type;
            column(Name; CompanyInfo.Name)
            {
            }
            column(EmployeeNo_HREmployeeRelative; "HR Employee Relative"."Employee No." + ' ' + Names)
            {
            }
            column(RelativeCode_HREmployeeRelative; "HR Employee Relative"."Relative Code")
            {
            }
            column(Surname_HREmployeeRelative; "HR Employee Relative".Surname)
            {
            }
            column(Firstname_HREmployeeRelative; "HR Employee Relative".Firstname)
            {
            }
            column(Middlename_HREmployeeRelative; "HR Employee Relative".Middlename)
            {
            }
            column(DateofBirth_HREmployeeRelative; "HR Employee Relative"."Date of Birth")
            {
            }
            column(Age_HREmployeeRelative; "HR Employee Relative".Age)
            {
            }
            column(Type_HREmployeeRelative; "HR Employee Relative".Type)
            {
            }
            column(Names; Names)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Employee.Reset;
                Employee.SetRange(Employee."No.", "HR Employee Relative"."Employee No.");
                if Employee.FindSet then begin
                    Names := Employee."Full Name";//Employee."First Name"+''+Employee."Middle Name"+''+Employee."Last Name";
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
}

