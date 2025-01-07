pageextension 60656 pageextension60656 extends "Purchasing Agent Role Center"
{
    layout
    {
        modify(Control1900724708)
        {
            Visible = false;
        }
        modify(Control37)
        {
            Visible = false;
        }
        modify(Control21)
        {
            Visible = false;
        }
        addfirst(Control1900724808)
        {
            part(Control131; "Headline RC Team Member")
            {
                ApplicationArea = Basic, Suite;
            }
        }
        moveafter(Control1902476008; Control1905989608)
        moveafter(Control44; Control35)
    }
    actions
    {
        // modify(Separator28)
        // {

        //     //Unsupported feature: Property Modification (Name) on "Separator28(Action 28)".

        //     Caption = 'Inventories';
        // }
        modify("Inventory &Purchase Orders")
        {
            Visible = false;
        }
        modify("Inventory - &Vendor Purchases")
        {
            Visible = false;
        }
        modify("Inventory &Cost and Price List")
        {
            Visible = false;
        }
        modify("Assembly Orders")
        {

            //Unsupported feature: Property Modification (Level) on ""Assembly Orders"(Action 26)".


            //Unsupported feature: Property Modification (Name) on ""Assembly Orders"(Action 26)".

            Caption = 'Approve Requisitions';
            ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
            ApplicationArea = Suite;

            //Unsupported feature: Property Modification (RunObject) on ""Assembly Orders"(Action 26)".

        }
        modify("Sales Orders")
        {

            //Unsupported feature: Property Modification (Name) on ""Sales Orders"(Action 32)".

            Caption = 'Pending Purch Requisition List';
            ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
            ApplicationArea = Suite;

            //Unsupported feature: Property Modification (RunObject) on ""Sales Orders"(Action 32)".

        }
        modify(Vendors)
        {

            //Unsupported feature: Property Modification (Level) on "Vendors(Action 85)".


            //Unsupported feature: Property Modification (Name) on "Vendors(Action 85)".

            Caption = 'Casuals Payment List';

            //Unsupported feature: Property Modification (RunObject) on "Vendors(Action 85)".

        }
        modify(Items)
        {

            //Unsupported feature: Property Modification (Name) on "Items(Action 88)".

            Caption = 'Phys. Inventory Journal - Stock Take';
            ToolTip = 'Adjust the physical quantity of items on inventory.';

            //Unsupported feature: Property Modification (RunObject) on "Items(Action 88)".


            //Unsupported feature: Property Modification (Image) on "Items(Action 88)".

        }
        modify("Catalog Items")
        {

            //Unsupported feature: Property Modification (Level) on ""Catalog Items"(Action 91)".


            //Unsupported feature: Property Modification (Name) on ""Catalog Items"(Action 91)".

            Caption = 'Pending Approv Petty Cash List';

            //Unsupported feature: Property Modification (RunObject) on ""Catalog Items"(Action 91)".

        }
        modify("Stockkeeping Units")
        {

            //Unsupported feature: Property Modification (Level) on ""Stockkeeping Units"(Action 94)".


            //Unsupported feature: Property Modification (Name) on ""Stockkeeping Units"(Action 94)".

            Caption = 'Petty Cash list';

            //Unsupported feature: Property Modification (RunObject) on ""Stockkeeping Units"(Action 94)".

        }
        modify(RequisitionWorksheets)
        {

            //Unsupported feature: Property Modification (Name) on "RequisitionWorksheets(Action 19)".

            Caption = 'Items';
            ToolTip = 'View or edit detailed information for the products that you trade in. The item card can be of type Inventory or Service to specify if the item is a physical unit or a labor time unit. Here you also define if items in inventory or on incoming orders are automatically reserved for outbound documents and whether order tracking links are created between demand and supply to reflect planning actions.';
            ApplicationArea = Basic, Suite;

            //Unsupported feature: Property Modification (RunObject) on "RequisitionWorksheets(Action 19)".


            //Unsupported feature: Property Insertion (Image) on "RequisitionWorksheets(Action 19)".

        }
        modify(SubcontractingWorksheets)
        {

            //Unsupported feature: Property Modification (Name) on "SubcontractingWorksheets(Action 20)".

            Caption = 'Vendors';
            ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
            ApplicationArea = Basic, Suite;

            //Unsupported feature: Property Modification (RunObject) on "SubcontractingWorksheets(Action 20)".


            //Unsupported feature: Property Insertion (Image) on "SubcontractingWorksheets(Action 20)".

        }

        //Unsupported feature: Property Modification (ActionType) on ""Standard Cost Worksheets"(Action 22)".


        //Unsupported feature: Property Modification (Name) on ""Standard Cost Worksheets"(Action 22)".

        modify("Posted Purchase Receipts")
        {

            //Unsupported feature: Property Modification (Name) on ""Posted Purchase Receipts"(Action 40)".

            Caption = 'Posted Purchase Receipts (GRN)';
        }
        modify("Posted Assembly Orders")
        {

            //Unsupported feature: Property Modification (Level) on ""Posted Assembly Orders"(Action 27)".


            //Unsupported feature: Property Modification (Name) on ""Posted Assembly Orders"(Action 27)".

            Caption = 'Purchase Requisition List';
            ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
            ApplicationArea = Suite;

            //Unsupported feature: Property Modification (RunObject) on ""Posted Assembly Orders"(Action 27)".

        }

        //Unsupported feature: Property Deletion (Image) on ""Sales Orders"(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Vendors(Action 85)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Vendors(Action 85)".


        //Unsupported feature: Property Deletion (Image) on "Vendors(Action 85)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Catalog Items"(Action 91)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Catalog Items"(Action 91)".


        //Unsupported feature: Property Deletion (Image) on ""Catalog Items"(Action 91)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Stockkeeping Units"(Action 94)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Stockkeeping Units"(Action 94)".


        //Unsupported feature: Property Deletion (Image) on ""Stockkeeping Units"(Action 94)".


        //Unsupported feature: Property Deletion (RunPageView) on "RequisitionWorksheets(Action 19)".


        //Unsupported feature: Property Deletion (RunPageView) on "SubcontractingWorksheets(Action 20)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Standard Cost Worksheets"(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Standard Cost Worksheets"(Action 22)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Standard Cost Worksheets"(Action 22)".


        //Unsupported feature: Property Deletion (RunObject) on ""Standard Cost Worksheets"(Action 22)".

        addafter("Inventory - &Availability Plan")
        {
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
        }
        addfirst(Embedding)
        {
            action("Leave Balances List")
            {
                Caption = 'Leave Balances List';
                RunObject = Page "Leave Balances List";
            }
        }
        addafter(RequisitionWorksheets)
        {
            action("Fixed Assets")
            {
                ApplicationArea = FixedAssets;
                Caption = 'Fixed Assets';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Fixed Asset List";
                ToolTip = 'Manage periodic depreciation of your machinery or machines, keep track of your maintenance costs, manage insurance policies related to fixed assets, and monitor fixed asset statistics.';
            }
        }
        addafter(PurchaseOrders)
        {
            action("Cancelled Purchase Order List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancelled Purchase Order List';
                RunObject = Page "Cancelled Purchase Order List";
                ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
            }
        }
        addafter(PurchaseOrdersPartDeliv)
        {
            action("Approved Repair Order List")
            {
                ApplicationArea = Suite;
                Caption = 'Approved Repair Order List';
                Image = Document;
                Promoted = false;
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
            action("Pending Transfer Orders")
            {
                ApplicationArea = Suite;
                Caption = 'Pending Transfer Orders';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Pending Transfer Orders";
                RunPageMode = Create;
                ToolTip = 'Create a new Transfer Orders.';
            }
            action("Approved Transfer Orders")
            {
                ApplicationArea = Suite;
                Caption = 'Approved Transfer Orders';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Approved Transfer Orders";
                RunPageMode = Create;
                ToolTip = 'Create a new Transfer Orders.';
            }
            action("Asset Transfer List")
            {
                ApplicationArea = Suite;
                Caption = 'Asset Transfer List';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "HR Asset Transfer List";
                RunPageMode = Create;
                ToolTip = 'Create a new Transfer Orders.';
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
            action("Professional Opinion List")
            {
                ApplicationArea = Suite;
                Caption = 'Professional Opinion List';
                RunObject = Page "Professiona Opinion List";
                ToolTip = 'Professional Opinion List';
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
        addafter("Purchase Quotes")
        {
            action("Pending Requisition List")
            {
                Caption = 'Pending Requisition List';
                RunObject = Page "Pending Requisition List";
            }
            action("Approved Requisitions")
            {
                ApplicationArea = Suite;
                Caption = 'Approved Requisitions';
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
        addafter("Sales Orders")
        {
            action("Approve Purch Requisitions")
            {
                ApplicationArea = Suite;
                Caption = 'Approve Purch Requisitions';
                RunObject = Page "Approve Purch Requisitions";
                ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
            }
            action("Closed Purchase Req. List")
            {
                ApplicationArea = Suite;
                Caption = 'Closed Purchase Req. List';
                RunObject = Page "Closed Purchase Req. List";
                ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
            }
            separator(Separator74)
            {
            }
            action("Supplimentary Purchase Req. List")
            {
                ApplicationArea = Suite;
                Caption = 'Supplimentary Purchase Req. List';
                RunObject = Page "Supplimentary Purchase Req. Li";
                ToolTip = 'Supplimentary Purchase Req. List';
            }
            action("Request for Quotation List")
            {
                ApplicationArea = Suite;
                Caption = 'Request for Quotation List';
                RunObject = Page "Request for Quotation List";
                ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
            }
            action("Closed Req. for Quotation List")
            {
                ApplicationArea = Suite;
                Caption = 'Closed Req. for Quotation List';
                RunObject = Page "Closed Req. for Quotation List";
                ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
            }
            action("Procurement Planning List")
            {
                ApplicationArea = Suite;
                Caption = 'Procurement Planning List';
                RunObject = Page "Procurement Planning List";
                ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
            }
            action("Tender List")
            {
                ApplicationArea = Suite;
                Caption = 'Tender List';
                RunObject = Page "Tender List";
                ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
            }
            action("Tender Evaluation List")
            {
                ApplicationArea = Suite;
                Caption = 'Tender Evaluation List';
                RunObject = Page "Tender Evaluation List";
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
            action("Approved Store Requisitions")
            {
                ApplicationArea = Suite;
                Caption = 'Approved Store Requisitions';
                RunObject = Page "Approved Store Requisitions";
                ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
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
            }
        }
        // addfirst("Catalog Items")
        // {
        //     action(" Approved Petty Cash List")
        //     {
        //         Caption = ' Approved Petty Cash List';
        //         RunObject = Page "Approved Petty Cash List";
        //     }
        //     action("Sales Quotes")
        //     {
        //         Caption = 'Sales Quotes';
        //         RunObject = Page "Sales Quotes";
        //     }
        //     action("Submitted Sales Quotes")
        //     {
        //         Caption = 'Submitted Sales Quotes';
        //         RunObject = Page "Submitted Sales Quotes";
        //     }
        //     action("Imprest List Status")
        //     {
        //         Caption = 'Imprest List Status';
        //         RunObject = Page "Imprest List Status";
        //     }
        //     action("Imprest Surrender List")
        //     {
        //         Caption = 'Imprest Surrender List';
        //         RunObject = Page "Imprest Surrender List";
        //     }
        //     action("Casual Requisitions")
        //     {
        //         Caption = 'Casual Requisitions';
        //         RunObject = Page "Casual Requisitions";
        //     }
        //     action("<Casual Requisitions Approved>")
        //     {
        //         Caption = 'Casual Requisitions Approved';
        //         RunObject = Page "Casual Requisitions Approved";
        //     }
        // }
        // addfirst(Vendors)
        // {
        //     action("Pending Approval Casual Payment List")
        //     {
        //         Caption = 'Pending Approval Casual Payment List';
        //         RunObject = Page "Pending Ap Casual Payment List";
        //     }
        //     action("Approved Casual Payment List")
        //     {
        //         Caption = 'Approved Casual Payment List';
        //         RunObject = Page "Approved Casual Payment List";
        //     }
        //     action("Salary Advance Applications")
        //     {
        //         Caption = 'Salary Advance Applications';
        //         RunObject = Page "Salary Advance Applications";
        //     }
        //     action(" Salary Advance Pending Approval")
        //     {
        //         Caption = ' Salary Advance Pending Approval';
        //         RunObject = Page "Salary Advance Pending Approvl";
        //     }
        //     action("Salary Advance Approved ")
        //     {
        //         Caption = 'Salary Advance Approved ';
        //         RunObject = Page "Salary Advance Approved";
        //     }
        //     action("Salary Advance posted")
        //     {
        //         Caption = 'Salary Advance posted';
        //         RunObject = Page "Salary Advance posted";
        //     }
        //     action("Leave Application")
        //     {
        //         Caption = 'Leave Application';
        //         RunObject = Page "Leave Applications";
        //     }
        //     action(" Leave Applications Status")
        //     {
        //         Caption = ' Leave Applications Status';
        //         RunObject = Page "Leave Applications Status";
        //     }
        // }
        // addfirst("Assembly Orders")
        // {
        //     action("Transport Request List")
        //     {
        //         Caption = 'Transport Request List';
        //         RunObject = Page "Transport Request List";
        //     }
        //     action("Store Requisitions List")
        //     {
        //         Caption = 'Store Requisitions List';
        //         RunObject = Page "Store Requisitions List";
        //     }
        //     action("Pending Store Requisitions")
        //     {
        //         Caption = 'Pending Store Requisitions';
        //         RunObject = Page "Pending Store Requisitions";
        //     }
        //     action(Action70)
        //     {
        //         Caption = 'Approved Store Requisitions';
        //         RunObject = Page "Approved Store Requisitions";
        //     }
        //     action("Converted Store Requisitions")
        //     {
        //         Caption = 'Converted Store Requisitions';
        //         RunObject = Page "Converted Store Requisitions";
        //     }
        //     action("Posted Store Requisitions List")
        //     {
        //         Caption = 'Posted Store Requisitions List';
        //         RunObject = Page "Posted Store Requisitions List";
        //     }
        //     action("Cancelled Store Requisitions List")
        //     {
        //         Caption = 'Cancelled Store Requisitions List';
        //         RunObject = Page "Cancel Store Requisitions List";
        //     }
        //     action("Requisition List")
        //     {
        //         Caption = 'Requisition List';
        //         RunObject = Page "Requisition List";
        //     }
        //     action(Action52)
        //     {
        //         Caption = 'Pending Requisition List';
        //         RunObject = Page "Pending Requisition List";
        //     }
        //     action("Status Requisition List")
        //     {
        //         Caption = 'Status Requisition List';
        //         RunObject = Page "Purchase Requisition List S";
        //     }
        //     action("Safari Notice List")
        //     {
        //         Caption = 'Safari Notice List';
        //         RunObject = Page "Safari Notice List";
        //     }
        //     action("Safari Notice List - Status")
        //     {
        //         Caption = 'Safari Notice List - Status';
        //         RunObject = Page "Safari Notice List - Status";
        //     }
        // }
        addafter("Posted Documents")
        {
            group("Loose Tool Management")
            {
                Caption = 'Loose Tool Management';
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
                action(Action121)
                {
                    ApplicationArea = Suite;
                    Caption = 'Value Addition List';
                    RunObject = Page "Bottled Water List";
                    ToolTip = ' Value Addition List';
                }
                action(Action120)
                {
                    ApplicationArea = Suite;
                    Caption = 'Posted Value Addition List';
                    RunObject = Page "Posted Bottled Water";
                    ToolTip = 'Posted Value Addition List';
                }
            }
        }
        addafter("Navi&gate")
        {
            action("Purchase Order Archives")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Order Archives';
                Image = Archive;
                RunObject = Page "Purchase Order Archives";
                ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';
            }
        }
        // moveafter(ActionContainer1900000011; SubcontractingWorksheets)
        // moveafter(Vendors; RequisitionWorksheets)
        // moveafter("Purchase Quotes"; "Standard Cost Worksheets")
        // moveafter(Separator22; "Posted Assembly Orders")
        // moveafter("Purchase Requisition List"; "Sales Orders")
        // moveafter("Purchase Credit Memos"; "Purchase Analysis Reports")
        // moveafter("Purchase Journals"; ActionContainer1900000012)
        // moveafter(ActionContainer1900000012; "Stockkeeping Units")
        // moveafter("Petty Cash list"; "Catalog Items")
        // moveafter("Pending Approv Petty Cash List"; Vendors)
        // moveafter("Approve Requisitions"; "Posted Documents")
        // moveafter("Posted Purchase Credit Memos"; ActionContainer1)
    }

    var
        Item: Record Item;
}

