page 50700 "Payroll Accountant Role Center"
{
    Caption = 'Accountant', Comment = 'Use same translation as ''Profile Description'' (if applicable)';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control76; "Headline RC Accountant")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control123; "Team Member Activities")
            {
                ApplicationArea = Suite;
                Visible = false;
            }
            part(Control99; "Finance Performance")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control1902304208; "Accountant Activities")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control1907692008; "My Accounts")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control122; "Power BI Report Spinner Part")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control103; "Trailing Sales Orders Chart")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control106; "My Job Queue")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control9; "Help And Chart Wrapper")
            {
                //AccessByPermission = TableData "Assisted Setup"=R;
                ApplicationArea = Basic, Suite;
                Visible = false;
                ToolTip = 'Specifies the view of your business assistance';
            }
            part(Control100; "Cash Flow Forecast Chart")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control108; "Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox" = IMD;
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            systempart(Control1901377608; MyNotes)
            {
                ApplicationArea = Basic, Suite;
                // Visible = false;
            }
        }
    }

    actions
    {
        area(reporting)
        {
            group("G/L Reports")
            {
                Caption = 'G/L Reports';
                Visible = false;
                action("Casual Payment  Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Casual Payment  Report';
                    Image = "Report";
                    RunObject = Report "Casual Payment  Report";
                    Visible = false;
                    ToolTip = 'View, print, or send a report that shows the balances for the general ledger accounts, including the debits and credits. You can use this report to ensure accurate accounting practices.';
                }
                action("&G/L Trial Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&G/L Trial Balance';
                    Image = "Report";
                    RunObject = Report "Trial Balance";
                    Visible = false;
                    ToolTip = 'View, print, or send a report that shows the balances for the general ledger accounts, including the debits and credits. You can use this report to ensure accurate accounting practices.';
                }
                action("Petty Cash Reports")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Petty Cash Reports';
                    Image = "Report";
                    RunObject = Report "Petty Cash Reports";
                    ToolTip = 'Petty Cash Reports';
                    Visible = false;
                }
                action("Transaction By Account")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Transaction By Account';
                    Image = "Report";
                    RunObject = Report "Transaction By Acc";
                    Visible = false;
                    ToolTip = 'View, print, or send a report that shows the balances for the general ledger accounts, including the debits and credits. You can use this report to ensure accurate accounting practices.';
                }
                action("Petty Cash Surrender Summary")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Petty Cash Surrender Summary';
                    Image = "Report";
                    RunObject = Report "Petty Cash Surrender Summary";
                    ToolTip = 'Petty Cash Surrender Summary';
                    Visible = false;
                }
                action("Trial Balance by Period")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Trial Balance by Period';
                    Image = "Report";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Trial Balance by Period";
                    Visible = false;
                    ToolTip = 'View the opening balance by general ledger account, the movements in the selected period of month, quarter, or year, and the resulting closing balance.';
                }
                action("&Bank Detail Trial Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Bank Detail Trial Balance';
                    Image = "Report";
                    RunObject = Report "Bank Acc. - Detail Trial Bal.";
                    Visible = false;
                    ToolTip = 'View, print, or send a report that shows a detailed trial balance for selected bank accounts. You can use the report at the close of an accounting period or fiscal year.';
                }
                action("&Account Schedule")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Account Schedule';
                    Image = "Report";
                    RunObject = Report "Account Schedule";
                    Visible = false;
                    ToolTip = 'Open an account schedule to analyze figures in general ledger accounts or to compare general ledger entries with general ledger budget entries.';
                }
                action("Bu&dget")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bu&dget';
                    Image = "Report";
                    RunObject = Report Budget;
                    Visible = false;
                    ToolTip = 'View or edit estimated amounts for a range of accounting periods.';
                }
                action("Trial Bala&nce/Budget")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Trial Bala&nce/Budget';
                    Image = "Report";
                    Visible = false;
                    RunObject = Report "Trial Balance/Budget";
                    ToolTip = 'View a trial balance in comparison to a budget. You can choose to see a trial balance for selected dimensions. You can use the report at the close of an accounting period or fiscal year.';
                }
                action("Trial Balance by &Period")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Trial Balance by &Period';
                    Image = "Report";
                    Visible = false;
                    RunObject = Report "Trial Balance by Period";
                    ToolTip = 'Show the opening balance by general ledger account, the movements in the selected period of month, quarter, or year, and the resulting closing balance.';
                }
                action("&Fiscal Year Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Fiscal Year Balance';
                    Image = "Report";
                    Visible = false;
                    RunObject = Report "Fiscal Year Balance";
                    ToolTip = 'View, print, or send a report that shows balance sheet movements for selected periods. The report shows the closing balance by the end of the previous fiscal year for the selected ledger accounts. It also shows the fiscal year until this date, the fiscal year by the end of the selected period, and the balance by the end of the selected period, excluding the closing entries. The report can be used at the close of an accounting period or fiscal year.';
                }
                action("Balance Comp. - Prev. Y&ear")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Balance Comp. - Prev. Y&ear';
                    Image = "Report";
                    Visible = false;
                    RunObject = Report "Balance Comp. - Prev. Year";
                    ToolTip = 'View a report that shows your company''s assets, liabilities, and equity compared to the previous year.';
                }
                action("&Closing Trial Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Closing Trial Balance';
                    Image = "Report";
                    Visible = false;
                    RunObject = Report "Closing Trial Balance";
                    ToolTip = 'View, print, or send a report that shows this year''s and last year''s figures as an ordinary trial balance. The closing of the income statement accounts is posted at the end of a fiscal year. The report can be used in connection with closing a fiscal year.';
                }
                action("Dimensions - Total")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions - Total';
                    Image = "Report";
                    Visible = false;
                    RunObject = Report "Dimensions - Total";
                    ToolTip = 'View how dimensions or dimension sets are used on entries based on total amounts over a specified period and for a specified analysis view.';
                }
                action("Monthly  Fuel Consumption")
                {
                    Caption = 'Monthly  Fuel Consumption';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;
                    // RunObject = Report "Monthly  Fuel Consumption";
                }
                action("Employees Statement")
                {
                    Caption = 'Employees Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Employees Statement";
                    Visible = false;
                }
            }
            group("Monthly Reports")
            {
                Caption = 'Monthly Reports';
                Visible = false;
                action("Master Roll Report")
                {
                    Caption = 'Master Roll Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Master Roll Report";
                    Visible = false;
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
                    RunObject = Report "Company Payslip1";
                    Visible = false;
                }
                action(Payslip)
                {
                    Caption = 'Payslip';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report Payslips;
                    Visible = false;
                }
                action("ED Report")
                {
                    Caption = 'ED Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "ED Report";
                    Visible = false;
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
                    Visible = false;
                }
                action("Staff Gratuity Report")
                {
                    Caption = 'Staff Gratuity Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Staff Gratuity Report";
                    Visible = false;

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
                action(" Institution Based ED Report In")
                {
                    Caption = ' Institution Based ED Report In';
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
                    Visible = false;
                }
                action(" Payroll Reconciliation-All ED")
                {
                    Caption = ' Payroll Reconciliation-All ED';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Payroll Reconciliation-All ED";
                    Visible = false;
                }
                action(" Bank Payment Report")
                {
                    Caption = ' Bank Payment Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Bank Payment Report";
                    Visible = false;
                }
                action(Action267)
                {
                    Caption = 'Institution Based ED Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Institution Based ED Report";
                    Visible = false;
                }
                action("Net Pay Report")
                {
                    Caption = 'Net Pay Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Net Payments";
                    Visible = false;
                }
            }
            group("Monthly Statutory Reports")
            {
                Caption = 'Monthly Statutory Reports';
                Visible = false;
                action("NSSF Report")
                {
                    Caption = 'NSSF Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "NSSF Report";
                    Visible = false;
                }
                action("NSSF Tier Report")
                {
                    Caption = 'NSSF Tier Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "NSSF Tier Report";
                    Visible = false;
                }
                action("NSSF CSV")
                {
                    Caption = 'NSSF CSV';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "NSSF CSV";
                    Visible = false;
                }
                action("NHIF Report")
                {
                    Caption = 'NHIF Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "NHIF Report";
                    Visible = false;
                }
                action("NHIF CSV")
                {
                    Caption = 'NHIF CSV';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "NHIF CSV";
                    Visible = false;
                }
                action("PAYE Report")
                {
                    Caption = 'PAYE Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "PAYE Report";
                    Visible = false;
                }
                action("Generate P10")
                {
                    Caption = 'Generate P10';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Generate P10";
                    Visible = false;
                }
                action("<Report Pension Report>")
                {
                    Caption = 'Pension Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Pension Report";
                    Visible = false;
                }
            }
            group("Annual Statutory Reports")
            {
                Caption = 'Annual Statutory Reports';
                Visible = false;
                action("P9A Report")
                {
                    Caption = 'P9A Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "P9A Report";
                    Visible = false;
                }
                action(P10A)
                {
                    Caption = 'P10A';
                    Image = "Report";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report P10A;
                    Visible = false;
                }
                action(P10)
                {
                    Caption = 'P10';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report P10;
                    Visible = false;
                }
                action(P10D)
                {
                    Caption = 'P10D';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report P10D;
                    Visible = false;
                }
                action("NSSF YEARLY REPORT")
                {
                    Caption = 'NSSF YEARLY REPORT';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "NSSF YEARLY REPORT";
                    Visible = false;
                }
                action("<Report  NHIF YEARLY REPORT>")
                {
                    Caption = 'NHIF YEARLY REPORT';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "NHIF YEARLY REPORT";
                    Visible = false;
                }
                action("<Report  CBS>")
                {
                    Caption = 'CBS';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report CBS;
                    Visible = false;
                }
            }
            group("Cash Flow")
            {
                Caption = 'Cash Flow';
                Visible = false;
                action("Cash Flow Date List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Date List';
                    Image = "Report";
                    RunObject = Report "Cash Flow Date List";
                    Visible = false;
                    ToolTip = 'View forecast entries for a period of time that you specify. The registered cash flow forecast entries are organized by source types, such as receivables, sales orders, payables, and purchase orders. You specify the number of periods and their length.';
                }
            }
            group("Customers and Vendors")
            {
                Caption = 'Customers and Vendors';
                Visible = false;
                action("Aged Accounts &Receivable")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Aged Accounts &Receivable';
                    Image = "Report";
                    RunObject = Report "Aged Accounts Receivable";
                    Visible = false;
                    ToolTip = 'View an overview of when your receivables from customers are due or overdue (divided into four periods). You must specify the date you want aging calculated from and the length of the period that each column will contain data for.';
                }
                action("Aged Accounts Pa&yable")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Aged Accounts Pa&yable';
                    Image = "Report";
                    RunObject = Report "Aged Accounts Payable";
                    Visible = false;
                    ToolTip = 'View an overview of when your payables to vendors are due or overdue (divided into four periods). You must specify the date you want aging calculated from and the length of the period that each column will contain data for.';
                }
                action("Reconcile Cus&t. and Vend. Accs")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reconcile Cus&t. and Vend. Accs';
                    Image = "Report";
                    Visible = false;
                    RunObject = Report "Reconcile Cust. and Vend. Accs";
                    ToolTip = 'View if a certain general ledger account reconciles the balance on a certain date for the corresponding posting group. The report shows the accounts that are included in the reconciliation with the general ledger balance and the customer or the vendor ledger balance for each account and shows any differences between the general ledger balance and the customer or vendor ledger balance.';
                }
            }
            group("VAT Reports")
            {
                Caption = 'VAT Reports';
                Visible = false;
                action("&VAT Registration No. Check")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&VAT Registration No. Check';
                    Image = "Report";
                    RunObject = Report "VAT Registration No. Check";
                    Visible = false;
                    ToolTip = 'Use an EU VAT number validation service to validated the VAT number of a business partner.';
                }
                action("VAT E&xceptions")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'VAT E&xceptions';
                    Image = "Report";
                    RunObject = Report "VAT Exceptions";
                    Visible = false;
                    ToolTip = 'View the VAT entries that were posted and placed in a general ledger register in connection with a VAT difference. The report is used to document adjustments made to VAT amounts that were calculated for use in internal or external auditing.';
                }
                action("VAT &Statement")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'VAT &Statement';
                    Image = "Report";
                    RunObject = Report "VAT Statement";
                    Visible = false;
                    ToolTip = 'View a statement of posted VAT and calculate the duty liable to the customs authorities for the selected period.';
                }
                action("VAT - VIES Declaration Tax Aut&h")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'VAT - VIES Declaration Tax Aut&h';
                    Image = "Report";
                    RunObject = Report "VAT- VIES Declaration Tax Auth";
                    Visible = false;
                    ToolTip = 'View information to the customs and tax authorities for sales to other EU countries/regions. If the information must be printed to a file, you can use the VAT- VIES Declaration Disk report.';
                }
                action("VAT - VIES Declaration Dis&k")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'VAT - VIES Declaration Dis&k';
                    Image = "Report";
                    RunObject = Report "VAT- VIES Declaration Disk";
                    Visible = false;
                    ToolTip = 'Report your sales to other EU countries or regions to the customs and tax authorities. If the information must be printed out on a printer, you can use the VAT- VIES Declaration Tax Auth report. The information is shown in the same format as in the declaration list from the customs and tax authorities.';
                }
                action("EC Sales &List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'EC Sales &List';
                    Image = "Report";
                    RunObject = Report "EC Sales List";
                    Visible = false;
                    ToolTip = 'Calculate VAT amounts from sales, and submit the amounts to a tax authority.';
                }
            }
            group(Intrastat)
            {
                Caption = 'Intrastat';
                Visible = false;
                action("&Intrastat - Checklist")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Intrastat - Checklist';
                    Image = "Report";
                    RunObject = Report "Intrastat - Checklist";
                    Visible = false;
                    ToolTip = 'View a checklist that you can use to find possible errors before printing and also as documentation for what is printed. You can use the report to check the Intrastat journal before you use the Intrastat - Make Disk Tax Auth batch job.';
                }
                action("Intrastat - For&m")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Intrastat - For&m';
                    Image = "Report";
                    RunObject = Report "Intrastat - Form";
                    Visible = false;
                    ToolTip = 'View all the information that must be transferred to the printed Intrastat form.';
                }
            }
            group("Cost Accounting")
            {
                Caption = 'Cost Accounting';
                Visible = false;
                action("Cost Accounting P/L Statement")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Cost Accounting P/L Statement';
                    Image = "Report";
                    RunObject = Report "Cost Acctg. Statement";
                    Visible = false;
                    ToolTip = 'View the credit and debit balances per cost type, together with the chart of cost types.';
                }
                action("CA P/L Statement per Period")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'CA P/L Statement per Period';
                    Image = "Report";
                    RunObject = Report "Cost Acctg. Stmt. per Period";

                    ToolTip = 'View profit and loss for cost types over two periods with the comparison as a percentage.';
                }
                action("CA P/L Statement with Budget")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'CA P/L Statement with Budget';
                    Image = "Report";
                    RunObject = Report "Cost Acctg. Statement/Budget";
                    ToolTip = 'View a comparison of the balance to the budget figures and calculates the variance and the percent variance in the current accounting period, the accumulated accounting period, and the fiscal year.';
                }
                action("Cost Accounting Analysis")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Cost Accounting Analysis';
                    Image = "Report";
                    RunObject = Report "Cost Acctg. Analysis";
                    ToolTip = 'View balances per cost type with columns for seven fields for cost centers and cost objects. It is used as the cost distribution sheet in Cost accounting. The structure of the lines is based on the chart of cost types. You define up to seven cost centers and cost objects that appear as columns in the report.';
                }
            }
        }
        area(embedding)
        {
            action("Chart of Accounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Chart of Accounts';
                RunObject = Page "Chart of Accounts";
                ToolTip = 'Open the chart of accounts.';
                Visible = false;
            }
            action(Customers)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customers List';
                Image = Customer;
                RunObject = Page "Customer List";
                ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
            }
            action("Bank Acc. Reconciliation List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Ongoing Reconciliation List';
                Image = BankAccount;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Bank Acc. Reconciliation List";
                ToolTip = 'Bank Acc. Reconciliation List';
            }
            action("Bank Acc. Statements")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Posted Bank Reconciliations';
                Image = BankAccountStatement;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Bank Account Statement List";
                ToolTip = 'View statements for selected bank accounts. For each bank transaction, the report shows a description, an applied amount, a statement amount, and other information.';
            }
            action("Posted Sales Invoices")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Posted Invoices';
                Image = PostedOrder;
                RunObject = Page "Posted Sales Invoices";
                ToolTip = 'Open the list of posted sales invoices.';
            }
            action("Posted Sales Credit Memos")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancelled Invoices';
                Image = PostedOrder;
                RunObject = Page "Posted Sales Credit Memos";
                ToolTip = 'Open the list of posted sales credit memos.';
            }
            action("Posted Receipt List")
            {
                Caption = 'Posted Receipt List';
                RunObject = Page "Posted Receipt List";
            }
            action("Leave Balances List")
            {
                Caption = 'Leave Balances List';
                RunObject = Page "Leave Balances List";
                Visible = false;
            }
            action("Purchase Orders")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Orders';
                RunObject = Page "Purchase Order List";
                Visible = false;
                ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
            }
            action("Purchase Invoices")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Invoices';
                Image = Invoice;
                RunObject = Page "Purchase Invoices";
                Visible = false;
                ToolTip = 'Create purchase invoices to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase invoices dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase invoices can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
            }
            action("Bank Accounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Accounts';
                Image = BankAccount;
                RunObject = Page "Bank Account List";
                Visible = false;
                ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
            }
            action("Employee List Finance")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Employee List';
                Image = Employee;
                RunObject = Page "Employee List Finance";
                Visible = false;
                ToolTip = 'View or edit detailed information for the Employee that you trade with. From each employee card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
            }

            action(Vendors)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page "Vendor List";
                Visible = false;
                ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
            }
            action(VendorsBalance)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Vendor List";
                Visible = false;
                RunPageView = WHERE("Balance (LCY)" = FILTER(<> 0));
                ToolTip = 'View a summary of the bank account balance in different periods.';
            }
            action(Items)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Items';
                Image = Vendor;
                RunObject = Page "Item List";
                ToolTip = 'Item List';
                Visible = false;
            }
            action(CustomersBalance)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Customer List";
                Visible = false;
                RunPageView = WHERE("Balance (LCY)" = FILTER(<> 0));
                ToolTip = 'View a summary of the bank account balance in different periods.';
            }
            action("Incoming Documents")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Incoming Documents';
                Image = Documents;
                RunObject = Page "Incoming Documents";
                Visible = false;
                ToolTip = 'Handle incoming documents, such as vendor invoices in PDF or as image files, that you can manually or automatically convert to document records, such as purchase invoices. The external files that represent incoming documents can be attached at any process stage, including to posted documents and to the resulting vendor, customer, and general ledger entries.';
            }
            action(Budgets)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Budgets';
                RunObject = Page "G/L Budget Names";
                Visible = false;
                ToolTip = 'View or edit estimated amounts for a range of accounting periods.';
            }
            action("Fuel Filling List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Fuel Filling List';
                RunObject = Page "Fuel Filling List";
                ToolTip = 'Fuel Filling List';
                Visible = false;
            }
            action("Submitted Fuel Filling List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Submitted Fuel Filling List';
                Image = VATStatement;
                RunObject = Page "Submitted Fuel Filling List";
                ToolTip = 'Submitted Fuel Filling List';
                Visible = false;
            }
        }
        area(sections)
        {
            group(SETUPS)
            {
                Caption = 'SETUPS';
                Visible = false;
                action("City Lookup Values")
                {
                    Caption = 'City Lookup Values';
                    RunObject = Page "Procurement Lookup Values";
                }
                action("Allowance Matrix")
                {
                    Caption = 'Allowance Matrix';
                    RunObject = Page "Allowance Matrix";
                }
                action("Cluster Codes")
                {
                    Caption = 'Cluster Codes';
                    RunObject = Page "Cluster Codes";
                }
                action("Casual Rates")
                {
                    Caption = 'Casual Rates';
                    RunObject = Page "Casual Rates";
                }
                action("Fuel Prices")
                {
                    Caption = 'Fuel Prices';
                    RunObject = Page "Fuel Prices";
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
                    RunObject = Page "Casuals Payment List2";
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
                action("Posted Casual Payment List")
                {
                    Caption = 'Posted Casual Payment List';
                    RunObject = Page "Posted Casual Payment List";
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
                action("Purchase Requisition List")
                {
                    Caption = 'Purchase Requisition List';
                    RunObject = Page "Requisition List";
                }
                action("Pending Purch Requisition List")
                {
                    Caption = 'Pending Purch Requisition List';
                    RunObject = Page "Pending Requisition List";
                }
                action("Approve Purch Requisitions")
                {
                    ApplicationArea = Suite;
                    Caption = 'Approve Purch Requisitions';
                    RunObject = Page "Approve  Requisitions";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
                action("Closed Purchase Req. List")
                {
                    ApplicationArea = Suite;
                    Caption = 'Closed Purchase Req. List';
                    RunObject = Page "Closed  Requisition List";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
                action("Transport Request List")
                {
                    Caption = 'Transport Request List';
                    RunObject = Page "Transport Request List";
                }
            }
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
            group(ActionGroup172)
            {
                Caption = 'Finance';
                Image = Journals;
                Visible = false;
                ToolTip = 'Collect and make payments, prepare statements, and reconcile bank accounts.';
                action("General Journals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Journals';
                    Image = Journal;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(false));
                    ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                }
                action("Recurring General Journals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Recurring General Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(true));
                    ToolTip = 'Define how to post transactions that recur with few or no changes to general ledger, bank, customer, vendor, or fixed asset accounts';
                }
                action(Action170)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Chart of Accounts';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Chart of Accounts";
                    ToolTip = 'View or organize the general ledger accounts that store your financial data. All values from business transactions or internal adjustments end up in designated G/L accounts. Business Central includes a standard chart of accounts that is ready to support businesses in your country, but you can change the default accounts and add new ones.';
                }
                action("G/L Account Categories")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Account Categories';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "G/L Account Categories";
                    ToolTip = 'Personalize the structure of your financial statements by mapping general ledger accounts to account categories. You can create category groups by indenting subcategories under them. Each grouping shows a total balance. When you choose the Generate Account Schedules action, the account schedules for the underlying financial reports are updated. The next time you run one of these reports, such as the balance statement, new totals and subentries are added, based on your changes.';
                }
                action(Currencies)
                {
                    ApplicationArea = Suite;
                    Caption = 'Currencies';
                    Image = Currency;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page Currencies;
                    ToolTip = 'View the different currencies that you trade in or update the exchange rates by getting the latest rates from an external service provider.';
                }
                action(Employees)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employees';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Employee List";
                    ToolTip = 'View or modify employees'' details and related information, such as qualifications and pictures, or register and analyze employee absence. Keeping up-to-date records about your employees simplifies personnel tasks. For example, if an employee''s address changes, you register this on the employee card.';
                }
                action("Analysis Views")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Analysis Views';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Analysis View List";
                    ToolTip = 'Analyze amounts in your general ledger by their dimensions using analysis views that you have set up.';
                }
                action("Account Schedules")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Account Schedules';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Account Schedule Names";
                    ToolTip = 'Get insight into the financial data stored in your chart of accounts. Account schedules analyze figures in G/L accounts, and compare general ledger entries with general ledger budget entries. For example, you can view the general ledger entries as percentages of the budget entries. Account schedules provide the data for core financial statements and views, such as the Cash Flow chart.';
                }
                action(Dimensions)
                {
                    ApplicationArea = Suite;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page Dimensions;
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                }
                action(Action38)
                {
                    ApplicationArea = Suite;
                    Caption = 'Currencies';
                    Image = Currency;
                    RunObject = Page Currencies;
                    ToolTip = 'View the different currencies that you trade in or update the exchange rates by getting the latest rates from an external service provider.';
                }
                action(Action144)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employees';
                    RunObject = Page "Employee List";
                    ToolTip = 'Manage employees'' details and related information, such as qualifications and pictures, or register and analyze employee absence. Keeping up-to-date records about your employees simplifies personnel tasks. For example, if an employee''s address changes, you register this on the employee card.';
                }
                action("Accounting Periods")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Accounting Periods';
                    Image = AccountingPeriods;
                    RunObject = Page "Accounting Periods";
                    ToolTip = 'Set up the number of accounting periods, such as 12 monthly periods, within the fiscal year and specify which period is the start of the new fiscal year.';
                }
                action("Number Series")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Number Series';
                    RunObject = Page "No. Series";
                    ToolTip = 'View or edit the number series that are used to organize transactions';
                }
                action(Action116)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Account Categories';
                    RunObject = Page "G/L Account Categories";
                    ToolTip = 'Personalize the structure of your financial statements by mapping general ledger accounts to account categories. You can create category groups by indenting subcategories under them. Each grouping shows a total balance. When you choose the Generate Account Schedules action, the account schedules for the underlying financial reports are updated. The next time you run one of these reports, such as the balance statement, new totals and subentries are added, based on your changes.';
                }
                action("Bank Account Posting Groups")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Account Posting Groups';
                    RunObject = Page "Bank Account Posting Groups";
                    ToolTip = 'Set up posting groups, so that payments in and out of each bank account are posted to the specified general ledger account.';
                }
            }
            group(Journals)
            {
                Caption = 'Journals';
                Image = Journals;
                ToolTip = 'Post financial transactions.';
                Visible = false;
                action(GeneralJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Journals';
                    Image = Journal;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(false));
                    ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                }
            }
            group("Fund Management")
            {
                Caption = 'Fund Management';
                Visible = false;
                action(Action302)
                {
                    Caption = 'Allowance Matrix';
                    RunObject = Page "Allowance Matrix";
                }
                action(Action131)
                {
                    Caption = ' Imprest List';
                    RunObject = Page "Imprest List 2";
                }
                action(" Pending Approval Imprest List")
                {
                    Caption = ' Pending Approval Imprest List';
                    RunObject = Page "pending Approval Imprest List";
                }
                action(Action208)
                {
                    Caption = 'Approved Imprest List';
                    RunObject = Page "Approved Imprest List";
                }
                action("Allocated Imprest List")
                {
                    Caption = 'Allocated Imprest List';
                    RunObject = Page "Allocated Imprest List";
                }
                action("Posted Imprest List")
                {
                    Caption = 'Posted Imprest List';
                    RunObject = Page "Posted Imprest List";
                }
                action(Action183)
                {
                    Caption = 'Imprest Surrender List';
                    RunObject = Page "Imprest Surrender List";
                }
                action("Pending Approval Imprest Surrender List")
                {
                    Caption = 'Pending Approval Imprest Surrender List';
                    RunObject = Page "Pending Approval Imprest Surre";
                }
                action("Approved Imprest Surrender")
                {
                    Caption = 'Approved Imprest Surrender';
                    RunObject = Page "Approved Imprest Surrender";
                }
                action("Posted Imprest Surrender List")
                {
                    Caption = 'Posted Imprest Surrender List';
                    RunObject = Page "Posted Imprest Surrender List";
                }
                action("Board Allowances List")
                {
                    Caption = 'Board Allowances List';
                    RunObject = Page "Board Allowances List";
                }
                action("Approved Board Allowances List")
                {
                    Caption = 'Approved Board Allowances List';
                    RunObject = Page "Approved Board Allowances List";
                }
                action("Paid  Board Allowances List")
                {
                    Caption = 'Paid  Board Allowances List';
                    RunObject = Page "Paid  Board Allowances List";
                }
                action("Posted Board Allowances List")
                {
                    Caption = 'Posted Board Allowances List';
                    RunObject = Page "Posted Board Allowances List";
                }
                action("Pending Approv Petty Cash List")
                {
                    Caption = 'Pending Approv Petty Cash List';
                    RunObject = Page "Pending Approv Petty Cash List";
                    Visible = false;
                }
                action(" Approved Petty Cash List")
                {
                    Caption = ' Approved Petty Cash List';
                    RunObject = Page "Approved Petty Cash List";
                    Visible = false;
                }
                action("Posted Petty Cash List")
                {
                    Caption = 'Posted Petty Cash List';
                    RunObject = Page "Posted Petty Cash List";
                    Visible = false;
                }
                action("Petty Cash Surrender list")
                {
                    Caption = 'Petty Cash Surrender list';
                    RunObject = Page "Petty Cash Surrender List";
                    Visible = false;
                }
                action("Posted Petty Surrender List")
                {
                    Caption = 'Posted Petty Surrender List';
                    RunObject = Page "Posted Petty Surrender List";
                    Visible = false;
                }
                action("Payment List")
                {
                    Caption = 'Payment List';
                    RunObject = Page "Payment List";
                }
                action("Pending Approval Payment List")
                {
                    Caption = 'Pending Approval Payment List';
                    RunObject = Page "Pending Approval Payment List";
                }
                action("Approved Payment List")
                {
                    Caption = 'Approved Payment List';
                    RunObject = Page "Approved Payment List";
                }
                action("Posted Payment List")
                {
                    Caption = 'Posted Payment List';
                    RunObject = Page "Posted Payment List";
                }
                action("Cancelled  Payment List")
                {
                    Caption = 'Cancelled  Payment List';
                    RunObject = Page "Cancelled  Payment List";
                }
                action("Deposits Refund List")
                {
                    Caption = 'Deposits Refund List';
                    RunObject = Page "Deposits Refund List";
                }
                action(" Pending  Deposits Refund")
                {
                    Caption = ' Pending  Deposits Refund';
                    RunObject = Page "Pending  Deposits Refund";
                }
                action(" Approved  Deposits Refund")
                {
                    Caption = ' Approved  Deposits Refund';
                    RunObject = Page "Approved  Deposits Refund";
                }
                action("Posted  Deposits Refund List")
                {
                    Caption = 'Posted  Deposits Refund List';
                    RunObject = Page "Posted  Deposits Refund List";
                }
                action("Cash Payment List")
                {
                    Caption = 'Cash Payment List';
                    RunObject = Page "Cash Payment List";
                    Visible = false;
                }
                action(Action235)
                {
                    Caption = 'Cash Payment List';
                    RunObject = Page "Cash Payment List";
                    Visible = false;
                }
                action("Pending Cash Payment List")
                {
                    Caption = 'Pending Cash Payment List';
                    RunObject = Page "Pending Cash Payment List";
                    Visible = false;
                }
                action("Approved Cash Payment List")
                {
                    Caption = 'Approved Cash Payment List';
                    RunObject = Page "Approved Cash Payment List";
                    Visible = false;
                }
                action("Posted Cash Payment List")
                {
                    Caption = 'Posted Cash Payment List';
                    RunObject = Page "Posted Cash Payment List";
                    Visible = false;
                }
                action("Cancelled Cash Payment List")
                {
                    Caption = 'Cancelled Cash Payment List';
                    RunObject = Page "Cancelled Cash Payment List";
                    Visible = false;
                }
                action("Receipt List")
                {
                    Caption = 'Receipt List';
                    RunObject = Page "Receipt List";
                }
                action("Journal Voucher List")
                {
                    Caption = 'Journal Voucher List';
                    RunObject = Page "Journal Voucher List";
                }
                action("Journal Vouchers Pend.Approval")
                {
                    Caption = 'Journal Vouchers Pend.Approval';
                    RunObject = Page "Journal Vouchers Pend.Approval";
                }
                action("Journal Vouchers Approved")
                {
                    Caption = 'Journal Vouchers Approved';
                    RunObject = Page "Journal Vouchers Approved";
                }
                action("Journal Vouchers Posted")
                {
                    Caption = 'Journal Vouchers Posted';
                    RunObject = Page "Journal Vouchers Posted";
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
                action("Salary Advance Approved ")
                {
                    Caption = 'Salary Advance Approved ';
                    RunObject = Page "Salary Advance Approved";
                }
                action("Salary Advance posted")
                {
                    Caption = 'Salary Advance posted';
                    RunObject = Page "Salary Advance posted";
                }
                action("Purchase Requisition Codes")
                {
                    Caption = 'Purchase Requisition Codes';
                    RunObject = Page "Purchase Requisition Codes";
                }
                action("Receipt Codes")
                {
                    Caption = 'Receipt Codes';
                    RunObject = Page "Receipt Codes";
                }
                action("Payment Codes")
                {
                    Caption = 'Payment Codes';
                    RunObject = Page "Payment Codes";
                }
                action("Imprest Codes")
                {
                    Caption = 'Imprest Codes';
                    RunObject = Page "Imprest Codes";
                }
                action("Funds Tax Codes")
                {
                    Caption = 'Funds Tax Codes';
                    RunObject = Page "Funds Tax Codes";
                }
                action("Budget Control Setup ")
                {
                    Caption = 'Budget Control Setup ';
                    RunObject = Page "Budget Control Setup";
                }
                action("Funds User Setup")
                {
                    Caption = 'Funds User Setup';
                    RunObject = Page "Funds User Setup";
                }
                action("Budget Committment Lines")
                {
                    Caption = 'Budget Committment Lines';
                    RunObject = Page "Budget Committment Lines";
                }
            }
            group("Cash Management")
            {
                Caption = 'Cash Management';
                Visible = false;
                ToolTip = 'Process incoming and outgoing payments. Set up bank accounts and service connections for electronic banking.  ';
                action(CashReceiptJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Receipt Journals';
                    Image = Journals;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST("Cash Receipts"),
                                        Recurring = CONST(false));
                    ToolTip = 'Register received payments by manually applying them to the related customer, vendor, or bank ledger entries. Then, post the payments to G/L accounts and thereby close the related ledger entries.';
                }
                action(PaymentJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Journals';
                    Image = Journals;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Payments),
                                        Recurring = CONST(false));
                    ToolTip = 'Register payments to vendors. A payment journal is a type of general journal that is used to post outgoing payment transactions to G/L, bank, customer, vendor, employee, and fixed assets accounts. The Suggest Vendor Payments functions automatically fills the journal with payments that are due. When payments are posted, you can export the payments to a bank file for upload to your bank if your system is set up for electronic banking. You can also issue computer checks from the payment journal.';
                }
                action(Action226)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Payment List';
                    Image = BankAccount;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Cash Payment List";
                    ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
                }
                action(Action164)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Bank Account List";
                    ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
                }
            }
            group(ActionGroup16)
            {
                Caption = 'Fixed Assets';
                Image = FixedAssets;
                Visible = false;
                ToolTip = 'Manage depreciation and insurance of your fixed assets.';
                action(Action17)
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Fixed Asset List";
                    ToolTip = 'Manage periodic depreciation of your machinery or machines, keep track of your maintenance costs, manage insurance policies related to fixed assets, and monitor fixed asset statistics.';
                }
                action("Fixed Assets G/L Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets G/L Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Assets),
                                        Recurring = CONST(false));
                    ToolTip = 'Post fixed asset transactions, such as acquisition and depreciation, in integration with the general ledger. The FA G/L Journal is a general journal, which is integrated into the general ledger.';
                }
                action("Fixed Assets Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "FA Journal Batches";
                    RunPageView = WHERE(Recurring = CONST(false));
                    ToolTip = 'Post fixed asset transactions, such as acquisition and depreciation book without integration to the general ledger.';
                }
                action("Fixed Assets Reclass. Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets Reclass. Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "FA Reclass. Journal Batches";
                    ToolTip = 'Transfer, split, or combine fixed assets by preparing reclassification entries to be posted in the fixed asset journal.';
                }
                action(Insurance)
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Insurance';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Insurance List";
                    ToolTip = 'Manage insurance policies for fixed assets and monitor insurance coverage.';
                }
                action("Insurance Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Insurance Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Insurance Journal Batches";
                    ToolTip = 'Post entries to the insurance coverage ledger.';
                }
                action("Recurring Fixed Asset Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Recurring Fixed Asset Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "FA Journal Batches";
                    RunPageView = WHERE(Recurring = CONST(true));
                    ToolTip = 'Post recurring fixed asset transactions, such as acquisition and depreciation book without integration to the general ledger.';
                }
            }
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                Visible = false;
                ToolTip = 'View the posting history for sales, shipments, and inventory.';

                action("Posted Purchase Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ToolTip = 'Open the list of posted purchase invoices.';
                }
                action("Posted Purchase Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ToolTip = 'Open the list of posted purchase credit memos.';
                }
                action("G/L Registers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Registers';
                    Image = GLRegisters;
                    RunObject = Page "G/L Registers";
                    ToolTip = 'View auditing details for all general ledger entries. Every time an entry is posted, a register is created in which you can see the first and last number of its entries in order to document when entries were posted.';
                }
                action(Action191)
                {
                    Caption = 'Posted Payment List';
                    RunObject = Page "Posted Payment List";
                }

                action("Posted Funds Transfer List")
                {
                    Caption = 'Posted Funds Transfer List';
                    RunObject = Page "Posted Funds Transfer List";
                }
                action("Posted Fund Claim List")
                {
                    Caption = 'Posted Fund Claim List';
                    RunObject = Page "Posted Fund Claim List";
                }
                action(Action200)
                {
                    Caption = 'Posted Imprest Surrender List';
                    RunObject = Page "Posted Imprest Surrender List";
                }
                action(Action205)
                {
                    Caption = 'Journal Vouchers Posted';
                    RunObject = Page "Journal Vouchers Posted";
                }
            }
            group(SetupAndExtensions)
            {
                Caption = 'Setup & Extensions';
                Image = Setup;
                Visible = false;
                ToolTip = 'Overview and change system and application settings, and manage extensions and services';
                action("Assisted Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Assisted Setup';
                    Image = QuestionaireSetup;
                    RunObject = Page "Assisted Setup";
                    ToolTip = 'Set up core functionality such as sales tax, sending documents as email, and approval workflow by running through a few pages that guide you through the information.';
                }
                action("Manual Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Manual Setup';
                    ///  RunObject = Page "Business Setup";
                    ToolTip = 'Define your company policies for business departments and for general activities.';
                }
                action(General)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General';
                    // RunObject = Page "Business Setup";
                    // RunPageView = SORTING(Name)
                    //               WHERE(Area=FILTER(General));
                    ToolTip = 'General';
                }
                action(Finance)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Finance';
                    // RunObject = Page "Business Setup";
                    // RunPageView = SORTING(Name)
                    //               WHERE(Area=FILTER(Finance));
                    //The property 'ToolTip' cannot be empty.
                    //ToolTip = '';
                }
                action(Sales)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales';
                    // RunObject = Page "Business Setup";
                    // RunPageView = SORTING(Name)
                    //               WHERE(Area=FILTER(Sales));
                    ToolTip = 'Define your general policies for sales invoicing and returns, such as when to show credit and stockout warnings and how to post sales discounts. Set up your number series for creating customers and different sales documents.';
                }
                action(Purchasing)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchasing';
                    // RunObject = Page "Business Setup";
                    // RunPageView = SORTING(Name)
                    //               WHERE(Area=FILTER(Purchasing));
                    ToolTip = 'Define your general policies for purchase invoicing and returns, such as whether to require vendor invoice numbers and how to post purchase discounts. Set up your number series for creating vendors and different purchase documents.';
                }
                action(Jobs)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Jobs';
                    // RunObject = Page "Business Setup";
                    // RunPageView = SORTING(Name)
                    //               WHERE(Area=FILTER(Jobs));
                    ToolTip = 'Define a project activity by creating a job card with integrated job tasks and job planning lines, structured in two layers. The job task enables you to set up job planning lines and to post consumption to the job. The job planning lines specify the detailed use of resources, items, and various general ledger expenses.';
                }
                action("Fixed Assets")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets';
                    // RunObject = Page "Business Setup";
                    // RunPageView = SORTING(Name)
                    //               WHERE(Area=FILTER("Fixed Assets"));
                    ToolTip = 'Manage periodic depreciation of your machinery or machines, keep track of your maintenance costs, manage insurance policies related to fixed assets, and monitor fixed asset statistics.';
                }
                action(HR)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'HR';
                    // RunObject = Page "Business Setup";
                    // RunPageView = SORTING(Name)
                    //               WHERE(Area=FILTER(HR));
                    ToolTip = 'Manage employees.';
                }
                action(Inventory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inventory';
                    // RunObject = Page "Business Setup";
                    // RunPageView = SORTING(Name)
                    //               WHERE(Area=FILTER(Inventory));
                    ToolTip = 'Inventory';
                }
                action(Service)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Service';
                    // RunObject = Page "Business Setup";
                    // RunPageView = SORTING(Name)
                    //               WHERE(Area=FILTER(Service));
                    //The property 'ToolTip' cannot be empty.
                    //ToolTip = '';
                }
                action(System)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'System';
                    // RunObject = Page "Business Setup";
                    // RunPageView = SORTING(Name)
                    //               WHERE(Area=FILTER(System));
                    ToolTip = 'System';
                }
                action("Relationship Management")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Relationship Management';
                    // RunObject = Page "Business Setup";
                    // RunPageView = SORTING(Name)
                    //               WHERE(Area=FILTER("Relationship Mngt"));
                    ToolTip = 'Set up business relations, configure sales cycles, campaigns, and interactions, and define codes for various marketing communication.';
                }
                action(Intercompany)
                {
                    ApplicationArea = Intercompany;
                    Caption = 'Intercompany';
                    // RunObject = Page "Business Setup";
                    // RunPageView = SORTING(Name)
                    //               WHERE(Area=FILTER(Intercompany));
                    ToolTip = 'Intercompany Postings';
                }
                action("Service Connections")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Service Connections';
                    Image = ServiceTasks;
                    RunObject = Page "Service Connections";
                    ToolTip = 'Enable and configure external services, such as exchange rate updates, Microsoft Social Engagement, and electronic bank integration.';
                }
                action(Extensions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Extensions';
                    Image = NonStockItemSetup;
                    RunObject = Page "Extension Management";
                    ToolTip = 'Install Extensions for greater functionality of the system.';
                }
                action(Workflows)
                {
                    ApplicationArea = Suite;
                    Caption = 'Workflows';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page Workflows;
                    ToolTip = 'Set up or enable workflows that connect business-process tasks performed by different users. System tasks, such as automatic posting, can be included as steps in workflows, preceded or followed by user tasks. Requesting and granting approval to create new records are typical workflow steps.';
                }
            }
        }
        area(creation)
        {
            action("Sales &Credit Memo")
            {
                AccessByPermission = TableData "Sales Header" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Sales &Credit Memo';
                Image = CreditMemo;
                Visible = false;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Sales Credit Memo";
                RunPageMode = Create;
                ToolTip = 'Create a new sales credit memo to revert a posted sales invoice.';
            }
            action("P&urchase Credit Memo")
            {
                AccessByPermission = TableData "Purchase Header" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'P&urchase Credit Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Purchase Credit Memo";
                RunPageMode = Create;
                Visible = false;
                ToolTip = 'Create a new purchase credit memo so you can manage returned items to a vendor.';
            }
            action("G/L Journal Entry")
            {
                AccessByPermission = TableData "G/L Entry" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'G/L Journal Entry';
                Visible = false;
                Image = TileNew;
                //  RunObject = Page "General Journal";
                ToolTip = 'Prepare to post any transaction to the company books.';
            }
            action("Payment Journal Entry")
            {
                AccessByPermission = TableData "Gen. Journal Batch" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Payment Journal Entry';
                Visible = false;
                Image = TileNew;
                RunObject = Page "Payment Journal";
                ToolTip = 'Pay your vendors by filling the payment journal automatically according to payments due, and potentially export all payment to your bank for automatic processing.';
            }
            action("Change Password")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Change Password';
                Image = TileNew;
                //  RunObject = Page "Change Password";
                ToolTip = 'Change Password';
                Visible = false;
            }
        }
        area(processing)
        {
            group(Payroll)
            {
                Caption = 'Payroll';
                Visible = false;
                group(ActionGroup333)
                {
                    Caption = 'Employees';
                    action("Payroll Employee List")
                    {
                        Caption = 'Payroll Employee List';
                        Image = Allocate;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Payroll Employee List";
                    }
                    action("Terminated Employee List")
                    {
                        Caption = 'Terminated Employee List';
                        Image = Allocate;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Terminated Employee List";
                    }
                }
                group("Payroll Processing")
                {
                    Caption = 'Payroll Processing';
                    action("Payroll Header List")
                    {
                        Caption = 'Payroll Header List';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Payroll Header List";
                    }
                    action(" Loans/Advances")
                    {
                        Caption = ' Loans/Advances';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Loans/Advances";
                    }
                    action("Loan Entry")
                    {
                        Caption = 'Loan Entry';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Loan Entry";
                    }
                }
                group("Payroll Approvals")
                {
                    Caption = 'Payroll Approvals';
                    action(" Payroll Period List")
                    {
                        Caption = ' Payroll Period List';
                        Image = OpenJournal;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Payroll Period List";
                    }
                    action("Pending Payroll Period List")
                    {
                        Caption = 'Pending Payroll Period List';
                        Image = Calculate;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Pending Payroll Period List";
                    }
                    action("Approved Payroll Period List")
                    {
                        Caption = 'Approved Payroll Period List';
                        Image = GLJournal;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Approved Payroll Period List";
                    }
                    action("Posted Payroll Period List")
                    {
                        Caption = 'Posted Payroll Period List';
                        Image = GetEntries;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Posted Payroll Period List";
                    }
                }
                group("Salary Advance")
                {
                    Caption = 'Salary Advance';
                    action(Action307)
                    {
                        Caption = 'Salary Advance Applications';
                        RunObject = Page "Salary Advance Applications";
                    }
                    action("Salary Advance Pending Approval")
                    {
                        Caption = 'Salary Advance Pending Approval';
                        RunObject = Page "Salary Advance Pending Approvl";
                    }
                    action("Salary Advance Approved")
                    {
                        Caption = 'Salary Advance Approved';
                        RunObject = Page "Salary Advance Approved";
                    }
                    action(Action296)
                    {
                        Caption = 'Salary Advance posted';
                        RunObject = Page "Salary Advance posted";
                    }
                }
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
                    action(Action230)
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
                group("Payroll Allowances")
                {
                    Caption = 'Payroll Allowances';
                    action("Allowance List- Open")
                    {
                        Caption = 'Allowance List- Open';
                        Image = OpenJournal;
                        Promoted = true;
                        PromotedCategory = Process;
                        // RunObject = Page "Allowance List- Open";
                    }
                    action("Allowance List Pending approval")
                    {
                        Caption = 'Allowance List Pending approval';
                        Image = Calculate;
                        Promoted = true;
                        PromotedCategory = Process;
                        //  RunObject = Page "Allowance List Pending approva";
                    }
                    action("Allowance List- Approved")
                    {
                        Caption = 'Allowance List- Approved';
                        Image = GLJournal;
                        Promoted = true;
                        // PromotedCategory = Process;
                        // RunObject = Page "Allowance List- Approved";
                    }
                    action("Posted Allowance List")
                    {
                        Caption = 'Posted Allowance List';
                        Image = GetEntries;
                        Promoted = true;
                        PromotedCategory = Process;
                        //RunObject = Page "Posted Allowance List";
                    }
                }
                group("Payroll Setups")
                {
                    Caption = 'Payroll Setups';
                    action("Calculation Header")
                    {
                        Caption = 'Calculation Header';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Calculation Header";
                    }
                    action(" Payroll")
                    {
                        Caption = ' Payroll';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page Payroll;
                    }
                    action("Payroll Year")
                    {
                        Caption = 'Payroll Year';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Payroll Year";
                    }
                    action("ED Definitions")
                    {
                        Caption = 'ED Definitions';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "ED Definitions";
                    }
                    action(" Payroll Setups")
                    {
                        Caption = ' Payroll Setups';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Payroll Setups";
                    }
                    action("Payroll Posting Setup")
                    {
                        Caption = 'Payroll Posting Setup';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Payroll Posting Setup";
                    }
                    action("ED Posting Group")
                    {
                        Caption = 'ED Posting Group';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "ED Posting Group";
                    }
                    action("Payslip Group")
                    {
                        Caption = 'Payslip Group';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Payslip Group";
                    }
                    action(" Allowed Payrolls")
                    {
                        Caption = ' Allowed Payrolls';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Allowed Payrolls";
                    }
                    action(" Lookup Table Header")
                    {
                        Caption = ' Lookup Table Header';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Lookup Table Header";
                    }
                    action("Special Payments")
                    {
                        Caption = 'Special Payments';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Special Payments";
                    }
                    action(" Mode of Payment")
                    {
                        Caption = ' Mode of Payment';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Mode of Payment";
                    }
                    action("Institution  List")
                    {
                        Caption = 'Institution  List';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Institution  List";
                    }
                    action("Loan types")
                    {
                        Caption = 'Loan types';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Loan types";
                    }
                    action("Master Roll Group")
                    {
                        Caption = 'Master Roll Group';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Master Roll Group";
                    }
                    action("Employee Customer Loan Link")
                    {
                        Caption = 'Employee Customer Loan Link';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Employee Customer Loan Link";
                    }
                }
            }
            group(Payments)
            {
                Caption = 'Payments';
                Visible = false;
                action("Cas&h Receipt Journal")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cas&h Receipt Journal';
                    Image = CashReceiptJournal;
                    RunObject = Page "Cash Receipt Journal";
                    ToolTip = 'Apply received payments to the related non-posted sales documents.';
                }
                action("Pa&yment Journal")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pa&yment Journal';
                    Image = PaymentJournal;
                    RunObject = Page "Payment Journal";
                    ToolTip = 'Make payments to vendors.';
                }
            }
            group(Analysis)
            {
                Caption = 'Analysis';
                Visible = false;
                action("Analysis &Views")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Analysis &Views';
                    Image = AnalysisView;
                    RunObject = Page "Analysis View List";
                    ToolTip = 'Analyze amounts in your general ledger by their dimensions using analysis views that you have set up.';
                }
                action("Analysis by &Dimensions")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Analysis by &Dimensions';
                    Image = AnalysisViewDimension;
                    RunObject = Page "Analysis by Dimensions";
                    ToolTip = 'Analyze activities using dimensions information.';
                }
            }
            group(Tasks)
            {
                Caption = 'Tasks';
                Visible = false;
                action("Calculate Deprec&iation")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Calculate Deprec&iation';
                    Ellipsis = true;
                    Image = CalculateDepreciation;
                    RunObject = Report "Calculate Depreciation";
                    ToolTip = 'Calculate depreciation according to the conditions that you define. If the fixed assets that are included in the batch job are integrated with the general ledger (defined in the depreciation book that is used in the batch job), the resulting entries are transferred to the fixed assets general ledger journal. Otherwise, the batch job transfers the entries to the fixed asset journal. You can then post the journal or adjust the entries before posting, if necessary.';
                }
                action("Import Co&nsolidation from Database")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Import Co&nsolidation from Database';
                    Ellipsis = true;
                    Image = ImportDatabase;
                    RunObject = Report "Import Consolidation from DB";
                    ToolTip = 'Import entries from the business units that will be included in a consolidation. You can use the batch job if the business unit comes from the same database in Business Central as the consolidated company.';
                }
                action("Bank Account R&econciliation")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Account R&econciliation';
                    Image = BankAccountRec;
                    RunObject = Page "Bank Acc. Reconciliation";
                    ToolTip = 'View the entries and the balance on your bank accounts against a statement from the bank.';
                }
                action("Payment Reconciliation Journals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Reconciliation Journals';
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Pmt. Reconciliation Journals";
                    RunPageMode = View;
                    ToolTip = 'Reconcile unpaid documents automatically with their related bank transactions by importing a bank statement feed or file. In the payment reconciliation journal, incoming or outgoing payments on your bank are automatically, or semi-automatically, applied to their related open customer or vendor ledger entries. Any open bank account ledger entries related to the applied customer or vendor ledger entries will be closed when you choose the Post Payments and Reconcile Bank Account action. This means that the bank account is automatically reconciled for payments that you post with the journal.';
                }
                action("Adjust E&xchange Rates")
                {
                    ApplicationArea = Suite;
                    Caption = 'Adjust E&xchange Rates';
                    Ellipsis = true;
                    Image = AdjustExchangeRates;
                    RunObject = Report "Adjust Exchange Rates";
                    ToolTip = 'Adjust general ledger, customer, vendor, and bank account entries to reflect a more updated balance if the exchange rate has changed since the entries were posted.';
                }
                action("P&ost Inventory Cost to G/L")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&ost Inventory Cost to G/L';
                    Image = PostInventoryToGL;
                    RunObject = Report "Post Inventory Cost to G/L";
                    ToolTip = 'Record the quantity and value changes to the inventory in the item ledger entries and the value entries when you post inventory transactions, such as sales shipments or purchase receipts.';
                }
                action("Intrastat &Journal")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Intrastat &Journal';
                    Image = Journal;
                    RunObject = Page "Intrastat Jnl. Batches";
                    ToolTip = 'Summarize the value of your purchases and sales with business partners in the EU for statistical purposes and prepare to send it to the relevant authority.';
                }
                action("Calc. and Pos&t VAT Settlement")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Calc. and Pos&t VAT Settlement';
                    Image = SettleOpenTransactions;
                    RunObject = Report "Calc. and Post VAT Settlement";
                    ToolTip = 'Close open VAT entries and transfers purchase and sales VAT amounts to the VAT settlement account. For every VAT posting group, the batch job finds all the VAT entries in the VAT Entry table that are included in the filters in the definition window.';
                }
            }
            group(Create)
            {
                Caption = 'Create';
                Visible = false;
                action("C&reate Reminders")
                {
                    ApplicationArea = Suite;
                    Caption = 'C&reate Reminders';
                    Ellipsis = true;
                    Image = CreateReminders;
                    RunObject = Report "Create Reminders";
                    ToolTip = 'Create reminders for one or more customers with overdue payments.';
                }
                action("Create Finance Charge &Memos")
                {
                    ApplicationArea = Suite;
                    Caption = 'Create Finance Charge &Memos';
                    Ellipsis = true;
                    Image = CreateFinanceChargememo;
                    RunObject = Report "Create Finance Charge Memos";
                    ToolTip = 'Create finance charge memos for one or more customers with overdue payments.';
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
                Visible = false;
                group("Financial Statements")
                {
                    Caption = 'Financial Statements';
                    Image = ReferenceData;
                    action("Balance Sheet")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Balance Sheet';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Balance Sheet";
                        ToolTip = 'View a report that shows your company''s assets, liabilities, and equity.';
                    }
                    action("Income Statement")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Income Statement';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Income Statement";
                        ToolTip = 'View a report that shows your company''s income and expenses.';
                    }
                    action("Statement of Cash Flows")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement of Cash Flows';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Statement of Cashflows";
                        ToolTip = 'View a financial statement that shows how changes in balance sheet accounts and income affect the company''s cash holdings, displayed for operating, investing, and financing activities respectively.';
                    }
                    action("Statement of Retained Earnings")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement of Retained Earnings';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Retained Earnings Statement";
                        ToolTip = 'View a report that shows your company''s changes in retained earnings for a specified period by reconciling the beginning and ending retained earnings for the period, using information such as net income from the other financial statements.';
                    }
                }
                group("Excel Reports")
                {
                    Caption = 'Excel Reports';
                    Image = Excel;
                    action(ExcelTemplatesBalanceSheet)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Balance Sheet';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Balance Sheet";
                        ToolTip = 'Open a spreadsheet that shows your company''s assets, liabilities, and equity.';
                    }
                    action(ExcelTemplateIncomeStmt)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Income Statement';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Income Stmt.";
                        ToolTip = 'Open a spreadsheet that shows your company''s income and expenses.';
                    }
                    action(ExcelTemplateCashFlowStmt)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Flow Statement';
                        Image = "Report";
                        RunObject = Codeunit "Run Template CashFlow Stmt.";
                        ToolTip = 'Open a spreadsheet that shows how changes in balance sheet accounts and income affect the company''s cash holdings.';
                    }
                    action(ExcelTemplateRetainedEarn)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Retained Earnings Statement';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Retained Earn.";
                        ToolTip = 'Open a spreadsheet that shows your company''s changes in retained earnings based on net income from the other financial statements.';
                    }
                    action(ExcelTemplateTrialBalance)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Trial Balance';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Trial Balance";
                        ToolTip = 'Open a spreadsheet that shows a summary trial balance by account.';
                    }
                    action(ExcelTemplateAgedAccPay)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged Accounts Payable';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Aged Acc. Pay.";
                        ToolTip = 'Open a spreadsheet that shows a list of aged remaining balances for each vendor by period.';
                    }
                    action(ExcelTemplateAgedAccRec)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged Accounts Receivable';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Aged Acc. Rec.";
                        ToolTip = 'Open a spreadsheet that shows when customer payments are due or overdue by period.';
                    }
                }
                action("Run Consolidation")
                {
                    ApplicationArea = Suite;
                    Caption = 'Run Consolidation';
                    Ellipsis = true;
                    Image = ImportDatabase;
                    RunObject = Report "Import Consolidation from DB";
                    ToolTip = 'Run the Consolidation report.';
                }
            }
            group(Setup)
            {
                Caption = 'Setup';
                Visible = false;
                action(Action112)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Assisted Setup';
                    Image = QuestionaireSetup;
                    RunObject = Page "Assisted Setup";
                    ToolTip = 'Set up core functionality such as sales tax, sending documents as email, and approval workflow by running through a few pages that guide you through the information.';
                }
                action("General &Ledger Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General &Ledger Setup';
                    Image = Setup;
                    RunObject = Page "General Ledger Setup";
                    ToolTip = 'Define your general accounting policies, such as the allowed posting period and how payments are processed. Set up your default dimensions for financial analysis.';
                }
                action("&Sales && Receivables Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Sales && Receivables Setup';
                    Image = Setup;
                    RunObject = Page "Sales & Receivables Setup";
                    ToolTip = 'Define your general policies for sales invoicing and returns, such as when to show credit and stockout warnings and how to post sales discounts. Set up your number series for creating customers and different sales documents.';
                }
                action("&Purchases && Payables Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Purchases && Payables Setup';
                    Image = Setup;
                    RunObject = Page "Purchases & Payables Setup";
                    ToolTip = 'Define your general policies for purchase invoicing and returns, such as whether to require vendor invoice numbers and how to post purchase discounts. Set up your number series for creating vendors and different purchase documents.';
                }
                action("&Fixed Asset Setup")
                {
                    ApplicationArea = FixedAssets;
                    Caption = '&Fixed Asset Setup';
                    Image = Setup;
                    RunObject = Page "Fixed Asset Setup";
                    ToolTip = 'Define your accounting policies for fixed assets, such as the allowed posting period and whether to allow posting to main assets. Set up your number series for creating new fixed assets.';
                }
                action("Funds General Setup")
                {
                    Caption = 'Funds General Setup';
                    Image = Setup;
                    Promoted = true;
                    // RunObject = Page "Funds General Setup";
                }
                action("Cash Flow Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Setup';
                    Image = CashFlowSetup;
                    RunObject = Page "Cash Flow Setup";
                    ToolTip = 'Set up the accounts where cash flow figures for sales, purchase, and fixed-asset transactions are stored.';
                }
                action("Cost Accounting Setup")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Cost Accounting Setup';
                    Image = CostAccountingSetup;
                    RunObject = Page "Cost Accounting Setup";
                    ToolTip = 'Specify how you transfer general ledger entries to cost accounting, how you link dimensions to cost centers and cost objects, and how you handle the allocation ID and allocation document number.';
                }
            }
            group(History)
            {
                Caption = 'History';
                Visible = false;
                action("Navi&gate")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Navi&gate';
                    Image = Navigate;
                    RunObject = Page Navigate;
                    ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';
                }
            }
        }
    }
}

