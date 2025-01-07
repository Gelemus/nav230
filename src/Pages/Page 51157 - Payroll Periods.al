page 51157 "Payroll Periods"
{
    PageType = List;
    Permissions = TableData Periods = rimd;
    SourceTable = Periods;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Period ID"; Rec."Period ID")
                {
                    Visible = false;
                }
                field("Period Month"; Rec."Period Month")
                {
                    Visible = true;
                }
                field("Period Year"; Rec."Period Year")
                {
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    Visible = true;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("NHIF Period Start"; Rec."NHIF Period Start")
                {
                    Visible = false;
                }
                field(Hours; Rec.Hours)
                {
                }
                field(Days; Rec.Days)
                {
                }
                field("Tax Penalties"; Rec."Tax Penalties")
                {
                    Visible = false;
                }
                field("Annualize TAX"; Rec."Annualize TAX")
                {
                }
                field("Low Interest Benefit %"; Rec."Low Interest Benefit %")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        //SKM 06/04/00 show history setting but
        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //IF Status <> Status::Open THEN ERROR('You can only edit open periods');
    end;

    trigger OnOpenPage()
    var
        MyPeriod: Record Periods;
    begin
        gsSegmentPayrollData; //skm150506
        MyPeriod.SetRange(MyPeriod.Status, MyPeriod.Status::Open);
        if MyPeriod.Find('-') then Rec := MyPeriod;
    end;

    procedure gsSegmentPayrollData()
    var
        lvAllowedPayrolls: Record "Allowed Payrolls";
        lvPayrollUtilities: Codeunit "Payroll Posting";
        UsrID: Code[10];
        UsrID2: Code[10];
        StringLen: Integer;
        lvActiveSession: Record "Active Session";
    begin
        /*lvSession.SETRANGE("My Session", TRUE);
        lvSession.FINDFIRST; //fire error in absence of a login
        IF lvSession."Login Type" = lvSession."Login Type"::Database THEN
          lvAllowedPayrolls.SETRANGE("User ID", USERID)
        ELSE*/

        lvActiveSession.Reset;
        lvActiveSession.SetRange("Server Instance ID", ServiceInstanceId);
        lvActiveSession.SetRange("Session ID", SessionId);
        lvActiveSession.FindFirst;


        lvAllowedPayrolls.SetRange("User ID", lvActiveSession."User ID");
        lvAllowedPayrolls.SetRange("Last Active Payroll", true);
        if lvAllowedPayrolls.FindFirst then
            Rec.SetRange("Payroll Code", lvAllowedPayrolls."Payroll Code")
        else
            Error('You are not allowed access to this payroll dataset.');
        Rec.FilterGroup(100);

    end;
}

