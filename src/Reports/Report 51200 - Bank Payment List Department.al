report 51200 "Bank Payment List Department"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Bank Payment List Department.rdl';

    dataset
    {
        dataitem(Periods; Periods)
        {
            DataItemTableView = SORTING("Start Date") WHERE(Status = FILTER(Open | Posted));
            RequestFilterFields = "Period ID";
            column(CompName; CompName)
            {
            }
            column(CompanyInformation_Name; CompanyInfo.Name)
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
            column(Periods_Description; Description)
            {
            }
            column(Periods_Status; Status)
            {
            }
            column(CompNameCaption; CompNameCaptionLbl)
            {
            }
            column(Periods_DescriptionCaption; Periods_DescriptionCaptionLbl)
            {
            }
            column(Period_StatusCaption; Period_StatusCaptionLbl)
            {
            }
            column(Periods_Period_ID; "Period ID")
            {
            }
            column(Periods_Period_Month; "Period Month")
            {
            }
            column(Periods_Period_Year; "Period Year")
            {
            }
            column(Periods_Payroll_Code; "Payroll Code")
            {
            }
            dataitem(Employee; Employee)
            {
                DataItemTableView = SORTING("No.") WHERE(Status = CONST(Active));
                RequestFilterFields = "No.", "Bank Code", "Statistics Group Code", "Global Dimension 1 Code", "Global Dimension 2 Code", Status, "Mode of Payment";
                column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
                {
                }
                column(Employee__No__; "No.")
                {
                }
                column(Employee_Name; Name)
                {
                }
                column(Employee_Amount; Amount)
                {
                }
                column(Department; Employee."Global Dimension 1 Code")
                {
                }
                column(Section; Employee."Global Dimension 2 Code")
                {
                }
                column(Mobile_No; Employee."Mobile Phone No.")
                {
                }
                column(BankName; BankName)
                {
                }
                column(BranchName; BranchName)
                {
                }
                column(Employee__Bank_Account_No__; "Bank Account No")
                {
                }
                column(TotalAmount; TotalAmount)
                {
                }
                column(TotalAmount_Control23; TotalAmount)
                {
                }
                column(Periods_Description_Control25; Periods.Description)
                {
                }
                column(FORMAT_TODAY_0_4__Control28; Format(Today, 0, 4))
                {
                }
                column(Number_of_Employees____FORMAT_EmpCount_; 'Number of Employees ' + Format(EmpCount))
                {
                }
                column(Employee_AmountCaption; Employee_AmountCaptionLbl)
                {
                }
                column(Employee_NameCaption; Employee_NameCaptionLbl)
                {
                }
                column(Employee__No__Caption; FieldCaption("No."))
                {
                }
                column(BranchNameCaption; BranchNameCaptionLbl)
                {
                }
                column(BankNameCaption; BankNameCaptionLbl)
                {
                }
                column(Employee__Bank_Account_No__Caption; FieldCaption("Bank Account No"))
                {
                }
                column(TotalAmountCaption; TotalAmountCaptionLbl)
                {
                }
                column(Please_recieve_cheque_number___________________________________________Caption; Please_recieve_cheque_number___________________________________________CaptionLbl)
                {
                }
                column(for_ShsCaption; for_ShsCaptionLbl)
                {
                }
                column(covering_payments_of_salaries_to_the_above_listed_staff_forCaption; covering_payments_of_salaries_to_the_above_listed_staff_forCaptionLbl)
                {
                }
                column(Please_credit_their_accounts_accordingly_Caption; Please_credit_their_accounts_accordingly_CaptionLbl)
                {
                }
                column(Approved_By__Chief_Executive_OfficerCaption; Approved_By__Chief_Executive_OfficerCaptionLbl)
                {
                }
                column(Approved_By__AccountantCaption; Approved_By__AccountantCaptionLbl)
                {
                }
                column(Approved_By__HR___Admin_ManagerCaption; Approved_By__HR___Admin_ManagerCaptionLbl)
                {
                }
                column(NationalID_Employee; Employee."National ID")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //IF BankTable.GET(Employee."Bank Code") THEN BEGIN //SNG 080611 Make sure employee has bank code setup

                    BankName := BankTable.Name;
                    BranchName := BankTable.Branch;

                    Name := Employee.FullName;

                    if Header.Get(Periods."Period ID", Employee."No.") then begin
                        Header.CalcFields("Total Payable (LCY)", "Total Deduction (LCY)", "Total Rounding Pmts (LCY)", "Total Rounding Ded (LCY)");
                        Amount := Header."Total Payable (LCY)" + Header."Total Rounding Pmts (LCY)" - (Header."Total Deduction (LCY)" +
                          Header."Total Rounding Ded (LCY)");
                        if Amount < 0 then
                            CurrReport.Skip
                        else
                            TotalAmount := TotalAmount + Amount;
                    end else
                        CurrReport.Skip;

                    EmpCount := EmpCount + 1;
                    /*END
                    ELSE
                      ERROR(Employee."First Name" + ' '+ Employee."Middle Name" +
                      '\Employee No. ' + Employee."No." + '\Does not seem to have a bank Code setup');
                    */

                end;

                trigger OnPreDataItem()
                begin
                    EmpCount := 0;
                    SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                    //SETRANGE(Employee."Mode of Payment", ModeOfPayment);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TotalAmount := 0;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                // IF Periods.GETFILTER(Periods."Period ID")=''THEN ERROR('Specify the Period ID');
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

    trigger OnInitReport()
    begin
        //SNG 080611 Enable user to dynamicaly select the Mode of Payment
        /*MESSAGE('Select The Bank Payment Option ');
        IF ACTION::LookupOK = PAGE.RUNMODAL(PAGE::"Mode of Payment",gvPayment) THEN
          ModeOfPayment := gvPayment.Code
        ELSE
          ERROR('Please Select a mode of payment');
        */

    end;

    trigger OnPreReport()
    begin
        gsSegmentPayrollData;
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        Header: Record "Payroll Header";
        BankTable: Record "Employee Bank Account";
        Name: Text[60];
        Amount: Decimal;
        TotalAmount: Decimal;
        Emplo: Record Employee;
        BankName: Text[50];
        BranchName: Text[50];
        PeriodName: Text[50];
        CompName: Text[50];
        EmpCount: Integer;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        gvPayment: Record "Mode of Payment";
        ModeOfPayment: Code[20];
        CompNameCaptionLbl: Label 'Bank Schedule for: ';
        Periods_DescriptionCaptionLbl: Label 'Employees  List For';
        Period_StatusCaptionLbl: Label 'Period Status';
        Employee_AmountCaptionLbl: Label 'Amount';
        Employee_NameCaptionLbl: Label 'Name';
        BranchNameCaptionLbl: Label 'Branch';
        BankNameCaptionLbl: Label 'Bank';
        TotalAmountCaptionLbl: Label 'Total Amount';
        Please_recieve_cheque_number___________________________________________CaptionLbl: Label 'Please recieve cheque number __________________________________________';
        for_ShsCaptionLbl: Label 'for Shs';
        covering_payments_of_salaries_to_the_above_listed_staff_forCaptionLbl: Label ', covering payments of salaries to the above listed staff for';
        Please_credit_their_accounts_accordingly_CaptionLbl: Label 'Please credit their accounts accordingly.';
        Approved_By__Chief_Executive_OfficerCaptionLbl: Label 'Approved By: Chief Executive Officer';
        Approved_By__AccountantCaptionLbl: Label 'Approved By: Accountant';
        Approved_By__HR___Admin_ManagerCaptionLbl: Label 'Approved By: HR / Admin Manager';
        CompanyInfo: Record "Company Information";

    procedure gsSegmentPayrollData()
    var
        lvAllowedPayrolls: Record "Allowed Payrolls";
        lvPayrollUtilities: Codeunit "Payroll Posting";
        UsrID: Code[10];
        UsrID2: Code[10];
        StringLen: Integer;
        lvActiveSession: Record "Active Session";
    begin

        lvActiveSession.Reset;
        lvActiveSession.SetRange("Server Instance ID", ServiceInstanceId);
        lvActiveSession.SetRange("Session ID", SessionId);
        lvActiveSession.FindFirst;


        gvAllowedPayrolls.SetRange("User ID", lvActiveSession."User ID");
        gvAllowedPayrolls.SetRange("Last Active Payroll", true);
        if not gvAllowedPayrolls.FindFirst then
            Error('You are not allowed access to this payroll dataset.');
    end;
}

