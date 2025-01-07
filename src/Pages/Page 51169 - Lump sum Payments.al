page 51169 "Lump sum Payments"
{
    AutoSplitKey = true;
    PageType = List;
    SourceTable = "Lump Sum Payments";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Line No"; Rec."Line No")
                {
                    Visible = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("ED Code"; Rec."ED Code")
                {
                }
                field("ED Description"; Rec."ED Description")
                {
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                }
                field("Assessment Year"; Rec."Assessment Year")
                {
                }
                field("Annual Tax Table"; Rec."Annual Tax Table")
                {
                }
            }
        }
    }

    actions
    {
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

