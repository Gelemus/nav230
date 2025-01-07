page 50384 "Salary Advance Applications"
{
    CardPageID = "Salary Advance Card";
    DeleteAllowed = true;
    PageType = List;
    SourceTable = "Salary Advance";
    SourceTableView = WHERE(Type = CONST(Advance),
                            "Paid to Employee" = CONST(false),
                            Status = CONST(Open));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ID; Rec.ID)
                {
                }
                field(Employee; Rec.Employee)
                {
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                }
                field("Loan Types"; Rec."Loan Types")
                {
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field(Principal; Rec.Principal)
                {
                }
                field("Principal (LCY)"; Rec."Principal (LCY)")
                {
                }
                field("Start Period"; Rec."Start Period")
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
                field("Paid to Employee"; Rec."Paid to Employee")
                {
                    Editable = false;
                }
                field(Create; Rec.Create)
                {
                }
                field(Pay; Rec.Pay)
                {
                }
                field(Created; Rec.Created)
                {
                    Editable = false;
                }
                field("File Name"; Rec."File Name")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Loan")
            {
                Caption = '&Loan';
                action("Create Loan")
                {
                    Caption = 'Create Loan';

                    trigger OnAction()
                    begin
                        Rec.CreateLoan;
                    end;
                }
                action("Create Batch")
                {
                    Caption = 'Create Batch';

                    trigger OnAction()
                    begin
                        CreateBatch
                    end;
                }
                action("Create from Schedule")
                {
                    Caption = 'Create from Schedule';

                    trigger OnAction()
                    begin
                        Rec.CreateLoanfromSchedule;
                    end;
                }
                separator(Separator42)
                {
                    Caption = '';
                }
                action("Pay Loan")
                {
                    Caption = 'Pay Loan';

                    trigger OnAction()
                    begin
                        Rec.PayLoan;
                    end;
                }
                action("Pay Batch")
                {
                    Caption = 'Pay Batch';

                    trigger OnAction()
                    begin
                        PayBatch
                    end;
                }
                separator(Separator39)
                {
                    Caption = '';
                }
                action("Write Off Loan")
                {
                    Caption = 'Write Off Loan';
                    RunObject = Page "Write Off Loan";
                    //  RunPageLink ="Loan ID" = FIELD(ID);
                }
                action("Payoff Loan")
                {
                    Caption = 'Payoff Loan';
                    RunObject = Page "Pay Off Loan";
                    // RunPageLink = "Loan ID" = FIELD(ID);
                }
                separator(Separator36)
                {
                    Caption = '';
                }
                action("Change Loan")
                {
                    Caption = 'Change Loan';
                    RunObject = Page "Change Loan";
                    //  RunPageLink = "Loan ID" = FIELD(ID);
                }
                separator(Separator19)
                {
                }
            }
            action("Salary Advance")
            {
                Caption = 'Salary Advance';
                RunObject = Report "Salary Advance";

                trigger OnAction()
                begin
                    Rec.SetRange(ID, Rec.ID);
                    REPORT.Run(REPORT::"Salary Advance", true, true, Rec);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin

        //gsSegmentPayrollData;
        //MarkClearedLoans;
        Rec.SetRange("USER ID", UserId);
    end;

    var
        gvAllowedPayrolls: Record "Allowed Payrolls";
        SalaryAdvance: Record "Salary Advance";

    procedure MarkClearedLoans()
    var
        lvLoan: Record "Loans/Advances";
    begin
        //skm 130405
        lvLoan.SetRange(Cleared, false);
        lvLoan.SetRange(Created, true);
        if lvLoan.Find('-') then
            repeat
                lvLoan.CalcFields("Remaining Debt");
                if lvLoan."Remaining Debt" = 0 then begin
                    lvLoan.Cleared := true;
                    lvLoan.Modify
                end
            until lvLoan.Next = 0;

        Rec.SetRange(Cleared, false);
    end;

    procedure CreateBatch()
    begin
        if not Confirm('Create all loans with a tick on Create field and within your current filters?', false) then exit;
        gvAllowedPayrolls.SetRange("User ID", UserId);
        gvAllowedPayrolls.SetRange("Last Active Payroll", true);
        gvAllowedPayrolls.FindFirst;
        Rec.SetRange(Create, true);
        Rec.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
        if Rec.Find('-') then
            repeat
                Rec.CreateLoan
            until Rec.Next = 0;

        Rec.Reset;
        Rec.SetRange(Cleared, false);
        Message('Loans successfully created.')
    end;

    procedure PayBatch()
    begin
        if not Confirm('Pay all loans with a tick on Pay field and within your current filters?', false) then exit;
        gvAllowedPayrolls.SetRange("User ID", UserId);
        gvAllowedPayrolls.SetRange("Last Active Payroll", true);
        gvAllowedPayrolls.FindFirst;
        Rec.SetRange(Pay, true);
        Rec.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
        if Rec.Find('-') then
            repeat
                Rec.PayLoan
            until Rec.Next = 0;

        Rec.Reset;
        Rec.SetRange(Cleared, false);
        Message('Loans successfully paid.')
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

