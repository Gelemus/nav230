report 50190 "Post Employee Loan Interest"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Employee Loan Accounts";"Employee Loan Accounts")
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                EmployeeRepaymentSchedule.Reset;
                EmployeeRepaymentSchedule.SetRange("Loan No.","Employee Loan Accounts"."No.");
                if EmployeeRepaymentSchedule.FindSet then begin
                  repeat
                    if (CalcDate('-CM',EmployeeRepaymentSchedule."Repayment Date") <=RunDate) and (RunDate<=CalcDate('CM',EmployeeRepaymentSchedule."Repayment Date") ) then begin
                      LineNo:=LineNo+1;
                      DailyInterest:=EmployeeRepaymentSchedule."Interest Repayment"/Date2DMY(CalcDate('CM',EmployeeRepaymentSchedule."Repayment Date"),1);
                      HRLoanMgt.PostLoanInterest(EmployeeRepaymentSchedule."Loan No.",DailyInterest,RunDate,LineNo);
                    end;
                  until EmployeeRepaymentSchedule.Next = 0;
                end;
            end;

            trigger OnPreDataItem()
            begin
                LineNo:=0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(RunDate;RunDate)
                {
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CompanyInformation: Record "Company Information";
        RunDate: Date;
        DailyInterest: Decimal;
        HRLoanMgt: Codeunit "HR Loan Management";
        LineNo: Integer;
        EmployeeRepaymentSchedule: Record "Employee Repayment Schedule";
}

