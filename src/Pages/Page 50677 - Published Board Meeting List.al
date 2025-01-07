page 50677 "Published Board Meeting List"
{
    CardPageID = "Board Meeting Card";
    PageType = List;
    SourceTable = "Board Meeting";
    SourceTableView = WHERE(Published = FILTER(true));

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
        area(creation)
        {
            action("Send Notification")
            {

                trigger OnAction()
                begin
                    Message('Sent Seccessfully');
                end;
            }
        }
    }
}

