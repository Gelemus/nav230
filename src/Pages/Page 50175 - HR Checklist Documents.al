page 50175 "HR Checklist Documents"
{
    PageType = List;
    SourceTable = "HR Mandatory Doc. Checklist";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Mandatory Doc. Code"; Rec."Mandatory Doc. Code")
                {
                }
                field("Document Attached"; Rec."Document Attached")
                {
                }
                field("Mandatory Doc. Description"; Rec."Mandatory Doc. Description")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control8; Links)
            {
                Visible = true;
            }
            systempart(Control4; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

