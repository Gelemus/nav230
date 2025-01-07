page 50444 "Performance Objectives"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "HR Appraisal Objectives";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal No."; Rec."Appraisal No.")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                }
                field("Appraisal Objective"; Rec."Appraisal Objective")
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field(Score; Rec.Score)
                {

                    trigger OnValidate()
                    begin
                        Rec.Target := Rec.Score;
                    end;
                }
                field("Perfomance Indictor/Activities"; Rec."Perfomance Indictor/Activities")
                {
                    Visible = false;
                }
                field("Status Previous Year"; Rec."Status Previous Year")
                {
                }
                field(Target; Rec.Target)
                {
                }
                field("Self Rating"; Rec."Self Rating")
                {

                    trigger OnValidate()
                    begin
                        /*IF "Self Rating">Score THEN
                          ERROR('Self Rating Must be less than Score WT');
                        */

                    end;
                }
                field(Actual; Rec.Actual)
                {
                    Caption = 'Consensus';

                    trigger OnValidate()
                    begin
                        /*IF Actual > Score THEN
                        ERROR('Consensus Rating Must be less than Score WT');
                        */

                    end;
                }
                field("Maintaining Last Year Score"; Rec."Maintaining Last Year Score")
                {
                }
                field("Curreny Year Increase/Decline"; Rec."Curreny Year Increase/Decline")
                {
                }
                field(Consensus; Rec.Consensus)
                {
                    Caption = 'Total';
                }
                field("Perfomance Target"; Rec."Perfomance Target")
                {
                    Visible = false;
                }
                field(Comments; Rec.Comments)
                {
                    Caption = 'Comments';
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

