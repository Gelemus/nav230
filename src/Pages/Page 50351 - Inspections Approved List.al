page 50351 "Inspections Approved List"
{
    CardPageID = "Inspection Header Approved Car";
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Inspection Header";
    SourceTableView = WHERE(Status = CONST(Released),
                            "Approval Status" = FILTER(<> Rejected));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Inspection No"; Rec."Inspection No")
                {
                }
                field("Order No"; Rec."Order No")
                {
                }
                field("Commitee Appointment No"; Rec."Commitee Appointment No")
                {
                }
                field("Inspection Date"; Rec."Inspection Date")
                {
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
    }

    actions
    {
    }
}

