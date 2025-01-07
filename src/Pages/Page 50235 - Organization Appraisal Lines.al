page 50235 "Organization Appraisal Lines"
{
    Caption = 'Organization Appraisal Lines';
    PageType = ListPart;
    SourceTable = "Organization Appraisal Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal Objective"; Rec."Appraisal Objective")
                {
                }
                field("Activity Code"; Rec."Activity Code")
                {
                }
                field("Activity Description"; Rec."Activity Description")
                {
                }
                field("Activity Option"; Rec."Activity Option")
                {

                    trigger OnValidate()
                    begin
                        if Rec."Activity Option" = Rec."Activity Option"::"Final-Level" then begin
                            ObjectiveWeightEditable := true;
                            ActivityWeightEditable := true;
                            TargetValueEditable := true;
                        end;


                        if Rec."Activity Option" = Rec."Activity Option"::"Cascade-Down" then begin
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

                    trigger OnValidate()
                    begin
                        /*TotalActivityWeight:=0;
                        EmployeeAppraisalLines.RESET;
                        EmployeeAppraisalLines.SETRANGE(EmployeeAppraisalLines."Appraisal No.","Appraisal No.");
                        EmployeeAppraisalLines.SETRANGE(EmployeeAppraisalLines."Appraisal Objective","Appraisal Objective");
                        IF EmployeeAppraisalLines.FINDSET THEN BEGIN
                          REPEAT
                            TotalActivityWeight:=TotalActivityWeight+EmployeeAppraisalLines."Activity Weight";
                          UNTIL EmployeeAppraisalLines.NEXT=0;
                        END;
                        TotalActivityWeight:=TotalActivityWeight+"Activity Weight";
                        IF TotalActivityWeight > 100 THEN
                          ERROR(Txt_001);
                        */

                    end;
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
        AppraisalCodes: Record "HR Appraisal KPI";
        AppraisalHeader: Record "HR Employee Appraisal Header";
        AppraisalTargetOutputs: Record "HR Appraisal Objective";
        EmployeeAppraisalLines: Record "Organization Appraisal Lines";
        Results: Decimal;
        NoSeriesManagement: Codeunit NoSeriesManagement;
        TotalActivityWeight: Decimal;
        Txt_001: Label 'The Activity weight should not exceed 100%! Please check';
        ObjectiveWeightEditable: Boolean;
        ActivityWeightEditable: Boolean;
        TargetValueEditable: Boolean;
        AppraisalScoreType: Boolean;
}

