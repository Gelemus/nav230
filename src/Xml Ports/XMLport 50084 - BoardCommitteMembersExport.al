xmlport 50084 BoardCommitteMembersExport
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(BoardCommitteeMembersRoot)
        {
            tableelement("Board Committee Members";"Board Committee Members")
            {
                XmlName = 'BoardCommitteeMembers';
                fieldelement(CommitteeCode;"Board Committee Members"."Committee Code")
                {
                }
                fieldelement(MemberNo;"Board Committee Members"."Member No")
                {
                }
                fieldelement(Name;"Board Committee Members"."Member Name")
                {
                }
                fieldelement(Role;"Board Committee Members".Role)
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

