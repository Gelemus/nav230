page 51156 "Payroll Posting Setup"
{
    PageType = List;
    SourceTable = "Payroll Posting Setup";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Posting Group"; Rec."Posting Group")
                {
                    Caption = 'Employee Posting Group';
                }
                field("ED Posting Group"; Rec."ED Posting Group")
                {
                }
                field("Account Type Debit"; Rec."Account Type Debit")
                {
                }
                field("Debit Account"; Rec."Debit Account")
                {
                }
                field("Account Type Credit"; Rec."Account Type Credit")
                {
                }
                field("Credit Account"; Rec."Credit Account")
                {
                }
                field("Payroll Code"; Rec."Payroll Code")
                {
                }
            }
            group(Control13)
            {
                ShowCaption = false;
                field("Debit Account Name"; Rec."Debit Account Name")
                {
                    Editable = false;
                    Enabled = true;
                }
                field("Credit Account Name"; Rec."Credit Account Name")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        gsSegmentPayrollData; //Mesh
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

