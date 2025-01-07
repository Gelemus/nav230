page 51155 "Employee Posting Group"
{
    PageType = List;
    SourceTable = "Employee Posting Groups";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Posting Group"; Rec."Posting Group")
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Setup")
            {
                Caption = '&Setup';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Payroll Posting Setup";
                RunPageLink = "Posting Group" = FIELD("Posting Group");
            }
        }
    }

    trigger OnOpenPage()
    begin
        gsSegmentPayrollData; //skm150506
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

