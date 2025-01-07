page 50236 "Departmental Appraisal Lines"
{
    PageType = ListPart;
    SourceTable = "Departmental Appraisal Lines";

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
                field("Activity option"; Rec."Activity option")
                {

                    trigger OnValidate()
                    begin
                        if Rec."Activity option" = Rec."Activity option"::"Final-Level" then begin
                            ObjectiveWeightEditable := true;
                            ActivityWeightEditable := true;
                            TargetValueEditable := true;
                        end;


                        if Rec."Activity option" = Rec."Activity option"::"Cascade-Down" then begin
                            ObjectiveWeightEditable := false;
                            ActivityWeightEditable := false;
                            TargetValueEditable := false;
                        end;
                    end;
                }
                field("Objective Weight"; Rec."Objective Weight")
                {
                    Editable = ObjectiveWeightEditable;
                }
                field("Activity Weight"; Rec."Activity Weight")
                {
                    Editable = ActivityWeightEditable;
                }
                field("Target Value"; Rec."Target Value")
                {
                    Editable = TargetValueEditable;
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

