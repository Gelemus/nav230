page 50823 "Secretary  Role Centre"
{
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control81)
            {
                ShowCaption = false;
                part(Control15; "Headline RC Team Member")
                {
                    ApplicationArea = Basic, Suite;
                }
                systempart(Control2; MyNotes)
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
                Visible = true;
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
                action("Petty Cash list")
                {
                    Caption = 'Petty Cash list';
                    RunObject = Page "Petty Cash list";
                    Visible = true;
                }
                action("Petty Cash list Status")
                {
                    Caption = 'Petty Cash list Status';
                    RunObject = Page "Petty Cash list S";
                    Visible = false;
                }
                action("Petty Cash Surrender list")
                {
                    Caption = 'Petty Cash Surrender list';
                    RunObject = Page "Petty Cash Surrender List";
                    Visible = true;
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
                action("Store Requisitions List")
                {
                    Caption = 'Store Requisitions List';
                    RunObject = Page "Store Requisitions List";
                }
                action("<Page Store Requisitions List St")
                {
                    Caption = 'Store Requisitions List Status';
                    RunObject = Page "Store Requisitions List Status";
                }
                action("Return to Store List")
                {
                    Caption = 'Return to Store List';
                    RunObject = Page "Return to Store List";
                }
                action("Sales Quotes")
                {
                    Caption = 'Sales Quotes';
                    RunObject = Page "Sales Quotes";
                }
                action("Submitted Sales Quotes")
                {
                    Caption = 'Submitted Sales Quotes';
                    RunObject = Page "Submitted Sales Quotes";
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
                action("Salary Advance Applications")
                {
                    Caption = 'Salary Advance Applications';
                    RunObject = Page "Salary Advance Applications";
                }
                action("Casual Requisitions")
                {
                    Caption = 'Casual Requisitions';
                    RunObject = Page "Casual Requisitions";
                }
                action("Page Casuals Payment List")
                {
                    Caption = 'Page Casuals Payment List';
                    RunObject = Page "Casuals Payment List";
                    Visible = false;
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
                action("Casuals Payment List")
                {
                    Caption = 'Casuals Payment List';
                    RunObject = Page "Casuals Payment List";
                }
                action("Approved Imprest List")
                {
                    Caption = 'Approved Imprest List';
                    RunObject = Page "Approved Imprest List";
                    Visible = false;
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
                action(Action58)
                {
                    Caption = 'Imprest Surrender List';
                    RunObject = Page "Imprest Surrender List";
                }
                action("Approved Imprest Surrender")
                {
                    Caption = 'Approved Imprest Surrender';
                    RunObject = Page "Approved Imprest Surrender";
                    Visible = false;
                }
                action("Approved Petty Cash Surrender")
                {
                    Caption = 'Approved Petty Cash Surrender';
                    RunObject = Page "Approved Petty Cash Surrender";
                    Visible = false;
                }
                action("Requisition List")
                {
                    Caption = 'Requisition List';
                    RunObject = Page "Requisition List";
                }
                action(" Salary Advance Pending Approval")
                {
                    Caption = ' Salary Advance Pending Approval';
                    RunObject = Page "Salary Advance Pending Approvl";
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
            }
            group("Fleet Management")
            {
                Caption = 'Fleet Management';
                Image = LotInfo;
                Visible = true;
                action("Repair Order List")
                {
                    Caption = 'Repair Order List';
                    RunObject = Page "Repair Order List";
                    ToolTip = 'Repair Order List';
                }
                action("Status Repair Order List")
                {
                    Caption = 'Status Repair Order List';
                    RunObject = Page "Status Repair Order List";
                    ToolTip = 'Status Repair Order List';
                }
                action("Handover Notes List")
                {
                    Caption = 'Handover Notes List';
                    RunObject = Page "Handover Note List";
                    ToolTip = 'Handover Notes List';
                }
                action("Submitted Handover Note List")
                {
                    Caption = 'Submitted Handover Note List';
                    RunObject = Page "Approved Handover Note List";
                    ToolTip = 'Submitted Handover Note List';
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
                action("Filling List")
                {
                    Caption = 'Fuel Filling List';
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
                    Visible = false;
                }
                action("Submitted Oil Requisition List")
                {
                    Caption = 'Submitted Oil Requisition List';
                    RunObject = Page "Submitted Oil Requisition List";
                    ToolTip = 'Submitted Oil Requisition List';
                    Visible = false;
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
                action("Fleet List")
                {
                    Caption = 'Fleet List';
                    RunObject = Page "Vehicle List";
                    ToolTip = 'Fleet List';
                }
            }
            group(Registry)
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
        }
        area(embedding)
        {
            action("Imprest List")
            {
                Caption = 'Imprest List';
                RunObject = Page "Imprest List";
                Visible = false;
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
                Visible = false;
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
                Visible = false;
            }
            action(Action22)
            {
                Caption = 'Requisition List';
                RunObject = Page "Requisition List";
                Visible = false;
            }
        }
        //     group(ActionGroup54)
        //     {
        //         Caption = 'Fleet Management';
        //         Visible = true;
        //         action("Daily Fuel Consumption")
        //         {
        //             Caption = 'Daily Fuel Consumption';
        //             Image = "Report";
        //             Promoted = true;
        //             PromotedCategory = "Report";
        //             RunObject = Report "Daily Fuel Consumption";
        //         }
        //         action("Weekly Fuel ConsumptionReport.")
        //         {
        //             Caption = 'Weekly Fuel ConsumptionReport.';
        //             Image = "Report";
        //             //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
        //             //PromotedCategory = "Report";
        //             RunObject = Report "Weekly Fuel Consumption";
        //         }
        //         action("Monthly  Fuel Consumption")
        //         {
        //             Caption = 'Monthly  Fuel Consumption';
        //             Image = "Report";
        //             Promoted = true;
        //             PromotedCategory = "Report";
        //             RunObject = Report "Monthly  Fuel Consumption";
        //         }
        //     }
    }
}

