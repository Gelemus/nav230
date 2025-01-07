page 50664 "Work Ticket List-Approved"
{
    CardPageID = "Work Ticket Card -Approved";
    Editable = false;
    PageType = List;
    SourceTable = "Work Ticket";
    SourceTableView = WHERE(Status = CONST(Approved));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Ticket No"; Rec."Ticket No")
                {
                }
                field("Vehicle No"; Rec."Vehicle No")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Oil Drawn (Litres)"; Rec."Oil Drawn (Litres)")
                {
                }
                field("Fuel Drawn (Litres)"; Rec."Fuel Drawn (Litres)")
                {
                }
                field("Start Speedometer Reading"; Rec."Start Speedometer Reading")
                {
                }
                field("Kms Covered"; Rec."Kms Covered")
                {
                }
                field("Driver No"; Rec."Driver No")
                {
                }
                field("Driver Name"; Rec."Driver Name")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Registration No"; Rec."Registration No")
                {
                }
                field("Last Mileage Reading"; Rec."Last Mileage Reading")
                {
                }
                field("Journey Details"; Rec."Journey Details")
                {
                }
                field("Start Time"; Rec."Start Time")
                {
                }
                field("Return TIme"; Rec."Return TIme")
                {
                }
            }
        }
    }

    actions
    {
    }
}

