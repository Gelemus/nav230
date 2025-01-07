page 51198 "Payroll Header List"
{
    CardPageID = "Payroll Header Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Payroll Header";
    SourceTableView = WHERE(Posted = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Payroll ID"; Rec."Payroll ID")
                {
                }
                field("Payroll Month"; Rec."Payroll Month")
                {
                }
                field("Payroll Year"; Rec."Payroll Year")
                {
                }
                field("Employee no."; Rec."Employee no.")
                {
                }
                field("First Name"; Rec."First Name")
                {
                }
                field("Middle Name"; Rec."Middle Name")
                {
                }
                field("Last Name"; Rec."Last Name")
                {
                }
                field(Calculated; Rec.Calculated)
                {
                }
                field("Pay Leave"; Rec."Pay Leave")
                {
                }
                field("Mode of Payment"; Rec."Mode of Payment")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Enable Payslip")
            {
                Image = Insert;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Clear(ApprovePayslip);
                    ApprovePayslip.Run;

                    //Periods.RESET;
                    //Periods.
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        gsSegmentPayrollData; //skm200406
    end;

    var
        ApprovePayslip: Report "approval payroll";
        documentNo: Code[20];
        Periods: Record Periods;

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

