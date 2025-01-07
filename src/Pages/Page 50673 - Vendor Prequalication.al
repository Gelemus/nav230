page 50673 "Vendor Prequalication"
{
    PageType = List;
    SourceTable = "Vendor Prequalified Categories";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Prequalification Code"; Rec."Prequalification Code")
                {
                }
                field("Prequalification Name"; Rec."Prequalification Name")
                {
                    Editable = false;
                }
                field("Financial Year"; Rec."Financial Year")
                {
                }
            }
        }
    }

    actions
    {
    }
}

