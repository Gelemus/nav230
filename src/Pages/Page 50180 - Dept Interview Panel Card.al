page 50180 "Dept Interview Panel Card"
{
    PageType = Card;
    SourceTable = "Interview Committee Dep Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Department Code"; Rec."Department Code")
                {
                }
                field("Dept Committee Name"; Rec."Dept Committee Name")
                {
                }
            }
            part(Control5; "Interview Panel Subform")
            {
                SubPageLink = Code = FIELD("Department Code");
            }
        }
    }

    actions
    {
    }
}

