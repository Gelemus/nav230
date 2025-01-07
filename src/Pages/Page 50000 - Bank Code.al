page 50000 "Bank Code"
{
    PageType = List;
    SourceTable = "Bank Code";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bank Code"; Rec."Bank Code")
                {
                    ToolTip = 'Specifies the Bank Unique Code';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ToolTip = 'Specifies the name of the bank';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Bank Branches")
            {
                Image = BankAccountRec;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Bank Branch";
                RunPageLink = "Bank Code" = FIELD("Bank Code");
                ToolTip = 'List of All Bank Branches';
            }
        }
    }
}

