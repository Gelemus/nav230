page 50839 "Procurement Agent Role Center"
{
    Caption = 'Purchasing Agent', Comment = '{Dependency=Match,"ProfileDescription_PURCHASINGAGENT"}';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                ShowCaption = false;
                part(Control131; "Headline RC Team Member")
                {
                    ApplicationArea = Basic, Suite;
                }
                part(Control1907662708; "Purchase Agent Activities")
                {
                    ApplicationArea = Basic, Suite;
                }
                part(Control1902476008; "My Vendors")
                {
                    ApplicationArea = Basic, Suite;
                }
                part(Control1905989608; "My Items")
                {
                    ApplicationArea = Basic, Suite;
                }
                part(Control25; "Purchase Performance")
                {
                    ApplicationArea = Basic, Suite;
                }
                part(Control44; "Inventory Performance")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                part(Control35; "My Job Queue")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                part(Control45; "Report Inbox Part")
                {
                    ApplicationArea = Basic, Suite;
                }
                systempart(Control43; MyNotes)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Vendor - T&op 10 List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendor - T&op 10 List';
                Image = "Report";
                RunObject = Report "Vendor - Top 10 List";
                ToolTip = 'View a list of the vendors from whom you purchase the most or to whom you owe the most.';
            }
            action("Vendor/&Item Purchases")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendor/&Item Purchases';
                Image = "Report";
                RunObject = Report "Vendor/Item Purchases";
                ToolTip = 'View a list of item entries for each vendor in a selected period.';
            }
            separator(Inventories)
            {
                Caption = 'Inventories';
            }
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
            separator(Separator102)
            {
            }
            action("Inventory &Purchase Orders")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Inventory &Purchase Orders';
                Image = "Report";
                RunObject = Report "Inventory Purchase Orders";
                ToolTip = 'View a list of items on order from vendors. The report also shows the expected receipt date and the quantity and amount on back orders. The report can be used, for example, to see when items should be received and whether a reminder of a back order should be issued.';
                Visible = false;
            }
            action("Inventory - &Vendor Purchases")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Inventory - &Vendor Purchases';
                Image = "Report";
                RunObject = Report "Inventory - Vendor Purchases";
                ToolTip = 'View a list of the vendors that your company has purchased items from within a selected period. It shows invoiced quantity, amount and discount. The report can be used to analyze a company''s item purchases.';
                Visible = false;
            }
            action("Inventory &Cost and Price List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Inventory &Cost and Price List';
                Image = "Report";
                RunObject = Report "Inventory Cost and Price List";
                ToolTip = 'View price information for your items or stockkeeping units, such as direct unit cost, last direct cost, unit price, profit percentage, and profit.';
                Visible = false;
            }
        }
        area(embedding)
        {
            action(Vendors)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page "Vendor List";
                ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
            }
            action(Items)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
                ToolTip = 'View or edit detailed information for the products that you trade in. The item card can be of type Inventory or Service to specify if the item is a physical unit or a labor time unit. Here you also define if items in inventory or on incoming orders are automatically reserved for outbound documents and whether order tracking links are created between demand and supply to reflect planning actions.';
            }
            action("Fixed Assets")
            {
                ApplicationArea = FixedAssets;
                Caption = 'Fixed Assets';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Fixed Asset List";
                ToolTip = 'Manage periodic depreciation of your machinery or machines, keep track of your maintenance costs, manage insurance policies related to fixed assets, and monitor fixed asset statistics.';
            }
            action("Transfer Orders")
            {
                ApplicationArea = Suite;
                Caption = 'Transfer Orders';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Transfer Orders";
                RunPageMode = Create;
                ToolTip = 'Create a new Transfer Orders.';
            }
            action("Posted Transfer Receipts")
            {
                ApplicationArea = Suite;
                Caption = 'Posted Transfer Receipts';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Posted Transfer Receipts";
                RunPageMode = Create;
                ToolTip = 'Posted Transfer Receipts';
            }
            action(" Donation List")
            {
                ApplicationArea = Suite;
                Caption = ' Donation List';
                RunObject = Page "Donation List";
                ToolTip = ' Donation List';
            }
            action("Posted Donation List")
            {
                ApplicationArea = Suite;
                Caption = 'Posted Donation List';
                RunObject = Page "Posted Donation List";
                ToolTip = 'Posted Donation List';
            }
            action("Procurement Planning List")
            {
                ApplicationArea = Suite;
                Caption = 'Procurement Planning List';
                RunObject = Page "Procurement Planning List";
                ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
            }
            action("Blanket Purchase Orders")
            {
                ApplicationArea = Suite;
                Caption = 'Blanket Purchase Orders';
                RunObject = Page "Blanket Purchase Orders";
                ToolTip = 'Use blanket purchase orders as a framework for a long-term agreement between you and your vendors to buy large quantities that are to be delivered in several smaller shipments over a certain period of time. Blanket orders often cover only one item with predetermined delivery dates. The main reason for using a blanket order rather than a purchase order is that quantities entered on a blanket order do not affect item availability and thus can be used as a worksheet for monitoring, forecasting, and planning purposes..';
            }
            action("Purchase Analysis Reports")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Analysis Reports';
                RunObject = Page "Analysis Report Purchase";
                RunPageView = WHERE("Analysis Area" = FILTER(Purchase));
                ToolTip = 'Analyze the dynamics of your purchase volumes. You can also use the report to analyze your vendors'' performance and purchase prices.';
            }
            action("Inventory Analysis Reports")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Inventory Analysis Reports';
                RunObject = Page "Analysis Report Inventory";
                RunPageView = WHERE("Analysis Area" = FILTER(Inventory));
                ToolTip = 'Analyze the dynamics of your inventory according to key performance indicators that you select, for example inventory turnover. You can also use the report to analyze your inventory costs, in terms of direct and indirect costs, as well as the value and quantities of your different types of inventory.';
            }
            action("Item Journals")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item Journals';
                RunObject = Page "Item Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(Item),
                                    Recurring = CONST(false));
                ToolTip = 'Post item transactions directly to the item ledger to adjust inventory in connection with purchases, sales, and positive or negative adjustments without using documents. You can save sets of item journal lines as standard journals so that you can perform recurring postings quickly. A condensed version of the item journal function exists on item cards for quick adjustment of an items inventory quantity.';
            }
            action("Purchase Journals")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Journals';
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(Purchases),
                                    Recurring = CONST(false));
                ToolTip = 'Post any purchase-related transaction directly to a vendor, bank, or general ledger account instead of using dedicated documents. You can post all types of financial purchase transactions, including payments, refunds, and finance charge amounts. Note that you cannot post item quantities with a purchase journal.';
            }
        }
        area(sections)
        {
            group("Self Service")
            {

                Caption = 'Self Service';
                Visible = true;
                Enabled = true;

                action(" Imprest List")
                {
                    Caption = ' Imprest List';
                    ApplicationArea = All;
                    Visible = true;
                    Enabled = true;
                    RunObject = Page "Imprest List";
                }
                action("Petty Cash list")
                {
                    Caption = 'Petty Cash list';
                    ApplicationArea = All;
                    Visible = true;
                    Enabled = true;
                    RunObject = Page "Petty Cash list";
                }
                action("Pending Approv Petty Cash List")
                {
                    Caption = 'Pending Approv Petty Cash List';
                    ApplicationArea = All;
                    Visible = true;
                    Enabled = true;
                    RunObject = Page "Pending Approv Petty Cash List";
                }
                action(" Approved Petty Cash List")
                {
                    Caption = ' Approved Petty Cash List';
                    ApplicationArea = All;
                    Visible = true;
                    Enabled = true;
                    RunObject = Page "Approved Petty Cash List";
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
                action("Imprest List Status")
                {
                    Caption = 'Imprest List Status';
                    ApplicationArea = All;
                    Visible = true;
                    Enabled = true;
                    RunObject = Page "Imprest List Status";
                }
                action("Imprest Surrender List")
                {
                    Caption = 'Imprest Surrender List';
                    ApplicationArea = All;
                    Visible = true;
                    Enabled = true;
                    RunObject = Page "Imprest Surrender List";
                }
                action("Casual Requisitions")
                {
                    Caption = 'Casual Requisitions';
                    ApplicationArea = All;
                    Visible = true;
                    Enabled = true;
                    RunObject = Page "Casual Requisitions";
                }
                action("<Casual Requisitions Approved>")
                {
                    Caption = 'Casual Requisitions Approved';
                    ApplicationArea = All;
                    Visible = true;
                    Enabled = true;
                    RunObject = Page "Casual Requisitions Approved";
                }
                action("Casuals Payment List")
                {
                    Caption = 'Casuals Payment List';
                    ApplicationArea = All;
                    Visible = true;
                    Enabled = true;
                    RunObject = Page "Casuals Payment List";
                }
                action("Pending Approval Casual Payment List")
                {
                    Caption = 'Pending Approval Casual Payment List';
                    ApplicationArea = All;
                    Visible = true;
                    Enabled = true;
                    RunObject = Page "Pending Ap Casual Payment List";
                }
                action("Approved Casual Payment List")
                {
                    Caption = 'Approved Casual Payment List';
                    ApplicationArea = All;
                    Visible = true;
                    Enabled = true;
                    RunObject = Page "Approved Casual Payment List";
                }
                action("Salary Advance Applications")
                {
                    Caption = 'Salary Advance Applications';
                    ApplicationArea = All;
                    Visible = true;
                    Enabled = true;
                    RunObject = Page "Salary Advance Applications";
                }
                action(" Salary Advance Pending Approval")
                {
                    Caption = ' Salary Advance Pending Approval';
                    ApplicationArea = All;
                    Visible = true;
                    Enabled = true;
                    RunObject = Page "Salary Advance Pending Approvl";
                }
                action("Salary Advance Approved ")
                {
                    Caption = 'Salary Advance Approved ';
                    ApplicationArea = All;
                    Visible = true;
                    Enabled = true;
                    RunObject = Page "Salary Advance Approved";
                }
                action("Salary Advance posted")
                {
                    Caption = 'Salary Advance posted';
                    ApplicationArea = All;
                    Visible = true;
                    Enabled = true;
                    RunObject = Page "Salary Advance posted";
                }
                action("Leave Application")
                {
                    Caption = 'Leave Application';
                    ApplicationArea = All;
                    Visible = true;
                    Enabled = true;
                    RunObject = Page "Leave Applications";
                }
                action(" Leave Applications Status")
                {
                    Caption = ' Leave Applications Status';
                    ApplicationArea = All;
                    Visible = true;
                    Enabled = true;
                    RunObject = Page "Leave Applications Status";
                }
            }
            group("Purchase Requisition")
            {
                Caption = 'Purchase Requisition';
                Image = FiledPosted;


                action("Purchase Requisition List")
                {
                    Caption = 'Purchase Requisition List';
                    RunObject = Page "Requisition List";
                    ApplicationArea = Suite;
                    Enabled = true;
                    Visible = true;
                }
                action("Pending Requisition List")
                {
                    Caption = 'Pending Requisition List';
                    ApplicationArea = Suite;
                    RunObject = Page "Pending Requisition List";
                    Enabled = true;
                    Visible = true;
                }
                action("Approved Purchase  Requisition List")
                {
                    ApplicationArea = Suite;
                    Caption = 'Approved Purchase  Requisition List';
                    RunObject = Page "Approve  Requisitions";
                    Enabled = true;
                    Visible = true;
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
                action("Closed Purchase  Requisition List")
                {
                    ApplicationArea = Suite;
                    Enabled = true;
                    Visible = true;
                    Caption = 'Closed Purchase  Requisition List';
                    RunObject = Page "Closed  Requisition List";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
                action("Status Requisition List")
                {
                    Caption = 'Status Requisition List';
                    ApplicationArea = Suite;
                    Enabled = true;
                    Visible = true;
                    RunObject = Page "Purchase Requisition List S";
                }
            }
            group("Purchase Orders")
            {
                Caption = 'Purchase Orders';
                Image = FiledPosted;
                action(PurchaseOrders)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Orders';
                    Enabled = true;
                    Visible = true;
                    RunObject = Page "Purchase Order List";
                    ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
                }
                action("Cancelled Purchase Order List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancelled Purchase Order List';
                    Enabled = true;
                    Visible = true;
                    RunObject = Page "Cancelled Purchase Order List";
                    ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
                }
                action("Purchase Order Archives")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = true;
                    Visible = true;
                    Caption = 'Purchase Order Archives';
                    RunObject = Page "Purchase Order Archives";
                    ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
                }
                action(PurchaseOrdersPendConf)
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = true;
                    Visible = true;
                    Caption = 'Pending Confirmation';
                    RunObject = Page "Purchase Order List";
                    RunPageView = WHERE(Status = FILTER(Open));
                    ToolTip = 'View the list of purchase orders that await the vendor''s confirmation. ';
                }
                action("Purchase Return Orders")
                {
                    ApplicationArea = PurchReturnOrder;
                    Enabled = true;
                    Visible = true;
                    Caption = 'Purchase Return Orders';
                    RunObject = Page "Purchase Return Order List";
                    ToolTip = 'Create purchase return orders to mirror sales return documents that vendors send to you for incorrect or damaged items that you have paid for and then returned to the vendor. Purchase return orders enable you to ship back items from multiple purchase documents with one purchase return and support warehouse documents for the item handling. Purchase return orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature. Note: If you have not yet paid for an erroneous purchase, you can simply cancel the posted purchase invoice to automatically revert the financial transaction.';
                    //Visible = false;
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
            group("Repair Orders")
            {
                Caption = 'Repair Orders';
                action("Approved Repair Order List")
                {
                    ApplicationArea = Suite;
                    Caption = 'Approved Repair Order List';
                    Image = Document;
                    Promoted = false;
                    Enabled = true;
                    Visible = true;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Approved Repair Order List";
                    RunPageMode = Create;
                    ToolTip = 'Create a new Transfer Orders.';
                }
                action("Completed  Repair Order List")
                {
                    ApplicationArea = Suite;
                    Caption = 'Completed  Repair Order List';
                    Image = Document;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Completed  Repair Order List";
                    RunPageMode = Create;
                    ToolTip = 'Create a new Transfer Orders.';
                }
            }
            group(Inspection)
            {
                Caption = 'Inspection';
                action("Inspections List")

                {
                    ApplicationArea = Suite;
                    Caption = 'Inspections List';
                    Enabled = true;
                    Visible = true;
                    RunObject = Page "Inspections List";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
                action("Inspections Approved List")
                {
                    ApplicationArea = Suite;
                    Enabled = true;
                    Visible = true;
                    Caption = 'Inspections Approved List';
                    RunObject = Page "Inspections Approved List";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
                action("Inspections Rejected List")
                {
                    ApplicationArea = Suite;
                    Enabled = true;
                    Visible = true;
                    Caption = 'Inspections Rejected List';
                    RunObject = Page "Inspections Rejected List";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
            }
            group("Store Requisition")
            {
                Caption = 'Store Requisition';
                Image = FiledPosted;
                action("Store Requisitions List")
                {
                    Caption = 'Store Requisitions List';
                    Enabled = true;
                    Visible = true;
                    ApplicationArea = Suite;
                    RunObject = Page "Store Requisitions List";
                }
                action("Pending Store Requisitions")
                {
                    Caption = 'Pending Store Requisitions';
                    Enabled = true;
                    Visible = true;
                    ApplicationArea = Suite;
                    RunObject = Page "Pending Store Requisitions";
                }
                action("Approved Store Requisitions")
                {
                    Caption = 'Approved Store Requisitions';
                    Enabled = true;
                    Visible = true;
                    ApplicationArea = Suite;
                    RunObject = Page "Approved Store Requisitions";
                }
                action("Cancelled Store Requisitions List")
                {
                    Caption = 'Cancelled Store Requisitions List';
                    Enabled = true;
                    Visible = true;
                    ApplicationArea = Suite;
                    RunObject = Page "Cancel Store Requisitions List";
                }
                action("Posted Store Requisitions List")
                {
                    Caption = 'Posted Store Requisitions List';
                    Enabled = true;
                    Visible = true;
                    ApplicationArea = Suite;
                    RunObject = Page "Posted Store Requisitions List";
                }
                action("Return to Store List")
                {
                    ApplicationArea = Suite;
                    Enabled = true;
                    Visible = true;
                    Caption = 'Return to Store List';
                    RunObject = Page "Return to Store List";
                    ToolTip = 'Return to Store List';
                }
                action("Posted Return to Store")
                {
                    Caption = 'Posted Return to Store';
                    ApplicationArea = Suite;
                    Enabled = true;
                    Visible = true;
                    RunObject = Page "Posted Return to Store";
                }
                action("Converted Store Requisitions")
                {
                    Caption = 'Converted Store Requisitions';
                    RunObject = Page "Converted Store Requisitions";
                    Visible = false;
                }
            }
            group("Transfer Order")
            {
                Caption = 'Transfer Order';
                action(Action65)
                {
                    ApplicationArea = Suite;
                    Caption = 'Transfer Orders';
                    RunObject = Page "Transfer Orders";
                    ToolTip = 'Transfer Orders';
                }
                action("Pending Transfer Orders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Pending Transfer Orders';
                    RunObject = Page "Pending Transfer Orders";
                    ToolTip = 'Pending Transfer Orders';
                }
                action("Approved Transfer Orders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Approved Transfer Orders';
                    RunObject = Page "Approved Transfer Orders";
                    ToolTip = 'Approved Transfer Orders';
                }
            }
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                action("Posted Purchase Receipts (GRN)")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Receipts (GRN)';
                    RunObject = Page "Posted Purchase Receipts";
                    ToolTip = 'Open the list of posted purchase receipts.';
                }
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
            }
            group(InvetorySetup)
            {
                Caption = 'Inventory Setups';

                action("Inventory User Setup")
                {
                    RunObject = page "Inventory User Setup";
                    Caption = 'Inventory User Setup';
                    ApplicationArea = Suite;
                    ToolTip = 'Give permissions for posting of materials in the store';
                }
            }
            group(ImprestCode)
            {
                Caption = 'Funds Transaction Code';

                action("Funds Transaction Code")
                {
                    RunObject = page "Imprest Codes";
                    // Caption = 'Inventory User Setup';
                    ApplicationArea = Suite;
                    //ToolTip = 'Give permissions for posting of materials in the store';
                }
            }
            group(Tendering)
            {
                Caption = 'Tendering';
                Image = FiledPosted;
                action("Supplier Registrations")
                {
                    ApplicationArea = Suite;
                    Caption = 'Supplier Registrations';
                    RunObject = Page "Supplier Registrations";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
                action("Tender List")
                {
                    ApplicationArea = Suite;
                    Caption = 'Tender List';
                    RunObject = Page "Tender List";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
                action("Tender Applications.")
                {
                    ApplicationArea = Suite;
                    Caption = 'Tender Applications.';
                    RunObject = Page "Tender Applications.";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
                action("Tender Evaluation List")
                {
                    ApplicationArea = Suite;
                    Caption = 'Tender Evaluation List';
                    RunObject = Page "Tender Evaluation List";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
                action("Request for proposals")
                {
                    ApplicationArea = Suite;
                    Caption = 'Request for proposals';
                    RunObject = Page "Request for proposals";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
                action("Request for Quotation List")
                {
                    ApplicationArea = Suite;
                    Caption = 'Request for Quotation List';
                    RunObject = Page "Request for Quotation List";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
                action("Purchase Quotes")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchase Quotes';
                    RunObject = Page "Purchase Quotes";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
                action("Closed Req. for Quotation List")
                {
                    ApplicationArea = Suite;
                    Caption = 'Closed Req. for Quotation List';
                    RunObject = Page "Closed Req. for Quotation List";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
                action("Bid Analysis List")
                {
                    ApplicationArea = Suite;
                    Caption = 'Bid Analysis List';
                    RunObject = Page "Bid Analysis List";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
                action("Released Bid Analysis List")
                {
                    ApplicationArea = Suite;
                    Caption = 'Released Bid Analysis List';
                    RunObject = Page "Released Bid Analysis List";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
            }
            group("Loose Tool Management")
            {
                Caption = 'Loose Tool Management';
                Visible = false;
                action("Loose Tool List")
                {
                    Caption = 'Loose Tool List';
                    RunObject = Page "Loose Tool List";
                }
                action("Tools Category")
                {
                    Caption = 'Tools Category';
                    RunObject = Page "File Types";
                    Visible = false;
                }
                action("Tools List")
                {
                    Caption = 'Tools List';
                    RunObject = Page "File List";
                    Visible = false;
                }
                action("Tools Request List")
                {
                    Caption = 'Tools Request List';
                    RunObject = Page "File Requests list";
                    Visible = false;
                }
                action("Received Tools ")
                {
                    Caption = 'Received Tools ';
                    RunObject = Page "Received File Request List";
                    Visible = false;
                }
                action("Issued Tools")
                {
                    Caption = 'Issued Tools';
                    RunObject = Page "Issued File Request List";
                    Visible = false;
                }
            }
            group("Value Addition")
            {
                Caption = 'Value Addition';
                Visible = false;
                action("Value Addition List")
                {
                    ApplicationArea = Suite;
                    Caption = 'Value Addition List';
                    RunObject = Page "Bottled Water List";
                    ToolTip = ' Value Addition List';
                }
                action("Posted Value Addition List")
                {
                    ApplicationArea = Suite;
                    Caption = 'Posted Value Addition List';
                    RunObject = Page "Posted Bottled Water";
                    ToolTip = 'Posted Value Addition List';
                }
            }
        }
        area(processing)
        {
            separator(Tasks)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
            action("&Purchase Journal")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Purchase Journal';
                Image = Journals;
                RunObject = Page "Purchase Journal";
                ToolTip = 'Post purchase transactions directly to the general ledger. The purchase journal may already contain journal lines that are created as a result of related functions.';
            }
            action("Item &Journal")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item &Journal';
                Image = Journals;
                RunObject = Page "Item Journal";
                ToolTip = 'Adjust the physical quantity of items on inventory.';
            }
            action("Phys. Inventory Journal - Stock Take")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Phys. Inventory Journal - Stock Take';
                Image = Journals;
                RunObject = Page "Phys. Inventory Journal";
                ToolTip = 'Adjust the physical quantity of items on inventory.';
            }
            action("Order Plan&ning")
            {
                ApplicationArea = Planning;
                Caption = 'Order Plan&ning';
                Image = Planning;
                RunObject = Page "Order Planning";
                ToolTip = 'Plan supply orders order by order to fulfill new demand.';
            }
            separator(Separator38)
            {
            }
            action("Requisition &Worksheet")
            {
                ApplicationArea = Planning;
                Caption = 'Requisition &Worksheet';
                Image = Worksheet;
                RunObject = Page "Req. Wksh. Names";
                RunPageView = WHERE("Template Type" = CONST("Req."),
                                    Recurring = CONST(false));
                ToolTip = 'Calculate a supply plan to fulfill item demand with purchases or transfers.';
            }
            action("Pur&chase Prices")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Pur&chase Prices';
                Image = Price;
                RunObject = Page "Purchase Prices";
                ToolTip = 'View or set up different prices for items that you buy from the vendor. An item price is automatically granted on invoice lines when the specified criteria are met, such as vendor, quantity, or ending date.';
            }
            action("Purchase &Line Discounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase &Line Discounts';
                Image = LineDiscount;
                RunObject = Page "Purchase Line Discounts";
                ToolTip = 'View or set up different discounts for items that you buy from the vendor. An item discount is automatically granted on invoice lines when the specified criteria are met, such as vendor, quantity, or ending date.';
            }
            separator(History)
            {
                Caption = 'History';
                IsHeader = true;
            }
            action("Navi&gate")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Navi&gate';
                Image = Navigate;
                RunObject = Page Navigate;
                ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';
            }
            action(Action122)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Order Archives';
                Image = Archive;
                RunObject = Page "Purchase Order Archives";
                ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';
            }
        }
    }

    var
        Item: Record Item;
}

