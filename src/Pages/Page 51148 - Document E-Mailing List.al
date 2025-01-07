page 51148 "Document E-Mailing List"
{
    //CardPageID = 51146;
    Editable = false;
    PageType = Card;
    SourceTable = "Document E-Mailing Setup";

    layout
    {
        area(content)
        {
            repeater(Control1102754000)
            {
                ShowCaption = false;
                field("Document Type"; Rec."Document Type")
                {
                }
                field("Email Subject"; Rec."Email Subject")
                {
                }
                field("Email Body"; Rec."Email Body")
                {
                }
                field("Sender Name"; Rec."Sender Name")
                {
                }
                field("Sender Email"; Rec."Sender Email")
                {
                }
            }
        }
    }

    actions
    {
    }
}

