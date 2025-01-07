page 56201 "Customer Feedback Card"
{
    Caption = 'Customer Feedback';
    PageType = Card;
    SourceTable = "Customer FeedbackS";

    layout
    {
        area(content)
        {
            group(General)
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

