page 50113 "Procurement Upload Documents"
{
    PageType = ListPart;
    SourceTable = "Procurement Upload Documents";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                }
                field("Document Code"; Rec."Document Code")
                {
                }
                field("Document Description"; Rec."Document Description")
                {
                }
                field("Document Mandatory"; Rec."Document Mandatory")
                {
                }
                field("Tender Stage"; Rec."Tender Stage")
                {
                }
            }
        }
    }

    actions
    {
    }
}

