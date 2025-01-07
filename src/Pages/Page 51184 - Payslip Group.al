page 51184 "Payslip Group"
{
    PageType = List;
    SourceTable = "Payslip Group";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                }
                field("Heading Text"; Rec."Heading Text")
                {
                }
                field("Include Total For Group"; Rec."Include Total For Group")
                {
                }
                field("Line Type"; Rec."Line Type")
                {
                }
                field("Heading Text 2"; Rec."Heading Text 2")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Group Lines")
            {
                Caption = 'Group Lines';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Payslip Lines";
                RunPageLink = "Payslip Group" = FIELD(Code),
                              "Payroll Code" = FIELD("Payroll Code"),
                              "Line Type" = FIELD("Line Type");
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

