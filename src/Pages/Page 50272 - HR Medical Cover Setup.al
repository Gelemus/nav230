page 50272 "HR Medical Cover Setup"
{
    PageType = List;
    SourceTable = "Medical Cover Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee Category"; Rec."Employee Category")
                {
                }
                field("In-Patient Amount"; Rec."In-Patient Amount")
                {
                }
                field("Out-Patient Amount"; Rec."Out-Patient Amount")
                {
                }
            }
        }
    }

    actions
    {
    }
}

