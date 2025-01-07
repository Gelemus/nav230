page 50239 "Support Training & Development"
{
    PageType = ListPart;
    SourceTable = "Appraisal Training and Dev";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                }
                field("Appraisal No."; Rec."Appraisal No.")
                {
                    Visible = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Visible = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Visible = false;
                }
                field("Area of Development"; Rec."Area of Development")
                {
                }
                field("Agreed Improv Action plan"; Rec."Agreed Improv Action plan")
                {
                }
                field(Resposibility; Rec.Resposibility)
                {
                    Visible = false;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                }
            }
        }
    }

    actions
    {
    }
}

