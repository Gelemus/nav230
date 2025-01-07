pageextension 60662 pageextension60662 extends "Business Manager Role Center"
{
    actions
    {
        modify("Intrastat Journals")
        {
            Visible = false;
            Enabled = false;
        }

        //Unsupported feature: Property Modification (Name) on ""Cash Flow Forecasts"(Action 68)".


        //Unsupported feature: Property Modification (Name) on ""Chart of Cash Flow Accounts"(Action 67)".


        //Unsupported feature: Property Modification (Name) on ""Cash Flow Manual Revenues"(Action 66)".


        //Unsupported feature: Property Modification (Name) on ""Cash Flow Manual Expenses"(Action 64)".


        //Unsupported feature: Property Modification (Name) on ""Posted Sales Invoices"(Action 50)".


        //Unsupported feature: Property Modification (Name) on ""Posted Sales Credit Memos"(Action 45)".

        addafter("Excel Reports")
        {
            group("Biometric Report")
            {
                Caption = 'Biometric Report';
                action("Attendance Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Attendance Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Attendance Report";
                    ToolTip = 'Attendance Report';
                }
                action("AttendanceSummary Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'AttendanceSummary Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "AttendanceSummary Report";
                    ToolTip = 'AttendanceSummary Report';
                }
                action("User Time Register Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'User Time Register Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "User Time Register Report";
                    ToolTip = 'User Time Register Report';
                }
            }
            group("Inventory Report")
            {
                Caption = 'Inventory Report';
                action("Inventory - &Availability Plan")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inventory - &Availability Plan';
                    Image = ItemAvailability;
                    RunObject = Report "Inventory - Availability Plan";
                    ToolTip = 'View a list of the quantity of each item in customer, purchase, and transfer orders and the quantity available in inventory. The list is divided into columns that cover six periods with starting and ending dates as well as the periods before and after those periods. The list is useful when you are planning your inventory purchases.';
                }
                action("Inventory Valuation")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inventory Valuation';
                    Image = ItemAvailability;
                    RunObject = Report "Inventory Valuation";
                    ToolTip = 'View a list of the quantity of each item in customer, purchase, and transfer orders and the quantity available in inventory. The list is divided into columns that cover six periods with starting and ending dates as well as the periods before and after those periods. The list is useful when you are planning your inventory purchases.';
                }
                action("Inventory - Transaction Detail")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inventory - Transaction Detail';
                    Image = ItemAvailability;
                    RunObject = Report "Inventory - Transaction Detail";
                    ToolTip = 'View a list of the quantity of each item in customer, purchase, and transfer orders and the quantity available in inventory. The list is divided into columns that cover six periods with starting and ending dates as well as the periods before and after those periods. The list is useful when you are planning your inventory purchases.';
                }
                action("Items Per Region Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Items Per Region Report';
                    Image = "report";
                    RunObject = Report "Items Per Region Report";
                    ToolTip = 'Items Per Region Report';
                }
                action("Value Addition Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Value Addition Report';
                    Image = "report";
                    RunObject = Report "Value Addition Report I";
                    ToolTip = 'Item Consumption';
                }
                action("Receipt Summary Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Receipt Summary Report';
                    Image = "report";
                    RunObject = Report "Receipt Summary Report";
                    ToolTip = 'Receipt Summary Report';
                }
                action("Returned Materials  Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Returned Materials  Report';
                    Image = "report";
                    RunObject = Report "Return Material Summary Report";
                    ToolTip = 'Returned Material Summary Report';
                }
                action("Invoiced Customer Fittings ")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Invoiced Customer Fittings ';
                    Image = "report";
                    RunObject = Report "Invoiced Customer Fittings";
                    ToolTip = 'Invoiced Customer Fittings';
                }
                action("Shipped Order Transfers Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Shipped Order Transfers Report';
                    Image = "report";
                    RunObject = Report "Shipped Order Transfers Report";
                    ToolTip = 'Shipped Order Transfers Report';
                }
                action("Received Order Transfer Report ")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Received Order Transfer Report ';
                    Image = "report";
                    RunObject = Report "Receive Order Transfers Report";
                    ToolTip = 'Receive Order Transfer Report';
                }
                action("Item Consumption")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Consumption';
                    Image = "report";
                    RunObject = Report "Item Consumption";
                    ToolTip = 'Item Consumption';
                    Visible = false;
                }
                separator(Purchases)
                {
                    Caption = 'Purchases';
                }
                action("Invoiced Purchases Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Invoiced Purchases Report';
                    Image = "report";
                    //RunObject = Report "Invoiced Purchases Report";
                    ToolTip = 'Invoiced Purchases Report';
                }
                action("Not Invoiced Purchases Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Not Invoiced Purchases Report';
                    Image = "report";
                    RunObject = Report "Purchases Report";
                    ToolTip = 'Purchases Report';
                }
            }
            group("Payroll Reports")
            {
                Caption = 'Payroll Reports';
                action("Master Roll Report")
                {
                    Caption = 'Master Roll Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Master Roll Report";
                }
                action("Master Roll Report-Dimensions")
                {
                    Caption = 'Master Roll Report-Dimensions';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Master Roll Report-Dimensions";
                }
                action("Payroll Allowance Report")
                {
                    Caption = 'Payroll Allowance Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Payroll Allowance Report";
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
                    Visible = false;
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
                    RunObject = Report "Bank Payment Report";
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
            group("Fleet Management")
            {
                Caption = 'Fleet Management';
                action("Daily Fuel Consumption")
                {
                    Caption = 'Daily Fuel Consumption';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    // RunObject = Report "Daily Fuel Consumption";
                }
                action("Weekly Fuel ConsumptionReport.")
                {
                    Caption = 'Weekly Fuel ConsumptionReport.';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    // RunObject = Report "Weekly Fuel Consumption";
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
            }
            group("HR Reports")
            {
                Caption = 'HR Reports';
                action(Action376)
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
        }
        addafter(Vendors)
        {
            action("Leave Balances List")
            {
                Caption = 'Leave Balances List';
                RunObject = Page "Leave Balances List";
            }
        }
        addafter(Items)
        {
            action("User Time Registers")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'User Time Registers';
                Image = BankAccount;
                RunObject = Page "User Time Registers";
                ToolTip = 'User Time Registers';
            }
        }
        addafter("Chart of Accounts")
        {
            action("G/L Registers")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'G/L Registers';
                Image = GLRegisters;
                RunObject = Page "G/L Registers";
                ToolTip = 'View auditing details for all general ledger entries. Every time an entry is posted, a register is created in which you can see the first and last number of its entries in order to document when entries were posted.';
            }
            action(PurchaseOrders)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Orders';
                RunObject = Page "Purchase Order List";
                ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
            }
            action("Cancelled Purchase Order List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancelled Purchase Order List';
                RunObject = Page "Cancelled Purchase Order List";
                ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
            }
            action(PurchaseOrdersPendConf)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Pending Confirmation';
                RunObject = Page "Purchase Order List";
                RunPageView = WHERE(Status = FILTER(Open));
                ToolTip = 'View the list of purchase orders that await the vendor''s confirmation. ';
            }
            action(PurchaseOrdersPartDeliv)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Partially Delivered';
                RunObject = Page "Purchase Order List";
                RunPageView = WHERE(Status = FILTER(Released),
                                    Receive = FILTER(true),
                                    "Completely Received" = FILTER(false));
                ToolTip = 'View the list of purchases that are partially received.';
            }
            action("Cost Accounting Registers")
            {
                ApplicationArea = CostAccounting;
                Caption = 'Cost Accounting Registers';
                RunObject = Page "Cost Registers";
                ToolTip = 'View auditing details for all cost accounting entries. Every time an entry is posted, a register is created in which you can see the first and last number of its entries in order to document when entries were posted.';
                Visible = false;
            }
            action("Cost Accounting Budget Registers")
            {
                ApplicationArea = CostAccounting;
                Caption = 'Cost Accounting Budget Registers';
                RunObject = Page "Cost Budget Registers";
                ToolTip = 'View auditing details for all cost accounting budget entries. Every time an entry is posted, a register is created in which you can see the first and last number of its entries in order to document when entries were posted.';
                Visible = false;
            }
        }
        addfirst(Sections)
        {
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
            group("Approved Documents")
            {
                Caption = 'Approved Documents';
                action(" Approved Petty Cash List")
                {
                    Caption = ' Approved Petty Cash List';
                    RunObject = Page "Approved Petty Cash List";
                }
                action("Approved Imprest List")
                {
                    Caption = 'Approved Imprest List';
                    RunObject = Page "Approved Imprest List";
                }
                action("Approve Purch Requisitions")
                {
                    ApplicationArea = Suite;
                    Caption = 'Approve Purch Requisitions';
                    RunObject = Page "Approve Purch Requisitions";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
                action("Imprest List Status")
                {
                    Caption = 'Imprest List Status';
                    RunObject = Page "Imprest List Status";
                }
                action("Approved Imprest Surrender")
                {
                    Caption = 'Approved Imprest Surrender';
                    RunObject = Page "Approved Imprest Surrender";
                }
                action("Approved Store Requisitions")
                {
                    Caption = 'Approved Store Requisitions';
                    RunObject = Page "Approved Store Requisitions";
                }
                action("Fuel Filling List-Approved")
                {
                    ApplicationArea = Suite;
                    Caption = 'Fuel Filling List-Approved';
                    RunObject = Page "Fuel Filling List-Approved";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
                action("Approve Requisitions")
                {
                    ApplicationArea = Suite;
                    Caption = 'Approve Requisitions';
                    RunObject = Page "Approve  Requisitions";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
                action("<Casual Requisitions Approved>")
                {
                    Caption = 'Casual Requisitions Approved';
                }
                action("Approved Casual Payment List")
                {
                    Caption = 'Approved Casual Payment List';
                    RunObject = Page "Approved Casual Payment List";
                }
                action("Approved Payment List")
                {
                    Caption = 'Approved Payment List';
                    RunObject = Page "Approved Payment List";
                }
                action("Journal Vouchers Approved")
                {
                    Caption = 'Journal Vouchers Approved';
                    RunObject = Page "Journal Vouchers Approved";
                }
                action("Inspections Approved List")
                {
                    ApplicationArea = Suite;
                    Caption = 'Inspections Approved List';
                    RunObject = Page "Inspections Approved List";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
                action("Salary Advance Approved ")
                {
                    Caption = 'Salary Advance Approved ';
                    RunObject = Page "Salary Advance Approved";
                }
                action("<Approved Repair Order List>")
                {
                    Caption = 'Approved Repair Order List';
                    RunObject = Page "Approved Repair Order List";
                    ToolTip = 'Approved Repair Order List';
                }
                action("<Allocated Vehicle List>")
                {
                    Caption = 'Allocated Vehicle List';
                    RunObject = Page "Allocated Vehicle List";
                    ToolTip = 'Allocated Vehicle List';
                }
                action("<Work Ticket List-Approved>")
                {
                    Caption = 'Work Ticket List-Approved';
                    RunObject = Page "Work Ticket List-Approved";
                    ToolTip = 'Work Ticket List-Approved';
                }
                action("<Work Ticket List-Closed>")
                {
                    Caption = 'Work Ticket List-Closed';
                    RunObject = Page "Work Ticket List-Closed";
                    ToolTip = 'Work Ticket List-Closed';
                    Visible = false;
                }
            }
            group(ActionGroup270)
            {
                Caption = 'Fixed Assets';
                Image = FixedAssets;
                Visible = false;
                action(Action269)
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets';
                    RunObject = Page "Fixed Asset List";
                    ToolTip = 'Manage periodic depreciation of your machinery or machines, keep track of your maintenance costs, manage insurance policies related to fixed assets, and monitor fixed asset statistics.';
                }
                action(Insurance)
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Insurance';
                    RunObject = Page "Insurance List";
                    ToolTip = 'Manage insurance policies for fixed assets and monitor insurance coverage.';
                    Visible = false;
                }
                action("Fixed Assets G/L Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets G/L Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Assets),
                                        Recurring = CONST(false));
                    ToolTip = 'Post fixed asset transactions, such as acquisition and depreciation, in integration with the general ledger. The FA G/L Journal is a general journal, which is integrated into the general ledger.';
                    Visible = false;
                }
                action("Fixed Assets Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets Journals';
                    RunObject = Page "FA Journal Batches";
                    RunPageView = WHERE(Recurring = CONST(false));
                    ToolTip = 'Post fixed asset transactions, such as acquisition and depreciation book without integration to the general ledger.';
                    Visible = false;
                }
                action("Fixed Assets Reclass. Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets Reclass. Journals';
                    RunObject = Page "FA Reclass. Journal Batches";
                    ToolTip = 'Transfer, split, or combine fixed assets by preparing reclassification entries to be posted in the fixed asset journal.';
                    Visible = false;
                }
                action("Insurance Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Insurance Journals';
                    RunObject = Page "Insurance Journal Batches";
                    ToolTip = 'Post entries to the insurance coverage ledger.';
                    Visible = false;
                }
                action("<Action3>")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Recurring General Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(true));
                    ToolTip = 'Define how to post transactions that recur with few or no changes to general ledger, bank, customer, vendor, or fixed asset accounts';
                    Visible = false;
                }
                action("Recurring Fixed Asset Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Recurring Fixed Asset Journals';
                    RunObject = Page "FA Journal Batches";
                    RunPageView = WHERE(Recurring = CONST(true));
                    ToolTip = 'Post recurring fixed asset transactions, such as acquisition and depreciation book without integration to the general ledger.';
                    Visible = false;
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
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
                    Visible = false;
                }
            }
            group("Cash Flow")
            {
                Caption = 'Cash Flow';
                Visible = false;
                action("Cash Flow Forecasts1")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Forecasts';
                    RunObject = Page "Cash Flow Forecast List";
                    ToolTip = 'Combine various financial data sources to find out when a cash surplus or deficit might happen or whether you should pay down debt, or borrow to meet upcoming expenses.';
                }
                action("Chart of Cash Flow Accounts1")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Chart of Cash Flow Accounts';
                    RunObject = Page "Chart of Cash Flow Accounts";
                    ToolTip = 'View a chart contain a graphical representation of one or more cash flow accounts and one or more cash flow setups for the included general ledger, purchase, sales, services, or fixed assets accounts.';
                }
                action("Cash Flow Manual Revenues1")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Manual Revenues';
                    RunObject = Page "Cash Flow Manual Revenues";
                    ToolTip = 'Record manual revenues, such as rental income, interest from financial assets, or new private capital to be used in cash flow forecasting.';
                }
                action("Cash Flow Manual Expenses1")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Manual Expenses';
                    RunObject = Page "Cash Flow Manual Expenses";
                    ToolTip = 'Record manual expenses, such as salaries, interest on credit, or planned investments to be used in cash flow forecasting.';
                }
            }
            group("Cost Accounting")
            {
                Caption = 'Cost Accounting';
                Visible = false;
                action("Cost Types")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Cost Types';
                    RunObject = Page "Chart of Cost Types";
                    ToolTip = 'View the chart of cost types with a structure and functionality that resembles the general ledger chart of accounts. You can transfer the general ledger income statement accounts or create your own chart of cost types.';
                }
                action("Cost Centers")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Cost Centers';
                    RunObject = Page "Chart of Cost Centers";
                    ToolTip = 'Manage cost centers, which are departments and profit centers that are responsible for costs and income. Often, there are more cost centers set up in cost accounting than in any dimension that is set up in the general ledger. In the general ledger, usually only the first level cost centers for direct costs and the initial costs are used. In cost accounting, additional cost centers are created for additional allocation levels.';
                }
                action("Cost Objects")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Cost Objects';
                    RunObject = Page "Chart of Cost Objects";
                    ToolTip = 'Set up cost objects, which are products, product groups, or services of a company. These are the finished goods of a company that carry the costs. You can link cost centers to departments and cost objects to projects in your company.';
                }
                action("Cost Allocations")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Cost Allocations';
                    RunObject = Page "Cost Allocation Sources";
                    ToolTip = 'Manage allocation rules to allocate costs and revenues between cost types, cost centers, and cost objects. Each allocation consists of an allocation source and one or more allocation targets. For example, all costs for the cost type Electricity and Heating are an allocation source. You want to allocate the costs to the cost centers Workshop, Production, and Sales, which are three allocation targets.';
                }
                action("Cost Budgets")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Cost Budgets';
                    RunObject = Page "Cost Budget Names";
                    ToolTip = 'Set up cost accounting budgets that are created based on cost types just as a budget for the general ledger is created based on general ledger accounts. A cost budget is created for a certain period of time, for example, a fiscal year. You can create as many cost budgets as needed. You can create a new cost budget manually, or by importing a cost budget, or by copying an existing cost budget as the budget base.';
                }
            }
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                action("Posted Payment List")
                {
                    Caption = 'Posted Payment List';
                    RunObject = Page "Posted Payment List";
                }
                action("Posted Imprest List")
                {
                    Caption = 'Posted Imprest List';
                    RunObject = Page "Posted Imprest List";
                }
                action("Posted Transfer Receipts")
                {
                    Caption = 'Posted Transfer Receipts';
                    RunObject = Page "Posted Transfer Receipts";
                    Visible = true;
                }
                action("Posted Store Requisitions List")
                {
                    Caption = 'Posted Store Requisitions List';
                    RunObject = Page "Posted Store Requisitions List";
                    Visible = true;
                }
                action("Posted Imprest Surrender List")
                {
                    Caption = 'Posted Imprest Surrender List';
                    RunObject = Page "Posted Imprest Surrender List";
                    Visible = true;
                }
                action("Posted Cash Payment List")
                {
                    Caption = 'Posted Cash Payment List';
                    RunObject = Page "Posted Cash Payment List";
                }
                action("Posted Receipt List")
                {
                    Caption = 'Posted Receipt List';
                    RunObject = Page "Posted Receipt List";
                }
                action("Posted Petty Cash List")
                {
                    Caption = 'Posted Petty Cash List';
                    RunObject = Page "Posted Petty Cash List";
                }
                action("Posted Petty Surrender List")
                {
                    Caption = 'Posted Petty Surrender List';
                    RunObject = Page "Posted Petty Surrender List";
                }
                action("Salary Advance posted")
                {
                    Caption = 'Salary Advance posted';
                    RunObject = Page "Salary Advance posted";
                }
                action("Posted Funds Transfer List")
                {
                    Caption = 'Posted Funds Transfer List';
                    RunObject = Page "Posted Funds Transfer List";
                    Visible = true;
                }
                action("Journal Vouchers Posted")
                {
                    Caption = 'Journal Vouchers Posted';
                    RunObject = Page "Journal Vouchers Posted";
                }
                action("Posted Sales Invoices1")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Invoices";
                    ToolTip = 'Open the list of posted sales invoices.';
                }
                action("Posted Sales Credit Memos1")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Credit Memos";
                    ToolTip = 'Open the list of posted sales credit memos.';
                }
                action("Posted Purchase Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ToolTip = 'Open the list of posted purchase invoices.';
                }
                action(Action230)
                {
                    Caption = 'Journal Vouchers Posted';
                    RunObject = Page "Journal Vouchers Posted";
                }
                action("Posted Purchase Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ToolTip = 'Open the list of posted purchase credit memos.';
                }
                action("Posted Purchase Receipts")
                {
                    ApplicationArea = Suite;
                    Caption = 'Posted Purchase Receipts';
                    Image = OrderReminder;
                    RunObject = Page "Posted Purchase Receipts";
                    ToolTip = 'View the list of Posted Purchase Receipts';
                }
                action("Issued Fin. Charge Memos")
                {
                    ApplicationArea = Suite;
                    Caption = 'Issued Fin. Charge Memos';
                    Image = PostedMemo;
                    RunObject = Page "Issued Fin. Charge Memo List";
                    ToolTip = 'View the list of issued finance charge memos.';
                    Visible = false;
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
                action("Closed Requisition List")
                {
                    ApplicationArea = Suite;
                    Caption = 'Closed Requisition List';
                    RunObject = Page "Closed  Requisition List";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
                action("Closed Purchase Req. List")
                {
                    ApplicationArea = Suite;
                    Caption = 'Closed Purchase Req. List';
                    RunObject = Page "Closed Purchase Req. List";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
                action("Closed Req. for Quotation List")
                {
                    ApplicationArea = Suite;
                    Caption = 'Closed Req. for Quotation List';
                    RunObject = Page "Closed Req. for Quotation List";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
                action("Released Bid Analysis List")
                {
                    ApplicationArea = Suite;
                    Caption = 'Released Bid Analysis List';
                    RunObject = Page "Released Bid Analysis List";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
                action(Action221)
                {
                    Caption = 'Posted Store Requisitions List';
                    RunObject = Page "Posted Store Requisitions List";
                }
                action("Safari Notice List - Status")
                {
                    Caption = 'Safari Notice List - Status';
                    RunObject = Page "Safari Notice List - Status";
                }
                action("Posted Purchase Receipts (GRN)")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Receipts (GRN)';
                    RunObject = Page "Posted Purchase Receipts";
                    ToolTip = 'Open the list of posted purchase receipts.';
                }
                action(Action218)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Registers';
                    Image = GLRegisters;
                    RunObject = Page "G/L Registers";
                    ToolTip = 'View posted G/L entries.';
                    Visible = false;
                }
                action(Action217)
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Cost Accounting Registers';
                    RunObject = Page "Cost Registers";
                    ToolTip = 'Get an overview of all cost entries sorted by posting date. ';
                    Visible = false;
                }
                action(Action180)
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Cost Accounting Budget Registers';
                    RunObject = Page "Cost Budget Registers";
                    ToolTip = 'Get an overview of all cost budget entries sorted by posting date. ';
                    Visible = false;
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
                action(Action153)
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
                action("Safari Notice List")
                {
                    Caption = 'Safari Notice List';
                    RunObject = Page "Safari Notice List";
                }
                action(Action155)
                {
                    Caption = 'Safari Notice List - Status';
                    RunObject = Page "Safari Notice List - Status";
                }
            }
        }
        // addfirst(SetupAndExtensions)
        // {
        //     action("City Lookup Values")
        //     {
        //         Caption = 'City Lookup Values';
        //         RunObject = Page "Procurement Lookup Values";
        //     }
        //     action("Allowance Matrix")
        //     {
        //         Caption = 'Allowance Matrix';
        //         RunObject = Page "Allowance Matrix";
        //     }
        //     action("Cluster Codes")
        //     {
        //         Caption = 'Cluster Codes';
        //         RunObject = Page "Cluster Codes";
        //     }
        //     action("Casual Rates")
        //     {
        //         Caption = 'Casual Rates';
        //         RunObject = Page "Casual Rates";
        //     }
        //     action("Fuel Prices")
        //     {
        //         Caption = 'Fuel Prices';
        //         RunObject = Page "Fuel Prices";
        //     }
        // }
        // addafter(SetupAndExtensions)
        // {
        //     group("HR Jobs Management")
        //     {
        //         Caption = 'HR Jobs Management';
        //         Image = Administration;
        //         action("Human Resource Jobs List")
        //         {
        //             Caption = 'HR Jobs List';
        //             Image = Job;
        //             RunObject = Page "HR Jobs List";
        //             ToolTip = 'Shows HR Job List';
        //         }
        //         action("Approved Human Resource Jobs")
        //         {
        //             Caption = '<Approved HR Jobs>';
        //             Image = Job;
        //             RunObject = Page "Approved HR Jobs";
        //             Visible = false;
        //         }
        //         action("Human Resorce Job Grades List")
        //         {
        //             Caption = '<HR Job Grades List>';
        //             Image = GanttChart;
        //             RunObject = Page "HR Job Grades";
        //         }
        //         action("Human Resource Job Values List")
        //         {
        //             Caption = '<HR Job Values List>';
        //             Image = GanttChart;
        //             RunObject = Page "HR Job Values";
        //         }
        //     }
        //     group("HR Recruitment Management")
        //     {
        //         Caption = 'HR Recruitment Management';
        //         Image = ProductDesign;
        //         action("Employee Requisitions")
        //         {
        //             ApplicationArea = Manufacturing;
        //             Caption = 'Employee Requisitions List';
        //             Image = ConsumptionJournal;
        //             RunObject = Page "Employee Requisitions";
        //             ToolTip = 'Employee Requisitions List.';
        //         }
        //         action("HR Shortlisted Job Applicants")
        //         {
        //             Caption = 'HR Shortlisted Job Applicants List';
        //             RunObject = Page "HR Shortlisted Job Applicants";
        //             ToolTip = 'HR Shortlisted Job Applicants List';
        //         }
        //         action("Closed Employee Requisitions List")
        //         {
        //             Caption = 'Closed Employee Requisitions List';
        //             RunObject = Page "Closed Employee Requisitions";
        //             ToolTip = 'Closed Employee Requisitions List';
        //         }
        //         action("HR Job Applications List")
        //         {
        //             Caption = 'HR Job Applications List';
        //             RunObject = Page "HR Job Applications";
        //             ToolTip = 'HR Job Applications List';
        //         }
        //         action(" Closed Job Applications List")
        //         {
        //             Caption = 'Closed Job Applications List';
        //             RunObject = Page "Closed Job Applications";
        //             ToolTip = 'Closed Job Applications List';
        //         }
        //         action("Interview Panel List")
        //         {
        //             Caption = 'Interview Panel List';
        //             RunObject = Page "Interview Header List";
        //             ToolTip = 'Interview Panel List';
        //         }
        //         action("Dept Interview Panel List")
        //         {
        //             Caption = 'Dept Interview Panel List';
        //             RunObject = Page "Dept Interview Panel List";
        //             ToolTip = 'Department Interview Panel List';
        //         }
        //     }
        //     group("Employee Management")
        //     {
        //         Caption = 'Employee Management';
        //         Image = HumanResources;
        //         action("HR Employees Permanent List")
        //         {
        //             Caption = 'HR Permanent  Employees';
        //             RunObject = Page Employees;
        //             ToolTip = 'HR Employees Permanent List';
        //         }
        //         action("Short Term Employees List")
        //         {
        //             Caption = 'HR Contract Employees';
        //             RunObject = Page Employees;
        //             RunPageView = WHERE("Emplymt. Contract Code" = CONST('CONTRACT'));
        //             ToolTip = 'Human Resource Short Term Employees List';
        //             Visible = false;
        //         }
        //         action("HR Employees Piece Rate List")
        //         {
        //             Caption = 'Piece Rate List';
        //             RunObject = Page Employees;
        //             RunPageView = WHERE("Emplymt. Contract Code" = CONST('CASUALS'));
        //             ToolTip = 'HR Employees Permanent List';
        //             Visible = false;
        //         }
        //         action("In-Active Employees Interns")
        //         {
        //             RunObject = Page "In-Active Employees Interns";
        //             Visible = false;
        //         }
        //         action(" Inactive Employees")
        //         {
        //             Caption = 'HR Permanent In-Active';
        //             RunObject = Page "Inactive Employees";
        //             RunPageView = WHERE("Emplymt. Contract Code" = CONST('PERMANENT'));
        //         }
        //         action("Terminated Piece RateList")
        //         {
        //             Caption = 'Terminate Piece Rate';
        //             RunObject = Page "In-Active Employees other";
        //             RunPageView = WHERE("Emplymt. Contract Code" = CONST('CAUSUALS'));
        //             Visible = false;
        //         }
        //         action("In-Active Employees other")
        //         {
        //             Caption = 'HR Contract In- Active';
        //             RunObject = Page "In-Active Employees other";
        //             RunPageView = WHERE("Emplymt. Contract Code" = CONST('CONTRACT'));
        //             Visible = false;
        //         }
        //     }
        //     group("Leave Management")
        //     {
        //         Caption = 'Leave Management';
        //         Image = ExecuteBatch;
        //         action("Leave Planner List")
        //         {
        //             Caption = 'Leave Planner List';
        //             RunObject = Page "Leave Planner List";
        //             ToolTip = 'Human Resource Leave Planner List';
        //         }
        //         action("Approved Leave Planner List")
        //         {
        //             Caption = 'Approved Planner List';
        //             RunObject = Page "Approved Leave Planner List";
        //             ToolTip = 'Human Resource Approved Leave Planner List';
        //         }
        //         action(" Leave Applications")
        //         {
        //             Caption = 'Leave Application';
        //             RunObject = Page "Leave Applications";
        //             ToolTip = 'Human Resource Leave Applications List';
        //         }
        //         action("Leave Applications Pending")
        //         {
        //             Caption = 'Leave Applications Pending';
        //             RunObject = Page "Leave Applications Pending";
        //             ToolTip = 'Human Resource Approved Leave Applications List';
        //             Visible = false;
        //         }
        //         action("Released Leave Applications")
        //         {
        //             Caption = 'Approved Leave';
        //             RunObject = Page "Released Leave Applications";
        //             ToolTip = 'Human Resource Approved Leave Applications List';
        //             Visible = false;
        //         }
        //         action("Posted Leave Applications List")
        //         {
        //             Caption = 'Posted Leave';
        //             RunObject = Page "Posted Leave Applications";
        //             ToolTip = 'Human Resource Posted Leave Applications List';
        //         }
        //         action("Leave Reimbursements List")
        //         {
        //             Caption = 'Leave Reimbursements List';
        //             RunObject = Page "Leave Reimbursements";
        //             ToolTip = 'Human Resource Leave Reimbursements List';
        //         }
        //         action("Posted Leave Reimbursements List")
        //         {
        //             Caption = 'Posted Leave Reimbursements';
        //             RunObject = Page "Posted Leave Reimbursements";
        //             ToolTip = 'Human Posted Leave Reimbursements List';
        //         }
        //         action(" Leave Carryovers List")
        //         {
        //             Caption = 'Leave Carryover List';
        //             RunObject = Page "Leave Carryovers";
        //             ToolTip = 'Human Resource Leave Carryover List';
        //             Visible = false;
        //         }
        //         action("Posted Leave Carryovers List")
        //         {
        //             Caption = 'Posted Leave Carryovers List';
        //             RunObject = Page "Posted Leave Carryovers";
        //             ToolTip = 'Human Resource Posted Leave Carryovers List';
        //             Visible = false;
        //         }
        //         action("Leave Allocations List")
        //         {
        //             Caption = 'Leave Allocations List';
        //             RunObject = Page "Leave Allocations";
        //             ToolTip = 'Human Resource Leave Allocations List';
        //         }
        //         action("Posted Leave Allocations List")
        //         {
        //             Caption = 'Posted Leave Allocations List';
        //             RunObject = Page "Posted Leave Allocations";
        //             ToolTip = 'Human Resource Posted Leave Allocations List';
        //         }
        //         action("Leave Types List")
        //         {
        //             Caption = 'Leave Types List';
        //             RunObject = Page "Leave Types";
        //             ToolTip = 'Human Resource Leave Types List ';
        //         }
        //         action("Leave Periods List")
        //         {
        //             Caption = 'Leave Periods List';
        //             RunObject = Page "Leave Periods";
        //             ToolTip = 'Human Resource Leave Periods List ';
        //         }
        //     }
        //     group("Performace Management")
        //     {
        //         Caption = 'Performace Management';
        //         Image = Calculator;
        //         action("HR Employee Appraisals List")
        //         {
        //             Caption = 'Employee Appraisals List';
        //             RunObject = Page "HR Employee Appraisals";
        //             ToolTip = 'Human Resoource Employee Appraisals List';
        //         }
        //         action("Human Resource Global Appraisal Objectives")
        //         {
        //             Caption = 'Global Appraisal Objectives KPI';
        //             RunObject = Page "HR Appraisal Global Objectives";
        //             Visible = false;
        //         }
        //         action("Performance Objectives")
        //         {
        //             Caption = 'Performance Objectives';
        //             RunObject = Page "Membership Numbers";
        //             Visible = false;
        //         }
        //         action("HR Appraisal Global Competency")
        //         {
        //             Caption = 'Appraisal Global Competency';
        //             RunObject = Page "HR Appraisal Global Competency";
        //             Visible = false;
        //         }
        //         action("HR Appraisal Period")
        //         {
        //             Caption = 'Appraisal Period';
        //             RunObject = Page "HR Appraisal Period";
        //             ToolTip = 'Human Resource Appraisal Period';
        //         }
        //     }
        //     group("Training Management")
        //     {
        //         Caption = 'Training Management';
        //         Image = LotInfo;
        //         action("HR Training Needs List")
        //         {
        //             Caption = 'Training Needs List';
        //             RunObject = Page "Training Needs";
        //             ToolTip = 'Human Resource Training Needs List';
        //         }
        //         action("Proposed Training Needs List")
        //         {
        //             Caption = 'Approved Training Need List';
        //             RunObject = Page "Proposed Training Needs List";
        //             ToolTip = 'Human Resource Proposed Training Needs List';
        //         }
        //         action("HR Approved Training Need List")
        //         {
        //             Caption = 'Approved Training Need List';
        //             Enabled = true;
        //             RunObject = Page "HR Approved Training Need List";
        //             ToolTip = 'Human Resorce Approved Training Need List';
        //             Visible = false;
        //         }
        //         action("HR Training Groups List")
        //         {
        //             Caption = 'Training Groups List';
        //             RunObject = Page "Training Groups";
        //             ToolTip = 'Human Resorce Training Groups List';
        //         }
        //         action("HR Training Applications List")
        //         {
        //             Caption = 'Training Applications List';
        //             RunObject = Page "Training Applications";
        //             ToolTip = 'Human Resource Training Applications List';
        //         }
        //         action("HR Training Evaluation List")
        //         {
        //             Caption = 'Training Evaluation List';
        //             RunObject = Page "Training Evaluation List";
        //             ToolTip = 'Human Resorce Training Evaluation List';
        //         }
        //     }
        //     group("Employee Disciplinary Management")
        //     {
        //         Caption = 'Employee Disciplinary Management';
        //         Image = LotInfo;
        //         action("HR Employee Disciplinary Cases List")
        //         {
        //             Caption = 'Disciplinary Cases List';
        //             RunObject = Page "Disciplinary Case";
        //             ToolTip = 'Human Resource Disciplinary Cases List';
        //         }
        //         action("HR Closed Disciplinary Cases List")
        //         {
        //             Caption = 'Closed Disciplinary Cases List';
        //             RunObject = Page "Closed Disciplinary Cases";
        //             ToolTip = 'Human Resource Closed Disciplinary Cases List';
        //         }
        //     }
        //     group(ActionGroup358)
        //     {
        //         Caption = 'Fleet Management';
        //         Image = LotInfo;
        //         action("Employees List")
        //         {
        //             Caption = 'Employee  List';
        //             RunObject = Page "Employees List";
        //             ToolTip = 'Driver List';
        //         }
        //         action("Driver List")
        //         {
        //             Caption = 'Driver List';
        //             RunObject = Page "Driver List";
        //             ToolTip = 'Driver List';
        //         }
        //         action("Fleet List")
        //         {
        //             Caption = 'Fleet List';
        //             RunObject = Page "Vehicle List";
        //             ToolTip = 'Fleet List';
        //         }
        //         action("Handover Notes List")
        //         {
        //             Caption = 'Handover Notes List';
        //             RunObject = Page "Handover Note List";
        //             ToolTip = 'Handover Notes List';
        //         }
        //         action("Submitted Handover Note List")
        //         {
        //             Caption = 'Approved Handover Note List';
        //             RunObject = Page "Approved Handover Note List";
        //             ToolTip = 'Submitted Handover Note List';
        //         }
        //         action("Repair Order List")
        //         {
        //             Caption = 'Repair Order List';
        //             RunObject = Page "Repair Order List";
        //             ToolTip = 'Repair Order List';
        //         }
        //         action("Pending Approval Repair Order List")
        //         {
        //             Caption = 'Pending Approval Repair Order List';
        //             RunObject = Page "Pending ApproRepair Order List";
        //             ToolTip = 'Pending Approval Repair Order List';
        //         }
        //         action("Approved Repair Order List")
        //         {
        //             Caption = 'Approved Repair Order List';
        //             RunObject = Page "Approved Repair Order List";
        //             ToolTip = 'Approved Repair Order List';
        //         }
        //         action("Page Safari Notice List")
        //         {
        //             Caption = 'Safari Notice List';
        //             RunObject = Page "Safari Notice List";
        //         }
        //         action("Page Pending App Safari Notice ")
        //         {
        //             Caption = 'Pending Approval Safari Notice List';
        //             RunObject = Page "Pending App Safari Notice List";
        //         }
        //         action("Page Approval Safari Notice Lis")
        //         {
        //             Caption = 'Approved Safari Notice List';
        //             RunObject = Page "Approval Safari Notice List";
        //         }
        //         action("Filling List")
        //         {
        //             Caption = 'Fuel Requisition List';
        //             RunObject = Page "Fuel Filling List";
        //             ToolTip = 'Filling List';
        //         }
        //         action("Fuel Requisition Pending List")
        //         {
        //             Caption = 'Fuel Requisition Pending List';
        //             RunObject = Page "Fuel Filling List-Pening Appro";
        //             ToolTip = 'Fuel Requisition Pending List';
        //         }
        //         action("Fuel Requisition Approved List")
        //         {
        //             Caption = 'Fuel Requisition Approved List';
        //             RunObject = Page "Fuel Filling List-Approved";
        //             ToolTip = 'Fuel Requisition Approved List';
        //         }
        //     }
        // }
    }
}

