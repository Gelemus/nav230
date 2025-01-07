page 50567 "HR Email Messages"
{
    PageType = List;
    SourceTable = "HR Email Messages";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sender Name"; Rec."Sender Name")
                {
                }
                field("Sender Address"; Rec."Sender Address")
                {
                }
                field(Subject; Rec.Subject)
                {
                }
                field(Recipients; Rec.Recipients)
                {
                }
                field("Recipients CC"; Rec."Recipients CC")
                {
                }
                field("Recipients BCC"; Rec."Recipients BCC")
                {
                }
                field(Body; Rec.Body)
                {
                }
                field(HtmlFormatted; Rec.HtmlFormatted)
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Date Created"; Rec."Date Created")
                {
                }
                field("Time Created"; Rec."Time Created")
                {
                }
                field("Email Sent"; Rec."Email Sent")
                {
                }
                field("Date Sent"; Rec."Date Sent")
                {
                }
                field("Time Sent"; Rec."Time Sent")
                {
                }
            }
        }
    }

    actions
    {
    }
}

