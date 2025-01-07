page 51174 "Loan types"
{
    PageType = List;
    SourceTable = "Loan Types";

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
                field(Description; Rec.Description)
                {
                }
                field("Calculate Interest Benefit"; Rec."Calculate Interest Benefit")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Advance Type"; Rec."Advance Type")
                {
                }
                field("Loan Accounts Type"; Rec."Loan Accounts Type")
                {
                }
                field("Loan Account"; Rec."Loan Account")
                {
                }
                field("Loan Losses Account"; Rec."Loan Losses Account")
                {
                }
                field("Loan Interest Account Type"; Rec."Loan Interest Account Type")
                {
                }
                field("Loan Interest Account"; Rec."Loan Interest Account")
                {
                }
                field("Loan E/D Code"; Rec."Loan E/D Code")
                {
                }
                field("Loan Interest E/D Code"; Rec."Loan Interest E/D Code")
                {
                }
                field("Finance Source"; Rec."Finance Source")
                {
                }
                field(Rounding; Rec.Rounding)
                {
                }
                field("Rounding Precision"; Rec."Rounding Precision")
                {
                }
            }
            field("Loan Account Name"; Rec."Loan Account Name")
            {
                Editable = false;
            }
            field("Losses Account Name"; Rec."Losses Account Name")
            {
                Editable = false;
            }
            field("Loan E/D Name"; Rec."Loan E/D Name")
            {
                Editable = false;
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
        /*lvAllowedPayrolls.SETRANGE("Last Active Payroll", TRUE);
        IF lvAllowedPayrolls.FINDFIRST THEN
          SETRANGE("Payroll Code", lvAllowedPayrolls."Payroll Code")
        ELSE
          ERROR('You are not allowed access to this payroll dataset.');
        FILTERGROUP(100);*/

    end;
}

