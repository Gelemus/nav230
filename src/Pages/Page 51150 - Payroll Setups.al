page 51150 "Payroll Setups"
{
    // V.6.1.65_07SEP10  :Added One Field <Leave Travel Allowance ED>

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Payroll Setups";

    layout
    {
        area(content)
        {
            group(Payroll)
            {
                Caption = 'Payroll';
                field("PAYE ED Code"; Rec."PAYE ED Code")
                {
                }
                field("Nssf Tier 1 Employee"; Rec."Nssf Tier 1 Employee")
                {
                }
                field("Nssf Tier 1 Employer"; Rec."Nssf Tier 1 Employer")
                {
                }
                field("Nssf Tier 2 Employee"; Rec."Nssf Tier 2 Employee")
                {
                }
                field("Nssf Tier 2  Employer"; Rec."Nssf Tier 2  Employer")
                {
                }
                field("Nssf Voluntary"; Rec."Nssf Voluntary")
                {
                }
                field("NSSF ED Code"; Rec."NSSF ED Code")
                {
                }
                field("NSSF Company Contribution"; Rec."NSSF Company Contribution")
                {
                }
                field("NHIF ED Code"; Rec."NHIF ED Code")
                {
                }
                field("Pension ED Code"; Rec."Pension ED Code")
                {
                    Caption = 'Pension Employee';
                }
                field("Pension ED Code Employer"; Rec."Pension ED Code Employer")
                {
                }
                field("Pension 2 ED Code"; Rec."Pension 2 ED Code")
                {
                }
                field("Pension 2 Employer ED Code"; Rec."Pension 2 Employer ED Code")
                {
                }
                field("Pension 3 ED Code"; Rec."Pension 3 ED Code")
                {
                }
                field("Gross Pay Code"; Rec."Gross Pay  Code")
                {
                }
                field("Pension 3 Employer ED Code"; Rec."Pension 3 Employer ED Code")
                {
                }
                field("Gratitude ED Code"; Rec."Gratitude ED Code")
                {
                }
                field("Gratuity Percentage"; Rec."Gratuity Percentage")
                {
                }
                field("Gratuity Tax Exempt"; Rec."Gratuity Tax Exempt")
                {
                }
                field("Gratuity Tax Rate"; Rec."Gratuity Tax Rate")
                {
                }
                field("Tax Relief Code"; Rec."Tax Relief Code")
                {
                }
                field("Interest Benefit"; Rec."Interest Benefit")
                {
                }
                field("Tax on Lump Sum ED"; Rec."Tax on Lump Sum ED")
                {
                }
                field("Pension Lumpsom Contribution"; Rec."Pension Lumpsom Contribution")
                {
                }
                field("Mid Month ED Code"; Rec."Mid Month ED Code")
                {
                }
                field("Tax Calculation"; Rec."Tax Calculation")
                {
                }
                field("NITA Amount"; Rec."NITA Amount")
                {
                }
                field("Leave Travel Allowance ED"; Rec."Leave Travel Allowance ED")
                {
                }
                field("Leave Advance Payment ED"; Rec."Leave Advance Payment ED")
                {
                }
                field("Personal Account Recoveries ED"; Rec."Personal Account Recoveries ED")
                {
                }
                field("Make Personal A/C Recoveries"; Rec."Make Personal A/C Recoveries")
                {
                }
                field("Income Brackets Rate"; Rec."Income Brackets Rate")
                {
                }
                field("Net Pay Rounding Precision"; Rec."Net Pay Rounding Precision")
                {
                }
                field("Insert Special Payments"; Rec."Insert Special Payments")
                {
                }
                field("Overdrawn ED"; Rec."Overdrawn ED")
                {
                }
                field("NHIF Relief Code"; Rec."NHIF Relief Code")
                {
                }
                field("Insurance Relief ED"; Rec."Insurance Relief ED")
                {
                }
                field("Rent Recovery ED"; Rec."Rent Recovery ED")
                {
                }
                field("Net Pay Rounding B/F"; Rec."Net Pay Rounding B/F")
                {
                }
                field("Net Pay Rounding C/F"; Rec."Net Pay Rounding C/F")
                {
                }
                field("Net Pay Rounding B/F (-Ve)"; Rec."Net Pay Rounding B/F (-Ve)")
                {
                }
                field("Net Pay Rounding C/F (-ve)"; Rec."Net Pay Rounding C/F (-ve)")
                {
                }
                field("Net Pay Rounding Mid Amount"; Rec."Net Pay Rounding Mid Amount")
                {
                }
                field("House Allowances ED"; Rec."House Allowances ED")
                {
                }
                field("Salary Arrears Code"; Rec."Salary Arrears Code")
                {
                }
                field("Commuter Allowance ED"; Rec."Commuter Allowance ED")
                {
                }
                field("Lost Hours Registration Type"; Rec."Lost Hours Registration Type")
                {
                }
                field("Leave Advance Loan"; Rec."Leave Advance Loan")
                {
                }
                field("% of Basic Pay to Advance"; Rec."% of Basic Pay to Advance")
                {
                }
                field("Default Cause of Absence"; Rec."Default Cause of Absence")
                {
                    ToolTip = 'Filled for a non-working day in the Time Registration ''Suggest employee attendance''';
                }
            }
            group(Posting)
            {
                Caption = 'Posting';
                field("Payroll Template"; Rec."Payroll Template")
                {
                }
                field("Payroll Batch"; Rec."Payroll Batch")
                {
                }
                field("Loan Template"; Rec."Loan Template")
                {
                }
                field("Loan Payments Batch"; Rec."Loan Payments Batch")
                {
                }
                field("Loan Losses Batch"; Rec."Loan Losses Batch")
                {
                }
                field("Priority to Dims Assigned To"; Rec."Priority to Dims Assigned To")
                {
                }
                field("Auto-Post Payroll Journals"; Rec."Auto-Post Payroll Journals")
                {
                }
                field("Bonuses Exist"; Rec."Bonuses Exist")
                {
                }
                field("Payroll Expense Based On"; Rec."Payroll Expense Based On")
                {
                }
                field("Emp ID in Payroll Posting Jnl"; Rec."Emp ID in Payroll Posting Jnl")
                {
                }
                field("Payroll Base Currency"; Rec."Payroll Base Currency")
                {
                }
            }
            group("Basic Pay")
            {
                Caption = 'Basic Pay';
                field("Basic Pay E/D Code"; Rec."Basic Pay E/D Code")
                {
                }
                field("Daily Rate Rounding"; Rec."Daily Rate Rounding")
                {
                }
                field("Daily Rounding Precision"; Rec."Daily Rounding Precision")
                {
                }
                field("Hourly Rate Rounding"; Rec."Hourly Rate Rounding")
                {
                }
                field("Hourly Rounding Precision"; Rec."Hourly Rounding Precision")
                {
                }
            }
            group(Information)
            {
                Caption = 'Information';
                field("Employer Name"; Rec."Employer Name")
                {
                }
                field("Employer PIN No."; Rec."Employer PIN No.")
                {
                }
                field("Employer NSSF No."; Rec."Employer NSSF No.")
                {
                }
                field("Employer NHIF No."; Rec."Employer NHIF No.")
                {
                }
                field("Employer LASC No."; Rec."Employer LASC No.")
                {
                }
                field("Employers Address"; Rec."Employers Address")
                {
                }
                field("Employer HELB No."; Rec."Employer HELB No.")
                {
                }
                field("Attendance Time Register Code"; Rec."Attendance Time Register Code")
                {
                }
                field("Overtime Time Register Code"; Rec."Overtime Time Register Code")
                {
                }
                field("Absence Time Register Code"; Rec."Absence Time Register Code")
                {
                }
                field("Normal OT ED"; Rec."Normal OT ED")
                {
                }
                field("Normal OT Rate"; Rec."Normal OT Rate")
                {
                }
                field("Weekend OT ED"; Rec."Weekend OT ED")
                {
                }
                field("Weekend OT Rate"; Rec."Weekend OT Rate")
                {
                }
                field("Holiday OT ED"; Rec."Holiday OT ED")
                {
                }
                field("Special Duty ED Code"; Rec."Special Duty ED Code")
                {
                }
                field("Hazard ED Code"; Rec."Hazard ED Code")
                {
                }
                field("Holiday OT Rate"; Rec."Holiday OT Rate")
                {
                }
                field("Payslip Message Footer"; Rec."Payslip Message Footer")
                {
                }
            }
            group("Payroll Transfer")
            {
                Caption = 'Payroll Transfer';
                field("Payroll Transfer Path"; Rec."Payroll Transfer Path")
                {
                }
                field("Bank Code"; Rec."Bank Code")
                {
                }
                field("Bank Account No"; Rec."Bank Account No")
                {
                }
                field("KRA Tax Logo"; Rec."KRA Tax Logo")
                {
                }
            }
            group("Payslip E-mailing")
            {
                Caption = 'Payslip E-mailing';
                field("Payslips Folder"; Rec."Payslips Folder")
                {
                }
                field("Payslips Folder No Email"; Rec."Payslips Folder No Email")
                {
                }
                field("Email Subject"; Rec."Email Subject")
                {
                }
                field("Email Body"; Rec."Email Body")
                {
                }
                field("Email Footer Line 1"; Rec."Email Footer Line 1")
                {
                }
                field("Email Footer Line 2"; Rec."Email Footer Line 2")
                {
                }
                field("Email Footer Line 3"; Rec."Email Footer Line 3")
                {
                }
                field("Email Footer Line 4"; Rec."Email Footer Line 4")
                {
                }
                field("Email Footer Line 5"; Rec."Email Footer Line 5")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("KRA Logo")
            {
                Caption = 'KRA Logo';
                action("Import KRA Logo")
                {
                    Caption = 'Import KRA Logo';
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.Import;
                    end;
                }
                action("Export KRA Logo")
                {
                    Caption = 'Export KRA Logo';
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.ExportAttachment('');
                    end;
                }
                action("Delete KRA Logo")
                {
                    Caption = 'Delete KRA Logo';
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.RemoveAttachment(true);
                        // END;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        lvAllowedPayrolls: Record "Allowed Payrolls";
    begin
        Rec.Reset;
        gsSegmentPayrollData; //skm150506
        lvAllowedPayrolls.SetRange("User ID", UserId);
        lvAllowedPayrolls.SetRange("Last Active Payroll", true);
        lvAllowedPayrolls.FindFirst;
        if not Rec.Get(lvAllowedPayrolls."Payroll Code") then begin
            Rec."Payroll Code" := lvAllowedPayrolls."Payroll Code";
            Rec.Insert;
        end
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
        Rec.FilterGroup(7);

    end;
}

