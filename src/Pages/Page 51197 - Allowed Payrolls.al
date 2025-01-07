page 51197 "Allowed Payrolls"
{
    PageType = List;
    SourceTable = "Allowed Payrolls";

    layout
    {
        area(content)
        {
            repeater(Control1102754000)
            {
                ShowCaption = false;
                field("Payroll Code"; Rec."Payroll Code")
                {
                    Editable = AllowEdit;
                    Enabled = AllowEdit;
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = AllowEdit;
                    Enabled = AllowEdit;
                }
                field("Valid to Date"; Rec."Valid to Date")
                {
                    Editable = AllowEdit;
                    Enabled = AllowEdit;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        AllowEdit := false;
    end;

    trigger OnOpenPage()
    begin
        gsSegmentPayrollData;
    end;

    var
        AllowEdit: Boolean;

    local procedure gsSegmentPayrollData()
    var
        lvAllowedPayrolls: Record "Allowed Payrolls";
        lvPayrollUtilities: Codeunit "Payroll Posting";
        UsrID: Code[10];
        UsrID2: Code[10];
        StringLen: Integer;
        lvActiveSession: Record "Active Session";
        UserSetup: Record "User Setup";
    begin
        /*lvActiveSession.RESET;
        lvActiveSession.SETRANGE("Server Instance ID",SERVICEINSTANCEID);
        lvActiveSession.SETRANGE("Session ID",SESSIONID);
        lvActiveSession.FINDFIRST;
        
        
        lvAllowedPayrolls.SETRANGE("User ID", lvActiveSession."User ID");
        //lvAllowedPayrolls.SETRANGE("Last Active Payroll", TRUE);//mesh
        IF lvAllowedPayrolls.FINDFIRST THEN
          SETRANGE("Payroll Code", lvAllowedPayrolls."Payroll Code")
        ELSE
          ERROR('You are not allowed access to this payroll dataset.');
        FILTERGROUP(100);*/

        UserSetup.Get(UserId);
        if not UserSetup."Payroll Admin" then begin
            AllowEdit := false
        end else
            AllowEdit := true;

        // AllowEdit := UserSetup.Get(UserId) and UserSetup."Payroll Admin";


    end;
}

