page 56200 "Customer Feedback List"
{
    CardPageID = "Customer Feedback Card";
    Editable = false;
    PageType = List;
    SourceTable = "Customer FeedbackS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("Customer Name"; Rec."Customer Name")
                {
                }
                field("Feedback Date"; Rec."Feedback Date")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Action"; Rec.Action)
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Date created"; Rec."Date created")
                {
                }
                field("Time created"; Rec."Time created")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control12; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

