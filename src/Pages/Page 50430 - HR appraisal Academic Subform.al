page 50430 "HR appraisal Academic Subform"
{
    AutoSplitKey = true;
    Caption = 'HR appraisal Academic/Qualification Subform';
    PageType = ListPart;
    SourceTable = "Hr Appraisal Academic/Prof Qua";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Name of Institution"; Rec."Name of Institution")
                {
                    Caption = 'Academic Qualification';
                }
                field("Qualification Awarded"; Rec."Qualification Awarded")
                {
                    Caption = 'Proffesional Qualification';
                }
                field("Period Of Study"; Rec."Period Of Study")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

