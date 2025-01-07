page 51202 "Mode of Payment"
{
    PageType = List;
    SourceTable = "Mode of Payment";

    layout
    {
        area(content)
        {
            repeater(Control1102754000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Net Pay Account Type"; Rec."Net Pay Account Type")
                {
                }
                field("Net Pay Account No"; Rec."Net Pay Account No")
                {
                }
            }
        }
    }

    actions
    {
    }
}

