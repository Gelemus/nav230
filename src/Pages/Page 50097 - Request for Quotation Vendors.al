page 50097 "Request for Quotation Vendors"
{
    PageType = List;
    SourceTable = "Request for Quotation Vendors";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                }
                field("Not listed Vendor"; Rec."Not listed Vendor")
                {
                }
                field("Vendor Email Address"; Rec."Vendor Email Address")
                {
                }
                field(Address; Rec.Address)
                {
                }
                field("Telephone No"; Rec."Telephone No")
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        Mail: Record "Request for Quotation Vendors";
}

