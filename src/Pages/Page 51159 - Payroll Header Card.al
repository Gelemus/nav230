page 51159 "Payroll Header Card"
{
    DeleteAllowed = false;
    PageType = Document;
    Permissions = TableData "Payroll Header" = rimd,
                  TableData "Payroll Lines" = rimd,
                  TableData "Payroll Entry" = rimd,
                  TableData "Periods" = rimd;
    SourceTable = "Payroll Header";

    layout
    {
        area(content)
        {
            group(Control1)
            {
                Caption = 'Payroll';
                field("Payroll ID"; Rec."Payroll ID")
                {
                    Editable = false;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                }
                field("First Name"; Rec."First Name")
                {
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    Editable = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                }
                field("Employee no."; Rec."Employee no.")
                {
                    Editable = false;
                }
                field("Total Payable (LCY)"; Rec."Total Payable (LCY)")
                {
                }
                field("Total Benefit (LCY)"; Rec."Total Benefit (LCY)")
                {
                }
                field("Total Income"; "Total Income")
                {
                    Caption = 'Total Income';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Total Deduction (LCY)"; Rec."Total Deduction (LCY)")
                {
                }
                field("<Total Payments>"; "Total Payments")
                {
                    Caption = 'Net Payment';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Total Other (LCY)"; Rec."Total Other (LCY)")
                {
                }
                field(Calculated; Rec.Calculated)
                {
                    Editable = false;
                }
                field("Pay Leave"; Rec."Pay Leave")
                {
                }
            }
            group(P9A)
            {
                Caption = 'P9A';
                field("A (LCY)"; Rec."A (LCY)")
                {
                    Editable = false;
                }
                field("B (LCY)"; Rec."B (LCY)")
                {
                    Editable = false;
                }
                field("C (LCY)"; Rec."C (LCY)")
                {
                    Editable = false;
                }
                field("D (LCY)"; Rec."D (LCY)")
                {
                    Editable = false;
                }
                field("E1 (LCY)"; Rec."E1 (LCY)")
                {
                    Editable = false;
                }
                field("E2 (LCY)"; Rec."E2 (LCY)")
                {
                    Editable = false;
                }
                field("E3 (LCY)"; Rec."E3 (LCY)")
                {
                    Editable = false;
                }
                field("F (LCY)"; Rec."F (LCY)")
                {
                    Editable = false;
                }
                field("G (LCY)"; Rec."G (LCY)")
                {
                    Editable = false;
                }
                field("H (LCY)"; Rec."H (LCY)")
                {
                    Editable = false;
                }
                field("J (LCY)"; Rec."J (LCY)")
                {
                    Editable = false;
                }
                field("K (LCY)"; Rec."K (LCY)")
                {
                    Editable = false;
                }
                field("L (LCY)"; Rec."L (LCY)")
                {
                    Editable = false;
                }
                field("M (LCY)"; Rec."M (LCY)")
                {
                    Editable = false;
                }
            }
            part(PayrollEntriesEarnings; "Payroll Entry")
            {
                Caption = 'Payroll Entries Earnings';
                SubPageLink = "Payroll ID" = FIELD("Payroll ID"),
                              "Employee No." = FIELD("Employee no."),
                              "Calculation Group" = FILTER(Payments);
            }
            part(PayrollEntriesDedeuctions; "Payroll Entry")
            {
                Caption = 'Payroll Entries Deductions';
                SubPageLink = "Payroll ID" = FIELD("Payroll ID"),
                              "Employee No." = FIELD("Employee no."),
                              "Calculation Group" = CONST(Deduction);
            }
            part("Calculated Earnings/Deductions"; "Calculated Earnings/Deductions")
            {
                Caption = 'Calculated Earnings/Deductions';
                SubPageLink = "Payroll ID" = FIELD("Payroll ID"),
                              "Employee No." = FIELD("Employee no."),
                              "Calculation Group" = FILTER(Payments | Deduction);
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Payroll)
            {
                Caption = 'Payroll';
                separator(Separator48)
                {
                }
                action("Calculate Payroll")
                {
                    Caption = 'Calculate Payroll';
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = true;

                    trigger OnAction()
                    begin
                        //CurrPage.UPDATE(TRUE);
                        CODEUNIT.Run(CODEUNIT::"Calculate One Payroll", Rec);
                    end;
                }
                action(Payslip)
                {
                    Caption = 'Payslip';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        lvPayslip: Report Payslips;
                        lvPayrollLine: Record "Payroll Lines";
                        lvPeriods: Record Periods;
                        lvEmployee: Record Employee;
                    begin
                        lvPeriods.SetRange("Period ID", Rec."Payroll ID");
                        lvEmployee.SetRange("No.", Rec."Employee no.");
                        lvPayslip.SetTableView(lvPeriods);
                        lvPayslip.SetTableView(lvEmployee);
                        lvPayslip.RunModal;
                    end;
                }
                separator(Separator49)
                {
                }
                action("Insert Payroll")
                {
                    Caption = 'Insert Payroll';
                    Image = Insert;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        lvInsertIntoPeriod: Record Periods;
                        lvAllowedPayrolls: Record "Allowed Payrolls";
                        lvPeriods: Record Periods;
                        lvPayrollMonth: Integer;
                        lvPayrollYear: Integer;
                    begin
                        //skm230409 revised to be able to insert the first payroll while ensuring Payroll ID is not blank.
                        if Rec."Payroll ID" <> '' then
                            lvInsertIntoPeriod.Get(Rec."Payroll ID", Rec."Payroll Month", Rec."Payroll Year", Rec."Payroll Code")
                        else begin
                            lvAllowedPayrolls.SetRange("Last Active Payroll", true);
                            if lvAllowedPayrolls.FindFirst then begin
                                //Message('test1');
                                Rec.SetRange("Payroll Code", lvAllowedPayrolls."Payroll Code")
                            end
                            else
                                Error('You did not select a payroll during login or are not allowed access to any payroll dataset.');

                            //Message('test2');
                            lvInsertIntoPeriod.SetRange("Payroll Code", lvAllowedPayrolls."Payroll Code");
                            lvInsertIntoPeriod.SetRange(lvInsertIntoPeriod.Status, lvInsertIntoPeriod.Status::Open);
                            if GuiAllowed then
                                if not (ACTION::LookupOK = PAGE.RunModal(PAGE::"Payroll Periods", lvInsertIntoPeriod)) then begin
                                    Message('You have cancelled new payroll insertion.');
                                    exit
                                end;
                            Message('test3');

                        end;

                        if ACTION::LookupOK = PAGE.RunModal(PAGE::"Employee List", Employee) then begin
                            Name := Employee."First Name" + ' ' + Employee."Last Name";

                            //Payroll Month 0 Payroll Year 0 error
                            if ((lvInsertIntoPeriod."Period Month" = 0) or (lvInsertIntoPeriod."Period Year" = 0)) then begin
                                lvPeriods.SetRange("Period ID", lvInsertIntoPeriod."Period ID");
                                lvPeriods.SetRange("Payroll Code", lvAllowedPayrolls."Payroll Code");
                                if lvPeriods.FindFirst then begin
                                    lvPayrollMonth := lvPeriods."Period Month";
                                    lvPayrollYear := lvPeriods."Period Year";
                                end;
                            end else begin
                                lvPayrollMonth := lvInsertIntoPeriod."Period Month";
                                lvPayrollYear := lvInsertIntoPeriod."Period Year";
                            end;
                            //END Payroll Month 0 Payroll Year 0 error

                            if Confirm('Do you want to insert\%1\in payroll period\%2', false, Name, lvInsertIntoPeriod."Period ID") then begin
                                Rec."Payroll ID" := lvInsertIntoPeriod."Period ID";
                                Rec."Employee no." := Employee."No.";
                                //Payroll Month 0 Payroll Year 0 error. Original lines commented
                                //"Payroll Month" := lvInsertIntoPeriod."Period Month";
                                //"Payroll Year" := lvInsertIntoPeriod."Period Year";
                                Rec."Payroll Month" := lvPayrollMonth;
                                Rec."Payroll Year" := lvPayrollYear;
                                //END Payroll Month 0 Payroll Year 0 error
                                if not Rec.Insert(true) then
                                    Message('The employee already exits.')
                            end;

                            Rec.Get(Rec."Payroll ID", Employee."No.");
                        end;
                    end;
                }
                action("Delete Employee")
                {
                    Caption = 'Delete Employee';
                    Image = Delete;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('This will remove this employee from the current months payroll, Continue', false) then
                            Rec.Delete(true)
                        else
                            Message('Operation Cancelled');
                    end;
                }
                separator(Separator1102754009)
                {
                }
            }
        }
        area(navigation)
        {
            action(Dimensions)
            {
                Caption = 'Dimensions';
                Image = Dimensions;

                trigger OnAction()
                begin
                    Rec.ShowPayrollDim;
                end;
            }
            action("List Employee")
            {
                Caption = 'List Employee';
                //     Image = List;
                //     Promoted = true;
                //     PromotedCategory = Category4;

                //     trigger OnAction()
                //     begin
                //         if ACTION::LookupOK = PAGE.RunModal(PAGE::"Employee List", Employee) then
                //             if not Rec.Get(Rec."Payroll ID", Employee."No.") then
                ;
                //     end
            }
            action("Employee Card")
            {
                Caption = 'Employee Card';
                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Employee Card";

                trigger OnAction()
                var
                    lvEmployee: Record Employee;
                begin
                    lvEmployee.SetRange("No.", Rec."Employee no.");
                    PAGE.Run(PAGE::"Employee Card", lvEmployee);
                end;
            }
            action("Non Payroll Receipts")
            {
                Caption = 'Non Payroll Receipts';
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Non Payroll Receipts";
                RunPageLink = "Employee No" = FIELD("Employee no.");
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        "Total Income" := (Rec."Total Payable (LCY)" + Rec."Total Benefit (LCY)");
        Rec."Total Payable (LCY)" := "Total Income";
        "Total Payments" := Rec."Total Payable (LCY)" - Rec."Total Deduction (LCY)";
        //CALCFIELDS("Mid Month Advance Code", "Advance (LCY)");
    end;

    trigger OnOpenPage()
    begin
        gsSegmentPayrollData; //skm150506
        Rec.SetCurrentKey(Posted);
        Rec.FilterGroup := 2;
        Rec.SetRange(Posted, false);
        Rec.FilterGroup := 0;
    end;

    var
        Employee: Record Employee;
        Periods: Record Periods;
        FilteredHeader: Record "Payroll Header";
        CalcPayrollCodeUnit: Codeunit "Calculate All Payrolls";
        "Total Payments": Decimal;
        "Total Income": Decimal;
        Name: Text[50];
        PayrollEntry: Record "Payroll Entry";
        PayrollLines: Record "Payroll Lines";

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

