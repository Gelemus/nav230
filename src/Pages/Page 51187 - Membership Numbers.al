page 51187 "Membership Numbers"
{
    PageType = List;
    SourceTable = "Membership Numbers";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("ED Code"; Rec."ED Code")
                {
                }
                field("Number Name"; Rec."Number Name")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Membership Number"; Rec."Membership Number")
                {
                }
                field("Payroll Code"; Rec."Payroll Code")
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
        /*gsSegmentPayrollData; //skm150506
        IF NOT FIND('-') THEN BEGIN
          gvEDDEF.SETFILTER(gvEDDEF."Membership No. Name",'<>%1','');
          gvEDDEF.SETRANGE("Payroll Code", gvAllowedPayrolls."Payroll Code");
          IF gvEDDEF.FIND('-') THEN BEGIN
            REPEAT
              "ED Code" := gvEDDEF."ED Code";
              INSERT(TRUE);
            UNTIL gvEDDEF.NEXT = 0;
          END;
        END;
        */

    end;

    var
        gvEDDEF: Record "ED Definitions";
        gvAllowedPayrolls: Record "Allowed Payrolls";
        gvThisCode: Code[20];

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

