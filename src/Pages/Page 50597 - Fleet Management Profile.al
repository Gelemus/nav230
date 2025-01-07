page 50597 "Fleet Management Profile"
{
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control82)
            {
                ShowCaption = false;
                part(Control80; "Headline RC Team Member")
                {
                    ApplicationArea = Basic, Suite;
                }
                systempart(Control79; MyNotes)
                {
                    ApplicationArea = Basic, Suite;
                }
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
                    Visible = false;
                }
                action("Petty Cash list Status")
                {
                    Caption = 'Petty Cash list Status';
                    RunObject = Page "Petty Cash list S";
                    Visible = false;
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
                    Visible = false;
                }
                action("Approved Petty Cash Surrender")
                {
                    Caption = 'Approved Petty Cash Surrender';
                    RunObject = Page "Approved Petty Cash Surrender";
                    Visible = false;
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
                action(" Purchase Requisition List")
                {
                    Caption = ' Purchase Requisition List';
                    RunObject = Page "Purchase Requisition List";
                }
                action("Status Purchase Requisition Status")
                {
                    Caption = 'Status Purchase Requisition Status';
                    RunObject = Page "Purchase Requisition List S";
                }
                action("Salary Advance Applications")
                {
                    Caption = 'Salary Advance Applications';
                    RunObject = Page "Salary Advance Applications";
                }
                action(" Salary Advance Pending Approval")
                {
                    Caption = ' Salary Advance Pending Approval';
                    RunObject = Page "Salary Advance Pending Approvl";
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
                    Visible = false;
                }
                action("HR Employee Appraisals")
                {
                    Caption = 'HR Employee Appraisals';
                    RunObject = Page "HR Employee Appraisals";
                    Visible = false;
                }
                action("HR Employee Appraisals Status")
                {
                    Caption = 'HR Employee Appraisals Status';
                    RunObject = Page "HR Employee Appraisals Status";
                    Visible = false;
                }
                action(Action29)
                {
                    Caption = 'Transport Request List';
                    RunObject = Page "Transport Request List";
                }
                action(Action16)
                {
                    Caption = 'Vehicle Allocations List';
                    RunObject = Page "Vehicle Allocations List";
                }
                action("Transfer Orders")
                {
                    Caption = 'Transfer Orders';
                    RunObject = Page "Transfer Orders";
                }
                action("Posted Transfer Shipments")
                {
                    Caption = 'Posted Transfer Shipments';
                    RunObject = Page "Posted Transfer Shipments";
                }
                action("Posted Transfer Receipts")
                {
                    Caption = 'Posted Transfer Receipts';
                    RunObject = Page "Posted Transfer Receipts";
                }
            }
            group("Fleet Management")
            {
                Caption = 'Fleet Management';
                Image = LotInfo;
                action("Employees List")
                {
                    Caption = 'Employee  List';
                    RunObject = Page "Employees List";
                    ToolTip = 'Driver List';
                }
                action("Driver List")
                {
                    Caption = 'Driver List';
                    RunObject = Page "Driver List";
                    ToolTip = 'Driver List';
                }
                action("Fleet List")
                {
                    Caption = 'Fleet List';
                    RunObject = Page "Vehicle List";
                    ToolTip = 'Fleet List';
                }
                action("Handover Notes List")
                {
                    Caption = 'Handover Notes List';
                    RunObject = Page "Handover Note List";
                    ToolTip = 'Handover Notes List';
                }
                action("Submitted Handover Note List")
                {
                    Caption = 'Approved Handover Note List';
                    RunObject = Page "Approved Handover Note List";
                    ToolTip = 'Submitted Handover Note List';
                }
                action("Repair Order List")
                {
                    Caption = 'Repair Order List';
                    RunObject = Page "Repair Order List";
                    ToolTip = 'Repair Order List';
                }
                action("Pending Approval Repair Order List")
                {
                    Caption = 'Pending Approval Repair Order List';
                    RunObject = Page "Pending ApproRepair Order List";
                    ToolTip = 'Pending Approval Repair Order List';
                }
                action("Approved Repair Order List")
                {
                    Caption = 'Approved Repair Order List';
                    RunObject = Page "Approved Repair Order List";
                    ToolTip = 'Approved Repair Order List';
                }
                action("Page Completed  Repair Order Li")
                {
                    ApplicationArea = Suite;
                    Caption = 'Completed  Repair Order List';
                    Image = Document;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Completed  Repair Order List";
                    RunPageMode = Create;
                    ToolTip = 'Create a new Transfer Orders.';
                }
                action("Page Safari Notice List")
                {
                    Caption = 'Safari Notice List';
                    RunObject = Page "Safari Notice List";
                }
                action("Page Pending App Safari Notice ")
                {
                    Caption = 'Pending Approval Safari Notice List';
                    RunObject = Page "Pending App Safari Notice List";
                }
                action("Page Approval Safari Notice Lis")
                {
                    Caption = 'Approved Safari Notice List';
                    RunObject = Page "Approval Safari Notice List";
                }
                action("Filling List")
                {
                    Caption = 'Fuel Requisition List';
                    RunObject = Page "Fuel Filling List";
                    ToolTip = 'Filling List';
                }
                action("Fuel Requisition Pending List")
                {
                    Caption = 'Fuel Requisition Pending List';
                    RunObject = Page "Fuel Filling List-Pening Appro";
                    ToolTip = 'Fuel Requisition Pending List';
                }
                action("Fuel Requisition Approved List")
                {
                    Caption = 'Fuel Requisition Approved List';
                    RunObject = Page "Fuel Filling List-Approved";
                    ToolTip = 'Fuel Requisition Approved List';
                }
                action("Fuel Prices")
                {
                    Caption = 'Fuel Prices';
                    RunObject = Page "Fuel Prices";
                    ToolTip = 'Fuel Prices';
                }
                action("Oil Requisition List")
                {
                    Caption = 'Oil Requisition List';
                    RunObject = Page "Oil Requisition List";
                    ToolTip = 'Oil Requisition List';
                    Visible = false;
                }
                action("Submitted Oil Requisition List")
                {
                    Caption = 'Submitted Oil Requisition List';
                    RunObject = Page "Submitted Oil Requisition List";
                    ToolTip = 'Submitted Oil Requisition List';
                    Visible = false;
                }
                action("Work Ticket List")
                {
                    Caption = 'Work Ticket List';
                    RunObject = Page "Work Ticket List";
                    ToolTip = 'Work Ticket List';
                }
                action("Work Ticket List-Pending")
                {
                    Caption = 'Work Ticket List-Pending';
                    RunObject = Page "Work Ticket List-Pending";
                    ToolTip = 'Work Ticket List-Pending';
                }
                action("Work Ticket List-Approved")
                {
                    Caption = 'Work Ticket List-Approved';
                    RunObject = Page "Work Ticket List-Approved";
                    ToolTip = 'Work Ticket List-Approved';
                }
                action("Work Ticket List-Closed")
                {
                    Caption = 'Work Ticket List-Closed';
                    RunObject = Page "Work Ticket List-Closed";
                    ToolTip = 'Work Ticket List-Closed';
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
                action("Vehicle Allocations List")
                {
                    Caption = 'Vehicle Allocations List';
                    RunObject = Page "Vehicle Allocations List";
                    ToolTip = 'Vehicle Allocations List';
                }
                action("Allocated Vehicle List")
                {
                    Caption = 'Allocated Vehicle List';
                    RunObject = Page "Allocated Vehicle List";
                    ToolTip = 'Allocated Vehicle List';
                }
                action("Vehicle Allocations List-Compl")
                {
                    Caption = ' Vehicle Allocations List-Compl';
                    RunObject = Page "Vehicle Allocations List-Compl";
                    ToolTip = ' Vehicle Allocations List-Compl';
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
                    Visible = false;
                }
                action("Card Information List")
                {
                    Caption = 'Card Information List';
                    RunObject = Page "Card Information List";
                    ToolTip = 'Card Information List';
                    Visible = false;
                }
                action("Card Ledger Entries")
                {
                    Caption = 'Card Ledger Entries';
                    RunObject = Page "Card Ledger Entries";
                    ToolTip = 'Card Ledger Entries';
                    Visible = false;
                }
            }
        }
        area(embedding)
        {
            action("Imprest List")
            {
                Caption = 'Imprest List';
                RunObject = Page "Imprest List";
            }
            action(Action35)
            {
                Caption = 'Petty Cash list';
                RunObject = Page "Petty Cash list";
                Visible = false;
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
                Visible = false;
            }
            action(Action21)
            {
                Caption = 'Store Requisitions List';
                RunObject = Page "Store Requisitions List";
            }
            action("Requisition List")
            {
                Caption = 'Requisition List';
                RunObject = Page "Requisition List";
                Visible = false;
            }
            action("Fleet Imprest List")
            {
                Caption = 'Fleet Imprest List';
                RunObject = Page "Fleet Imprest List";
            }
        }
        area(reporting)
        {
            action("Daily Fuel Consumption")
            {
                Caption = 'Daily Fuel Consumption';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                //  RunObject = Report "Daily Fuel Consumption";
            }
            action("Weekly Fuel ConsumptionReport.")
            {
                Caption = 'Weekly Fuel ConsumptionReport.';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                //  RunObject = Report "Weekly Fuel Consumption";
            }
            action("Monthly  Fuel Consumption")
            {
                Caption = 'Monthly  Fuel Consumption';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                // RunObject = Report "Monthly  Fuel Consumption";
            }
            action("completed Repair Order")
            {
                Caption = 'completed Repair Order';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "completed Repair Order";
            }
        }
    }
}

