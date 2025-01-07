page 50585 "Human Resource Officer Profile"
{
    Caption = 'Human Resource & Admin  Manager', Comment = '{Dependency=Match,"ProfileDescription_SHOPSUPERVISOR-FOUNDATION"}';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                ShowCaption = false;
                part(Approvals; "Approvals Activities")
                {
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                }
                part("My Activities"; "Human Resource Cues Page")
                {
                    ApplicationArea = Advanced;
                    Caption = 'My Activities';
                }
                part("Intercompany Activities"; "Intercompany Activities")
                {
                    ApplicationArea = Intercompany;
                }
                part("User Tasks Activities"; "User Tasks Activities")
                {
                    ApplicationArea = Suite;
                }
                part("Emails"; "Email Activities")
                {
                    ApplicationArea = Basic, Suite;
                }
                part(Control123; "Team Member Activities")
                {
                    ApplicationArea = Suite;
                }

                part(Control87; "Team Member Activities No Msgs")
                {
                    ApplicationArea = Suite;
                }

            }
            group(Control1900724708)
            {
                ShowCaption = false;

            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Establishment Report")
            {
                ApplicationArea = Manufacturing;
                Caption = 'Establishment Report';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "HR Jobs";
                ToolTip = 'View Job Positions in the Organization. The report also shows information about Job establishment/positions in the organization.';
                Visible = false;
            }
            action(Action215)
            {
                ApplicationArea = Manufacturing;
                Caption = 'Retirement Age Report';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Retirement Age Report";
                ToolTip = 'View Job Positions in the Organization. The report also shows information about Job establishment/positions in the organization.';
                Visible = false;
            }
            action("Employees Statement")
            {
                ApplicationArea = Manufacturing;
                Caption = 'Employees Statement';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Employees Statement";
                ToolTip = 'View Job Positions in the Organization. The report also shows information about Job establishment/positions in the organization.';
                Visible = false;
            }
            action("Company Staff")
            {
                ApplicationArea = Manufacturing;
                Caption = 'Company Staff';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Company Staff";
                ToolTip = 'View Job Positions in the Organization. The report also shows information about Job establishment/positions in the organization.';
                Visible = false;
            }
            group("Monthly Reports")
            {
                Caption = 'Monthly Reports';
                action("Master Roll Report")
                {
                    Caption = 'Master Roll Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Master Roll Report";
                }
                action("A Third Rule Report")
                {
                    Caption = 'A Third Rule Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "AThird Rule Report";
                }
                action("Master Roll Report-Dimensions")
                {
                    Caption = 'Master Roll Report-Dimensions';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Master Roll Report-Dimensions";
                }
                action("Advance Summary Report")
                {
                    Caption = 'Advance Summary Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Salary Advance Summary Report";
                }
                action("Timesheet Report")
                {
                    Caption = 'Timesheet Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Generate P10 Re";
                    Visible = false;
                }
                action("Company Payslip")
                {
                    Caption = 'Company Payslip';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Company Payslip";
                }
                action("Overall Company Payslip")
                {
                    Caption = 'Overall Company Payslip';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Overall Company Payslip";
                }
                action(Payslip)
                {
                    Caption = 'Payslip';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report Payslips;
                }
                action("ED Report")
                {
                    Caption = 'ED Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "ED Report";
                }
                action("Sacco Report")
                {
                    Caption = 'Sacco Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Sacco Report";
                }
                action("ED Totals Per Period")
                {
                    Caption = 'ED Totals Per Period';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "ED Totals Per Period";
                    Visible = false;
                }
                action(" Bank Payment List")
                {
                    Caption = ' Bank Payment List';
                    Image = Payment;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Bank Payment List";
                }
                action("Staff Gratuity Report")
                {
                    Caption = 'Staff Gratuity Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Staff Gratuity Report";
                }
                action("Institution Based ED Report")
                {
                    Caption = 'Institution Based ED Report';
                    Image = Payment;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Institution Based ED Report";
                    Visible = false;
                }
                action("Insurance  ED Report ")
                {
                    Caption = 'Insurance  ED Report ';
                    Image = Payment;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Institution Based ED Report In";
                }
                action("Check Payment List")
                {
                    Caption = 'Check Payment List';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Check Payment List";
                    Visible = false;
                }
                action(" Cash Payment List")
                {
                    Caption = ' Cash Payment List';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Cash Payment List";
                    Visible = false;
                }
                action("MPESA Payment List")
                {
                    Caption = 'MPESA Payment List';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "MPESA Payment List";
                    Visible = false;
                }
                action("Payroll Reconciliation-Per ED")
                {
                    Caption = 'Payroll Reconciliation-Per ED';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Payroll Reconciliation-Per ED";
                }
                action(" Payroll Reconciliation-All ED")
                {
                    Caption = ' Payroll Reconciliation-All ED';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Payroll Reconciliation-All ED";
                }
                action("Salaries  Bank Payment Report")
                {
                    Caption = 'Salaries  Bank Payment Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Bank Payment2 Report";
                }
            }
            group("Monthly Statutory Reports")
            {
                Caption = 'Monthly Statutory Reports';
                action("NSSF Report")
                {
                    Caption = 'NSSF Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "NSSF ReportII";
                }
                action("NSSF Tier Report")
                {
                    Caption = 'NSSF Tier Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "NSSF Tier Report";
                }
                action("NHIF Report")
                {
                    Caption = 'NHIF Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "NHIF Report";
                }
                action("Affordable Housing Levy Report")
                {
                    Caption = 'Affordable Housing Levy Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Affordable Housing Levy Report";
                }
                action("PAYE Report")
                {
                    Caption = 'PAYE Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "PAYE Report";
                }
                action("Generate P10")
                {
                    Caption = 'Generate P10';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Generate P10";
                }
                action("<Report Pension Report>")
                {
                    Caption = 'Pension Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Pension Report";
                }
            }
            group("Annual Statutory Reports")
            {
                Caption = 'Annual Statutory Reports';
                action("P9A Report")
                {
                    Caption = 'P9A Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "P9A Report";
                }
                action(P10A)
                {
                    Caption = 'P10A';
                    Image = "Report";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report P10A;
                }
                action(P10)
                {
                    Caption = 'P10';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report P10;
                }
                action(P10D)
                {
                    Caption = 'P10D';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report P10D;
                }
                action("NSSF YEARLY REPORT")
                {
                    Caption = 'NSSF YEARLY REPORT';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "NSSF YEARLY REPORT";
                }
                action("<Report  NHIF YEARLY REPORT>")
                {
                    Caption = 'NHIF YEARLY REPORT';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "NHIF YEARLY REPORT";
                }
                action("<Report  CBS>")
                {
                    Caption = 'CBS';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report CBS;
                }
            }
            group("HR Reports")
            {
                Caption = 'HR Reports';
                action("Attendance Report")
                {
                    Caption = 'Attendance Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Attendance Report";
                }
                action("Attendance Summary Report")
                {
                    Caption = 'Attendance Summary Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "AttendanceSummary Report";
                }
                action("Human Resource Staff Report")
                {
                    Caption = 'Human Resource Staff Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Human Resource Staff Report";
                }
                action("Employee Family Details Report")
                {
                    Caption = 'Employee Family Details Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Employee Family Details Report";
                }
                action("Leave Balances Per Period")
                {
                    Caption = 'Leave Balances Per Period';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Leave Balances Per Period";
                }
                action("Employee Leave Balances Summary Monthly")
                {
                    Caption = 'Employee Leave Balances Summary Monthly';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Employee Leave Summary";
                }
                action("Employee Leave Balances Todate")
                {
                    Caption = 'Employee Leave Balances Todate';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Employee Leave Balances";
                }
                action("HR Leave Applications List")
                {
                    Caption = 'HR Leave Applications List';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "HR Leave Applications List";
                }
                action("Employees On Leave")
                {
                    Caption = 'Employees On Leave';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Employees On Leave";
                    Visible = false;
                }
                action("Employees On Leave As At Today")
                {
                    Caption = 'Employees On Leave As At Today';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Employees On Leave As At Today";
                    Visible = false;
                }
                action("<Staff Establishment Report>")
                {
                    Caption = 'Staff Establishment Report';
                    Image = "report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Summary title report";
                    Visible = false;
                }
                action("HR Jobs")
                {
                    Caption = 'HR Jobs';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "HR Jobs";
                }
                action("Casual Payment  Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Casual Payment  Report';
                    Image = "Report";
                    RunObject = Report "Casual Payment  Report";
                    ToolTip = 'View, print, or send a report that shows the balances for the general ledger accounts, including the debits and credits. You can use this report to ensure accurate accounting practices.';
                }
                action("Retirement Age Report")
                {
                    Caption = 'Retirement Age Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Retirement Age Report";
                }
            }
            group(Registry)
            {
                Caption = 'Registry';
                Visible = false;
                action("Released Cheque Report.")
                {
                    Caption = 'Released Cheque Report.';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Released Cheque Report.";
                }
                action("Deposited Cheque Report.")
                {
                    Caption = 'Deposited Cheque Report.';
                    Image = "Report";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Deposited Cheque Report.";
                }
                action("Incoming Mail  Report.")
                {
                    Caption = 'Incoming Mail  Report.';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Incoming Mail  Report.";
                }
                action("Released Letterl  Report.")
                {
                    Caption = 'Released Letterl  Report.';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Released Letterl  Report.";
                }
                action("Sent Letter  Report.")
                {
                    Caption = 'Sent Letter  Report.';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Sent Letterl  Report.";
                }
                action("Oil Requistion  Report.")
                {
                    Caption = 'Oil Requistion  Report.';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Oil Requistion  Report.";
                }
            }
        }
        area(embedding)
        {
            action("Transfer Orders")
            {
                ApplicationArea = Suite;
                Caption = 'Transfer Orders';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Transfer Orders";
                RunPageMode = Create;
                ToolTip = 'Create a new Transfer Orders.';
            }
            action("Posted Transfer Shipments")
            {
                ApplicationArea = Suite;
                Caption = 'Posted Transfer Shipments';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Posted Transfer Shipments";
                RunPageMode = Create;
                ToolTip = 'Posted Transfer Shipments';
            }
            action("Posted Transfer Receipts")
            {
                ApplicationArea = Suite;
                Caption = 'Posted Transfer Receipts';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Posted Transfer Receipts";
                RunPageMode = Create;
                ToolTip = 'Posted Transfer Receipts';
            }
            action("Store Requisitions List")
            {
                Caption = 'Store Requisitions List';
                RunObject = Page "Store Requisitions List";
            }
            action("Pending Store Requisitions")
            {
                Caption = 'Pending Store Requisitions';
                RunObject = Page "Pending Store Requisitions";
            }
            action("Approved Store Requisitions")
            {
                Caption = 'Approved Store Requisitions';
                RunObject = Page "Approved Store Requisitions";
            }
            action("Posted Store Requisitions List")
            {
                Caption = 'Posted Store Requisitions List';
                RunObject = Page "Posted Store Requisitions List";
            }
            action("Cancelled Store Requisitions List")
            {
                Caption = 'Cancelled Store Requisitions List';
                RunObject = Page "Cancel Store Requisitions List";
            }
            action("HR Jobs List")
            {
                Caption = 'HR Jobs List';
                Image = Job;
                RunObject = Page "HR Jobs List";
                ToolTip = 'Shows HR Job List';
            }
            action("Approved HR Jobs List")
            {
                Image = Job;
                RunObject = Page "Approved HR Jobs";
            }
            action("HR Job Grades List")
            {
                Image = GanttChart;
                RunObject = Page "HR Job Grades";
            }
            action("HR Job Values List")
            {
                Image = GanttChart;
                RunObject = Page "HR Job Values";
            }
            action("Risk Register List")
            {
                Image = GanttChart;
                RunObject = Page "Risk Register List";
            }
            action("Risk Register Submitted List")
            {
                Image = GanttChart;
                RunObject = Page "Risk Register Submitted List";
            }
        }
        area(processing)
        {
            group("Human Resource Setup")
            {
                Caption = 'Human Resource Setup';
                Image = LotInfo;
                action("HR Employment Contracts")
                {
                    Caption = 'Employment Contracts';
                    Image = JobListSetup;
                    RunObject = Page "Employment Contracts";
                    ToolTip = 'Human Resource Employment Contracts';
                }
                action("HR Lookup Values")
                {
                    Caption = 'Lookup Values';
                    Image = Hierarchy;
                    RunObject = Page "HR Lookup Values";
                }
                action("County List")
                {
                    Caption = 'County List';
                    Image = List;
                    RunObject = Page "County List";
                    ToolTip = 'County List';
                }
                action("Page Human Resources Setup")
                {
                    Caption = 'HR General Setup';
                    Image = "Order";
                    Promoted = true;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Human Resources Setup";
                    RunPageMode = Create;
                    ToolTip = 'Human Resources General Setup';
                }
                action("ED Definitions")
                {
                    Caption = 'ED Definitions';
                    Image = Job;
                    RunObject = Page "ED Definitions";
                }
                action("Payroll Setups")
                {
                    Caption = 'Payroll Setups';
                    Image = Job;
                    RunObject = Page "Payroll Setups";
                }
                action("Maintanance and repair")
                {
                    Caption = 'Maintanance & repair';
                    RunObject = Page "Maintanance Schedule";
                    ToolTip = 'Maintanance and repair';
                }
            }
            group(Payroll)
            {
                Caption = 'Payroll';
                group(Employees)
                {
                    Caption = 'Employees';
                    action("Payroll Employee List")
                    {
                        Caption = 'Payroll Employee List';
                        Image = Allocate;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Payroll Employee List";
                    }
                    action("Terminated Employee List")
                    {
                        Caption = 'Terminated Employee List';
                        Image = Allocate;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Terminated Employee List";
                    }
                }
                group("Payroll Processing")
                {
                    Caption = 'Payroll Processing';
                    action("Payroll Header List")
                    {
                        Caption = 'Payroll Header List';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Payroll Header List";
                    }
                    action(" Loans/Advances")
                    {
                        Caption = ' Loans/Advances';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Loans/Advances";
                    }
                    action("Loan Entry")
                    {
                        Caption = 'Loan Entry';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Loan Entry";
                    }
                }
                group("Payroll Approvals")
                {
                    Caption = 'Payroll Approvals';
                    action(" Payroll Period List")
                    {
                        Caption = ' Payroll Period List';
                        Image = OpenJournal;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Payroll Period List";
                    }
                    action("Pending Payroll Period List")
                    {
                        Caption = 'Pending Payroll Period List';
                        Image = Calculate;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Pending Payroll Period List";
                    }
                    action("Approved Payroll Period List")
                    {
                        Caption = 'Approved Payroll Period List';
                        Image = GLJournal;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Approved Payroll Period List";
                    }
                    action("Posted Payroll Period List")
                    {
                        Caption = 'Posted Payroll Period List';
                        Image = GetEntries;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Posted Payroll Period List";
                    }
                }
                group("Salary Advance")
                {
                    Caption = 'Salary Advance';
                    action("Salary Advance Applications")
                    {
                        Caption = 'Salary Advance Applications';
                        RunObject = Page "Salary Advance Applications";
                    }
                    action("Salary Advance Pending Approval")
                    {
                        Caption = 'Salary Advance Pending Approval';
                        RunObject = Page "Salary Advance Pending Approvl";
                    }
                    action("Salary Advance Approved")
                    {
                        Caption = 'Salary Advance Approved';
                        RunObject = Page "Salary Advance Approved";
                    }
                    action("Salary Advance posted")
                    {
                        Caption = 'Salary Advance posted';
                        RunObject = Page "Salary Advance posted";
                    }
                }
                group("Periodic Activities")
                {
                    Caption = 'Periodic Activities';
                    action("Open Period")
                    {
                        Caption = 'Open Period';
                        Image = OpenJournal;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Codeunit "Open Period";
                    }
                    action("Calculate All Payrolls")
                    {
                        Caption = 'Calculate All Payrolls';
                        Image = Calculate;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Codeunit "Calculate All Payrolls";
                    }
                    action("General Journals")
                    {
                        Caption = 'General Journals';
                        Image = GLJournal;
                        Promoted = true;
                        PromotedCategory = Process;
                        // RunObject = Page "General Journal";
                    }
                    action("Generate Payroll Journal Entries")
                    {
                        Caption = 'Generate Payroll Journal Entries';
                        Image = GetEntries;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Codeunit "Payroll Posting";
                    }
                }
                group("Payroll Allowances")
                {
                    Caption = 'Payroll Allowances';
                    action("Allowance List- Open")
                    {
                        Caption = 'Allowance List- Open';
                        Image = OpenJournal;
                        Promoted = true;
                        PromotedCategory = Process;
                        // RunObject = Page "Allowance List- Open";
                    }
                    action("Allowance List Pending approval")
                    {
                        Caption = 'Allowance List Pending approval';
                        Image = Calculate;
                        Promoted = true;
                        PromotedCategory = Process;
                        // RunObject = Page "Allowance List Pending approva";
                    }
                    action("Allowance List- Approved")
                    {
                        Caption = 'Allowance List- Approved';
                        Image = GLJournal;
                        Promoted = true;
                        PromotedCategory = Process;
                        //  RunObject = Page "Allowance List- Approved";
                    }
                    action("Posted Allowance List")
                    {
                        Caption = 'Posted Allowance List';
                        Image = GetEntries;
                        Promoted = true;
                        PromotedCategory = Process;
                        //  RunObject = Page "Posted Allowance List";
                    }
                }
                group(ActionGroup187)
                {
                    Caption = 'Payroll Setups';
                    action("Calculation Header")
                    {
                        Caption = 'Calculation Header';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Calculation Header";
                    }
                    action(" Payroll")
                    {
                        Caption = ' Payroll';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page Payroll;
                    }
                    action("Payroll Year")
                    {
                        Caption = 'Payroll Year';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Payroll Year";
                    }
                    action("Leave Calendar Period")
                    {
                        Caption = 'Leave Calendar Period';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HR Calender Period";
                    }
                    action(Action182)
                    {
                        Caption = 'ED Definitions';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "ED Definitions";
                    }
                    action(" Payroll Setups")
                    {
                        Caption = ' Payroll Setups';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Payroll Setups";
                    }
                    action("Payroll Posting Setup")
                    {
                        Caption = 'Payroll Posting Setup';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Payroll Posting Setup";
                    }
                    action("ED Posting Group")
                    {
                        Caption = 'ED Posting Group';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "ED Posting Group";
                    }
                    action("Payslip Group")
                    {
                        Caption = 'Payslip Group';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Payslip Group";
                    }
                    action(" Allowed Payrolls")
                    {
                        Caption = ' Allowed Payrolls';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Allowed Payrolls";
                    }
                    action(" Lookup Table Header")
                    {
                        Caption = ' Lookup Table Header';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Lookup Table Header";
                    }
                    action("Special Payments")
                    {
                        Caption = 'Special Payments';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Special Payments";
                    }
                    action(" Mode of Payment")
                    {
                        Caption = ' Mode of Payment';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Mode of Payment";
                    }
                    action("Institution  List")
                    {
                        Caption = 'Institution  List';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Institution  List";
                    }
                    action("Loan types")
                    {
                        Caption = 'Loan types';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Loan types";
                    }
                    action("Master Roll Group")
                    {
                        Caption = 'Master Roll Group';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Master Roll Group";
                    }
                    action("Employee Customer Loan Link")
                    {
                        Caption = 'Employee Customer Loan Link';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Employee Customer Loan Link";
                        Visible = false;
                    }
                }
            }
        }
        area(sections)
        {
            group("Employee Self Service")
            {
                Caption = 'Employee Self Service';
                Enabled = true;
                Visible = true;
                //Enabled = true;

                action("Safari Notice List")
                {
                    Caption = 'Safari Notice List';
                    RunObject = Page "Safari Notice List";
                }
                action("Safari Notice List - Status")
                {
                    Caption = 'Safari Notice List - Status';
                    RunObject = Page "Safari Notice List - Status";
                }
                action(Action171)
                {
                    Caption = 'Salary Advance Applications';
                    RunObject = Page "Salary Advance Applications";
                }
                action(" Salary Advance Pending Approval")
                {
                    Caption = ' Salary Advance Pending Approval';
                    RunObject = Page "Salary Advance Pending Approvl";
                }
                action("Salary Advance Approved ")
                {
                    Caption = 'Salary Advance Approved ';
                    RunObject = Page "Salary Advance Approved";
                }
                action(Action168)
                {
                    Caption = 'Salary Advance posted';
                    RunObject = Page "Salary Advance posted";
                }
                action("Leave Balances List")
                {
                    Caption = 'Leave Balances List';
                    RunObject = Page "Leave Balances List";
                }
                action(" Imprest List")
                {
                    Caption = ' Imprest List';
                    RunObject = Page "Imprest List";
                }
                action("Imprest List Status")
                {
                    Caption = 'Imprest List Status';
                    RunObject = Page "Imprest List Status";
                }
                action("Casual Requisitions")
                {
                    Caption = 'Casual Requisitions';
                    RunObject = Page "Casual Requisitions";
                }
                action("Casual Requisitions Pending")
                {
                    Caption = 'Casual Requisitions Pending';
                    RunObject = Page "Casual Requisitions Pending";
                }
                action("Casual Requisitions Approved")
                {
                    Caption = 'Casual Requisitions Approved';
                    RunObject = Page "Casual Requisitions Approved";
                }
                action("Posted Casual Payment List")
                {
                    Caption = 'Posted Casual Payment List';
                    RunObject = Page "Posted Casual Payment List";
                }
                action("Casuals Payment List")
                {
                    Caption = 'Casuals Payment List';
                    RunObject = Page "Casuals Payment List";
                }
                action("Pending Approval Casual Payment List")
                {
                    Caption = 'Pending Approval Casual Payment List';
                    RunObject = Page "Pending Ap Casual Payment List";
                }
                action("Approved Casual Payment List")
                {
                    Caption = 'Approved Casual Payment List';
                    RunObject = Page "Approved Casual Payment List";
                }
                action(Action2)
                {
                    Caption = 'Approved Casual Payment List';
                    RunObject = Page "Approved Casual Payment List";
                }
                action("pending Approval Imprest List")
                {
                    Caption = 'pending Approval Imprest List';
                    RunObject = Page "pending Approval Imprest List";
                }
                action("Imprest Surrender List")
                {
                    Caption = 'Imprest Surrender List';
                    RunObject = Page "Imprest Surrender List";
                    Visible = false;
                }
                action("Grievance List")
                {
                    Caption = 'Grievance List';
                    RunObject = Page "Grievance List";
                    Visible = true;
                }
                action("Petty Cash list")
                {
                    Caption = 'Petty Cash list';
                    RunObject = Page "Petty Cash list";
                    Visible = false;
                }
                action("Petty Cash list Status")
                {
                    Caption = 'Petty Cash list Status';
                    RunObject = Page "Petty Cash list S";
                    Visible = false;
                }
                action("Pending Approv Petty Cash List")
                {
                    Caption = 'Pending Approv Petty Cash List';
                    RunObject = Page "Pending Approv Petty Cash List";
                    Visible = false;
                }
                action(Action246)
                {
                    Caption = 'Imprest Surrender List';
                    RunObject = Page "Imprest Surrender List";
                }
                action("Approved Imprest Surrender")
                {
                    Caption = 'Approved Imprest Surrender';
                    RunObject = Page "Approved Imprest Surrender";
                }
                action("Petty Cash Surrender list")
                {
                    Caption = 'Petty Cash Surrender list';
                    RunObject = Page "Petty Cash Surrender List";
                }
                action("Approved Petty Cash Surrender")
                {
                    Caption = 'Approved Petty Cash Surrender';
                    RunObject = Page "Approved Petty Cash Surrender";
                }
                action(Action191)
                {
                    Caption = 'Store Requisitions List';
                    RunObject = Page "Store Requisitions List";
                }
                action("Store Requisitions List Status")
                {
                    Caption = 'Store Requisitions List Status';
                    RunObject = Page "Store Requisitions List Status";
                }
                action("Purchase Requisition List")
                {
                    Caption = 'Purchase Requisition List';
                    RunObject = Page "Purchase Requisition List";
                }
                action("Status Requisition List")
                {
                    Caption = 'Status Requisition List';
                    RunObject = Page "Purchase Requisition List S";
                }
                action("Leave Application")
                {
                    Caption = 'Leave Application';
                    RunObject = Page "Leave Applications";
                }
                action(" Leave Applications Status")
                {
                    Caption = ' Leave Applications Status';
                    RunObject = Page "Leave Applications Status";
                }
                action("Leave Reimbursements")
                {
                    Caption = 'Leave Reimbursements';
                    RunObject = Page "Leave Reimbursements";
                }
                action("HR Employee Appraisals")
                {
                    Caption = 'HR Employee Appraisals';
                    RunObject = Page "HR Employee Appraisals";
                }
                action("HR Employee Appraisals Status")
                {
                    Caption = 'HR Employee Appraisals Status';
                    RunObject = Page "HR Employee Appraisals Status";
                }
                action(Action148)
                {
                    Caption = 'Transport Request List';
                    RunObject = Page "Transport Request List";
                }
                action(Action147)
                {
                    Caption = 'Vehicle Allocations List';
                    RunObject = Page "Vehicle Allocations List";
                }
                action(Action146)
                {
                    Caption = 'Allocated Vehicle List';
                    RunObject = Page "Allocated Vehicle List";
                }
            }
            group("Biometric Attendance")
            {
                Caption = 'Biometric Attendance';
                action("Terminal List")
                {
                    Caption = 'Terminal List';
                    Image = Job;
                    RunObject = Page "Terminal List";
                    ToolTip = 'Shows HR Job List';
                    Visible = false;
                }
                action("Attendance List")
                {
                    Caption = ' Attendance List';
                    Image = Job;
                    RunObject = Page "Attendance List";
                }
                action("Attendance Summary")
                {
                    Caption = 'Attendance Summary';
                    Image = GanttChart;
                    RunObject = Page "Attendance Summary";
                }
            }
            group("Employee Management")
            {
                Caption = 'Employee Management';
                Image = HumanResources;
                action("HR Employees Permanent List")
                {
                    Caption = 'HR  Employees List';
                    RunObject = Page Employees;
                    ToolTip = 'HR Employees Permanent List';
                }
                action("Short Term Employees List")
                {
                    Caption = 'HR Contract Employees';
                    RunObject = Page Employees;
                    RunPageView = WHERE("Emplymt. Contract Code" = CONST('CONTRACT'));
                    ToolTip = 'Human Resource Short Term Employees List';
                    Visible = false;
                }
                action("HR Employees Piece Rate List")
                {
                    Caption = 'Piece Rate List';
                    RunObject = Page Employees;
                    RunPageView = WHERE("Emplymt. Contract Code" = CONST('CASUALS'));
                    ToolTip = 'HR Employees Permanent List';
                    Visible = false;
                }
                action("In-Active Employees Interns")
                {
                    RunObject = Page "In-Active Employees Interns";
                    Visible = false;
                }
                action(" Inactive Employees")
                {
                    Caption = 'HR In-Active List';
                    RunObject = Page "Inactive Employees";
                    RunPageView = WHERE(Status = FILTER(<> Active));
                }
                action("Terminated Piece RateList")
                {
                    Caption = 'Terminate Piece Rate';
                    RunObject = Page "In-Active Employees other";
                    RunPageView = WHERE("Emplymt. Contract Code" = CONST('CAUSUALS'));
                    Visible = false;
                }
                action("In-Active Employees other")
                {
                    Caption = 'HR Contract In- Active';
                    RunObject = Page "In-Active Employees other";
                    RunPageView = WHERE("Emplymt. Contract Code" = CONST('CONTRACT'));
                    Visible = false;
                }
            }
            group("Leave Management")
            {
                Caption = 'Leave Management';
                Image = ExecuteBatch;
                action("Leave Planner List")
                {
                    Caption = 'Leave Planner List';
                    RunObject = Page "Leave Planner List";
                    ToolTip = 'Human Resource Leave Planner List';
                }
                action("Pending Leave Planner List")
                {
                    Caption = 'Pending Leave Planner List';
                    RunObject = Page "Pending Leave Planner List";
                    ToolTip = 'Human Resource Pending Leave Planner List';
                }
                action("Approved Leave Planner List")
                {
                    Caption = 'Approved Planner List';
                    RunObject = Page "Approved Leave Planner List";
                    ToolTip = 'Human Resource Approved Leave Planner List';
                }
                action(" Leave Applications")
                {
                    Caption = 'Leave Application';
                    RunObject = Page "Leave Applications";
                    ToolTip = 'Human Resource Leave Applications List';
                }
                action("Leave Applications Pending")
                {
                    Caption = 'Leave Applications Pending';
                    RunObject = Page "Leave Applications Pending";
                    ToolTip = 'Human Resource Approved Leave Applications List';
                }
                action("Released Leave Applications")
                {
                    Caption = 'Approved Leave';
                    RunObject = Page "Released Leave Applications";
                    ToolTip = 'Human Resource Approved Leave Applications List';
                    Visible = true;
                }
                action("Posted Leave Applications List")
                {
                    Caption = 'Posted Leave';
                    RunObject = Page "Posted Leave Applications";
                    ToolTip = 'Human Resource Posted Leave Applications List';
                }
                action("Leave Reimbursements List")
                {
                    Caption = 'Leave Reimbursement/Recall';
                    RunObject = Page "Leave Reimbursements";
                    ToolTip = 'Human Resource Leave Reimbursements List';
                }
                action("Posted Leave Reimbursements List")
                {
                    Caption = 'Posted Leave Reimbursements';
                    RunObject = Page "Posted Leave Reimbursements";
                    ToolTip = 'Human Posted Leave Reimbursements List';
                }
                action(" Leave Carryovers List")
                {
                    Caption = 'Leave Carryover List';
                    RunObject = Page "Leave Carryovers";
                    ToolTip = 'Human Resource Leave Carryover List';
                }
                action("Posted Leave Carryovers List")
                {
                    Caption = 'Posted Leave Carryovers List';
                    RunObject = Page "Posted Leave Carryovers";
                    ToolTip = 'Human Resource Posted Leave Carryovers List';
                }
                action("Leave Allocations List")
                {
                    Caption = 'Leave Allocations List';
                    RunObject = Page "Leave Allocations";
                    ToolTip = 'Human Resource Leave Allocations List';
                }
                action("Posted Leave Allocations List")
                {
                    Caption = 'Posted Leave Allocations List';
                    RunObject = Page "Posted Leave Allocations";
                    ToolTip = 'Human Resource Posted Leave Allocations List';
                }
                action("Leave Types List")
                {
                    Caption = 'Leave Types List';
                    RunObject = Page "Leave Types";
                    ToolTip = 'Human Resource Leave Types List ';
                }
                action("Leave Periods List")
                {
                    Caption = 'Leave Periods List';
                    RunObject = Page "Leave Periods";
                    ToolTip = 'Human Resource Leave Periods List ';
                }
                action("HR Base Calendar List")
                {
                    Caption = 'HR Base Calendar List';
                    RunObject = Page "HR Base Calendar List";
                    ToolTip = 'Human Resource Leave Periods List ';
                }
                action("Leave Allowance Requests List")
                {
                    Caption = 'Leave Allowance';
                    RunObject = Page "Leave Allowance Requests1";
                    ToolTip = 'Human Resource Leave Allowance Requests List';
                    Visible = false;
                }
            }
            group("HR Jobs Management")
            {
                Caption = 'HR Jobs Management';
                Image = Administration;
                action("Human Resource Jobs List")
                {
                    Caption = 'HR Jobs List';
                    Image = Job;
                    RunObject = Page "HR Jobs List";
                    ToolTip = 'Shows HR Job List';
                }
                action("Approved Human Resource Jobs")
                {
                    Caption = '<Approved HR Jobs>';
                    Image = Job;
                    RunObject = Page "Approved HR Jobs";
                }
                action("Human Resorce Job Grades List")
                {
                    Caption = '<HR Job Grades List>';
                    Image = GanttChart;
                    RunObject = Page "HR Job Grades";
                }
                action("Human Resource Job Values List")
                {
                    Caption = '<HR Job Values List>';
                    Image = GanttChart;
                    RunObject = Page "HR Job Values";
                }
            }
            group("HR Recruitment Management")
            {
                Caption = 'HR Recruitment Management';
                Image = ProductDesign;
                action("Employee Requisitions")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Employee Requisitions List';
                    Image = ConsumptionJournal;
                    RunObject = Page "Employee Requisitions";
                    ToolTip = 'Employee Requisitions List.';
                }
                action("HR Shortlisted Job Applicants")
                {
                    Caption = 'HR Shortlisted Job Applicants List';
                    RunObject = Page "HR Shortlisted Job Applicants";
                    ToolTip = 'HR Shortlisted Job Applicants List';
                }
                action("Closed Employee Requisitions List")
                {
                    Caption = 'Closed Employee Requisitions List';
                    RunObject = Page "Closed Employee Requisitions";
                    ToolTip = 'Closed Employee Requisitions List';
                }
                action("HR Job Applications List")
                {
                    Caption = 'HR Job Applications List';
                    RunObject = Page "HR Job Applications";
                    ToolTip = 'HR Job Applications List';
                }
                action(" Closed Job Applications List")
                {
                    Caption = 'Closed Job Applications List';
                    RunObject = Page "Closed Job Applications";
                    ToolTip = 'Closed Job Applications List';
                }
                action("Interview Panel List")
                {
                    Caption = 'Interview Panel List';
                    RunObject = Page "Interview Header List";
                    ToolTip = 'Interview Panel List';
                }
                action("Dept Interview Panel List")
                {
                    Caption = 'Dept Interview Panel List';
                    RunObject = Page "Dept Interview Panel List";
                    ToolTip = 'Department Interview Panel List';
                }
            }
            group("Performace Management")
            {
                Caption = 'Performace Management';
                Image = Calculator;
                action("HR Employee Appraisals List")
                {
                    Caption = 'Employee Appraisals List';
                    RunObject = Page "HR Employee Appraisals";
                    ToolTip = 'Human Resoource Employee Appraisals List';
                }
                action("Human Resource Global Appraisal Objectives")
                {
                    Caption = 'Global Appraisal Objectives KPI';
                    RunObject = Page "HR Appraisal Global Objectives";
                    Visible = false;
                }
                action("Performance Objectives")
                {
                    Caption = 'Performance Objectives';
                    RunObject = Page "Membership Numbers";
                    Visible = false;
                }
                action("HR Appraisal Global Competency")
                {
                    Caption = 'Appraisal Global Competency';
                    RunObject = Page "HR Appraisal Global Competency";
                }
                action("HR Appraisal Period")
                {
                    Caption = 'Appraisal Period';
                    RunObject = Page "HR Appraisal Period";
                    ToolTip = 'Human Resource Appraisal Period';
                }
            }
            group("Training Management")
            {
                Caption = 'Training Management';
                Image = LotInfo;
                action("HR Training Needs List")
                {
                    Caption = 'Training Needs List';
                    RunObject = Page "Training Needs";
                    ToolTip = 'Human Resource Training Needs List';
                }
                action("Proposed Training Needs List")
                {
                    Caption = 'Approved Training Need List';
                    RunObject = Page "Proposed Training Needs List";
                    ToolTip = 'Human Resource Proposed Training Needs List';
                }
                action("HR Approved Training Need List")
                {
                    Caption = 'Approved Training Need List';
                    Enabled = true;
                    RunObject = Page "HR Approved Training Need List";
                    ToolTip = 'Human Resorce Approved Training Need List';
                    Visible = false;
                }
                action("HR Training Groups List")
                {
                    Caption = 'Training Groups List';
                    RunObject = Page "Training Groups";
                    ToolTip = 'Human Resorce Training Groups List';
                }
                action("HR Training Applications List")
                {
                    Caption = 'Training Applications List';
                    RunObject = Page "Training Applications";
                    ToolTip = 'Human Resource Training Applications List';
                }
                action("HR Training Evaluation List")
                {
                    Caption = 'Training Evaluation List';
                    RunObject = Page "Training Evaluation List";
                    ToolTip = 'Human Resorce Training Evaluation List';
                }
            }
            group("Employee Disciplinary Management")
            {
                Caption = 'Employee Disciplinary Management';
                Image = LotInfo;
                action("HR Employee Disciplinary Cases List")
                {
                    Caption = 'Disciplinary Cases List';
                    RunObject = Page "Disciplinary Case";
                    ToolTip = 'Human Resource Disciplinary Cases List';
                }
                action("HR Closed Disciplinary Cases List")
                {
                    Caption = 'Closed Disciplinary Cases List';
                    RunObject = Page "Closed Disciplinary Cases";
                    ToolTip = 'Human Resource Closed Disciplinary Cases List';
                }
            }
            group("Fleet Management")
            {
                Caption = 'Fleet Management';
                Image = LotInfo;
                action("Vehicle Allocations List")
                {
                    Caption = 'Vehicle Allocations List';
                    RunObject = Page "Vehicle Allocations List";
                    ToolTip = 'Vehicle Allocations List';
                }
                action("Transport Request List")
                {
                    Caption = 'Transport Request List';
                    RunObject = Page "Transport Request List";
                    ToolTip = 'Transport Request List';
                }
                action("Pending Transport Request")
                {
                    Caption = 'Pending Transport Request';
                    RunObject = Page "Pending Transport Request";
                    ToolTip = 'Pending Transport Request';
                }
                action("Allocated Vehicle List")
                {
                    Caption = 'Allocated Vehicle List';
                    RunObject = Page "Allocated Vehicle List";
                    ToolTip = 'Allocated Vehicle List';
                }
                action("Fleet Accident Log")
                {
                    Caption = 'Fleet Accident Log';
                    RunObject = Page "Fleet Accident Log";
                    ToolTip = 'Fleet Accident Log';
                }
                action("Service interval  List")
                {
                    Caption = 'Service interval  List';
                    RunObject = Page "Service interval  List";
                    ToolTip = 'Service interval  List';
                }
                action("Filling List")
                {
                    Caption = 'Filling List';
                    RunObject = Page "Fuel Filling List";
                    ToolTip = 'Filling List';
                }
                action("Submitted Fuel Filling List")
                {
                    Caption = 'Submitted Fuel Filling List';
                    RunObject = Page "Submitted Fuel Filling List";
                    ToolTip = 'Submitted Fuel Filling List';
                }
            }
            group(ActionGroup80)
            {
                Caption = 'Registry';
                Image = LotInfo;
                action("File Types")
                {
                    Caption = 'File Types';
                    RunObject = Page "File Types";
                    ToolTip = 'File Types';
                }
                action("File List")
                {
                    Caption = 'File List';
                    RunObject = Page "File List";
                    ToolTip = 'File List';
                }
                action("File Requests list")
                {
                    Caption = 'File Requests list';
                    RunObject = Page "File Requests list";
                    ToolTip = 'File Requests list';
                }
                action("Received File Request List ")
                {
                    Caption = 'Received File Request List ';
                    RunObject = Page "Received File Request List";
                    ToolTip = 'Received File Request List ';
                }
                action("Issued File Request List ")
                {
                    Caption = 'Issued File Request List ';
                    RunObject = Page "Issued File Request List";
                    ToolTip = 'Issued File Request List ';
                }
            }
            group("Employee Exit Interview")
            {
                Caption = 'Employee Exit Interview';
                Image = LotInfo;
                action("HR Employee Exit Int List")
                {
                    Caption = 'Employee Exit Interview List';
                    RunObject = Page "HR Employee Exit Int List";
                    ToolTip = 'Human Resource Employee Exit Interview List';
                }
                action("HR Employee Payroll Transactions")
                {
                    Caption = 'Employee Payroll Transactions List';
                    RunObject = Page "Allowance Codes";
                    ToolTip = 'Human Resource  Employee Payroll Transactions List';
                }
            }
        }
    }
}

