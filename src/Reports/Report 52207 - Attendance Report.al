report 52207 "Attendance Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Attendance Report.rdl';

    dataset
    {
        dataitem("Attendance Punches"; "Attendance Punches")
        {
            RequestFilterFields = No, "Employee No", Time;
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
            column(No_AttendancePunches; "Attendance Punches".No)
            {
            }
            column(EmployeeNo_AttendancePunches; "Attendance Punches"."Employee No")
            {
            }
            column(EmployeeName_AttendancePunches; Name)
            {
            }
            column(Time_AttendancePunches; "Attendance Punches".Time)
            {
            }
            column(WorkStatus_AttendancePunches; "Attendance Punches"."Work Status")
            {
            }
            column(AttenanceStatus_AttendancePunches; "Attendance Punches"."Attendance Status")
            {
            }
            column(Start_Date; "Start Date")
            {
            }
            column(End_Date; "End Date")
            {
            }

            trigger OnAfterGetRecord()
            begin
                /*SETFILTER(Time,'%1..%2',"Start Date","End Date");
                  "Start Date" := "Attendance Punches".GETRANGEMIN(Time);
                  "End Date" := "Attendance Punches".GETRANGEMAX(Time);
                  */
                EmployeeRec.Reset;
                EmployeeRec.SetRange(EmployeeRec."No.", "Attendance Punches"."Employee No");
                if EmployeeRec.FindSet then begin
                    Name := EmployeeRec."Full Name";
                end;

                if Name = '' then
                    CurrReport.Skip;

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; "Start Date")
                {
                    Caption = 'Start Date';
                    Visible = false;
                }
                field("End Date"; "End Date")
                {
                    Caption = 'End Date';
                    Visible = false;
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

    trigger OnPreReport()
    begin

        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        PayrollSetup: Record "Payroll Setups";
        PeriodRec: Record Periods;
        Name: Text[100];
        TitleText: Text[60];
        EmployerName: Text[50];
        AmountPeriod: Decimal;
        AmountThisYear: Decimal;
        AmountToDate: Decimal;
        TotalAmountThisYear: Decimal;
        TotalAmountToDate: Decimal;
        TotalAmount: Decimal;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        MembershipNumbers: Record "Membership Numbers";
        gvPinNo: Code[20];
        PrevEmpID: Code[20];
        gvPayrollLines: Record "Payroll Lines";
        gvPeriods: Record Periods;
        Amount_This_PeriodCaptionLbl: Label 'Amount This Period';
        Employee_NameCaptionLbl: Label 'Name';
        gvPinNoCaptionLbl: Label 'PIN No.';
        Employee__No__CaptionLbl: Label 'No.';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        AmountThisYearCaptionLbl: Label 'Amount';
        AmountToDateCaptionLbl: Label 'To Date';
        TotalsCaptionLbl: Label 'Totals';
        CompanyInfo: Record "Company Information";
        EmployeeRec: Record Employee;
        BasicAmount: Decimal;
        ArrearsAmount: Decimal;
        i: Integer;
        ShowPreparedBy: Boolean;
        PreparedBy: Text;
        PreparedByCaption: Text;
        ApprovedByCaption: Text;
        DateApproved: DateTime;
        "Start Date": DateTime;
        "End Date": DateTime;
}

