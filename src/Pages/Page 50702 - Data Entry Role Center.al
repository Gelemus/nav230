page 50702 "Data Entry Role Center"
{
    Caption = 'Accounting Manager', Comment='{Dependency=Match,"ProfileDescription_ACCOUNTINGMANAGER"}';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                ShowCaption = false;
                part(Control99;"Finance Performance")
                {
                    ApplicationArea = Basic,Suite;
                    Visible = false;
                }
                part(Control1902304208;"Account Manager Activities")
                {
                    ApplicationArea = Basic,Suite;
                }
                part(Control1907692008;"My Customers")
                {
                    ApplicationArea = Basic,Suite;
                }
            }
            group(Control1900724708)
            {
                ShowCaption = false;
                part(Control103;"Trailing Sales Orders Chart")
                {
                    ApplicationArea = Basic,Suite;
                    Visible = false;
                }
                part(Control106;"My Job Queue")
                {
                    ApplicationArea = Basic,Suite;
                    Visible = false;
                }
                part(Control100;"Cash Flow Forecast Chart")
                {
                    ApplicationArea = Basic,Suite;
                }
                part(Control1902476008;"My Vendors")
                {
                    ApplicationArea = Basic,Suite;
                }
                part(Control108;"Report Inbox Part")
                {
                    ApplicationArea = Basic,Suite;
                }
                systempart(Control1901377608;MyNotes)
                {
                    ApplicationArea = Basic,Suite;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("&G/L Trial Balance")
            {
                ApplicationArea = Basic,Suite;
                Caption = '&G/L Trial Balance';
                Image = "Report";
                RunObject = Report "Trial Balance";
                ToolTip = 'View, print, or send a report that shows the balances for the general ledger accounts, including the debits and credits. You can use this report to ensure accurate accounting practices.';
            }
            action("&Bank Detail Trial Balance")
            {
                ApplicationArea = Basic,Suite;
                Caption = '&Bank Detail Trial Balance';
                Image = "Report";
                RunObject = Report "Bank Acc. - Detail Trial Bal.";
                ToolTip = 'View, print, or send a report that shows a detailed trial balance for selected bank accounts. You can use the report at the close of an accounting period or fiscal year.';
            }
        }
        area(embedding)
        {
            action(GeneralJournals)
            {
                ApplicationArea = Basic,Suite;
                Caption = 'General Journals';
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type"=CONST(General),
                                    Recurring=CONST(false));
                ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
            }
            action("Chart of Accounts")
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Chart of Accounts';
                RunObject = Page "Chart of Accounts";
                ToolTip = 'View the chart of accounts.';
            }
            action(Vendors)
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page "Vendor List";
                ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
            }
            action(VendorsBalance)
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Vendor List";
                RunPageView = WHERE("Balance (LCY)"=FILTER(<>0));
                ToolTip = 'View a summary of the bank account balance in different periods.';
            }
            action("Bank Accounts")
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Bank Accounts';
                Image = BankAccount;
                RunObject = Page "Bank Account List";
                ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
            }
        }
        area(sections)
        {
        }
        area(processing)
        {
        }
    }
}

