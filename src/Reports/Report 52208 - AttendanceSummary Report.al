report 52208 "AttendanceSummary Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/AttendanceSummary Report.rdl';

    dataset
    {
        dataitem("Attendance Summary"; "Attendance Summary")
        {
            //The property 'DataItemTableView' shouldn't have an empty value.
            //DataItemTableView = '';
            RequestFilterFields = "No.", "Employee No.", Date;
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
            column(No_AttendanceSummary; "Attendance Summary"."No.")
            {
            }
            column(EmployeeNo_AttendanceSummary; "Attendance Summary"."Employee No.")
            {
            }
            column(EmployeeName_AttendanceSummary; "Attendance Summary"."Employee Name")
            {
            }
            column(Date_AttendanceSummary; "Attendance Summary".Date)
            {
            }
            column(TimeIn_AttendanceSummary; "Attendance Summary"."Time In")
            {
            }
            column(TimeOut_AttendanceSummary; "Attendance Summary"."Time Out")
            {
            }
            column(AgreedStatus_AttendanceSummary; "Attendance Summary"."Agreed Status")
            {
            }
            column(Clocked_AttendanceSummary; "Attendance Summary".Clocked)
            {
            }
            column(ClockedInLate_AttendanceSummary; "Attendance Summary"."Clocked In Late")
            {
            }
            column(ClocketOutEarly_AttendanceSummary; "Attendance Summary"."Clocket Out Early")
            {
            }
            column(TimeInString_AttendanceSummary; "Attendance Summary"."Time In String")
            {
            }
            column(TimeoutString_AttendanceSummary; "Attendance Summary"."Time out String")
            {
            }
            column(Id_AttendanceSummary; "Attendance Summary".Id)
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
                /*"Attendance Summary".SETFILTER("Attendance Summary".Date,'%1..%2',"Start Date","End Date");
                  "Start Date" := "Attendance Summary".GETRANGEMIN(Date);
                  "End Date" := "Attendance Summary".GETRANGEMAX(Date);
                 */

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
        "Start Date": Date;
        "End Date": Date;
}

