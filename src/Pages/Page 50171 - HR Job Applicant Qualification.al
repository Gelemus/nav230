page 50171 "HR Job Applicant Qualification"
{
    Caption = 'Job Applicant Academic Qualifications';
    PageType = List;
    SourceTable = "HR Job Applicant Qualification";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ToolTip = 'Specifies Qualification Code.';
                }
                field("Qualification Name"; Rec."Qualification Name")
                {
                    ToolTip = 'Specifies the  description.';
                }
                field("Document Attached"; Rec."Document Attached")
                {
                    ToolTip = 'Specifies the  document attached.';
                }
                field("Joining Date"; Rec."Joining Date")
                {
                }
                field("Completion Date"; Rec."Completion Date")
                {
                }
                field(Award; Rec.Award)
                {
                }
                field("Award Date"; Rec."Award Date")
                {
                }
                field("Institution Name"; Rec."Institution Name")
                {
                }
            }
        }
    }

    actions
    {
    }
}

