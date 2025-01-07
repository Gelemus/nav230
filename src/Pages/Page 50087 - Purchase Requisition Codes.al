page 50087 "Purchase Requisition Codes"
{
    PageType = List;
    SourceTable = "Purchase Requisition Codes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Requisition Type"; Rec."Requisition Type")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Requisition Code"; Rec."Requisition Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the field name';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the field name';
                }
                field(Description; Rec.Description)
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

