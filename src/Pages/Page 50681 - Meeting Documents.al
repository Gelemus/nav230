page 50681 "Meeting Documents"
{
    PageType = List;
    SourceTable = "Meeting Attachment";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Doc No"; Rec."Doc No")
                {
                }
                field("Document Description"; Rec."Document Description")
                {
                }
                field("Meeting No"; Rec."Meeting No")
                {
                }
                field(Attachment; Rec.Attachment)
                {
                }
                field("Attachment No"; Rec."Attachment No")
                {
                }
                field("Document Link"; Rec."Document Link")
                {
                }
            }
        }
    }

    actions
    {
    }
}

