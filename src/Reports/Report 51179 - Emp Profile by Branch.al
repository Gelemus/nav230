report 51179 "Emp Profile by Branch"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Emp Profile by Branch.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("Global Dimension 1 Code") ORDER(Ascending);
            RequestFilterFields = "Global Dimension 1 Code";
            column(PageTxt_________FORMAT_CurrReport_PAGENO_; PageTxt + ' ' + Format(CurrReport.PageNo))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(PRINTED_ON_________FORMAT__TODAY_; 'PRINTED ON' + ' ' + Format(Today))
            {
            }
            column(PRINTED_BY_________FORMAT_USERID_; 'PRINTED BY' + ' ' + Format(UserId))
            {
            }
            column(PRINTED_AT_________FORMAT_TIME_; 'PRINTED AT' + ' ' + Format(Time))
            {
            }
            column(Employee_Employee__Global_Dimension_1_Code_; Employee."Global Dimension 1 Code")
            {
            }
            column(DeptName; DeptName)
            {
            }
            column(Employee_Employee__Global_Dimension_1_Code__Control1101951009; Employee."Global Dimension 1 Code")
            {
            }
            column(Employee__No__; "No.")
            {
            }
            column(First_Name__________Middle_Name_; "First Name" + ' ' + "Middle Name")
            {
            }
            column(Employee__Last_Name_; "Last Name")
            {
            }
            column(NO__OF_EMPLOYEES____________FORMAT_EmpCount_; 'NO. OF EMPLOYEES         ' + Format(EmpCount))
            {
            }
            column(MitarbeiterCaption; MitarbeiterCaptionLbl)
            {
            }
            column(Employee_Employee__Global_Dimension_1_Code__Control1101951009Caption; FieldCaption("Global Dimension 1 Code"))
            {
            }
            column(Employee__No__Caption; FieldCaption("No."))
            {
            }
            column(Other_NamesCaption; Other_NamesCaptionLbl)
            {
            }
            column(SurNameCaption; SurNameCaptionLbl)
            {
            }
            column(Employee_Employee__Global_Dimension_1_Code_Caption; FieldCaption("Global Dimension 1 Code"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "Termination Date" <> 0D then begin
                    if "Termination Date" <= LastTermDate then
                        CurrReport.Skip
                    else
                        EmpCount := EmpCount + 1
                end else
                    EmpCount := EmpCount + 1
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                LastFieldNo := FieldNo("Global Dimension 1 Code");
                EmpCount := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control1102754001)
                {
                    ShowCaption = false;
                    field(LastTermDate; LastTermDate)
                    {
                        Caption = 'Print Termination Date After';
                    }
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
        if LastTermDate = 0D then Error('You must Specify Last Termination Date on the options Tab');
        gsSegmentPayrollData
    end;

    var
        PageTxt: Label 'Page';
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        EmpCount: Integer;
        DeptRec: Record "Dimension Value";
        DeptName: Text[30];
        LastTermDate: Date;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        MitarbeiterCaptionLbl: Label 'EMPLOYEE PROFILE BY DEPARTMENT';
        Other_NamesCaptionLbl: Label 'Other Names';
        SurNameCaptionLbl: Label 'SurName';

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

