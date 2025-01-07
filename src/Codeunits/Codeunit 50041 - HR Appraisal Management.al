codeunit 50041 "HR Appraisal Management"
{

    trigger OnRun()
    begin
    end;

    procedure GetActualandTargetValues(OrganizationAppraisalLines: Record "Organization Appraisal Lines")
    var
        OrganizationAppraisalLines2: Record "Organization Appraisal Lines";
        Results: Decimal;
    begin
        Results:=0;
        if OrganizationAppraisalLines."Parameter Type"=OrganizationAppraisalLines."Parameter Type"::"Time-Based" then begin
          if OrganizationAppraisalLines."Actual Value">0 then
         Results:=OrganizationAppraisalLines."Target Value"/OrganizationAppraisalLines."Actual Value"*3;

          if Results>1 then
           OrganizationAppraisalLines."Self Assessment Rating":=GetMinimumActualValueandTargetValue(Results,OrganizationAppraisalLines."Global Dimension 1 Code",
           OrganizationAppraisalLines."Appraisal Objective",OrganizationAppraisalLines."Appraisal Score Type") else
           OrganizationAppraisalLines."Self Assessment Rating":=1;
        end else begin
          Results:=OrganizationAppraisalLines."Actual Value"/OrganizationAppraisalLines."Target Value"*3;

          if Results>1 then
           OrganizationAppraisalLines."Self Assessment Rating":=GetMinimumActualValueandTargetValue(Results,OrganizationAppraisalLines."Global Dimension 1 Code",
           OrganizationAppraisalLines."Appraisal Objective",OrganizationAppraisalLines."Appraisal Score Type") else
           OrganizationAppraisalLines."Self Assessment Rating":=1;
        end;

        OrganizationAppraisalLines."Self Assessment Weighted Rat.":=OrganizationAppraisalLines."Activity Weight"/100*OrganizationAppraisalLines."Objective Weight"/100*OrganizationAppraisalLines."Self Assessment Rating";
    end;

    procedure GetMinimumActualValueandTargetValue(Results: Decimal;DepartmentCode: Code[20];ObjectiveCode: Code[20];Type: Option " ",Core,"Non-Core") MinimumValue: Decimal
    var
        HumanResourcesSetup: Record "Human Resources Setup";
        HRAppraisalObjective: Record "HR Appraisal Objective";
    begin
        HumanResourcesSetup.Get;
        HRAppraisalObjective.Reset;
        HRAppraisalObjective.SetRange("Deparment Code",DepartmentCode);
        HRAppraisalObjective.SetRange(Code,ObjectiveCode);
        if HRAppraisalObjective.FindFirst then begin
          if HRAppraisalObjective."Appraisal Score Type"=HRAppraisalObjective."Appraisal Score Type"::Core then begin
            if Results < HumanResourcesSetup."Appraisal Max score (Core)" then
              MinimumValue:=Results
            else
             MinimumValue:=HumanResourcesSetup."Appraisal Max score (Core)";
          end else begin
            if Results < HumanResourcesSetup."Appraisal Max Score(None Core)" then
             MinimumValue:=Results
            else
             MinimumValue:=HumanResourcesSetup."Appraisal Max Score(None Core)";
          end;
        end;
    end;
}

