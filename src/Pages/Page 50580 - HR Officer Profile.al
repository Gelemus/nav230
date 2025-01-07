page 50580 "HR Officer Profile"
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
                part(Approvals; "Team Member Activities")
                {
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                }
                part("My Activities"; "Human Resource Cues Page")
                {
                    ApplicationArea = Advanced;
                    Caption = 'My Activities';
                }
                part(Control1905989608; "My Items")
                {
                    ApplicationArea = Advanced;
                    Visible = false;
                }
            }
            group(Control1900724708)
            {
                ShowCaption = false;
                part(Control21; "My Job Queue")
                {
                    ApplicationArea = Advanced;
                    Visible = false;
                }
                part(Control27; "Report Inbox Part")
                {
                    ApplicationArea = Advanced;
                    Visible = false;
                }
                systempart(Control1901377608; MyNotes)
                {
                    ApplicationArea = Advanced;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Human Resource Establishment Report")
            {
                ApplicationArea = Manufacturing;
                Caption = 'Human Resource Establishment Report';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "HR Jobs";
                ToolTip = 'View Job Positions in the Organization. The report also shows information about Job establishment/positions in the organization.';
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
                action("ED Report")
                {
                    Caption = 'ED Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "ED Report";
                }
                action(Payslip)
                {
                    Caption = 'Payslip';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report Payslips;
                }
                action("Company Payslip")
                {
                    Caption = 'Company Payslip';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Company Payslip";
                }
                action(" Bank Payment List")
                {
                    Caption = ' Bank Payment List';
                    Image = Payment;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Bank Payment List";
                }
                action(" Payroll Reconciliation-All ED")
                {
                    Caption = ' Payroll Reconciliation-All ED';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Payroll Reconciliation-All ED";
                }
                action("Payroll Reconciliation-Per ED")
                {
                    Caption = 'Payroll Reconciliation-Per ED';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Payroll Reconciliation-Per ED";
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
                    RunObject = Report "NSSF Report";
                }
                action("NHIF Report")
                {
                    Caption = 'NHIF Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "NHIF Report";
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
            }
            group("Fleet Management")
            {
                Caption = 'Fleet Management';
                action("Daily Fuel Consumption")
                {
                    Caption = 'Daily Fuel Consumption';
                    Image = "Report";
                    // Promoted = true;
                    // PromotedCategory = "Report";
                    // RunObject = Report "Daily Fuel Consumption";
                }
                action("Weekly Fuel ConsumptionReport.")
                {
                    Caption = 'Weekly Fuel ConsumptionReport.';
                    Image = "Report";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    //  RunObject = Report "Weekly Fuel Consumption";
                }
                action("Monthly  Fuel Consumption")
                {
                    Caption = 'Monthly  Fuel Consumption';
                    Image = "Report";
                    // Promoted = true;
                    // PromotedCategory = "Report";
                    // RunObject = Report "Monthly  Fuel Consumption";
                }
                action("Card Load Report")
                {
                    Caption = 'Card Load Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Card Load Report";
                }
            }
            group(Registry)
            {
                Caption = 'Registry';
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
                    Caption = 'Human Resource Employment Contracts';
                    Image = JobListSetup;
                    RunObject = Page "Employment Contracts";
                    ToolTip = 'Human Resource Employment Contracts';
                }
                action("HR Lookup Values")
                {
                    Caption = 'Human Resource Lookup Values';
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
                    Caption = 'Human Resources General Setup';
                    Image = "Order";
                    Promoted = false;
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
                    Caption = 'Maintanance and repair';
                    RunObject = Page "Maintanance Schedule";
                    ToolTip = 'Maintanance and repair';
                }
            }
            group(ActionGroup98)
            {
                Caption = 'Payroll';
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
            }
        }
        area(creation)
        {
        }
        area(sections)
        {
            group("Employee Self Service")
            {
                Caption = 'Employee Self Service';
                action(" Imprest List")
                {
                    Caption = ' Imprest List';
                    RunObject = Page "Imprest List";
                }
                action("Approved Imprest List")
                {
                    Caption = 'Approved Imprest List';
                    RunObject = Page "Approved Imprest List";
                }
                action("Imprest Surrender List")
                {
                    Caption = 'Imprest Surrender List';
                    RunObject = Page "Imprest Surrender List";
                }
                action("Leave Application")
                {
                    Caption = 'Leave Application';
                    RunObject = Page "Leave Applications";
                }
                action(Action151)
                {
                    Caption = 'Released Leave Applications';
                    RunObject = Page "Released Leave Applications";
                }
                action("Leave Reimbursements")
                {
                    Caption = 'Leave Reimbursements';
                    RunObject = Page "Leave Reimbursements";
                }
                action("Store Requisitions List")
                {
                    Caption = 'Store Requisitions List';
                    RunObject = Page "Store Requisitions List";
                }
                action("Approved Store Requisitions")
                {
                    Caption = 'Approved Store Requisitions';
                    RunObject = Page "Approved Store Requisitions";
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
            }
            group(ActionGroup7)
            {
                Caption = 'Payroll';
                Image = Administration;
                action("Payroll Header List")
                {
                    Caption = 'Payroll Header List';
                    Image = Job;
                    RunObject = Page "Payroll Header List";
                    ToolTip = 'Payroll Header List';
                }
                action("Period Look Up")
                {
                    Caption = 'Period Look Up';
                    Image = Job;
                    RunObject = Page "Period Look Up";
                }
                action("Calculation Header")
                {
                    Caption = 'Calculation Header';
                    Image = GanttChart;
                    RunObject = Page "Calculation Header";
                }
                action(Payroll)
                {
                    Caption = 'Payroll';
                    Image = GanttChart;
                    RunObject = Page Payroll;
                }
                action("Payroll Year")
                {
                    Caption = 'Payroll Year';
                    Image = Job;
                    RunObject = Page "Payroll Year";
                    ToolTip = 'Payroll Year';
                }
                action("Payroll Posting Setup")
                {
                    Caption = 'Payroll Posting Setup';
                    Image = GanttChart;
                    RunObject = Page "Payroll Posting Setup";
                }
                action("ED Posting Group")
                {
                    Caption = 'ED Posting Group';
                    Image = GanttChart;
                    RunObject = Page "ED Posting Group";
                }
                action("Payslip Group")
                {
                    Caption = 'Payslip Group';
                    Image = GanttChart;
                    RunObject = Page "Payslip Group";
                }
                action("Lookup Table Header")
                {
                    Caption = 'Lookup Table Header';
                    Image = Job;
                    RunObject = Page "Lookup Table Header";
                    ToolTip = 'Lookup Table Header';
                }
                action("Master Roll Group")
                {
                    Caption = 'Master Roll Group';
                    Image = Job;
                    RunObject = Page "Master Roll Group";
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
                    Image = Job;
                    RunObject = Page "Approved HR Jobs";
                }
                action("Human Resorce Job Grades List")
                {
                    Image = GanttChart;
                    RunObject = Page "HR Job Grades";
                }
                action("Human Resource Job Values List")
                {
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
                action("HR Job Applications List")
                {
                    Caption = 'HR Job Applications List';
                    RunObject = Page "HR Job Applications";
                    ToolTip = 'HR Job Applications List';
                }
                action("HR Shortlisted Job Applicants")
                {
                    Caption = 'HR Shortlisted Job Applicants List';
                    RunObject = Page "HR Shortlisted Job Applicants";
                    ToolTip = 'HR Shortlisted Job Applicants List';
                }
                action("Dept Interview Panel List")
                {
                    Caption = 'Dept Interview Panel List';
                    RunObject = Page "Dept Interview Panel List";
                    ToolTip = 'Department Interview Panel List';
                }
                action("Interview Panel List")
                {
                    Caption = 'Interview Panel List';
                    RunObject = Page "Interview Header List";
                    ToolTip = 'Interview Panel List';
                }
                action("Closed Employee Requisitions List")
                {
                    Caption = 'Closed Employee Requisitions List';
                    RunObject = Page "Closed Employee Requisitions";
                    ToolTip = 'Closed Employee Requisitions List';
                }
                action(" Closed Job Applications List")
                {
                    Caption = 'Closed Job Applications List';
                    RunObject = Page "Closed Job Applications";
                    ToolTip = 'Closed Job Applications List';
                }
            }
            group("Employee Management")
            {
                Caption = 'Employee Management';
                Image = HumanResources;
                action("HR Employees Permanent List")
                {
                    Caption = 'Human Resource Employees Permanent List';
                    RunObject = Page Employees;
                    ToolTip = 'HR Employees Permanent List';
                }
                action("Short Term Employees List")
                {
                    Caption = 'Human Resource Short Term Employees List';
                    RunObject = Page "Short Term Employees";
                    ToolTip = 'Human Resource Short Term Employees List';
                }
                action(" Inactive Employees")
                {
                    Caption = 'Human Resource In-Active Permanent Employees List';
                    RunObject = Page "Inactive Employees";
                }
                action("In-Active Employees other")
                {
                    Caption = 'Human Resource In-Active Employees other';
                    RunObject = Page "In-Active Employees other";
                }
            }
            group("Leave Management")
            {
                Caption = 'Leave Management';
                Image = ExecuteBatch;
                action("Leave Planner List")
                {
                    Caption = 'Human Resource Leave Planner List';
                    RunObject = Page "Leave Planner List";
                    ToolTip = 'Human Resource Leave Planner List';
                }
                action("Approved Leave Planner List")
                {
                    Caption = 'Human Resource Approved Leave Planner List';
                    RunObject = Page "Approved Leave Planner List";
                    ToolTip = 'Human Resource Approved Leave Planner List';
                }
                action(" Leave Applications")
                {
                    Caption = 'Human Resource Leave Applications List';
                    RunObject = Page "Leave Applications";
                    ToolTip = 'Human Resource Leave Applications List';
                }
                action("Released Leave Applications")
                {
                    Caption = 'Human Resource Approved Leave Applications List';
                    RunObject = Page "Released Leave Applications";
                    ToolTip = 'Human Resource Approved Leave Applications List';
                }
                action("Posted Leave Applications List")
                {
                    Caption = 'Human Resource Posted Leave Applications List';
                    RunObject = Page "Posted Leave Applications";
                    ToolTip = 'Human Resource Posted Leave Applications List';
                }
                action("Leave Reimbursements List")
                {
                    Caption = 'Human Resource Leave Reimbursements List';
                    RunObject = Page "Leave Reimbursements";
                    ToolTip = 'Human Resource Leave Reimbursements List';
                }
                action("Posted Leave Reimbursements List")
                {
                    Caption = 'Human Posted Leave Reimbursements List';
                    RunObject = Page "Posted Leave Reimbursements";
                    ToolTip = 'Human Posted Leave Reimbursements List';
                }
                action(" Leave Carryovers List")
                {
                    Caption = 'Human Resource Leave Carryover List';
                    RunObject = Page "Leave Carryovers";
                    ToolTip = 'Human Resource Leave Carryover List';
                }
                action("Posted Leave Carryovers List")
                {
                    Caption = 'Human Resource Posted Leave Carryovers List';
                    RunObject = Page "Posted Leave Carryovers";
                    ToolTip = 'Human Resource Posted Leave Carryovers List';
                }
                action("Leave Allocations List")
                {
                    Caption = 'Human Resource Leave Allocations List';
                    RunObject = Page "Leave Allocations";
                    ToolTip = 'Human Resource Leave Allocations List';
                }
                action("Posted Leave Allocations List")
                {
                    Caption = 'Human Resource Posted Leave Allocations List';
                    RunObject = Page "Posted Leave Allocations";
                    ToolTip = 'Human Resource Posted Leave Allocations List';
                }
                action("Leave Types List")
                {
                    Caption = 'Human Resource Leave Types List ';
                    RunObject = Page "Leave Types";
                    ToolTip = 'Human Resource Leave Types List ';
                }
                action("Leave Periods List")
                {
                    Caption = 'Human Resource Leave Periods List ';
                    RunObject = Page "Leave Periods";
                    ToolTip = 'Human Resource Leave Periods List ';
                }
                action("Leave Allowance Requests List")
                {
                    Caption = 'Human Resource Leave Allowance Requests List';
                    RunObject = Page "Leave Allowance Requests1";
                    ToolTip = 'Human Resource Leave Allowance Requests List';
                }
            }
            group("Performace Management")
            {
                Caption = 'Performace Management';
                Image = Calculator;
                action("HR Employee Appraisals List")
                {
                    Caption = 'Human Resoource Employee Appraisals List';
                    RunObject = Page "HR Employee Appraisals";
                    ToolTip = 'Human Resoource Employee Appraisals List';
                }
                action("Human Resource Global Appraisal Objectives")
                {
                    Caption = 'Human Resource Global Appraisal Objectives';
                    RunObject = Page "HR Appraisal Global Objectives";
                }
                action("Human Resource Appraisal ")
                {
                    Caption = 'Human Resource Appraisal Objectives';
                    RunObject = Page "HR Appraisal Objectives";
                    ToolTip = 'Human Resource Appraisal Objectives';
                }
                action("HR Appraisal Period")
                {
                    Caption = 'Human Resource Appraisal Period';
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
                    Caption = 'Human Resource Training Needs List';
                    RunObject = Page "Training Needs";
                    ToolTip = 'Human Resource Training Needs List';
                }
                action("Proposed Training Needs List")
                {
                    Caption = 'Human Resource Proposed Training Needs List';
                    RunObject = Page "Proposed Training Needs List";
                    ToolTip = 'Human Resource Proposed Training Needs List';
                }
                action("HR Approved Training Need List")
                {
                    Caption = 'Human Resorce Approved Training Need List';
                    RunObject = Page "HR Approved Training Need List";
                    ToolTip = 'Human Resorce Approved Training Need List';
                }
                action("HR Training Groups List")
                {
                    Caption = 'Human Resorce Training Groups List';
                    RunObject = Page "Training Groups";
                    ToolTip = 'Human Resorce Training Groups List';
                }
                action("HR Training Applications List")
                {
                    Caption = 'Human Resource Training Applications List';
                    RunObject = Page "Training Applications";
                    ToolTip = 'Human Resource Training Applications List';
                }
                action("HR Training Evaluation List")
                {
                    Caption = 'Human Resorce Training Evaluation List';
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
                    Caption = 'Human Resource Disciplinary Cases List';
                    RunObject = Page "Disciplinary Case";
                    ToolTip = 'Human Resource Disciplinary Cases List';
                }
                action("HR Closed Disciplinary Cases List")
                {
                    Caption = 'Human Resource Closed Disciplinary Cases List';
                    RunObject = Page "Closed Disciplinary Cases";
                    ToolTip = 'Human Resource Closed Disciplinary Cases List';
                }
            }
            group(ActionGroup103)
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
                action("Oil Requisition List")
                {
                    Caption = 'Oil Requisition List';
                    RunObject = Page "Oil Requisition List";
                    ToolTip = 'Oil Requisition List';
                }
                action("Submitted Oil Requisition List")
                {
                    Caption = 'Submitted Oil Requisition List';
                    RunObject = Page "Submitted Oil Requisition List";
                    ToolTip = 'Submitted Oil Requisition List';
                }
                action("Card Information List")
                {
                    Caption = 'Card Information List';
                    RunObject = Page "Card Information List";
                    ToolTip = 'Card Information List';
                }
                action("Card Ledger Entries")
                {
                    Caption = 'Card Ledger Entries';
                    RunObject = Page "Card Ledger Entries";
                    ToolTip = 'Card Ledger Entries';
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
                action("Cheque Deposited list")
                {
                    Caption = 'Cheque Deposited list';
                    RunObject = Page "Cheque Deposited list";
                    ToolTip = 'Cheque Deposited list';
                }
                action("Submitted Cheque Deposited")
                {
                    Caption = 'Submitted Cheque Deposited';
                    RunObject = Page "Submitted Cheque Deposited";
                    ToolTip = 'Submitted Cheque Deposited';
                }
                action("Cheque Released List")
                {
                    Caption = 'Cheque Released List';
                    RunObject = Page "Cheque Released List";
                    ToolTip = 'Cheque Released List';
                }
                action("Submitted Cheque Released List")
                {
                    Caption = 'Submitted Cheque Released List';
                    RunObject = Page "Submitted Cheque Released List";
                    ToolTip = 'Submitted Cheque Released List';
                }
                action("Incoming Letters")
                {
                    Caption = 'Incoming Letters';
                    RunObject = Page "Incoming Letters";
                    ToolTip = 'Incoming Letters';
                }
                action("Submitted Incoming Letters")
                {
                    Caption = 'Submitted Incoming Letters';
                    RunObject = Page "Submitted Incoming Letters";
                    ToolTip = 'Submitted Incoming Letters';
                }
                action("Released Letters")
                {
                    Caption = 'Released Letters';
                    RunObject = Page "Released Letters";
                    ToolTip = 'Released Letters';
                }
                action("Submitted Released Letters")
                {
                    Caption = 'Submitted Released Letters';
                    RunObject = Page "Submitted Released Letters";
                    ToolTip = 'Submitted Released Letters';
                }
                action("Sent Letters List")
                {
                    Caption = 'Sent Letters List';
                    RunObject = Page "Sent Letters List";
                    ToolTip = 'Sent Letters List';
                }
                action("Submitted Sent Letters List")
                {
                    Caption = 'Submitted Sent Letters List';
                    RunObject = Page "Submitted Sent Letters List";
                    ToolTip = 'Submitted Sent Letters List';
                }
            }
            group("Employee Exit Interview")
            {
                Caption = 'Employee Exit Interview';
                Image = LotInfo;
                action("HR Employee Exit Int List")
                {
                    Caption = 'Human Resource Employee Exit Interview List';
                    RunObject = Page "HR Employee Exit Int List";
                    ToolTip = 'Human Resource Employee Exit Interview List';
                }
                action("HR Employee Payroll Transactions")
                {
                    Caption = 'Human Resource  Employee Payroll Transactions List';
                    RunObject = Page "Allowance Codes";
                    ToolTip = 'Human Resource  Employee Payroll Transactions List';
                }
            }
        }
    }
}

