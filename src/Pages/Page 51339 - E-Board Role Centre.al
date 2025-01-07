page 51339 "E-Board Role Centre"
{
    PageType = RoleCenter;
    ApplicationArea = All;

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
            group("Employee Self Service")
            {
                Caption = 'Employee Self Service';
                action("File Types")
                //ApplicationArea = All;
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
                action("Page Casuals Payment List")
                {
                    Caption = 'Page Casuals Payment List';
                    RunObject = Page "Casuals Payment List";
                    Visible = false;
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
                action(Action33)
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
                action("Requisition List")
                {
                    Caption = 'Requisition List';
                    RunObject = Page "Requisition List";
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
            group("Board Member")
            {
                Caption = 'Board Member';
                Image = LotInfo;
                action("Board Member List")
                {
                    Caption = 'Board Member List';
                    RunObject = Page "Board Member List";
                }
                action("Board Commitee List")
                {
                    Caption = 'Board Commitee List';
                    RunObject = Page "Board Commitee List";
                }
                action("Approval Entries")
                {
                    Caption = 'Approval Entries';
                    RunObject = Page "Approval Entries";
                    Visible = false;
                }
            }
        }
        area(embedding)
        {
            action(" Board Meeting List")
            {
                Caption = ' Board Meeting List';
                RunObject = Page "Board Meeting List";
            }
            action("Published Board Meeting List")
            {
                Caption = 'Published Board Meeting List';
                RunObject = Page "Published Board Meeting List";
            }
            action("Upcoming Board Meeting List")
            {
                Caption = 'Upcoming Board Meeting List';
                RunObject = Page "Upcoming Board Meeting List";
            }
            action("Past Board Meeting List")
            {
                Caption = 'Past Board Meeting List';
                RunObject = Page "Past Board Meeting List";
            }
            action("Cancelled Board Meeting List")
            {
                Caption = 'Cancelled Board Meeting List';
                RunObject = Page "Cancelled Board Meeting List";
            }
            action("Online Repo Documents")
            {
                Caption = 'Online Repo Documents';
                RunObject = Page "Online Repo Documents";
            }
            action("Purchase Requisition List")
            {
                Caption = 'Purchase Requisition List';
                RunObject = Page "Requisition List";
                Visible = false;
            }
        }
    }
}

