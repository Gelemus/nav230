report 50189 "Post Employee  Loan Principal"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Employee Loan Accounts";"Employee Loan Accounts")
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                if HRLoanProducts.Get("Employee Loan Accounts"."Loan Product Code") then begin
                  //if CalcDate(HRLoanProducts."Principal Moratorium Period","Employee Loan Accounts"."Repayment Start Date") > Today then CurrReport.Skip;
                  EmployeeRepaymentSchedule.Reset;
                  EmployeeRepaymentSchedule.SetRange("Loan No.","Employee Loan Accounts"."No.");
                  if EmployeeRepaymentSchedule.FindSet then begin
                    repeat
                      if (CalcDate('-CM',EmployeeRepaymentSchedule."Repayment Date") <=RunDate) and (RunDate<=CalcDate('CM',EmployeeRepaymentSchedule."Repayment Date") ) then begin
                        LineNo:=LineNo+1;
                        HRLoanMgt.PostLoanPrincipal(EmployeeRepaymentSchedule."Loan No.",EmployeeRepaymentSchedule."Principal Repayment",RunDate,LineNo);
                      end;
                    until EmployeeRepaymentSchedule.Next =0;
                  end;
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
        HRLoanProducts: Record "Employee Loan Products";
}

