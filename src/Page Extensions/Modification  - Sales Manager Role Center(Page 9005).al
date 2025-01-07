pageextension 60654 pageextension60654 extends "Sales Manager Role Center" 
{
    actions
    {
        addafter(SalesOrdersOpen)
        {
            action("Bottled Water List")
            {
                ApplicationArea = Suite;
                Caption = 'Bottled Water List';
                RunObject = Page "Bottled Water List";
                ToolTip = 'Bottled Water List';
            }
            action("Posted Bottled Water")
            {
                Caption = 'Posted Bottled Water';
                RunObject = Page "Posted Bottled Water";
            }
        }
        addafter("Administration Sales/Purchase")
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
                action("Released Leave Applications")
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
        }
    }
}

