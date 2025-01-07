page 50439 "HR Appraisal Competency Subfor"
{
    AutoSplitKey = true;
    Caption = 'HR Appraisal Competency Subform';
    PageType = ListPart;
    SourceTable = "HR Appraisal Competency Factor";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Competency Factor"; Rec."Competency Factor")
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field(Score; Rec.Score)
                {
                }
                field("Self Rating"; Rec."Self Rating")
                {
                    Caption = 'APPRASEE';
                }
                field(Consensus; Rec.Consensus)
                {
                    Caption = 'APPRAISER';
                }
                field(Comments; Rec.Comments)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec."Unit of Measure" := '%';
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Unit of Measure" := '%';
    end;

    trigger OnOpenPage()
    begin
        Rec."Unit of Measure" := '%';
    end;
}

