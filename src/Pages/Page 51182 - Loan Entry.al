page 51182 "Loan Entry"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "Payroll Header" = rimd,
                  TableData "Payroll Entry" = rimd,
                  TableData "Special Payments" = rimd;
    RefreshOnActivate = true;
    SourceTable = "Loan Entry";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                }
                field("Loan ID"; Rec."Loan ID")
                {
                }
                field(Employee; Rec.Employee)
                {
                }
                field(Period; Rec.Period)
                {
                }
                field("Period Status"; Rec."Period Status")
                {
                }
                field(Interest; Rec.Interest)
                {
                }
                field(Repayment; Rec.Repayment)
                {
                }
                field("Transfered To Payroll"; Rec."Transfered To Payroll")
                {
                }
                field("Remaining Debt"; Rec."Remaining Debt")
                {
                }
                field(Posted; Rec.Posted)
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
        //gsSegmentPayrollData; //Mesh
        Rec.SetCurrentKey("No.", "Loan ID");
        if Rec.Count > 0 then
            Rec.Find('-');
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

