page 50001 "Bank Branch"
{
    PageType = List;
    SourceTable = "Bank Branch";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bank Code"; Rec."Bank Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Bank Branch Code"; Rec."Bank Branch Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Bank Branch Name"; Rec."Bank Branch Name")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Branch Physical Location"; Rec."Branch Physical Location")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Branch Postal Code"; Rec."Branch Postal Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Branch Address"; Rec."Branch Address")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Branch Phone No."; Rec."Branch Phone No.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Branch Mobile No."; Rec."Branch Mobile No.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Branch Email Address"; Rec."Branch Email Address")
                {
                    ToolTip = 'Specifies the field name';
                }
            }
        }
    }

    actions
    {
    }
}

