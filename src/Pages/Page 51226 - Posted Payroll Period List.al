page 51226 "Posted Payroll Period List"
{
    CardPageID = "Payroll Period Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    Permissions = TableData Periods = rimd;
    SourceTable = Periods;
    SourceTableView = WHERE(Status = CONST(Posted));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Period ID"; Rec."Period ID")
                {
                    Visible = false;
                }
                field("Period Month"; Rec."Period Month")
                {
                    Visible = true;
                }
                field("Period Year"; Rec."Period Year")
                {
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("NHIF Period Start"; Rec."NHIF Period Start")
                {
                    Visible = false;
                }
                field(Hours; Rec.Hours)
                {
                }
                field(Days; Rec.Days)
                {
                }
                field("Tax Penalties"; Rec."Tax Penalties")
                {
                    Visible = false;
                }
                field("Annualize TAX"; Rec."Annualize TAX")
                {
                }
                field("Low Interest Benefit %"; Rec."Low Interest Benefit %")
                {
                }
                field("Approval Status"; Rec."Approval Status")
                {
                }
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(51151),
                              "No." = FIELD("Document No");
            }
            systempart(Control32; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action(OverallCompanyPayslip)
            {
                Caption = 'Overall Company Payslip';
                Image = "Report";
                Promoted = false;

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        OverallCompanyPayslip.SetTableView(Periods);
                        OverallCompanyPayslip.Run;
                    end;
                end;
            }
            action(CompanyPayslip)
            {
                Caption = 'CompanyPayslip';
                Image = "Report";

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        CompanyPayslip.SetTableView(Periods);
                        CompanyPayslip.Run;
                    end;
                end;
            }
            action("Master Roll Report")
            {
                Caption = 'Master Roll Report';
                Image = "Report";

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        MasterRollReport.SetTableView(Periods);
                        MasterRollReport.Run;
                    end;
                end;
            }
            separator(Separator28)
            {
            }
            action(PayrollAllowanceReport)
            {
                Caption = 'Leave Allowance Report';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        PayrollAllowanceReport.SetTableView(Periods);
                        PayrollAllowanceReport.Run;
                    end;
                end;
            }
            action(EdReport)
            {
                Caption = ' ED Report';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        EDReport.SetTableView(Periods);
                        EDReport.Run;
                    end;
                end;
            }
            action(Payslips)
            {
                Caption = 'Payslips';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        Payslips.SetTableView(Periods);
                        Payslips.Run;
                    end;
                end;
            }
            separator(Separator19)
            {
            }
            action(PayrollReconciliation)
            {
                Caption = 'Payroll Reconciliation-All ED';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        PayrollReconciliationAllED.SetTableView(Periods);
                        PayrollReconciliationAllED.Run;
                    end;
                end;
            }
            action(PayrollReconciliationPerEd)
            {
                Caption = 'Payroll Reconciliation-Per ED';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        PayrollReconciliationPerED.SetTableView(Periods);
                        PayrollReconciliationPerED.Run;
                    end;
                end;
            }
            action(BankPaymentList)
            {
                Caption = 'Bank Payment List';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        BankPaymentList.SetTableView(Periods);
                        BankPaymentList.Run;
                    end;
                end;
            }
            action(BankPaymentReport)
            {
                Caption = 'Salaries Bank Payment';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        BankPaymentReport.SetTableView(Periods);
                        BankPaymentReport.Run;
                    end;
                end;
            }
            separator(Separator13)
            {
            }
            action(PensionReport)
            {
                Caption = 'Pension Report';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        PensionReport.SetTableView(Periods);
                        PensionReport.Run;
                    end;
                end;
            }
            action(NSSFReport)
            {
                Caption = 'NSSF Report';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        NSSFReport.SetTableView(Periods);
                        NSSFReport.Run;
                    end;
                end;
            }
            action(NHIFReport)
            {
                Caption = 'NHIF Report';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        NHIFReport.SetTableView(Periods);
                        NHIFReport.Run;
                    end;
                end;
            }
            action(PayeReport)
            {
                Caption = 'PAYE Report';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        PAYEReport.SetTableView(Periods);
                        PAYEReport.Run;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        //SKM 06/04/00 show history setting but
        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //IF Status <> Status::Open THEN ERROR('You can only edit open periods');
    end;

    trigger OnOpenPage()
    var
        MyPeriod: Record Periods;
    begin
        gsSegmentPayrollData; //skm150506
        MyPeriod.SetRange(MyPeriod.Status, MyPeriod.Status::Open);
        if MyPeriod.Find('-') then Rec := MyPeriod;
    end;

    var
        NHIFReport: Report "NHIF Report";
        NSSFReport: Report "NSSF Report";
        CompanyPayslip: Report "Company Payslip";
        PayrollReconciliationAllED: Report "Payroll Reconciliation-All ED";
        PayrollReconciliationPerED: Report "Payroll Reconciliation-Per ED";
        PAYEReport: Report "PAYE Report";
        Payslips: Report Payslips;
        Periods: Record Periods;
        EDReport: Report "ED Report";
        MasterRollReport: Report "Master Roll Report";
        PayrollAllowanceReport: Report "Payroll Allowance Report";
        PensionReport: Report "Pension Report";
        BankPaymentList: Report "Bank Payment List";
        BankPaymentReport: Report "Bank Payment Report";
        OverallCompanyPayslip: Report "Overall Company Payslip";

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
