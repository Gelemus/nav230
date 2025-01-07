page 50675 "Board Meeting List"
{
    CardPageID = "Board Meeting Card";
    DeleteAllowed = false;
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Board Meeting";
    SourceTableView = WHERE(Published = FILTER(false),
                            Status = FILTER(Pending));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field(Title; Rec.Title)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Meeting Group"; Rec."Meeting Group")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control11; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

