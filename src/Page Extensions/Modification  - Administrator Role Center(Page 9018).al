pageextension 60660 pageextension60660 extends "Administrator Role Center"
{
    layout
    {
        addbefore(Control1904484608)
        {
            part(Approvals; "Approvals Activities")
            {
                ApplicationArea = Suite;
                Caption = 'Approvals';
            }
        }

        addafter(Control52)
        {
            part(Control150; "Team Member Activities No Msgs")
            {
                ApplicationArea = Suite;
            }

        }
    }
    actions
    {
        modify(Action57)
        {
            Visible = true;
            Enabled = true;
        }
        modify("Base Calendar List")
        {

            //Unsupported feature: Property Modification (Name) on ""Base Calendar List"(Action 10)".

            Caption = 'HR Base Calendar List';

            //Unsupported feature: Property Modification (RunObject) on ""Base Calendar List"(Action 10)".

        }
        modify(Workflow)
        {
            Visible = true;
            Enabled = true;
        }
        modify(Intrastat)
        {
            Visible = false;
        }
        modify("VAT Registration Numbers")
        {
            Visible = false;
        }
        modify("Analysis View")
        {
            Visible = false;
        }
        addfirst(Embedding)
        {
            action("Leave Balances List")
            {
                Caption = 'Leave Balances List';
                RunObject = Page "Leave Balances List";
            }
            action("Inventory User Setup")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Inventory User Setup';
                Image = UserSetup;
                RunObject = Page "Inventory User Setup";
                ToolTip = 'Inventory User Setup';
            }
            action(Users)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Users';
                Image = UserSetup;
                RunObject = Page Users;
                ToolTip = 'Set up users and define their permissions.';
            }
            action("Approval Request Entries")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approval Request Entries';
                Image = UserSetup;
                RunObject = Page "Approval Request Entries";
                ToolTip = 'Approval Request Entries';
            }
        }
        addafter("User Setup")
        {
            action("User Time Registers")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'User Time Registers';
                Image = UserSetup;
                RunObject = Page "User Time Registers";
                ToolTip = 'User Time Registers';
            }
            action(Employees)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Employees';
                Image = UserInterface;
                RunObject = Page Employees;
                ToolTip = 'Set up users and define their permissions.';
                Visible = true;
            }
            action("Attendance List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Attendance List';
                Image = UserInterface;
                RunObject = Page "Attendance List";
                ToolTip = 'Set up users and define their permissions.';
                Visible = true;
            }
            action(" Attendance Summary")
            {
                ApplicationArea = Basic, Suite;
                Caption = ' Attendance Summary';
                Image = UserInterface;
                RunObject = Page "Attendance Summary";
                ToolTip = 'Set up users and define their permissions.';
                Visible = true;
            }
        }
        addafter("Workflow User Groups")
        {
            action("User Personalization List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'User Personalization List';
                Image = Users;
                RunObject = Page "User Personalization";
                ToolTip = 'User Personalization List';
            }
        }
        addfirst(Sections)
        {
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
                action("Imprest Surrender List")
                {
                    Caption = 'Imprest Surrender List';
                    RunObject = Page "Imprest Surrender List";
                    Visible = false;
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
                action(Action139)
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
                action(Action100)
                {
                    Caption = 'HR Employee Appraisals';
                    RunObject = Page "HR Employee Appraisals";
                }
                action(Action92)
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
        }
        //     addafter()
        //     {
        //         group("Administrative Reports")
        //         {
        //             Caption = 'Administrative Reports';
        //             action("Document Track Report")
        //             {
        //                 ApplicationArea = Basic,Suite;
        //                 Caption = 'Document Track Report';
        //                 Image = VendorContact;
        //                 RunObject = Report "Document Track Report";
        //                 ToolTip = 'Document Track Report';
        //             }
        //             action("User Time Register Report")
        //             {
        //                 ApplicationArea = Basic,Suite;
        //                 Caption = 'User Time Register Report';
        //                 Image = VendorContact;
        //                 RunObject = Report "User Time Register Report";
        //                 ToolTip = 'User Time Register Report';
        //             }
        //         }
        //     }
        //     moveafter(ActionContainer1900000011;"User Setup")
        //     moveafter("User Setup";"Approval User Setup")
    }
}

