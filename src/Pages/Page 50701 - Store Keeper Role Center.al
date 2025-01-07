page 50701 "Store Keeper Role Center"
{
    Caption = 'Purchasing Agent', Comment='{Dependency=Match,"ProfileDescription_PURCHASINGAGENT"}';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                ShowCaption = false;
                part(Control1907662708;"Purchase Agent Activities")
                {
                    ApplicationArea = Basic,Suite;
                }
                part(Control1902476008;"My Vendors")
                {
                    ApplicationArea = Basic,Suite;
                }
            }
            group(Control1900724708)
            {
                ShowCaption = false;
                part(Control25;"Purchase Performance")
                {
                    ApplicationArea = Basic,Suite;
                }
                part(Control37;"Purchase Performance")
                {
                    ApplicationArea = Basic,Suite;
                    Visible = false;
                }
                part(Control21;"Inventory Performance")
                {
                    ApplicationArea = Basic,Suite;
                }
                part(Control44;"Inventory Performance")
                {
                    ApplicationArea = Basic,Suite;
                    Visible = false;
                }
                part(Control45;"Report Inbox Part")
                {
                    ApplicationArea = Basic,Suite;
                }
                part(Control35;"My Job Queue")
                {
                    ApplicationArea = Basic,Suite;
                    Visible = false;
                }
                part(Control1905989608;"My Items")
                {
                    ApplicationArea = Basic,Suite;
                }
                systempart(Control43;MyNotes)
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
            action("Inventory - &Availability Plan")
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Inventory - &Availability Plan';
                Image = ItemAvailability;
                RunObject = Report "Inventory - Availability Plan";
                ToolTip = 'View a list of the quantity of each item in customer, purchase, and transfer orders and the quantity available in inventory. The list is divided into columns that cover six periods with starting and ending dates as well as the periods before and after those periods. The list is useful when you are planning your inventory purchases.';
            }
            action("Inventory Valuation")
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Inventory Valuation';
                Image = ItemAvailability;
                RunObject = Report "Inventory Valuation";
                ToolTip = 'View a list of the quantity of each item in customer, purchase, and transfer orders and the quantity available in inventory. The list is divided into columns that cover six periods with starting and ending dates as well as the periods before and after those periods. The list is useful when you are planning your inventory purchases.';
            }
            action("Inventory - Transaction Detail")
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Inventory - Transaction Detail';
                Image = ItemAvailability;
                RunObject = Report "Inventory - Transaction Detail";
                ToolTip = 'View a list of the quantity of each item in customer, purchase, and transfer orders and the quantity available in inventory. The list is divided into columns that cover six periods with starting and ending dates as well as the periods before and after those periods. The list is useful when you are planning your inventory purchases.';
            }
            action("Item Consumption")
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Item Consumption';
                Image = "report";
                RunObject = Report "Item Consumption";
                ToolTip = 'Item Consumption';
            }
        }
        area(embedding)
        {
            action(Items)
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
                ToolTip = 'View or edit detailed information for the products that you trade in. The item card can be of type Inventory or Service to specify if the item is a physical unit or a labor time unit. Here you also define if items in inventory or on incoming orders are automatically reserved for outbound documents and whether order tracking links are created between demand and supply to reflect planning actions.';
            }
            action("Transfer Orders List")
            {
                ApplicationArea = Suite;
                Caption = 'Transfer Orders List';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Transfer Orders List";
                RunPageMode = Create;
                ToolTip = 'Create a new Transfer Orders.';
            }
            action("Pending Transfer Order")
            {
                Caption = 'Pending Transfer Order';
                RunObject = Page "Pending Transfer Order";
            }
            action("Approved Transfer Order")
            {
                ApplicationArea = Suite;
                Caption = 'Approved Transfer Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Approved Transfer Order";
                RunPageMode = Create;
                ToolTip = 'Posted Transfer Receipts';
            }
            action("Posted Transfer Shipments")
            {
                Caption = 'Posted Transfer Shipments';
                RunObject = Page "Posted Transfer Shipments";
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
            action("Store Requisitions List")
            {
                Caption = 'Store Requisitions List';
                RunObject = Page "Store Requisitions List";
            }
            action("Pending Store Requisitions")
            {
                Caption = 'Pending Store Requisitions';
                RunObject = Page "Pending Store Requisitions";
            }
            action("Approved Store Requisitions")
            {
                Caption = 'Approved Store Requisitions';
                RunObject = Page "Approved Store Requisitions";
            }
            action("Issued Store Requisitions List")
            {
                Caption = 'Issued Store Requisitions List';
                RunObject = Page "Posted Store Requisitions List";
            }
            action(PurchaseOrders)
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Purchase Orders';
                RunObject = Page "Purchase Order List";
                ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
            }
            action("Inspections List")
            {
                ApplicationArea = Suite;
                Caption = 'Inspections List';
                RunObject = Page "Inspections List";
                ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
            }
            action("Inspections Approved List")
            {
                ApplicationArea = Suite;
                Caption = 'Inspections Approved List';
                RunObject = Page "Inspections Approved List";
                ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
            }
            action("Inspections Rejected List")
            {
                ApplicationArea = Suite;
                Caption = 'Inspections Rejected List';
                RunObject = Page "Inspections Rejected List";
                ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
            }
            action("Posted Purchase Receipts (GRN)")
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Posted Purchase Receipts (GRN)';
                RunObject = Page "Posted Purchase Receipts";
                ToolTip = 'Open the list of posted purchase receipts.';
            }
            action("Return to Store List")
            {
                ApplicationArea = Suite;
                Caption = 'Return to Store List';
                RunObject = Page "Return to Store List";
                ToolTip = 'Return to Store List';
            }
            action("Posted Return to Store")
            {
                Caption = 'Posted Return to Store';
                RunObject = Page "Posted Return to Store";
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
            action("Casual Requisitions")
            {
                Caption = 'Casual Requisitions';
                RunObject = Page "Casual Requisitions";
            }
            action(" Imprest List")
            {
                Caption = ' Imprest List';
                RunObject = Page "Imprest List";
            }
            action("Imprest Surrender List")
            {
                Caption = 'Imprest Surrender List';
                RunObject = Page "Imprest Surrender List";
                Visible = false;
            }
        }
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
                action("Casual Requisitions Pending")
                {
                    Caption = 'Casual Requisitions Pending';
                    RunObject = Page "Casual Requisitions Pending";
                }
                action("Casuals Payment List")
                {
                    Caption = 'Casuals Payment List';
                    RunObject = Page "Casuals Payment List";
                }
                action("Imprest List Status")
                {
                    Caption = 'Imprest List Status';
                    RunObject = Page "Imprest List Status";
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
                action(Action85)
                {
                    Caption = 'Imprest Surrender List';
                    RunObject = Page "Imprest Surrender List";
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
                action("Store Requisitions List Status")
                {
                    Caption = 'Store Requisitions List Status';
                    RunObject = Page "Store Requisitions List Status";
                }
                action(" Purchase Requisition List")
                {
                    Caption = ' Purchase Requisition List';
                    RunObject = Page "Purchase Requisition List";
                }
                action("Status Purchase Requisition Status")
                {
                    Caption = 'Status Purchase Requisition Status';
                    RunObject = Page "Purchase Requisition List S";
                }
                action("Salary Advance Applications")
                {
                    Caption = 'Salary Advance Applications';
                    RunObject = Page "Salary Advance Applications";
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
            }
        }
    }

    var
        Item: Record Item;
}

