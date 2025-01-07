pageextension 60653 pageextension60653 extends "Acc. Payables Coordinator RC" 
{
    actions
    {
        addafter("Purchase Orders")
        {
            action(PurchaseOrdersPartDeliv)
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Partially Delivered';
                RunObject = Page "Purchase Order List";
                RunPageView = WHERE(Status=FILTER(Released),
                                    Receive=FILTER(true),
                                    "Completely Received"=FILTER(false));
                ToolTip = 'View the list of purchases that are partially received.';
            }
            action(PurchaseOrdersDelivered)
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Received Not Invoiced';
                RunObject = Page "Purchase Order List";
                RunPageView = WHERE(Status=FILTER(Released),
                                    Receive=FILTER(true),
                                    Invoice=FILTER(false));
                ToolTip = 'View the list of purchases that are partially received.';
            }
            action(PurchaseOrdersPendConf)
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Open';
                RunObject = Page "Purchase Order List";
                RunPageView = WHERE(Status=FILTER(Open));
                ToolTip = 'View the list of purchase orders that await the vendor''s confirmation. ';
            }
            action("Purchase Quotes")
            {
                ApplicationArea = Suite;
                Caption = 'Purchase Quotes';
                RunObject = Page "Purchase Quotes";
                ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
            }
        }
        addafter(Items)
        {
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
            action("Approve Purch Requisitions")
            {
                ApplicationArea = Suite;
                Caption = 'Approve Purch Requisitions';
                RunObject = Page "Approve  Requisitions";
                ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
            }
            action("Pending Purch Requisition List")
            {
                Caption = 'Pending Purch Requisition List';
                RunObject = Page "Pending Requisition List";
            }
            action("Closed Purchase Req. List")
            {
                ApplicationArea = Suite;
                Caption = 'Closed Purchase Req. List';
                RunObject = Page "Closed  Requisition List";
                ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
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
    }
}

