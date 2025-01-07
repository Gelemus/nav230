page 51337 "Projects Role Centre"
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
                }
                action("Petty Cash list Status")
                {
                    Caption = 'Petty Cash list Status';
                    RunObject = Page "Petty Cash list S";
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
            group("Project Management")
            {
                Caption = 'Project Management';
                Image = LotInfo;
                action("Project Request")
                {
                    Caption = 'Project Request';
                    RunObject = Page "Project Request";
                    ToolTip = 'Project Request';
                }
                action("Project Request Pending")
                {
                    Caption = 'Project Request Pending';
                    RunObject = Page "Project Request Pending";
                    ToolTip = 'Project Request Pending';
                }
                action("Approved Projects")
                {
                    Caption = 'Approved Projects';
                    RunObject = Page "Approved Projects";
                    ToolTip = 'Approved Projects';
                }
                action("Completed Projects")
                {
                    Caption = 'Completed Projectse List';
                    RunObject = Page "Completed Projects";
                    ToolTip = 'Completed Projects List';
                }
            }
            group(Process)
            {
                Caption = 'Process';
                ToolTip = ' Vehicle Allocations List-Compl';
                action("Feasiblity Study")
                {
                    Caption = 'Feasiblity Study';
                    RunObject = Page "Feasiblity Study";
                    ToolTip = 'Feasiblity Study';
                }
                action("Feasiblity Study - Submitted")
                {
                    Caption = 'Feasiblity Study - Submitted';
                    RunObject = Page "Feasiblity Study - Submitted";
                    ToolTip = 'Feasiblity Study - SubmittedList';
                }
                action("Concept Design")
                {
                    Caption = 'Concept Design';
                    RunObject = Page "Concept Design";
                    ToolTip = 'Concept Design';
                }
                action("Concept Design Approved")
                {
                    Caption = 'Concept Design Approved';
                    RunObject = Page "Concept Design Approved";
                    ToolTip = 'Concept Design Approved';
                }
                action("Project Proposal")
                {
                    Caption = 'Project Proposal';
                    RunObject = Page "Project Proposal";
                    ToolTip = 'Project Proposal';
                }
                action("Project Proposal -Approved")
                {
                    Caption = 'Project Proposal -Approved';
                    RunObject = Page "Project Proposal -Approved";
                    ToolTip = 'Project Proposal -Approved';
                }
                action("Actual Design")
                {
                    Caption = 'Actual Design';
                    RunObject = Page "Actual Design";
                    ToolTip = 'Actual Design';
                }
                action("Project Implementation")
                {
                    Caption = 'Project Implementation';
                    RunObject = Page "Project Implementation";
                    ToolTip = 'Project Implementation';
                }
            }
        }
        area(embedding)
        {
            action(Action25)
            {
                Caption = ' Imprest List';
                RunObject = Page "Imprest List";
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
        // group(Reports)
        // {
        //     Caption = 'Reports';
        //     action(Payslip)
        //     {
        //         Caption = 'Payslip';
        //         Image = "Report";
        //         Promoted = true;
        //         RunObject = Report "Employee Payslips";
        //         Visible = false;
        //     }
        //     action(" Projects List")
        //     {
        //         Caption = ' Projects List';
        //         Image = "Report";
        //         Promoted = true;
        //         RunObject = Report "Projects List";
        //     }
        //     action("Projects per status")
        //     {
        //         Caption = 'Projects per status';
        //         Image = "Report";
        //         Promoted = true;
        //         RunObject = Report "Projects per status";
        //     }
        // }
    }
}

