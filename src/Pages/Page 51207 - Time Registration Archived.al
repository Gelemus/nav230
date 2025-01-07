page 51207 "Time Registration Archived"
{
    AutoSplitKey = true;
    DataCaptionFields = "Employee No.";
    DelayedInsert = true;
    Editable = true;
    PageType = Card;
    Permissions = TableData "Employee Absence" = rimd,
                  TableData "Employee Absence Archive2" = rimd;
    SourceTable = "Employee Absence Archive2";

    layout
    {
        area(content)
        {
            field(FromDate; FromDate)
            {
                Caption = 'From';

                trigger OnValidate()
                begin
                    FromDateOnAfterValidate;
                end;
            }
            field(ToDate; ToDate)
            {
                Caption = 'To';

                trigger OnValidate()
                begin
                    ToDateOnAfterValidate;
                end;
            }
            field(SuperVis; SuperVis)
            {
                Caption = 'Supervisor';
                TableRelation = Employee;

                trigger OnValidate()
                begin
                    Employee.Reset;
                    if Employee.FindFirst then
                        repeat
                            EmpAbs.Reset;
                            EmpAbs.SetCurrentKey("Employee No.", "From Date");
                            EmpAbs.SetRange("Employee No.", Employee."No.");
                            if EmpAbs.FindFirst then
                                repeat
                                    EmpAbs.Validate("Employee No.", Employee."No.");
                                    EmpAbs.Modify;
                                until EmpAbs.Next = 0;
                        until Employee.Next = 0;
                    SuperVisOnAfterValidate;
                end;
            }
            field(OrgUnit; OrgUnit)
            {
                Caption = 'Org. Unit';
                // TableRelation = Table39013013;

                trigger OnValidate()
                begin
                    OrgUnitOnAfterValidate;
                end;
            }
            // field(payrollbatch;payrollbatch)
            // {
            //     Caption = 'Batch Name';
            //     Editable = true;
            //  //   TableRelation = Table39020333;
            // }
            repeater(Control1)
            {
                ShowCaption = false;
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("From Date"; Rec."From Date")
                {
                }
                field("Charge Date"; Rec."Charge Date")
                {
                }
                field("To Date"; Rec."To Date")
                {
                    Visible = false;
                }
                field("Cause of Absence Code"; Rec."Cause of Absence Code")
                {
                    Caption = 'Registration Type';
                }
                field(Description; Rec.Description)
                {
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field("Day/Hour"; Rec."Day/Hour")
                {
                    Editable = false;
                }
                field("Qty of Bouquets"; Rec."Qty of Bouquets")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Tranfer to Payroll"; Rec."Tranfer to Payroll")
                {
                    Editable = false;
                }
                field(Transferred; Rec.Transferred)
                {
                    Editable = false;
                }
                field("Transfer to Bonus"; Rec."Transfer to Bonus")
                {
                    Visible = false;
                }
                field(Comment; Rec.Comment)
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Time Reg")
            {
                Caption = 'Time Reg';
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Human Resource Comment Sheet";
                    // RunPageLink = "Table Name"=CONST("7"),
                    //               "Table Line No."=FIELD("Entry No.");
                }
            }
        }
    }

    trigger OnClosePage()
    begin
        gsSegmentPayrollData;
        Clear(FromDate);
        Clear(ToDate);
        Clear(OrgUnit);
        Clear(SuperVis);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        exit(Employee.Get(Rec."Employee No."));
    end;

    trigger OnOpenPage()
    begin
        Rec.Reset;
        Rec.FilterGroup(7);
        gsSegmentPayrollData;

        Rec."Batch name" := payrollbatch;
        Rec.SetRange("Batch name", Rec."Batch name");
        Rec.FilterGroup(0);
    end;

    var
        Employee: Record Employee;
        EmpAbs: Record "Employee Absence";
        Resource: Record Resource;
        CauseofAB: Record "Cause of Absence";
        EDDef: Record "ED Definitions";
        UserSetup: Record "User Setup";
        GLSetup: Record "General Ledger Setup";
        TimeRegF: Page "Time Registration";
        FLEEntryNo: Integer;
        EmpFilter: Text[250];
        Passon: Boolean;
        ConfirmPost: Boolean;
        Text000: Label 'Do you want to Transfer Entries to Field ledgers?';
        FromDate: Date;
        ToDate: Date;
        OrgUnit: Code[20];
        SuperVis: Code[20];
        SuperFilter: Text[250];
        EmpRec: Record Employee;
        I: Integer;
        EPCount: Integer;
        RangeMin: Code[20];
        RangeMax: Code[20];
        EmpAbsFilters: Text[250];
        PayrollSetup: Record "Payroll Setups";

    procedure payrollbatch(): Text[20]
    var
        lvuserseup: Record "User Setup";
    begin
        lvuserseup.SetRange("User ID", UserId);
        if lvuserseup.FindFirst then
            exit(lvuserseup."Payroll Batch");
    end;

    procedure getPayrollCode(): Code[20]
    var
        lvAllowedPayrolls: Record "Allowed Payrolls";
        lvPayrollUtilities: Codeunit "Payroll Posting";
    begin
        /*lvSession.SETRANGE("My Session", TRUE);
        lvSession.FINDFIRST; //fire error in absence of a login
        IF lvSession."Login Type" = lvSession."Login Type"::None THEN
          lvAllowedPayrolls.SETRANGE("User ID", USERID)
        ELSE*/
        lvAllowedPayrolls.SetRange("User ID", UserId);
        lvAllowedPayrolls.SetRange("Last Active Payroll", true);
        if lvAllowedPayrolls.FindFirst then
            exit(lvAllowedPayrolls."Payroll Code");

    end;

    procedure CheckForNonWorkingDay(date: Date; calendarCode: Code[10]) lvnonworking: Boolean
    var
        lvday: Integer;
        lvweek: Integer;
        lvbaseDate: Date;
        lvbaseDay: Integer;
        lvbaseSystem: Integer;
        lvCount: Integer;
    begin
        lvnonworking := false;
        lvCount := 0;

        lvday := Date2DWY(date, 1);
        /*
        BaseCalChange.RESET;
        BaseCalChange.SETFILTER("Base Calendar Code",'%1',calendarCode);
        BaseCalChange.SETFILTER(Nonworking,'%1',TRUE);
        
        IF BaseCalChange.FIND('-') THEN BEGIN
          REPEAT
            lvbaseDate:=BaseCalChange.Date;
            lvbaseDay:=BaseCalChange.Day;
            lvbaseSystem:=BaseCalChange."Recurring System";
            IF (BaseCalChange."Recurring System" = BaseCalChange."Recurring System"::"0") AND (lvbaseDate=date) THEN EXIT(TRUE);
            IF (BaseCalChange."Recurring System" = BaseCalChange."Recurring System"::"1") THEN BEGIN
              IF (DATE2DMY(date,1) = DATE2DMY(lvbaseDate,1)) AND (DATE2DMY(date,2) = DATE2DMY(lvbaseDate,2))
                  THEN EXIT(TRUE);
            END;
            IF (BaseCalChange."Recurring System" = BaseCalChange."Recurring System"::"2") THEN BEGIN
              IF (DATE2DWY(date,1) = lvbaseDay)  THEN EXIT(TRUE);
            END;
          UNTIL (BaseCalChange.NEXT=0);
        END;
        EXIT(FALSE);   */

    end;

    local procedure FromDateOnAfterValidate()
    begin
        if ((FromDate <> 0D) or (ToDate <> 0D)) then begin
            Rec.SetCurrentKey("Employee No.", Supervisor, "Org. Unit", "From Date");
            Rec.SetRange("From Date", FromDate, ToDate)
        end else
            Rec.Reset;
    end;

    local procedure ToDateOnAfterValidate()
    begin
        if ((FromDate <> 0D) or (ToDate <> 0D)) then
            Rec.SetRange("From Date", FromDate, ToDate)
        else
            Rec.Reset;
    end;

    local procedure OrgUnitOnAfterValidate()
    begin
        if OrgUnit <> '' then begin
            Rec.SetCurrentKey("Employee No.", Supervisor, "Org. Unit", "From Date");
            Rec.SetRange("Org. Unit", OrgUnit)
        end else
            Rec.Reset;
    end;

    local procedure SuperVisOnAfterValidate()
    begin
        if SuperVis <> '' then
            Rec.SetFilter(Supervisor, '=%1', SuperVis)
        else
            Rec.Reset;
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

