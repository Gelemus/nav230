page 50345 "Inspections List"
{
    CardPageID = "Inspection Card";
    DeleteAllowed = false;
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Inspection Header";
    SourceTableView = WHERE(Status = FILTER("Pending Approval" | Open),
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
                field("Prepared by"; Rec."Prepared by")
                {
                }
            }
        }
    }

    actions
    {
    }
}

