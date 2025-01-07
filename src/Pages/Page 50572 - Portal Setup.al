page 50572 "Portal Setup"
{
    PageType = Card;
    SourceTable = "Portal Setup";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Server File Path"; Rec."Server File Path")
                {
                    Editable = true;
                }
                field("Local File Path"; Rec."Local File Path")
                {
                    Editable = true;
                }

            }
        }
    }

    actions
    {
    }
}

