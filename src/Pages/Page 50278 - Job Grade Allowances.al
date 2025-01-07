page 50278 "Job Grade Allowances"
{
    PageType = List;
    SourceTable = "HR Job Grade Allowances";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job Grade"; Rec."Job Grade")
                {
                }
                field("Allowance Code"; Rec."Allowance Code")
                {
                }
                field("Allowance Description"; Rec."Allowance Description")
                {
                }
                field("Allowance Amount"; Rec."Allowance Amount")
                {
                }
            }
        }
    }

    actions
    {
    }
}

