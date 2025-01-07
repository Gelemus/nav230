page 51338 "PA  Role Centre"
{
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            systempart(Control2; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(sections)
        {
            group(Approval)
            {
                Caption = 'Approval';
                Image = LotInfo;
                action("Requests to Approve")
                {
                    Caption = 'Requests to Approve';
                    RunObject = Page "Requests to Approve";
                }
                action("Approval Entries")
                {
                    Caption = 'Approval Entries';
                    RunObject = Page "Approval Entries";
                }
            }
            group("Employee Self Service")
            {
                Caption = 'Employee Self Service';
                action(" Imprest List")
                {
                    Caption = ' Imprest List';
                    RunObject = Page "Imprest List 2";
                }
                action("Imprest List Status")
                {
                    Caption = 'Imprest List Status';
                    RunObject = Page "Imprest List Status";
                }
                action("Imprest Surrender List")
                {
                    Caption = 'Imprest Surrender List';
                    RunObject = Page "Imprest Surrender List";
                    Visible = false;
                }
                action("Petty Cash list")
                {
                    Caption = 'Petty Cash list';
                    RunObject = Page "Petty Cash list";
                }
                action("Petty Cash list Status")
                {
                    Caption = 'Petty Cash list Status';
                    RunObject = Page "Petty Cash list S";
                }
                action(Action58)
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
                action("Store Requisitions List")
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
                    RunObject = Page "Requisition List";
                }
                action("Status Purchase Requisition List")
                {
                    Caption = 'Status Purchase Requisition List';
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
                action("Transport Request List")
                {
                    Caption = 'Transport Request List';
                    RunObject = Page "Transport Request List";
                }
                action("Vehicle Allocations List")
                {
                    Caption = 'Vehicle Allocations List';
                    RunObject = Page "Vehicle Allocations List";
                }
                action("Allocated Vehicle List")
                {
                    Caption = 'Allocated Vehicle List';
                    RunObject = Page "Allocated Vehicle List";
                }
            }
        }
        area(embedding)
        {
            action("Imprest List")
            {
                Caption = 'Imprest List';
                RunObject = Page "Imprest List 2";
            }
            action(Action35)
            {
                Caption = 'Petty Cash list';
                RunObject = Page "Petty Cash list";
            }
            action(Action24)
            {
                Caption = 'Leave Application';
                RunObject = Page "Leave Applications";
            }
            action(Action23)
            {
                Caption = 'Leave Reimbursements';
                RunObject = Page "Leave Reimbursements";
            }
            action(Action21)
            {
                Caption = 'Store Requisitions List';
                RunObject = Page "Store Requisitions List";
            }
            action(Action22)
            {
                Caption = 'Purchase Requisition List';
                RunObject = Page "Requisition List";
                Visible = false;
            }
        }
        area(reporting)
        {
            action(Payslip)
            {
                Caption = 'Payslip';
                Image = "Report";
                Promoted = true;
                // RunObject = Report "Employee Payslips";
                Visible = false;
            }
            group("Fleet Management")
            {
                Caption = 'Fleet Management';
                action("Daily Fuel Consumption")
                {
                    Caption = 'Daily Fuel Consumption';
                    Image = "Report";
                    Promoted = true;
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
                    Promoted = true;
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
                    Visible = false;
                }
            }
        }
    }
}

