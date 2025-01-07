page 50780 "Agenda Vote Item"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Agenda vote items";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No"; Rec."Item No")
                {
                }
                field("Meeting No"; Rec."Meeting No")
                {
                }
                field("Agenda No"; Rec."Agenda No")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Yes Count"; Rec."Yes Count")
                {
                }
                field("No Count"; Rec."No Count")
                {
                }
                field("Abstain Count"; Rec."Abstain Count")
                {
                }
                field("Total Votes"; Rec."Total Votes")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Vote start Date"; Rec."Vote start Date")
                {
                }
                field("Vote start Time"; Rec."Vote start Time")
                {
                }
                field("Vote Enda date"; Rec."Vote Enda date")
                {
                }
                field("Vote Enda Time"; Rec."Vote Enda Time")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Agenda vote Item Entries")
            {
                ApplicationArea = Comments;
                Caption = 'Agenda vote Item Entries';
                Image = ViewComments;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Agenda vote Item Entries";
                RunPageLink = "Agenda Vote Item code" = FIELD("Item No"),
                              "Agenda No" = FIELD("Agenda No"),
                              "Meeting No" = FIELD("Meeting No");
                ToolTip = 'View or add Agenda vote Item Entries for the record.';
            }
        }
    }
}

