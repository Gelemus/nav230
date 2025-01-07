page 50431 "HR Appraisal Main Resp/Duties "
{
    AutoSplitKey = true;
    Caption = 'Main Responsibilities/Duties';
    PageType = ListPart;
    SourceTable = "HR Appraisal Resp/Duties";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Responsibility/Duty"; Rec."Responsibility/Duty")
                {
                }
            }
        }
    }

    actions
    {
    }
}

