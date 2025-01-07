page 56045 "Investigators Listing"
{
    PageType = List;
    SourceTable = "Case Investigator";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Case No"; Rec."Case No")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Effective Date"; Rec."Effective Date")
                {
                }
                field("Allocation Comments"; Rec."Allocation Comments")
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
            }
        }
    }

    actions
    {
    }
}

