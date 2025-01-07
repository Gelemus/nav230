page 50687 "Company Activities"
{
    PageType = List;
    SourceTable = "Rules & Regulations";
    SourceTableView = WHERE("Company Activities" = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Start Time"; Rec."Start Time")
                {
                }
                field("End Time"; Rec."End Time")
                {
                }
                field("Venue/Location"; Rec."Venue/Location")
                {
                }
                field(Cost; Rec.Cost)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control8; Notes)
            {
            }
            systempart(Control9; Links)
            {
            }
        }
    }

    actions
    {
    }
}

