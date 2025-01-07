page 51170 "Recurring Loans Schedule"
{
    AutoSplitKey = true;
    PageType = List;
    SourceTable = "Recurring Loans Schedule";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Employee; Rec.Employee)
                {
                }
                field("Loan Types"; Rec."Loan Types")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Principal; Rec.Principal)
                {
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                }
                field(Installments; Rec.Installments)
                {
                }
                field("Installment Amount"; Rec."Installment Amount")
                {
                }
                field("Payments Method"; Rec."Payments Method")
                {
                }
                field(Skip; Rec.Skip)
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

