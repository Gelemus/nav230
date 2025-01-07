page 51180 "Loans/Advances"
{
    CardPageID = "Loan/Advance Card";
    PageType = List;
    SourceTable = "Loans/Advances";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ID; Rec.ID)
                {
                    Visible = false;
                }
                field(Employee; Rec.Employee)
                {
                }
                field("First Name"; Rec."First Name")
                {
                }
                field("Last Name"; Rec."Last Name")
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
                field(PrincipalStat; Rec.Principal)
                {
                    Caption = 'Principal';
                    Editable = false;
                }
                field("Principal (LCY)Stat"; Rec."Principal (LCY)")
                {
                    Caption = 'Principal (LCY)';
                }
                field("Remaining Debt"; Rec."Remaining Debt")
                {
                }
                field("Remaining Debt (LCY)"; Rec."Remaining Debt (LCY)")
                {
                }
                field(Repaid; Rec.Repaid)
                {
                }
                field("Repaid (LCY)"; Rec."Repaid (LCY)")
                {
                }
                field("Number of Installments"; Rec."Number of Installments")
                {
                }
                field("Total Interest"; Rec."Total Interest")
                {
                }
                field("Total Interest (LCY)"; Rec."Total Interest (LCY)")
                {
                }
                field("Interest Paid"; Rec."Interest Paid")
                {
                }
                field("Interest Paid (LCY)"; Rec."Interest Paid (LCY)")
                {
                }
                field("Last Suspension Date"; Rec."Last Suspension Date")
                {
                    Editable = false;
                }
                field("Last Suspension Duration"; Rec."Last Suspension Duration")
                {
                    Editable = false;
                }
                field("Loan ID"; Rec."Loan ID")
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
                    RunPageLink = "Loan ID" = FIELD(ID);
                }
                action("Payoff Loan")
                {
                    Caption = 'Payoff Loan';
                    RunObject = Page "Pay Off Loan";
                    RunPageLink = "Loan ID" = FIELD(ID);
                }
                separator(Separator36)
                {
                    Caption = '';
                }
                action("Change Loan")
                {
                    Caption = 'Change Loan';
                    RunObject = Page "Change Loan";
                    RunPageLink = "Loan ID" = FIELD(ID);
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        Rec.CalcFields("Remaining Debt", Repaid, "Number of Installments", "Total Interest", "Interest Paid",
          "Remaining Debt (LCY)", "Repaid (LCY)", "Total Interest (LCY)", "Interest Paid (LCY)")
    end;

    trigger OnOpenPage()
    begin

        gsSegmentPayrollData;
        //MarkClearedLoans;
    end;

    var
        gvAllowedPayrolls: Record "Allowed Payrolls";

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

