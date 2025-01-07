report 51162 "Salary scales"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Salary scales.rdl';

    dataset
    {
        dataitem("Salary Scale"; "Salary Scale")
        {
            DataItemTableView = SORTING(Code);
            RequestFilterFields = "Code";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(Salary_Scale_Code; Code)
            {
            }
            column(Salary_Scale_Description; Description)
            {
            }
            column(Salary_ScaleCaption; Salary_ScaleCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            dataitem("Salary Scale Step"; "Salary Scale Step")
            {
                DataItemLink = Scale = FIELD(Code);
                DataItemTableView = SORTING(Code, Scale);
                column(Salary_Scale_Step_Code; Code)
                {
                }
                column(Salary_Scale_Step_Description; Description)
                {
                }
                column(Salary_Scale_Step_Amount; Amount)
                {
                }
                column(Salary_Scale_Step_Scale; Scale)
                {
                }

                trigger OnPreDataItem()
                begin
                    SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                end;
            }

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                LastFieldNo := FieldNo(Code);
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
        gsSegmentPayrollData;
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        Salary_ScaleCaptionLbl: Label 'Salary Scale';
        CurrReport_PAGENOCaptionLbl: Label 'Page';

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

