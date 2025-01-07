xmlport 50090 BoardMeetingCommentsExport
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(MeetingCommentsRoot)
        {
            tableelement("Meeting Comments";"Meeting Comments")
            {
                XmlName = 'MeetingComments';
                fieldelement(MeetingNo;"Meeting Comments"."Meeting No")
                {
                }
                fieldelement(Comment;"Meeting Comments".Comment)
                {
                }
                fieldelement(DateCreated;"Meeting Comments"."Date Created")
                {
                }
                fieldelement(MemberNo;"Meeting Comments"."Member No")
                {
                }
                fieldelement(TimeCreated;"Meeting Comments"."Time Created")
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

