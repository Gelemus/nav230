xmlport 50103 BoardMeetingAttachmentExport
{
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(BoardMeetingAttachmentRoot)
        {
            tableelement("Board Meeting Attachments";"Board Meeting Attachments")
            {
                XmlName = 'BoardMeetingAttachment';
                fieldelement(EntryNo;"Board Meeting Attachments"."Entry No")
                {
                }
                fieldelement(MeetingNo;"Board Meeting Attachments"."Meeting No")
                {
                }
                fieldelement(Description;"Board Meeting Attachments".Description)
                {
                }
                fieldelement(FileName;"Board Meeting Attachments".FileName)
                {
                }
                fieldelement(Comments;"Board Meeting Attachments".Comments)
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

