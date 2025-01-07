page 56039 "Case Schedule List"
{
    PageType = List;
    SourceTable = "Document registration";
    SourceTableView = WHERE("Court Date" = FILTER(<> 0D));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Case ID"; Rec."Case ID")
                {
                }
                field("Court Date"; Rec."Court Date")
                {
                }
                field("Case Title"; Rec."Case Title")
                {
                }
                field("Accused Name"; Rec."Accused Name")
                {
                }
                field("Assigned Investigator"; Rec."Assigned Investigator")
                {
                }
                field("Date Created"; Rec."Date Created")
                {
                }
                field("Time Created"; Rec."Time Created")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("No. Series"; Rec."No. Series")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control12; Outlook)
            {
            }
            systempart(Control13; Notes)
            {
            }
            systempart(Control14; Links)
            {
            }
        }
    }

    actions
    {
    }
}

