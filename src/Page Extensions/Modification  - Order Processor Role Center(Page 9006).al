pageextension 60655 pageextension60655 extends "Order Processor Role Center"
{
    actions
    {
        addafter("Sales Quotes")
        {
            action("Submitted Sales Quotes")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Submitted Sales Quotes';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Submitted Sales Quotes";
                ToolTip = 'Submitted Sales Quotes';
            }
        }
        addafter("Sales Orders")
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
        // addafter(ActionGroup76)
        // {
        //     group("Employee Self Service")
        //     {
        //         Caption = 'Employee Self Service';
        //         action(" Imprest List")
        //         {
        //             Caption = ' Imprest List';
        //             RunObject = Page "Imprest List";
        //         }
        //         action("Imprest List Status")
        //         {
        //             Caption = 'Imprest List Status';
        //             RunObject = Page "Imprest List Status";
        //         }
        //         action("Imprest Surrender List")
        //         {
        //             Caption = 'Imprest Surrender List';
        //             RunObject = Page "Imprest Surrender List";
        //             Visible = false;
        //         }
        //         action("Petty Cash list")
        //         {
        //             Caption = 'Petty Cash list';
        //             RunObject = Page "Petty Cash list";
        //         }
        //         action("Petty Cash list Status")
        //         {
        //             Caption = 'Petty Cash list Status';
        //             RunObject = Page "Petty Cash list S";
        //         }
        //         action("Store Requisitions List")
        //         {
        //             Caption = 'Store Requisitions List';
        //             RunObject = Page "Store Requisitions List";
        //         }
        //         action("Pending Store Requisitions")
        //         {
        //             Caption = 'Pending Store Requisitions';
        //             RunObject = Page "Pending Store Requisitions";
        //         }
        //         action("Store Requisitions List Status")
        //         {
        //             Caption = 'Store Requisitions List Status';
        //             RunObject = Page "Store Requisitions List Status";
        //         }
        //         action("Approved Store Requisitions")
        //         {
        //             Caption = 'Approved Store Requisitions';
        //             RunObject = Page "Approved Store Requisitions";
        //         }
        //         action("Posted Store Requisitions List")
        //         {
        //             Caption = 'Posted Store Requisitions List';
        //             RunObject = Page "Posted Store Requisitions List";
        //         }
        //         action("Purchase Requisition List")
        //         {
        //             Caption = 'Purchase Requisition List';
        //             RunObject = Page "Requisition List";
        //         }
        //         action("Status Purchase Requisition List")
        //         {
        //             Caption = 'Status Purchase Requisition List';
        //             RunObject = Page "Purchase Requisition List S";
        //         }
        //         action("Leave Application")
        //         {
        //             Caption = 'Leave Application';
        //             RunObject = Page "Leave Applications";
        //         }
        //         action(" Leave Applications Status")
        //         {
        //             Caption = ' Leave Applications Status';
        //             RunObject = Page "Leave Applications Status";
        //         }
        //         action("Leave Reimbursements")
        //         {
        //             Caption = 'Leave Reimbursements';
        //             RunObject = Page "Leave Reimbursements";
        //         }
        //         action("HR Employee Appraisals")
        //         {
        //             Caption = 'HR Employee Appraisals';
        //             RunObject = Page "HR Employee Appraisals";
        //         }
        //         action("HR Employee Appraisals Status")
        //         {
        //             Caption = 'HR Employee Appraisals Status';
        //             RunObject = Page "HR Employee Appraisals Status";
        //         }
        //         action("Transport Request List")
        //         {
        //             Caption = 'Transport Request List';
        //             RunObject = Page "Transport Request List";
        //         }
        //         action("Vehicle Allocations List")
        //         {
        //             Caption = 'Vehicle Allocations List';
        //             RunObject = Page "Vehicle Allocations List";
        //         }
        //         action("Allocated Vehicle List")
        //         {
        //             Caption = 'Allocated Vehicle List';
        //             RunObject = Page "Allocated Vehicle List";
        //         }
        //         action("Safari Notice List")
        //         {
        //             Caption = 'Safari Notice List';
        //             RunObject = Page "Safari Notice List";
        //         }
        //         action("Safari Notice List - Status")
        //         {
        //             Caption = 'Safari Notice List - Status';
        //             RunObject = Page "Safari Notice List - Status";
        //         }
        //     }
        // }
        addafter("Sales &Invoice")
        {
            action("Submitted Sales Quote")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Submitted Sales Quote';
                Image = NewSalesInvoice;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Submitted Sales Quote";
                RunPageMode = Create;
                ToolTip = 'Create a new invoice for the sales of items or services. Invoice quantities cannot be posted partially.';
            }
        }
        // addafter(ActionGroup42)
        // {
        //     group("Payroll Allowances")
        //     {
        //         Caption = 'Payroll Allowances';
        //         action("Allowance List- Open")
        //         {
        //             Caption = 'Allowance List- Open';
        //             Image = OpenJournal;
        //             Promoted = true;
        //             PromotedCategory = Process;
        //             RunObject = Page "Allowance List- Open";
        //         }
        //         action("Allowance List Pending approval")
        //         {
        //             Caption = 'Allowance List Pending approval';
        //             Image = Calculate;
        //             Promoted = true;
        //             PromotedCategory = Process;
        //             RunObject = Page "Allowance List Pending approva";
        //         }
        //         action("Allowance List- Approved")
        //         {
        //             Caption = 'Allowance List- Approved';
        //             Image = GLJournal;
        //             Promoted = true;
        //             PromotedCategory = Process;
        //             RunObject = Page "Allowance List- Approved";
        //         }
        // action("Posted Allowance List")
        // {
        //     Caption = 'Posted Allowance List';
        //     Image = GetEntries;
        //     Promoted = true;
        //     PromotedCategory = Process;
        //     RunObject = Page "Posted Allowance List";
        // }
    }
}
// addfirst(Reporting)
// {
//     group(Bottling)
//     {
//         Caption = 'Bottling';
//         Image = Customer;
//         action("Summary Sales Per SKU")
//         {
//             ApplicationArea = Basic,Suite;
//             Caption = 'Summary Sales Per SKU';
//             Image = "Report";
//             RunObject = Report "Inventory - Sales Statistics";
//             ToolTip = 'Inventory - Sales Statistics';
//         }
//         action("Customer Sales Report  Per SKU")
//         {
//             ApplicationArea = Basic,Suite;
//             Caption = 'Customer Sales Report  Per SKU';
//             Image = "Report";
//             RunObject = Report "Inventory - Customer Sales";
//             ToolTip = 'Inventory - Customer Sales';
//         }
//     }
// }
// addfirst("Customer/&Item Sales")
// {
//     action("Inventory - Availability Plan")
//     {
//         ApplicationArea = Basic,Suite;
//         Caption = 'Inventory - Availability Plan';
//         Image = ItemAvailability;
//         RunObject = Report "Inventory - Availability Plan";
//         ToolTip = 'View a list of the quantity of each item in customer, purchase, and transfer orders and the quantity available in inventory. The list is divided into columns that cover six periods with starting and ending dates as well as the periods before and after those periods. The list is useful when you are planning your inventory purchases.';
//     }
//     action("Inventory - Transaction Detail")
//     {
//         ApplicationArea = Basic,Suite;
//         Caption = 'Inventory - Transaction Detail';
//         Image = "Report";
//         RunObject = Report "Inventory - Transaction Detail";
//         ToolTip = 'View transaction details with entries for the selected items for a selected period. The report shows the inventory at the beginning of the period, all of the increase and decrease entries during the period with a running update of the inventory, and the inventory at the close of the period. The report can be used at the close of an accounting period, for example, or for an audit.';
//     }
//     action("Inventory Valuation")
//     {
//         ApplicationArea = Basic,Suite;
//         Caption = 'Inventory Valuation';
//         Image = "Report";
//         RunObject = Report "Inventory Valuation";
//         ToolTip = 'Inventory Valuation';
//     }
//     action("Inventory - Reorders")
//     {
//         ApplicationArea = Basic,Suite;
//         Caption = 'Inventory - Reorders';
//         Image = "Report";
//         RunObject = Report "Inventory - Reorders";
//         ToolTip = 'Inventory - Reorders';
//     }
//     action("Customer Statement")
//     {
//         ApplicationArea = Basic,Suite;
//         Caption = 'Customer Statement';
//         Image = "Report";
//         RunObject = Report "Standard Statement";
//         ToolTip = 'Standard Statement';
//     }
//     action(Action139)
//     {
//         ApplicationArea = Basic,Suite;
//         Caption = 'Inventory Valuation';
//         Image = "Report";
//         RunObject = Report "Inventory Valuation";
//         ToolTip = 'Inventory Valuation';
//     }
//     action(ReportCustomerTrialBalance)
//     {
//         ApplicationArea = Suite;
//         Caption = 'Customer - Trial Balance';
//         Image = "Report";
//         RunObject = Report "Customer - Trial Balance";
//         ToolTip = 'View the beginning and ending balance for customers with entries within a specified period. The report can be used to verify that the balance for a customer posting group is equal to the balance on the corresponding general ledger account on a certain date.';
//     }
//     action(ReportCustomerDetailTrial)
//     {
//         ApplicationArea = Basic,Suite;
//         Caption = 'Customer - Detail Trial Bal.';
//         Image = "Report";
//         RunObject = Report "Customer - Detail Trial Bal.";
//         ToolTip = 'View the balance for customers with balances on a specified date. The report can be used at the close of an accounting period, for example, or for an audit.';
//     }
//     action(ReportCustomerSummaryAging)
//     {
//         ApplicationArea = Suite;
//         Caption = 'Customer - Summary Aging';
//         Image = "Report";
//         RunObject = Report "Customer - Summary Aging";
//         ToolTip = 'View, print, or save a summary of each customer''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.';
//     }
//     action(ReportCustomerDetailedAging)
//     {
//         ApplicationArea = Suite;
//         Caption = 'Customer - Detailed Aging';
//         Image = "Report";
//         RunObject = Report "Customer Detailed Aging";
//         ToolTip = 'View, print, or save a detailed list of each customer''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.';
//     }
//     action(ReportAgedAccountsReceivable)
//     {
//         ApplicationArea = Basic,Suite;
//         Caption = 'Aged Accounts Receivable';
//         Image = "Report";
//         RunObject = Report "Aged Accounts Receivable";
//         ToolTip = 'View an overview of when customer payments are due or overdue, divided into four periods. You must specify the date you want aging calculated from and the length of the period that each column will contain data for.';
//     }
//     action(ReportCustomerPaymentReceipt)
//     {
//         ApplicationArea = Suite;
//         Caption = 'Customer - Payment Receipt';
//         Image = "Report";
//         RunObject = Report "Customer - Payment Receipt";
//         ToolTip = 'View a document showing which customer ledger entries that a payment has been applied to. This report can be used as a payment receipt that you send to the customer.';
//     }
// }
//moveafter(Reports;"Customer/&Item Sales")
//  }
//}

