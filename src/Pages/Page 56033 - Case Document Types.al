page 56033 "Case Document Types"
{
    PageType = List;
    SourceTable = "Case Document Types";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Require Court Date?"; Rec."Require Court Date?")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control6; Notes)
            {
            }
            systempart(Control7; Outlook)
            {
            }
            systempart(Control8; Links)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Case Document Sub Types")
            {
                Caption = 'Case Document Sub Types';
                Image = process;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Case Document Sub Types";
                RunPageLink = "Case Document Type" = FIELD(Code);
            }
        }
    }
}

