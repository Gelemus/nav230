page 50238 "Individual Appraisal Lines"
{
    PageType = ListPart;
    SourceTable = "Individual Appraisal Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal Objective"; Rec."Appraisal Objective")
                {
                }
                field("Organization Activity Code"; Rec."Organization Activity Code")
                {
                }
                field("Organization Activity Descrp"; Rec."Organization Activity Descrp")
                {
                }
                field("Departmental Activity Code"; Rec."Departmental Activity Code")
                {
                }
                field("Departmental Activity Descrp"; Rec."Departmental Activity Descrp")
                {
                }
                field("Divisional Activity Code"; Rec."Divisional Activity Code")
                {
                }
                field("Divisional Activity Descrp"; Rec."Divisional Activity Descrp")
                {
                }
                field("Activity Code"; Rec."Activity Code")
                {

                    trigger OnAssistEdit()
                    begin
                        //AssistEdit;
                    end;
                }
                field("Activity Description"; Rec."Activity Description")
                {
                }
                field("Objective Weight"; Rec."Objective Weight")
                {
                }
                field("Activity Weight"; Rec."Activity Weight")
                {
                }
                field("Target Value"; Rec."Target Value")
                {
                }
                field("Appraisal Score Type"; Rec."Appraisal Score Type")
                {
                }
                field("Parameter Type"; Rec."Parameter Type")
                {
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                }
                field("Actual Output Description"; Rec."Actual Output Description")
                {
                }
                field("Actual Value"; Rec."Actual Value")
                {
                }
                field("Self Assessment Rating"; Rec."Self Assessment Rating")
                {
                }
                field("Self Assessment Weighted Rat."; Rec."Self Assessment Weighted Rat.")
                {
                }
                field("Actual agreed Value"; Rec."Actual agreed Value")
                {
                }
                field("Agreed Rating with Supervisor"; Rec."Agreed Rating with Supervisor")
                {
                }
                field("Weighted Rat. With Supervisor"; Rec."Weighted Rat. With Supervisor")
                {
                }
                field("Moderated Value"; Rec."Moderated Value")
                {
                }
                field("Moderated Assessment Rating"; Rec."Moderated Assessment Rating")
                {
                }
                field("Weighted Rat. Moderated Value"; Rec."Weighted Rat. Moderated Value")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    var
        ObjectiveWeightEditable: Boolean;
        ActivityWeightEditable: Boolean;
        TargetValueEditable: Boolean;
        AppraisalScoreType: Boolean;
}

