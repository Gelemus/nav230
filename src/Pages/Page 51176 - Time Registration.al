page 51176 "Time Registration"
{
    AutoSplitKey = true;
    DataCaptionFields = "Employee No.";
    DelayedInsert = true;
    PageType = Card;
    Permissions = TableData "Employee Absence" = rimd,
                  TableData "Employee Absence Archive2" = rimd;
    SourceTable = "Employee Absence";

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
            // field(payrollbatch;Rec.payrollbatch)
            // {
            //     Caption = 'Batch Name';
            //     Editable = true;
            //     TableRelation = Table39020333;
            // }
            repeater(Control1)
            {
                ShowCaption = false;
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Entry No."; Rec."Entry No.")
                {
                    Visible = false;
                }
                field("From Date"; Rec."From Date")
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
                field(Quantity; Rec.Quantity)
                {
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
                    RunPageLink = "Table Name" = CONST("Employee Absence"),
                                  "Table Line No." = FIELD("Entry No.");
                }
                separator(Separator31)
                {
                }
                // action("Overview by &Categories")
                // {
                //     Caption = 'Overview by &Categories';
                //     RunObject = Page Page39012034;
                //     RunPageLink = Field47=FIELD("Employee No.");
                // }
                action("Overview by &Periods")
                {
                    Caption = 'Overview by &Periods';
                    RunObject = Page "Bank Code Card";
                }
                separator(Separator1102754000)
                {
                }
                action("Compute Bonus")
                {
                    Caption = 'Compute Bonus';

                    trigger OnAction()
                    var
                        lvPayrollSetup: Record "Payroll Setups";
                    begin
                        if lvPayrollSetup.Get(Rec."Payroll Code") then
                            if lvPayrollSetup."Bonuses Exist" then
                             // CODEUNIT.Run(CODEUNIT::Codeunit39019901, Rec)
                             // else exit;
                             ;
                    end;
                }
                separator(Separator1000000013)
                {
                }
                action("Get Attendance Details...")
                {
                    Caption = 'Get Attendance Details...';
                }
                action("Get Absence Details...")
                {
                    Caption = 'Get Absence Details...';
                }
                separator(Separator1000000014)
                {
                }
                action(Archive)
                {
                    Caption = 'Archive';

                    trigger OnAction()
                    var
                        EmpAbsenceArchive: Record "Employee Absence Archive2";
                        Text001: Label 'Do you want to archive the record?';
                        lvTimeRegistration: Record "Employee Absence";
                        lvHRCommentLine: Record "Human Resource Comment Line";
                        lvHRCommentLine2: Record "Human Resource Comment Line";
                    begin
                        if not Confirm(Text001, false) then
                            exit
                        else begin
                            lvTimeRegistration.CopyFilters(Rec);
                            lvTimeRegistration.FindFirst;
                            repeat
                                //BEGIN
                                EmpAbsenceArchive.Init;
                                EmpAbsenceArchive.TransferFields(lvTimeRegistration);
                                EmpAbsenceArchive."Archived By" := UserId;
                                EmpAbsenceArchive."Date Archived" := WorkDate;
                                EmpAbsenceArchive."Time Archived" := Time;
                                EmpAbsenceArchive.Insert;
                                //transfer comments cmm 270511
                                lvHRCommentLine.Reset;
                                lvHRCommentLine.SetRange(lvHRCommentLine."Table Name", lvHRCommentLine."Table Name"::"Employee Absence");
                                lvHRCommentLine.SetRange("Table Line No.", Rec."Entry No.");
                                if lvHRCommentLine.FindFirst then begin
                                    repeat
                                        lvHRCommentLine2.Init;
                                        lvHRCommentLine2.TransferFields(lvHRCommentLine);
                                        lvHRCommentLine2."Table Name" := lvHRCommentLine2."Table Name"::Employee;
                                        lvHRCommentLine2.Insert;
                                    until lvHRCommentLine.Next = 0;
                                    lvHRCommentLine.DeleteAll;
                                end;
                            //end cmm
                            until lvTimeRegistration.Next = 0;
                            lvTimeRegistration.DeleteAll;
                        end;
                        Clear(lvTimeRegistration);
                        CurrPage.Update;
                    end;
                }
                separator(Separator1000000016)
                {
                }
                action("Suggest Employee Attendance")
                {
                    Caption = 'Suggest Employee Attendance';

                    trigger OnAction()
                    var
                        lvAbsenceRegister: Record "Employee Absence";
                        lvLastEntryNo: BigInteger;
                        lvEmp: Record Employee;
                        lvPayrollSetup: Record "Payroll Setups";
                        lvEmpAbsence: Record "Employee Absence";
                        lvEmpAbsence2: Record "Employee Absence";
                        lvWindow: Dialog;
                        lvFromDate: Date;
                        lvToDate: Date;
                        lvCurrDate: Date;
                        NonWorkingDay: Boolean;
                    begin

                        if lvAbsenceRegister.FindLast then
                            lvLastEntryNo := lvAbsenceRegister."Entry No.";

                        //cmm 260511 get the dates to run through
                        if FromDate = 0D then
                            lvFromDate := WorkDate
                        else
                            lvFromDate := FromDate;
                        if ToDate = 0D then
                            lvToDate := WorkDate
                        else
                            lvToDate := ToDate;
                        lvCurrDate := lvFromDate;
                        lvPayrollSetup.Get(getPayrollCode);
                        //end cmm

                        lvWindow.Open('Processing Date #1########\Employee No.    #2########');
                        repeat
                            lvWindow.Update(1, lvCurrDate);
                            lvEmp.Reset;
                            // lvEmp.SETRANGE("Clocking Employee", FALSE);
                            //lvEmp.SETFILTER(lvEmp."Base Calendar Code",'<>%','' );
                            lvEmp.SetFilter("Payroll Code", getPayrollCode);
                            if lvEmp.FindFirst then begin
                                // lvWindow.OPEN('Processing Employee No.    #2######');
                                repeat
                                    lvWindow.Update(2, lvEmp."No.");
                                    NonWorkingDay := false;
                                    //ICS 2016
                                    //IF lvEmp."Base Calendar Code"<>'' THEN BEGIN
                                    //NonWorkingDay:= CheckForNonWorkingDay(lvCurrDate,lvEmp."Base Calendar Code");
                                    lvEmpAbsence2.Init;
                                    lvLastEntryNo += 1;
                                    lvEmpAbsence2."Entry No." := lvLastEntryNo;
                                    lvEmpAbsence2.Validate("Employee No.", lvEmp."No.");
                                    lvEmpAbsence2."From Date" := lvCurrDate;
                                    //lvEmpAbsence2.VALIDATE(Quantity, lvCalendarChange."Max Daily Working Hrs");
                                    lvEmpAbsence2."Payroll Code" := lvEmp."Payroll Code";
                                    //   lvEmpAbsence2."Org. Unit":= payrollbatch;
                                    lvEmpAbsence2."Global Dimension 1 Code" := lvEmp."Global Dimension 1 Code";
                                    lvEmpAbsence2.Insert;
                                //END;
                                until lvEmp.Next = 0;
                            end;
                            lvCurrDate := CalcDate('1D', lvCurrDate);
                        until lvCurrDate > lvToDate;
                        lvWindow.Close;
                    end;
                }
                action("Lost Hours Deduction")
                {
                    Caption = 'Lost Hours Deduction';

                    trigger OnAction()
                    var
                        lvPayrollSetup: Record "Payroll Setups";
                        lvEmployeeAbsence: Record "Employee Absence";
                        lvEmpAbsence2: Record "Employee Absence";
                        lvLastEntryNo: Integer;
                        lvWorkingQty: Decimal;
                        lvEmployee: Record Employee;
                        lvRegisteredQty: Decimal;
                    begin
                        lvPayrollSetup.Get(Rec."Payroll Code");
                        lvEmpAbsence2.Reset;
                        lvEmpAbsence2.FindLast;
                        lvLastEntryNo := lvEmpAbsence2."Entry No.";
                        lvEmployeeAbsence.Reset;
                        lvEmployeeAbsence.CopyFilters(Rec);
                        lvEmployeeAbsence.FindFirst;
                        lvEmpAbsence2.LockTable;
                        repeat
                            lvWorkingQty := 0;
                            lvRegisteredQty := 0;
                            lvEmployee.Get(lvEmployeeAbsence."Employee No.");
                            //IF lvEmployee."Base Calendar Code" <> '' THEN
                            //lvWorkingQty:= getMaxWorkingHrs(lvEmployeeAbsence."From Date",lvEmployee."Base Calendar Code");


                            //get registered hours for the employee for the day minus the leave hours registered in the Time Registration
                            lvEmpAbsence2.Reset;
                            lvEmpAbsence2.SetRange("Employee No.", lvEmployeeAbsence."Employee No.");
                            lvEmpAbsence2.SetRange("From Date", lvEmployeeAbsence."From Date");
                            if lvEmpAbsence2.FindFirst then
                                repeat
                                    lvRegisteredQty += Abs(lvEmpAbsence2.Quantity);
                                until lvEmpAbsence2.Next = 0;

                            if lvRegisteredQty < lvWorkingQty then begin
                                //insert leave deduction lines
                                lvEmpAbsence2.Init;
                                lvLastEntryNo += 1;
                                lvEmpAbsence2."Entry No." := lvLastEntryNo;
                                lvEmpAbsence2.Validate("Employee No.", lvEmployeeAbsence."Employee No.");
                                lvEmpAbsence2."From Date" := lvEmployeeAbsence."From Date";
                                lvEmpAbsence2.Validate("Cause of Absence Code", lvPayrollSetup."Lost Hours Registration Type");
                                lvEmpAbsence2.Validate(Quantity, lvWorkingQty - lvRegisteredQty);
                                //lvEmpAbsence2.VALIDATE("Unit of Measure Code",lvEmployeeAbsence."Unit of Measure Code");
                                lvEmpAbsence2."Payroll Code" := lvEmployeeAbsence."Payroll Code";
                                //        lvEmpAbsence2."Org. Unit":= payrollbatch;
                                lvEmpAbsence2."Global Dimension 1 Code" := lvEmployeeAbsence."Global Dimension 1 Code";
                                lvEmpAbsence2."Global Dimension 2 Code" := lvEmployeeAbsence."Global Dimension 2 Code";
                                lvEmpAbsence2.Insert;
                            end;
                        until lvEmployeeAbsence.Next = 0;

                        //SETCURRENTKEY("Employee No.","Cause of Absence Code","From Date");

                        //SETRANGE("Cause of Absence Code", lvPayrollSetup."Lost Hours Registration Type");
                        //Compute a month's working hours
                        //Compute lost hours for the month
                        //use this formula: (Basic Pay) /(Working Hours in a Month) *(Lost Hours in a Month)
                        //Use ED code linked to Lost Hour's Cause of Absence to populate Payroll Entry for payroll processing.
                    end;
                }
                separator(Separator1000000018)
                {
                }
                action(Approve)
                {
                    Caption = 'Approve';
                    Image = Approve;

                    trigger OnAction()
                    var
                        lvTimeRegFrm: Page "Time Registration";
                        lvUserSetup: Record "User Setup";
                    begin

                        /*
                        //IF lvUserSetup.GET(USERID) AND NOT lvUserSetup."Approve Time Registration" THEN
                          //ERROR('You do not have permission to approve time registration lines');
                        lvTimeRegFrm.SETTABLEVIEW(Rec);
                        CLEAR(EmpFilter);
                        CLEAR(EmpAbs);
                        EmpFilter := GETFILTERS();
                        IF EmpFilter <> '' THEN BEGIN
                          EmpAbs.COPYFILTERS(Rec);
                          IF EmpAbs.FINDFIRST THEN REPEAT
                            IF EmpAbs."Approval Status" <> EmpAbs."Approval Status"::"1" THEN
                              BEGIN
                                EmpAbs.VALIDATE(EmpAbs."Approval Status", EmpAbs."Approval Status"::"1");
                                EmpAbs.MODIFY
                              END;
                          UNTIL EmpAbs.NEXT = 0;
                        END ELSE BEGIN
                          EmpAbs.RESET;
                          IF EmpAbs.FINDFIRST THEN REPEAT
                            CurrPage.SETSELECTIONFILTER(EmpAbs);
                            IF EmpAbs."Approval Status" <> EmpAbs."Approval Status"::"1" THEN
                              BEGIN
                                EmpAbs.VALIDATE(EmpAbs."Approval Status", EmpAbs."Approval Status"::"1");
                                EmpAbs.MODIFY
                              END;
                          UNTIL EmpAbs.NEXT = 0;
                        END;
                         CLEAR(lvTimeRegFrm);
                         */

                    end;
                }
                action(Reopen)
                {
                    Caption = 'Reopen';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        lvTimeRegFrm: Page "Time Registration";
                    begin
                        lvTimeRegFrm.SetTableView(Rec);
                        Clear(EmpFilter);
                        /*
                        CLEAR(EmpAbs);
                        EmpFilter := GETFILTERS();
                        IF EmpFilter <> '' THEN BEGIN
                          EmpAbs.COPYFILTERS(Rec);
                          IF EmpAbs.FINDFIRST THEN REPEAT
                            IF EmpAbs."Approval Status" <> EmpAbs."Approval Status"::"0" THEN
                              BEGIN
                                EmpAbs.VALIDATE(EmpAbs."Approval Status", EmpAbs."Approval Status"::"0");
                                EmpAbs.MODIFY
                              END;
                          UNTIL EmpAbs.NEXT = 0;
                        END ELSE BEGIN
                          EmpAbs.RESET;
                          IF EmpAbs.FINDFIRST THEN REPEAT
                            CurrPage.SETSELECTIONFILTER(EmpAbs);
                            IF EmpAbs."Approval Status" <> EmpAbs."Approval Status"::"0" THEN
                              BEGIN
                                EmpAbs.VALIDATE(EmpAbs."Approval Status", EmpAbs."Approval Status"::"0");
                                EmpAbs.MODIFY
                              END;
                          UNTIL EmpAbs.NEXT = 0;
                        END;
                        
                        CLEAR(lvTimeRegFrm);
                        */

                    end;
                }
            }
        }
    }

    trigger OnClosePage()
    begin
        gsSegmentPayrollData; //skm150506
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
        gsSegmentPayrollData; //skm150506

        //
        /*
        "Org. Unit":=payrollbatch ;
        SETRANGE("Org. Unit","Org. Unit");
        FILTERGROUP(0);
        */

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
        lvSession: Record Session;
    begin
        /*lvSession.SETRANGE("My Session", TRUE);
        lvSession.FINDFIRST; //fire error in absence of a login
        IF lvSession."Login Type" = lvSession."Login Type"::None THEN
          lvAllowedPayrolls.SETRANGE("User ID", USERID)
        ELSE
          lvAllowedPayrolls.SETRANGE("User ID", USERID);
        lvAllowedPayrolls.SETRANGE("Last Active Payroll", TRUE);
        IF lvAllowedPayrolls.FINDFIRST THEN
          EXIT(lvAllowedPayrolls."Payroll Code");*/

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
        /*lvnonworking:=FALSE;
        lvCount:=0;
        
        lvday:=DATE2DWY(date, 1);
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
        EXIT(FALSE); */

    end;

    procedure getEmployeeTeam(EmpNo: Code[20]; WhichDate: Date): Code[20]
    var
        lvLicensePermission: Record "License Permission";
    begin
        /*lvLicensePermission.GET(lvLicensePermission."Object Type"::TableData, DATABASE::Table39020003);
        IF lvLicensePermission."Execute Permission" = lvLicensePermission."Execute Permission"::Yes THEN BEGIN
           lvShiftTeamMember.SETRANGE("Employee No.",EmpNo);
           lvShiftTeamMember.SETFILTER("Valid-to Date",'%1|>=%2',0D,WhichDate);
           IF lvShiftTeamMember.FINDFIRST THEN BEGIN
            REPEAT
                 IF lvTeamShift.GET(lvShiftTeamMember."Team Code") AND ((lvTeamShift."Valid-To">=WhichDate) OR
                 (lvTeamShift."Valid-To"=0D)) THEN EXIT(lvShiftTeamMember."Team Code");
            UNTIL lvShiftTeamMember.NEXT=0;
           END;
        END;
        EXIT('');*/

    end;

    procedure getMaxWorkingHrs(date: Date; calendarCode: Code[10]): Decimal
    var
        lvday: Integer;
        lvweek: Integer;
        lvbaseDate: Date;
        lvbaseDay: Integer;
        lvbaseSystem: Integer;
        lvCount: Integer;
    begin
        lvCount := 0;

        lvday := Date2DWY(date, 1);
        /*
        //check if the day is set for a particular no. of hours
        BaseCalChange.RESET;
        BaseCalChange.SETFILTER("Base Calendar Code",'%1',calendarCode);
        BaseCalChange.SETRANGE("Recurring System",BaseCalChange."Recurring System"::"0");
        BaseCalChange.SETRANGE(Date,date);
        IF BaseCalChange.FIND('-') THEN EXIT(BaseCalChange."Max Daily Working Hrs");
        
        BaseCalChange.RESET;
        BaseCalChange.SETFILTER("Base Calendar Code",'%1',calendarCode);
        BaseCalChange.SETRANGE("Recurring System",BaseCalChange."Recurring System"::"1");
        IF BaseCalChange.FIND('-') THEN BEGIN
          REPEAT
            IF (DATE2DMY(date,1) = DATE2DMY(BaseCalChange.Date,1)) AND (DATE2DMY(date,2) = DATE2DMY(BaseCalChange.Date,2))
                  THEN
            EXIT(BaseCalChange."Max Daily Working Hrs");
          UNTIL BaseCalChange.NEXT=0;
        END;
        
        BaseCalChange.RESET;
        BaseCalChange.SETFILTER("Base Calendar Code",'%1',calendarCode);
        BaseCalChange.SETRANGE("Recurring System",BaseCalChange."Recurring System"::"2");
        BaseCalChange.SETRANGE(BaseCalChange.Day,DATE2DWY(date,1));
        IF BaseCalChange.FIND('-') THEN
           EXIT(BaseCalChange."Max Daily Working Hrs");
        
        EXIT(0);*/

    end;

    local procedure FromDateOnAfterValidate()
    begin
        if ((FromDate <> 0D) or (ToDate <> 0D)) then begin
            Rec.SetCurrentKey("Employee No.", "From Date");
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
            Rec.SetCurrentKey("Employee No.", "From Date");
            //SETRANGE("Org. Unit",OrgUnit)
        end else
            Rec.Reset;
    end;

    local procedure SuperVisOnAfterValidate()
    begin
        /*IF SuperVis <> '' THEN
          //SETFILTER(Supervisor,'=%1',SuperVis)
        ELSE
          RESET; */

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

