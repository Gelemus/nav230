pageextension 60664 pageextension60664 extends "Accountant Role Center"
{
    layout
    {
        addafter(Control123)
        {
            part(Control186; "O365 Activities")
            {
                AccessByPermission = TableData "Activities Cue" = I;
                ApplicationArea = Basic, Suite;
            }
        }
        moveafter(Control76; Control123)
    }
    actions
    {
        modify("G/L Reports")
        {
            Visible = true;
        }
        //  modify("G/L Trial Balance")
        //  {

        //      //Unsupported feature: Property Modification (Name) on ""&G/L Trial Balance"(Action 32)".

        //      Caption = 'Payment  Report List';
        //      //Unsupported feature: Property Modification (RunObject) on ""&G/L Trial Balance"(Action 32)".

        //  }
        modify("Cash Flow")
        {
            Visible = true;
        }
        modify("Customers and Vendors")
        {
            Visible = true;
        }
        modify("VAT Reports")
        {
            Visible = true;
        }
        // modify(ActionGroup60)
        // {

        //     //Unsupported feature: Property Modification (Name) on "ActionGroup60(Action 60)".

        //     Visible = true;
        // }
        modify("Cost Accounting")
        {
            Visible = true;
        }
        modify("Purchase Orders")
        {
            Visible = false;
        }
        // modify("EC Sales List")
        // {

        //     //Unsupported feature: Property Modification (Level) on ""EC Sales List"(Action 143)".


        //     //Unsupported feature: Property Modification (Name) on ""EC Sales List"(Action 143)".

        //     Caption = ' Leave Applications Status';

        //     //Unsupported feature: Property Modification (RunObject) on ""EC Sales List"(Action 143)".

        // }
        // modify("VAT Returns")
        // {

        //     //Unsupported feature: Property Modification (Level) on ""VAT Returns"(Action 145)".


        //     //Unsupported feature: Property Modification (Name) on ""VAT Returns"(Action 145)".

        //     Caption = 'Pending Approval Safari Notice List';

        //     //Unsupported feature: Property Modification (RunObject) on ""VAT Returns"(Action 145)".

        // }
        // modify("VAT Statements")
        // {

        //     //Unsupported feature: Property Modification (Level) on ""VAT Statements"(Action 199)".


        //     //Unsupported feature: Property Modification (Name) on ""VAT Statements"(Action 199)".

        //     Caption = 'Imprest List Status';

        //     //Unsupported feature: Property Modification (RunObject) on ""VAT Statements"(Action 199)".

        // }
        //modify(Intrastat)
        // {

        //     //Unsupported feature: Property Modification (Level) on "Intrastat(Action 11)".


        //     //Unsupported feature: Property Modification (Name) on "Intrastat(Action 11)".

        //     Caption = 'Transport Request List';

        //     //Unsupported feature: Property Modification (RunObject) on "Intrastat(Action 11)".

        // }
        // modify(ActionGroup172)
        // {
        //     Visible = true;
        // }
        // modify(Action14)
        // {

        //     //Unsupported feature: Property Modification (Name) on "Action14(Action 14)".

        //     Caption = 'Salary Advance posted';

        //     //Unsupported feature: Property Modification (RunObject) on "Action14(Action 14)".

        // }
        // modify("Intrastat Journals")
        // {

        //     //Unsupported feature: Property Modification (Name) on ""Intrastat Journals"(Action 12)".

        //     Caption = 'Posted Petty Cash List';

        //     //Unsupported feature: Property Modification (RunObject) on ""Intrastat Journals"(Action 12)".

        // }
        // modify(Deferrals)
        // {

        //     //Unsupported feature: Property Modification (Name) on "Deferrals(Action 166)".

        //     Caption = 'Funds Transfer List';

        //     //Unsupported feature: Property Modification (RunObject) on "Deferrals(Action 166)".

        // }
        // modify(Partners)
        // {

        //     //Unsupported feature: Property Modification (Name) on "Partners(Action 168)".

        //     Caption = 'Allocated Imprest List';

        //     //Unsupported feature: Property Modification (RunObject) on "Partners(Action 168)".

        // }
        // modify(Action171)
        // {

        //     //Unsupported feature: Property Modification (Name) on "Action171(Action 171)".

        //     Caption = 'Payment List Deposits';

        //     //Unsupported feature: Property Modification (RunObject) on "Action171(Action 171)".

        // }
        // modify(Action173)
        // {

        //     //Unsupported feature: Property Modification (Level) on "Action173(Action 173)".


        //     //Unsupported feature: Property Modification (Name) on "Action173(Action 173)".

        //     Caption = 'Leave Balances List';

        //     //Unsupported feature: Property Modification (RunObject) on "Action173(Action 173)".

        // }
        modify("Accounting Periods")
        {
            Visible = false;
        }
        modify(Journals)
        {
            Visible = true;
        }
        // modify("<Action3>")
        // {

        //     //Unsupported feature: Property Modification (Name) on ""<Action3>"(Action 3)".

        //     Caption = 'Petty Cash Surrender list';

        //     //Unsupported feature: Property Modification (RunObject) on ""<Action3>"(Action 3)".

        //     Visible = false;
        // }
        // modify(PurchaseJournals)
        // {

        //     //Unsupported feature: Property Modification (Name) on "PurchaseJournals(Action 117)".

        //     Caption = 'Pending Approval Casual Payment List';

        //     //Unsupported feature: Property Modification (RunObject) on "PurchaseJournals(Action 117)".

        // }
        // modify(SalesJournals)
        // {

        //     //Unsupported feature: Property Modification (Name) on "SalesJournals(Action 118)".

        //     Caption = 'Casual Requisitions Approved';

        //     //Unsupported feature: Property Modification (RunObject) on "SalesJournals(Action 118)".

        // }
        modify("Cash Management")
        {
            Visible = true;
        }
        modify(CashReceiptJournals)
        {
            Visible = false;
        }
        modify(PaymentJournals)
        {
            Visible = false;
        }
        // modify("Direct Debit Collections")
        // {

        //     //Unsupported feature: Property Modification (Name) on ""Direct Debit Collections"(Action 165)".

        //     Caption = 'Safari Notice List - Status';

        //     //Unsupported feature: Property Modification (RunObject) on ""Direct Debit Collections"(Action 165)".

        // }
        // modify("Payment Recon. Journals")
        // {

        //     //Unsupported feature: Property Modification (Name) on ""Payment Recon. Journals"(Action 163)".

        //     Caption = 'Approved Safari Notice List';

        //     //Unsupported feature: Property Modification (RunObject) on ""Payment Recon. Journals"(Action 163)".

        // }
        // modify("Payment Terms")
        // {

        //     //Unsupported feature: Property Modification (Name) on ""Payment Terms"(Action 120)".

        //     Caption = 'Posted Casual Payment List';

        //     //Unsupported feature: Property Modification (RunObject) on ""Payment Terms"(Action 120)".

        // }
        // modify("Cash Flow Forecasts")
        // {

        //     //Unsupported feature: Property Modification (Name) on ""Cash Flow Forecasts"(Action 102)".

        //     Caption = 'Casual Requisitions Pending';

        //     //Unsupported feature: Property Modification (RunObject) on ""Cash Flow Forecasts"(Action 102)".

        // }
        // modify("Chart of Cash Flow Accounts")
        // {

        //     //Unsupported feature: Property Modification (Name) on ""Chart of Cash Flow Accounts"(Action 142)".

        //     Caption = 'Safari Notice List';

        //     //Unsupported feature: Property Modification (RunObject) on ""Chart of Cash Flow Accounts"(Action 142)".

        // }
        // modify("Cash Flow Manual Revenues")
        // {

        //     //Unsupported feature: Property Modification (Name) on ""Cash Flow Manual Revenues"(Action 174)".

        //     Caption = 'Fuel Prices';

        //     //Unsupported feature: Property Modification (RunObject) on ""Cash Flow Manual Revenues"(Action 174)".

        // }
        // modify("Cash Flow Manual Expenses")
        // {

        //     //Unsupported feature: Property Modification (Name) on ""Cash Flow Manual Expenses"(Action 177)".

        //     Caption = 'Budget Committment Lines';

        //     //Unsupported feature: Property Modification (RunObject) on ""Cash Flow Manual Expenses"(Action 177)".

        // }
        // modify(ActionGroup84)
        // {

        //     //Unsupported feature: Property Modification (Level) on "ActionGroup84(Action 84)".


        //     //Unsupported feature: Property Modification (ActionType) on "ActionGroup84(Action 84)".


        //     //Unsupported feature: Property Modification (Name) on "ActionGroup84(Action 84)".

        //     Caption = 'Casual Requisitions';

        //     //Unsupported feature: Property Insertion (RunObject) on "ActionGroup84(Action 84)".

        //}
        // modify("Cost Types")
        // {

        //     //Unsupported feature: Property Modification (Name) on ""Cost Types"(Action 77)".

        //     Caption = 'Salary Advance Applications';

        //     //Unsupported feature: Property Modification (RunObject) on ""Cost Types"(Action 77)".

        // }
        //  /
        //         modify("Cost Objects")
        //         {

        //             //Unsupported feature: Property Modification (Name) on ""Cost Objects"(Action 74)".

        //             Caption = 'Salary Advance Approved ';

        //             //Unsupported feature: Property Modification (RunObject) on ""Cost Objects"(Action 74)".

        //         }
        // modify("Cost Allocations")
        // {

        //     //Unsupported feature: Property Modification (Name) on ""Cost Allocations"(Action 63)".

        //     Caption = 'Petty Cash list';

        //     //Unsupported feature: Property Modification (RunObject) on ""Cost Allocations"(Action 63)".

        // }
        // modify("Cost Budgets")
        // {

        //     //Unsupported feature: Property Modification (Name) on ""Cost Budgets"(Action 1)".

        //     Caption = 'Posted Petty Surrender List';

        //     //Unsupported feature: Property Modification (RunObject) on ""Cost Budgets"(Action 1)".

        //     Visible = false;
        // }
        // modify(ActionGroup16)
        // {
        //     Visible = true;
        // }
        modify(Insurance)
        {
            Visible = false;
        }
        modify("Insurance Journals")
        {
            Visible = false;
        }
        modify("Posted Documents")
        {
            Visible = true;
        }
        // modify("Issued Reminders")
        // {

        //     //Unsupported feature: Property Modification (Name) on ""Issued Reminders"(Action 29)".

        //     Caption = ' Approved Petty Cash List';

        //     //Unsupported feature: Property Modification (RunObject) on ""Issued Reminders"(Action 29)".

        // }
        // modify("Issued Fin. Charge Memos")
        // {

        //     //Unsupported feature: Property Modification (Name) on ""Issued Fin. Charge Memos"(Action 30)".

        //     Caption = 'Pending Approv Petty Cash List';

        //     //Unsupported feature: Property Modification (RunObject) on ""Issued Fin. Charge Memos"(Action 30)".

        // }
        // modify("Cost Accounting Registers")
        // {

        //     //Unsupported feature: Property Modification (Name) on ""Cost Accounting Registers"(Action 83)".

        //     Caption = 'Casuals Payment List';

        //     //Unsupported feature: Property Modification (RunObject) on ""Cost Accounting Registers"(Action 83)".

        // }
        // modify("Cost Accounting Budget Registers")
        // {

        //     //Unsupported feature: Property Modification (Name) on ""Cost Accounting Budget Registers"(Action 91)".

        //     Caption = 'Approved Casual Payment List';

        //     //Unsupported feature: Property Modification (RunObject) on ""Cost Accounting Budget Registers"(Action 91)".

        // }
        // modify(SetupAndExtensions)
        // {
        //     Visible = true;
        // }
        // modify("Payment Journal Entry")
        // {

        //     //Unsupported feature: Property Modification (Name) on ""Payment Journal Entry"(Action 121)".

        //     Caption = 'Change Password';
        //     ToolTip = 'Change Password';

        //     //Unsupported feature: Property Modification (RunObject) on ""Payment Journal Entry"(Action 121)".

        // }
        modify(Payments)
        {
            Visible = true;
        }
        modify(Analysis)
        {
            Visible = true;
        }
        modify(Tasks)
        {
            Visible = true;
        }
        modify(Create)
        {
            Visible = true;
        }
        modify(Reports)
        {
            Visible = true;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""EC Sales List"(Action 143)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""EC Sales List"(Action 143)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Returns"(Action 145)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""VAT Returns"(Action 145)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Statements"(Action 199)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""VAT Statements"(Action 199)".


        //Unsupported feature: Property Deletion (Image) on ""VAT Statements"(Action 199)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Intrastat(Action 11)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Intrastat(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Action14(Action 14)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Action14(Action 14)".


        //Unsupported feature: Property Deletion (//Promoted) on "Action14(Action 14)".


        //Unsupported feature: Property Deletion (//PromotedCategory) on "Action14(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Intrastat Journals"(Action 12)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Intrastat Journals"(Action 12)".


        //Unsupported feature: Property Deletion (//Promoted) on ""Intrastat Journals"(Action 12)".


        //Unsupported feature: Property Deletion (//PromotedCategory) on ""Intrastat Journals"(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Deferrals(Action 166)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Deferrals(Action 166)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Partners(Action 168)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Partners(Action 168)".


        //Unsupported feature: Property Deletion (//Promoted) on "Partners(Action 168)".


        //Unsupported feature: Property Deletion (//PromotedCategory) on "Partners(Action 168)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Action171(Action 171)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Action171(Action 171)".


        //Unsupported feature: Property Deletion (//Promoted) on "Action171(Action 171)".


        //Unsupported feature: Property Deletion (//PromotedCategory) on "Action171(Action 171)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Action173(Action 173)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Action173(Action 173)".


        //Unsupported feature: Property Deletion (//Promoted) on "Action173(Action 173)".


        //Unsupported feature: Property Deletion (//PromotedCategory) on "Action173(Action 173)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""<Action3>"(Action 3)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""<Action3>"(Action 3)".


        //Unsupported feature: Property Deletion (RunPageView) on ""<Action3>"(Action 3)".


        //Unsupported feature: Property Deletion (//Promoted) on ""<Action3>"(Action 3)".


        //Unsupported feature: Property Deletion (//PromotedCategory) on ""<Action3>"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PurchaseJournals(Action 117)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "PurchaseJournals(Action 117)".


        //Unsupported feature: Property Deletion (RunPageView) on "PurchaseJournals(Action 117)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesJournals(Action 118)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "SalesJournals(Action 118)".


        //Unsupported feature: Property Deletion (RunPageView) on "SalesJournals(Action 118)".

        modify(ICGeneralJournals)
        {
            Visible = false;
        }
        // modify(Action1102601002)
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Direct Debit Collections"(Action 165)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Direct Debit Collections"(Action 165)".


        //Unsupported feature: Property Deletion (//Promoted) on ""Direct Debit Collections"(Action 165)".


        //Unsupported feature: Property Deletion (//PromotedCategory) on ""Direct Debit Collections"(Action 165)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Recon. Journals"(Action 163)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Payment Recon. Journals"(Action 163)".


        //Unsupported feature: Property Deletion (//Promoted) on ""Payment Recon. Journals"(Action 163)".


        //Unsupported feature: Property Deletion (Image) on ""Payment Recon. Journals"(Action 163)".


        //Unsupported feature: Property Deletion (//PromotedCategory) on ""Payment Recon. Journals"(Action 163)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Terms"(Action 120)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Payment Terms"(Action 120)".


        //Unsupported feature: Property Deletion (//Promoted) on ""Payment Terms"(Action 120)".


        //Unsupported feature: Property Deletion (Image) on ""Payment Terms"(Action 120)".


        //Unsupported feature: Property Deletion (//PromotedCategory) on ""Payment Terms"(Action 120)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cash Flow Forecasts"(Action 102)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Cash Flow Forecasts"(Action 102)".


        //Unsupported feature: Property Deletion (//Promoted) on ""Cash Flow Forecasts"(Action 102)".


        //Unsupported feature: Property Deletion (//PromotedCategory) on ""Cash Flow Forecasts"(Action 102)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Chart of Cash Flow Accounts"(Action 142)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Chart of Cash Flow Accounts"(Action 142)".


        //Unsupported feature: Property Deletion (//Promoted) on ""Chart of Cash Flow Accounts"(Action 142)".


        //Unsupported feature: Property Deletion (//PromotedCategory) on ""Chart of Cash Flow Accounts"(Action 142)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cash Flow Manual Revenues"(Action 174)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Cash Flow Manual Revenues"(Action 174)".


        //Unsupported feature: Property Deletion (//Promoted) on ""Cash Flow Manual Revenues"(Action 174)".


        //Unsupported feature: Property Deletion (//PromotedCategory) on ""Cash Flow Manual Revenues"(Action 174)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cash Flow Manual Expenses"(Action 177)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Cash Flow Manual Expenses"(Action 177)".


        //Unsupported feature: Property Deletion (//Promoted) on ""Cash Flow Manual Expenses"(Action 177)".


        //Unsupported feature: Property Deletion (//PromotedCategory) on ""Cash Flow Manual Expenses"(Action 177)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ActionGroup84(Action 84)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Types"(Action 77)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Cost Types"(Action 77)".


        //Unsupported feature: Property Deletion (//Promoted) on ""Cost Types"(Action 77)".


        //Unsupported feature: Property Deletion (//PromotedCategory) on ""Cost Types"(Action 77)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Centers"(Action 75)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Cost Centers"(Action 75)".


        //Unsupported feature: Property Deletion (//Promoted) on ""Cost Centers"(Action 75)".


        //Unsupported feature: Property Deletion (//PromotedCategory) on ""Cost Centers"(Action 75)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Objects"(Action 74)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Cost Objects"(Action 74)".


        //Unsupported feature: Property Deletion (//Promoted) on ""Cost Objects"(Action 74)".


        //Unsupported feature: Property Deletion (//PromotedCategory) on ""Cost Objects"(Action 74)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Allocations"(Action 63)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Cost Allocations"(Action 63)".


        //Unsupported feature: Property Deletion (//Promoted) on ""Cost Allocations"(Action 63)".


        //Unsupported feature: Property Deletion (//PromotedCategory) on ""Cost Allocations"(Action 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Budgets"(Action 1)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Cost Budgets"(Action 1)".


        //Unsupported feature: Property Deletion (//Promoted) on ""Cost Budgets"(Action 1)".


        //Unsupported feature: Property Deletion (//PromotedCategory) on ""Cost Budgets"(Action 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Issued Reminders"(Action 29)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Issued Reminders"(Action 29)".


        //Unsupported feature: Property Deletion (Image) on ""Issued Reminders"(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Issued Fin. Charge Memos"(Action 30)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Issued Fin. Charge Memos"(Action 30)".


        //Unsupported feature: Property Deletion (Image) on ""Issued Fin. Charge Memos"(Action 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Accounting Registers"(Action 83)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Cost Accounting Registers"(Action 83)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Accounting Budget Registers"(Action 91)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Cost Accounting Budget Registers"(Action 91)".


        //Unsupported feature: Property Deletion (AccessByPermission) on ""Payment Journal Entry"(Action 121)".

        addfirst("G/L Reports")
        {
            action("Employee Leave Summary")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Employee Leave Summary';
                Image = "Report";
                RunObject = Report "Employee Leave Summary";
                ToolTip = 'Employee Leave Summary';
            }
        }
        addafter("&G/L Trial Balance")
        {
            action("&G/L Trial Balances")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&G/L Trial Balance';
                Image = "Report";
                RunObject = Report "Trial Balance";
                ToolTip = 'View, print, or send a report that shows the balances for the general ledger accounts, including the debits and credits. You can use this report to ensure accurate accounting practices.';
            }
            action("Petty Cash Reports")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Petty Cash Reports';
                Image = "Report";
                RunObject = Report "Petty Cash Reports";
                ToolTip = 'Petty Cash Reports';
            }
            action("Transaction By Account")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Transaction By Account';
                Image = "Report";
                RunObject = Report "Transaction By Acc";
                ToolTip = 'View, print, or send a report that shows the balances for the general ledger accounts, including the debits and credits. You can use this report to ensure accurate accounting practices.';
            }
            action("Petty Cash Surrender Summary")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Petty Cash Surrender Summary';
                Image = "Report";
                RunObject = Report "Petty Cash Surrender Summary";
                ToolTip = 'Petty Cash Surrender Summary';
            }
            action("Trial Balance by Period")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Trial Balance by Period';
                Image = "Report";
                //The property '//PromotedCategory' can only be set if the property '//Promoted' is set to 'true'
                ////Promoted = true;
                ////PromotedCategory = "Report";
                RunObject = Report "Trial Balance by Period";
                ToolTip = 'View the opening balance by general ledger account, the movements in the selected period of month, quarter, or year, and the resulting closing balance.';
            }
        }
        addafter("Dimensions - Total")
        {
            action("Monthly  Fuel Consumption")
            {
                Caption = 'Monthly  Fuel Consumption';
                Image = "Report";
                ////Promoted = true;
                ////PromotedCategory = "Report";
                //RunObject = Report "Monthly  Fuel Consumption";
            }
            action("Employees Statement")
            {
                Caption = 'Employees Statement';
                Image = "Report";
                ////Promoted = true;
                ////PromotedCategory = "Report";
                RunObject = Report "Employees Statement";
            }
            group("Monthly Reports")
            {
                Caption = 'Monthly Reports';
                Visible = true;
                action("Master Roll Report")
                {
                    Caption = 'Master Roll Report';
                    Image = "Report";
                    ////Promoted = true;
                    ////PromotedCategory = "Report";
                    RunObject = Report "Master Roll Report";
                }
                action("Master Roll Report-Dim Summary")
                {
                    Caption = 'Master Roll Report-Dim Summary';
                    Image = "Report";
                    ////Promoted = true;
                    ////PromotedCategory = "Report";
                    RunObject = Report "Master Roll Report-Dim";
                }
                action("Master Roll Report-Dimensions")
                {
                    Caption = 'Master Roll Report-Dimensions';
                    Image = "Report";
                    ////Promoted = true;
                    ////PromotedCategory = "Report";
                    RunObject = Report "Master Roll Report-Dimensions";
                }
                action("A Third Rule Report")
                {
                    Caption = 'A Third Rule Report';
                    Image = "Report";
                    ////Promoted = true;
                    ////PromotedCategory = "Report";
                    RunObject = Report "AThird Rule Report";
                }
                action("Timesheet Report")
                {
                    Caption = 'Timesheet Report';
                    Image = "Report";
                    ////Promoted = true;
                    ////PromotedCategory = "Report";
                    RunObject = Report "Generate P10 Re";
                }
                action("Company Payslip")
                {
                    Caption = 'Company Payslip';
                    Image = "Report";
                    ////Promoted = true;
                    ////PromotedCategory = "Report";
                    RunObject = Report "Company Payslip";
                }
                action(Payslip)
                {
                    Caption = 'Payslip';
                    Image = "Report";
                    //Promoted = true;
                    //PromotedCategory = "Report";
                    RunObject = Report Payslips;
                    Visible = false;
                }
                action("ED Report")
                {
                    Caption = 'ED Report';
                    Image = "Report";
                    //Promoted = true;
                    //PromotedCategory = "Report";
                    RunObject = Report "ED Report";
                }
                action("ED Totals Per Period")
                {
                    Caption = 'ED Totals Per Period';
                    Image = "Report";
                    //Promoted = true;
                    //PromotedCategory = "Report";
                    RunObject = Report "ED Totals Per Period";
                }
                action("ED Report% Commission")
                {
                    Caption = 'ED Report% Commission';
                    Image = "Report";
                    //Promoted = true;
                    //PromotedCategory = "Report";
                    RunObject = Report "ED Report with commision";
                }
                action(" Bank Payment List")
                {
                    Caption = ' Bank Payment List';
                    Image = Payment;
                    //Promoted = true;
                    //PromotedCategory = "Report";
                    RunObject = Report "Bank Payment List";
                }
                action("Staff Gratuity Report")
                {
                    Caption = 'Staff Gratuity Report';
                    Image = "Report";
                    //Promoted = true;
                    //PromotedCategory = "Report";
                    RunObject = Report "Staff Gratuity Report";
                }
                action("Institution Based ED Report")
                {
                    Caption = 'Institution Based ED Report';
                    Image = Payment;
                    //Promoted = true;
                    //PromotedCategory = "Report";
                    RunObject = Report "Institution Based ED Report";
                }
                action(" Institution Based ED Report In")
                {
                    Caption = ' Institution Based ED Report In';
                    Image = Payment;
                    //Promoted = true;
                    //PromotedCategory = "Report";
                    RunObject = Report "Institution Based ED Report In";
                }
                action("Check Payment List")
                {
                    Caption = 'Check Payment List';
                    Image = "Report";
                    //Promoted = true;
                    //PromotedCategory = "Report";
                    RunObject = Report "Check Payment List";
                }
                action(" Cash Payment List")
                {
                    Caption = ' Cash Payment List';
                    Image = "Report";
                    //Promoted = true;
                    //PromotedCategory = "Report";
                    RunObject = Report "Cash Payment List";
                }
                action("MPESA Payment List")
                {
                    Caption = 'MPESA Payment List';
                    Image = "Report";
                    //Promoted = true;
                    //PromotedCategory = "Report";
                    RunObject = Report "MPESA Payment List";
                }
                action("Payroll Reconciliation-Per ED")
                {
                    Caption = 'Payroll Reconciliation-Per ED';
                    Image = "Report";
                    //Promoted = true;
                    //PromotedCategory = "Report";
                    RunObject = Report "Payroll Reconciliation-Per ED";
                }
                action(" Payroll Reconciliation-All ED")
                {
                    Caption = ' Payroll Reconciliation-All ED';
                    Image = "Report";
                    //Promoted = true;
                    //PromotedCategory = "Report";
                    RunObject = Report "Payroll Reconciliation-All ED";
                }
                action(" Bank Payment Report")
                {
                    Caption = ' Bank Payment Report';
                    Image = "Report";
                    //Promoted = true;
                    //PromotedCategory = "Report";
                    RunObject = Report "Bank Payment2 Report";
                }
            }
            group("Monthly Statutory Reports")
            {
                Caption = 'Monthly Statutory Reports';
                Visible = true;
                action("NSSF Report")
                {
                    Caption = 'NSSF Report';
                    Image = "Report";
                    //Promoted = true;
                    //PromotedCategory = "Report";
                    RunObject = Report "NSSF Report";
                }
                action("NSSF Tier Report")
                {
                    Caption = 'NSSF Tier Report';
                    Image = "Report";
                    //Promoted = true;
                    //PromotedCategory = "Report";
                    RunObject = Report "NSSF Tier Report";
                }
                action("NHIF Report")
                {
                    Caption = 'NHIF Report';
                    Image = "Report";
                    //Promoted = true;
                    //PromotedCategory = "Report";
                    RunObject = Report "NHIF Report";
                }
                action("PAYE Report")
                {
                    Caption = 'PAYE Report';
                    Image = "Report";
                    //Promoted = true;
                    //PromotedCategory = "Report";
                    RunObject = Report "PAYE Report";
                }
                action("Generate P10")
                {
                    Caption = 'Generate P10';
                    Image = "Report";
                    //Promoted = true;
                    //PromotedCategory = "Report";
                    RunObject = Report "Generate P10";
                }
                action("<Report Pension Report>")
                {
                    Caption = 'Pension Report';
                    Image = "Report";
                    //Promoted = true;
                    //PromotedCategory = "Report";
                    RunObject = Report "Pension Report";
                }
            }
            group("Annual Statutory Reports")
            {
                Caption = 'Annual Statutory Reports';
                Visible = true;
                action("P9A Report")
                {
                    Caption = 'P9A Report';
                    Image = "Report";
                    //Promoted = true;
                    //PromotedCategory = "Report";
                    RunObject = Report "P9A Report";
                }
                action(P10A)
                {
                    Caption = 'P10A';
                    Image = "Report";
                    //The property '//PromotedCategory' can only be set if the property '//Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report P10A;
                }
                action(P10)
                {
                    Caption = 'P10';
                    Image = "Report";
                    //Promoted = true;
                    //PromotedCategory = "Report";
                    RunObject = Report P10;
                }
                action(P10D)
                {
                    Caption = 'P10D';
                    Image = "Report";
                    //Promoted = true;
                    //PromotedCategory = "Report";
                    RunObject = Report P10D;
                }
                action("NSSF YEARLY REPORT")
                {
                    Caption = 'NSSF YEARLY REPORT';
                    Image = "Report";
                    //Promoted = true;
                    //PromotedCategory = "Report";
                    RunObject = Report "NSSF YEARLY REPORT";
                }
                action("<Report  NHIF YEARLY REPORT>")
                {
                    Caption = 'NHIF YEARLY REPORT';
                    Image = "Report";
                    //Promoted = true;
                    //PromotedCategory = "Report";
                    RunObject = Report "NHIF YEARLY REPORT";
                }
                action("<Report  CBS>")
                {
                    Caption = 'CBS';
                    Image = "Report";
                    //Promoted = true;
                    //PromotedCategory = "Report";
                    RunObject = Report CBS;
                }
            }
        }
        addafter("Purchase Orders")
        {
            action("Purchase Order Archives")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Order Archives';
                Image = Archive;
                RunObject = Page "Purchase Order Archives";
                ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';
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
        }
        addafter("Bank Accounts")
        {
            action("Employee List Finance")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Employee List';
                Image = Employee;
                RunObject = Page "Employee List Finance";
                ToolTip = 'View or edit detailed information for the Employee that you trade with. From each employee card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
            }
        }
        addafter(Vendors)
        {
            action(Items)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Items';
                Image = Vendor;
                RunObject = Page "Item List";
                ToolTip = 'Item List';
            }
        }
        addafter("Incoming Documents")
        {
            action("Fuel Filling List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Fuel Filling List';
                RunObject = Page "Fuel Filling List";
                ToolTip = 'Fuel Filling List';
            }
            action("Submitted Fuel Filling List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Submitted Fuel Filling List';
                Image = VATStatement;
                RunObject = Page "Submitted Fuel Filling List";
                ToolTip = 'Submitted Fuel Filling List';
            }
        }
        addfirst(Sections)
        {
            group("Change/Update Bank")
            {
                Caption = 'Change/Update Bank';
                action("Update Receipts Lists")
                {
                    Caption = 'Update Receipts Lists';
                    RunObject = Page "Update Receipts Lists";
                }
            }
            group(Setups)
            {
                Caption = 'Setups';
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
            }
        }
        addafter("Cash Flow Manual Revenues")
        {
            group("Employee Self Service")
            {
                Caption = 'Employee Self Service';
                action(" Imprest List")
                {
                    Caption = ' Imprest List';
                    RunObject = Page "Imprest List";
                }
            }
        }
        addfirst(Journals)
        {
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
        }
        addafter("Payment Terms")
        {
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
        }
        addfirst(Journals)
        {
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
            action("Requisition List")
            {
                Caption = 'Requisition List';
                RunObject = Page "Requisition List";
            }
            action("Pending Requisition List")
            {
                Caption = 'Pending Requisition List';
                RunObject = Page "Pending Requisition List";
            }
            action("Approve Requisitions")
            {
                ApplicationArea = Suite;
                Caption = 'Approve Requisitions';
                RunObject = Page "Approve  Requisitions";
                ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
            }
            action("Closed Requisition List")
            {
                ApplicationArea = Suite;
                Caption = 'Closed Requisition List';
                RunObject = Page "Closed  Requisition List";
                ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
            }
        }
        addafter(Journals)
        {
            group("Fund Management")
            {
                Caption = 'Fund Management';
                Visible = true;
                action(Action296)
                {
                    Caption = 'Casual Rates';
                    RunObject = Page "Casual Rates";
                }
                action(Action229)
                {
                    Caption = 'Casual Requisitions Pending';
                    RunObject = Page "Casual Requisitions Pending";
                }
                action(Action211)
                {
                    Caption = 'Casual Requisitions Approved';
                    RunObject = Page "Casual Requisitions Approved";
                }
                action(Action210)
                {
                    Caption = 'Approved Casual Payment List';
                    RunObject = Page "Approved Casual Payment List";
                }
                action(Action189)
                {
                    Caption = 'Posted Casual Payment List';
                    RunObject = Page "Posted Casual Payment List";
                }
                action(Action131)
                {
                    Caption = ' Imprest List';
                    RunObject = Page "Imprest List 2";
                }
                action("Memo List")
                {
                    Caption = 'Memo List';
                    RunObject = Page "Memo List";
                }
                action("Memo Pending")
                {
                    Caption = 'Memo Pending';
                    RunObject = Page "Memo Pending";
                }
                action("Memo Approved")
                {
                    Caption = 'Memo Approved';
                    RunObject = Page "Memo Approved";
                }
                action("Memo Posted")
                {
                    Caption = 'Memo Posted';
                    RunObject = Page "Memo Posted";
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
            }
        }
        addafter(Partners)
        {
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
        }
        addafter("Cost Budgets")
        {
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
            }
            action("Pending Cash Payment List")
            {
                Caption = 'Pending Cash Payment List';
                RunObject = Page "Pending Cash Payment List";
            }
            action("Approved Cash Payment List")
            {
                Caption = 'Approved Cash Payment List';
                RunObject = Page "Approved Cash Payment List";
            }
            action("Posted Cash Payment List")
            {
                Caption = 'Posted Cash Payment List';
                RunObject = Page "Posted Cash Payment List";
            }
            action("Cancelled Cash Payment List")
            {
                Caption = 'Cancelled Cash Payment List';
                RunObject = Page "Cancelled Cash Payment List";
            }
            action("Withholding List")
            {
                Caption = 'Withholding List';
                RunObject = Page "Withholding Lists";
            }
            action("Pending Withholding List")
            {
                Caption = 'Pending Withholding List';
                RunObject = Page "Pending Withholding Lists";
            }
            action("Approved Withholding List")
            {
                Caption = 'Approved Withholding List';
                RunObject = Page "Approved Withholding Lists";
            }
            action("Posted Withholding List")
            {
                Caption = 'Posted Withholding List';
                RunObject = Page "Posted Withholding Lists";
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
            action("Receipt Codes")
            {
                Caption = 'Receipt Codes';
                RunObject = Page "Receipt Codes";
            }
        }
        addafter(Deferrals)
        {
            action("Purchase Requisition Codes")
            {
                Caption = 'Purchase Requisition Codes';
                RunObject = Page "Purchase Requisition Codes";
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
        }
        addafter(PaymentJournals)
        {
            action(Action226)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cash Payment List';
                Image = BankAccount;
                //Promoted = true;
                //PromotedCategory = Process;
                RunObject = Page "Cash Payment List";
                ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
                Visible = false;
            }
        }
        addafter(Action164)
        {
            action("Bank Acc. Reconciliation List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Acc. Reconciliation List';
                Image = BankAccount;
                //Promoted = true;
                //PromotedCategory = Process;
                RunObject = Page "Bank Acc. Reconciliation List";
                ToolTip = 'Bank Acc. Reconciliation List';
            }
        }
        addfirst("Posted Documents")
        {
            action(Action335)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Order Archives';
                Image = Archive;
                RunObject = Page "Purchase Order Archives";
                ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';
            }
        }
        addafter("G/L Registers")
        {
            action(Action191)
            {
                Caption = 'Posted Payment List';
                RunObject = Page "Posted Payment List";
            }
            action("Posted Receipt List")
            {
                Caption = 'Posted Receipt List';
                RunObject = Page "Posted Receipt List";
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
        addfirst(Processing)
        {
            action(Payroll)
            {
                Caption = 'Payroll';
            }
            action("Open Period")
            {
                Caption = 'Open Period';
                Image = OpenJournal;
                //Promoted = true;
                //PromotedCategory = Process;
                RunObject = Codeunit "Open Period";
            }
            action("Calculate All Payrolls")
            {
                Caption = 'Calculate All Payrolls';
                Image = Calculate;
                //Promoted = true;
                //PromotedCategory = Process;
                RunObject = Codeunit "Calculate All Payrolls";
            }
            action(Action268)
            {
                Caption = 'General Journals';
                Image = GLJournal;
                //Promoted = true;
                //PromotedCategory = Process;
                RunObject = Page "General Journal";
            }
            action("Generate Payroll Journal Entries")
            {
                Caption = 'Generate Payroll Journal Entries';
                Image = GetEntries;
                //Promoted = true;
                //PromotedCategory = Process;
                RunObject = Codeunit "Payroll Posting";
            }
            action(" Payroll Setups")
            {
                Caption = ' Payroll Setups';
                //Promoted = true;
                //PromotedCategory = Process;
                RunObject = Page "Payroll Setups";
            }
            action("Payroll Posting Setup")
            {
                Caption = 'Payroll Posting Setup';
                //Promoted = true;
                //PromotedCategory = Process;
                RunObject = Page "Payroll Posting Setup";
            }
            action("ED Posting Group")
            {
                Caption = 'ED Posting Group';
                //Promoted = true;
                //PromotedCategory = Process;
                RunObject = Page "ED Posting Group";
            }
            group("Payroll Allowances")
            {
                Caption = 'Payroll Allowances';
                Visible = false;
            }
            action("Allowance List- Open")
            {
                Caption = 'Allowance List- Open';
                Image = OpenJournal;
                //Promoted = true;
                //PromotedCategory = Process;
                //RunObject = Page "Allowance List- Open";
            }
            action("Allowance List Pending approval")
            {
                Caption = 'Allowance List Pending approval';
                Image = Calculate;
                //Promoted = true;
                //PromotedCategory = Process;
                //RunObject = Page "Allowance List Pending approva";
            }
            action("Allowance List- Approved")
            {
                Caption = 'Allowance List- Approved';
                Image = GLJournal;
                //Promoted = true;
                //PromotedCategory = Process;
                //RunObject = Page "Allowance List- Approved";
            }
            action("Posted Allowance List")
            {
                Caption = 'Posted Allowance List';
                Image = GetEntries;
                //Promoted = true;
                //PromotedCategory = Process;
                //RunObject = Page "Posted Allowance List";
            }
            group("Payroll Setups")
            {
                Caption = 'Payroll Setups';
                Visible = true;
            }
            action("Calculation Header")
            {
                Caption = 'Calculation Header';
                //Promoted = true;
                //PromotedCategory = Process;
                RunObject = Page "Calculation Header";
            }
            action(" Payroll")
            {
                Caption = ' Payroll';
                //Promoted = true;
                //PromotedCategory = Process;
                RunObject = Page Payroll;
            }
            action("Payroll Year")
            {
                Caption = 'Payroll Year';
                //Promoted = true;
                //PromotedCategory = Process;
                RunObject = Page "Payroll Year";
            }
            action("ED Definitions")
            {
                Caption = 'ED Definitions';
                //Promoted = true;
                //PromotedCategory = Process;
                RunObject = Page "ED Definitions";
            }
            action(Action281)
            {
                Caption = ' Payroll Setups';
                //Promoted = true;
                //PromotedCategory = Process;
                RunObject = Page "Payroll Setups";
            }
            action(Action280)
            {
                Caption = 'Payroll Posting Setup';
                //Promoted = true;
                //PromotedCategory = Process;
                RunObject = Page "Payroll Posting Setup";
            }
            action(Action279)
            {
                Caption = 'ED Posting Group';
                //Promoted = true;
                //PromotedCategory = Process;
                RunObject = Page "ED Posting Group";
            }
            action("Payslip Group")
            {
                Caption = 'Payslip Group';
                //Promoted = true;
                //PromotedCategory = Process;
                RunObject = Page "Payslip Group";
            }
            action(" Allowed Payrolls")
            {
                Caption = ' Allowed Payrolls';
                //Promoted = true;
                //PromotedCategory = Process;
                RunObject = Page "Allowed Payrolls";
            }
            action(" Lookup Table Header")
            {
                Caption = ' Lookup Table Header';
                //Promoted = true;
                //PromotedCategory = Process;
                RunObject = Page "Lookup Table Header";
            }
            action("Special Payments")
            {
                Caption = 'Special Payments';
                //Promoted = true;
                //PromotedCategory = Process;
                RunObject = Page "Special Payments";
            }
            action(" Mode of Payment")
            {
                Caption = ' Mode of Payment';
                //Promoted = true;
                //PromotedCategory = Process;
                RunObject = Page "Mode of Payment";
            }
            action("Loan types")
            {
                Caption = 'Loan types';
                //Promoted = true;
                //PromotedCategory = Process;
                RunObject = Page "Loan types";
            }
            action("Master Roll Group")
            {
                Caption = 'Master Roll Group';
                //Promoted = true;
                //PromotedCategory = Process;
                RunObject = Page "Master Roll Group";
            }
            action("Employee Customer Loan Link")
            {
                Caption = 'Employee Customer Loan Link';
                //Promoted = true;
                //PromotedCategory = Process;
                RunObject = Page "Employee Customer Loan Link";
            }
        }
        addafter("General Journals")
        {
            action("Funds General Setup")
            {
                Caption = 'Funds General Setup';
                Image = Setup;
                //Promoted = true;
                //RunObject = Page "Funds General Setup";
            }
        }
        moveafter("Chart of Accounts"; Action173)
        //moveafter("Leave Balances List"; Budgets)
        moveafter(Budgets; "Purchase Orders")
        moveafter("Purchase Orders"; "Purchase Invoices")
        // moveafter("Incoming Documents"; ActionContainer1900000012)
        // moveafter(ActionContainer1900000012; "Cash Flow Manual Revenues")
        // moveafter("Fuel Prices"; "VAT Statements")
        // moveafter("Imprest List Status"; ActionGroup84)
        // moveafter("Casual Requisitions"; "Cash Flow Forecasts")
        // moveafter("Casual Requisitions Pending"; SalesJournals)
        // moveafter("Casual Requisitions Approved"; "Cost Accounting Registers")
        // moveafter("Casuals Payment List"; PurchaseJournals)
        // moveafter("Pending Approval Casual Payment List"; "Cost Accounting Budget Registers")
        // moveafter("Approved Casual Payment List"; "Payment Terms")
        //moveafter(" Leave Applications Status"; Dimensions)
        // moveafter("Transport Request List"; "Chart of Cash Flow Accounts")
        // moveafter("Safari Notice List"; "Direct Debit Collections")
        // moveafter("Pending Approval Safari Notice List"; "Payment Recon. Journals")
        moveafter(Employees; "Analysis Views")
        moveafter("Account Schedules"; Dimensions)
        // moveafter(Dimensions; Action38)
        moveafter(GeneralJournals; Partners)
        // moveafter("Allocated Imprest List"; "Cost Allocations")
        // moveafter("Petty Cash list"; "Issued Fin. Charge Memos")
        // moveafter("Pending Approv Petty Cash List"; Action171)
        // moveafter("Payment List Deposits"; "Issued Reminders")
        //moveafter(" Approved Petty Cash List"; "Intrastat Journals")
        // moveafter("Posted Petty Cash List"; "<Action3>")
        // moveafter("Petty Cash Surrender list"; "Cost Budgets")
        // moveafter("Posted Petty Surrender List"; "Cost Types")
        // moveafter("Funds Transfer List"; "Cash Flow Manual Expenses")
    }
}

