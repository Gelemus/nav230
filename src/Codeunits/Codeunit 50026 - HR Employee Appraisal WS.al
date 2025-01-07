codeunit 50026 "HR Employee Appraisal WS"
{

    trigger OnRun()
    begin
    end;

    var
        HREmployeeAppraisalHeader: Record "HR Employee Appraisal Header";
        HRIndividualAppraisalLines: Record "Individual Appraisal Lines";
        HumanResourcesSetup: Record "Human Resources Setup";
        ApprovalEntry: Record "Approval Entry";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

    procedure CheckOpenEmployeeTargetSettingExists("EmployeeNo.": Code[20]) EmployeeTargetSettingExist: Boolean
    begin
        EmployeeTargetSettingExist:=false;

        HREmployeeAppraisalHeader.Reset;
        HREmployeeAppraisalHeader.SetRange(HREmployeeAppraisalHeader."Employee No.","EmployeeNo.");
        HREmployeeAppraisalHeader.SetRange(HREmployeeAppraisalHeader.Status,HREmployeeAppraisalHeader.Status::Open);
        if HREmployeeAppraisalHeader.FindFirst then begin
          EmployeeTargetSettingExist:=true;
        end;
    end;

    procedure CheckEmployeeTargetSettingExists("AppraisalNo.": Code[20];"EmployeeNo.": Code[20]) EmployeeTargetSettingExist: Boolean
    begin
        EmployeeTargetSettingExist:=false;

        HREmployeeAppraisalHeader.Reset;
        HREmployeeAppraisalHeader.SetRange(HREmployeeAppraisalHeader."Employee No.","EmployeeNo.");
        HREmployeeAppraisalHeader.SetRange(HREmployeeAppraisalHeader."No.","AppraisalNo.");
        if HREmployeeAppraisalHeader.FindFirst then begin
          EmployeeTargetSettingExist:=true;
        end;
    end;

    procedure CreateEmployeeTargetSetting("EmployeeNo.": Code[20]) EmployeeTargetSettingCreated: Boolean
    begin
        EmployeeTargetSettingCreated:=false;

        HumanResourcesSetup.Get;
        HREmployeeAppraisalHeader.Init;

        HREmployeeAppraisalHeader."No.":=NoSeriesManagement.GetNextNo(HumanResourcesSetup."Employee Appraisal Nos.",0D,true);
        HREmployeeAppraisalHeader.Date:=Today;
        HREmployeeAppraisalHeader."Employee No.":="EmployeeNo.";
        HREmployeeAppraisalHeader.Validate(HREmployeeAppraisalHeader."Employee No.");

        if HREmployeeAppraisalHeader.Insert then begin
          EmployeeTargetSettingCreated:=true;
        end;
    end;

    procedure GetEmployeeAppraisalNo("EmployeeNo.": Code[20]) "OpenAppraisalNo.": Code[20]
    begin
        "OpenAppraisalNo.":='';

        HREmployeeAppraisalHeader.Reset;
        HREmployeeAppraisalHeader.SetRange(HREmployeeAppraisalHeader."Employee No.","EmployeeNo.");
        HREmployeeAppraisalHeader.SetRange(HREmployeeAppraisalHeader.Status,HREmployeeAppraisalHeader.Status::Open);

        if HREmployeeAppraisalHeader.FindFirst then begin
          "OpenAppraisalNo.":=HREmployeeAppraisalHeader."No.";
        end;
    end;

    procedure CreateEmployeeTargetSettingLine(EmployeeNo: Code[20];AppraisalPeriod: Code[50];AppraisalObjective: Code[30];OrganizationalAppraisalCode: Code[20];DepartmentalAppraisalCode: Code[20];DivisionalAppraisalCode: Code[30];ActivityDescription: Text[250];ActivityWeight: Decimal;TargetValue: Decimal;BUM: Code[30]) EmployeeTargetSettingLineCreated: Boolean
    begin
        EmployeeTargetSettingLineCreated:=false;

        HREmployeeAppraisalHeader.Reset;
        HREmployeeAppraisalHeader.SetRange(HREmployeeAppraisalHeader."Employee No.", EmployeeNo);
        HREmployeeAppraisalHeader.SetRange(HREmployeeAppraisalHeader.Status, HREmployeeAppraisalHeader.Status::Open);

        if HREmployeeAppraisalHeader.FindFirst then begin
           HumanResourcesSetup.Get;
          //Initialize Individual Appraisal Line
          HRIndividualAppraisalLines.Init;
          HRIndividualAppraisalLines."Appraisal No":= HREmployeeAppraisalHeader."No.";
          HRIndividualAppraisalLines."Appraisal Period":=AppraisalPeriod;
          HRIndividualAppraisalLines.Validate(HRIndividualAppraisalLines."Appraisal Period");
          HRIndividualAppraisalLines."Appraisal Objective":=AppraisalObjective;
         // HRIndividualAppraisalLines.VALIDATE("Appraisal Objective");
          HRIndividualAppraisalLines."Organization Activity Code":=OrganizationalAppraisalCode;
         // HRIndividualAppraisalLines.VALIDATE(HRIndividualAppraisalLines."Organization Activity Code");
          HRIndividualAppraisalLines."Departmental Activity Code":=DepartmentalAppraisalCode;
         // HRIndividualAppraisalLines.VALIDATE(HRIndividualAppraisalLines."Departmental Activity Code");
          HRIndividualAppraisalLines."Divisional Activity Code":=DivisionalAppraisalCode;
        //  HRIndividualAppraisalLines.VALIDATE("Divisional Activity Code");
          HRIndividualAppraisalLines."Activity Code":=NoSeriesManagement.GetNextNo(HumanResourcesSetup."Appraisal Activity Code Nos",0D,true);
          HRIndividualAppraisalLines."Activity Description":=ActivityDescription;
          HRIndividualAppraisalLines."Activity Weight":=ActivityWeight;
          //HRIndividualAppraisalLines.VALIDATE("Activity Weight");
          HRIndividualAppraisalLines."Target Value":=TargetValue;
          HRIndividualAppraisalLines."Base Unit of Measure":=BUM;

         if HRIndividualAppraisalLines.Insert then begin
           EmployeeTargetSettingLineCreated:=true;
         end;
        end;
    end;

    procedure ModifyEmployeeTargetSetting("AppraisalNo.": Code[20];"EmployeeNo.": Code[20]) EmployeeTargetSettingModified: Boolean
    begin
        EmployeeTargetSettingModified:=false;

        HRIndividualAppraisalLines.Reset;
        HRIndividualAppraisalLines.SetRange(HRIndividualAppraisalLines."Appraisal No","AppraisalNo.");

        if HRIndividualAppraisalLines.FindFirst then begin
          HREmployeeAppraisalHeader.Reset;
          HREmployeeAppraisalHeader.SetRange(HREmployeeAppraisalHeader."No.","AppraisalNo.");
          //HREmployeeAppraisalHeader.SETRANGE(HREmployeeAppraisalHeader."Employee No.","EmployeeNo.");
         if HREmployeeAppraisalHeader.FindFirst then begin
          HREmployeeAppraisalHeader.Date:=Today;
           HREmployeeAppraisalHeader."No.":="AppraisalNo.";
          HREmployeeAppraisalHeader."Appraisal Period":=HRIndividualAppraisalLines."Appraisal Period";
          HREmployeeAppraisalHeader.Validate(HREmployeeAppraisalHeader."Appraisal Period");
          HREmployeeAppraisalHeader.Description:= 'APPRAISAL PERIOD '+ HREmployeeAppraisalHeader."Appraisal Period";
          HREmployeeAppraisalHeader."Employee No.":="EmployeeNo.";
          HREmployeeAppraisalHeader.Validate(HREmployeeAppraisalHeader."Employee No.");

          HREmployeeAppraisalHeader.Modify;
          EmployeeTargetSettingModified:=true;
          end;
        end;
    end;

    procedure ModifyEmployeeTargetSettingLine("AppraisalNo.": Code[20];AppraisalObjective: Code[30];AppraisalPeriod: Code[50];OrganizationalAppraisalCode: Code[30];DepartmentalAppraisalCode: Code[30];DivisionalAppraisalCode: Code[30];ActivityDescription: Text[250];ActivityWeight: Decimal;TargetValue: Decimal;BUM: Code[30]) EmployeeTargetSettingLineModified: Boolean
    begin
        EmployeeTargetSettingLineModified:=false;

        HRIndividualAppraisalLines.Reset;
        HRIndividualAppraisalLines.SetRange(HRIndividualAppraisalLines."Appraisal No","AppraisalNo.");
        HRIndividualAppraisalLines.SetRange(HRIndividualAppraisalLines."Appraisal Objective",AppraisalObjective);

        if HRIndividualAppraisalLines.FindFirst then begin
          //Initialize Individual Appraisal Line
          HRIndividualAppraisalLines.Init;
          HRIndividualAppraisalLines."Appraisal No":=HRIndividualAppraisalLines."Appraisal No";
          HRIndividualAppraisalLines."Appraisal Period":=HRIndividualAppraisalLines."Appraisal Period";
          HRIndividualAppraisalLines.Validate(HRIndividualAppraisalLines."Appraisal Period");
          HRIndividualAppraisalLines."Appraisal Objective":=AppraisalObjective;
          HRIndividualAppraisalLines.Validate("Appraisal Objective");
          HRIndividualAppraisalLines."Organization Activity Code":=OrganizationalAppraisalCode;
          HRIndividualAppraisalLines.Validate(HRIndividualAppraisalLines."Organization Activity Code");
          HRIndividualAppraisalLines."Departmental Activity Code":=DepartmentalAppraisalCode;
          HRIndividualAppraisalLines.Validate(HRIndividualAppraisalLines."Departmental Activity Code");
          HRIndividualAppraisalLines."Divisional Activity Code":=DivisionalAppraisalCode;
          HRIndividualAppraisalLines.Validate("Divisional Activity Code");
          HRIndividualAppraisalLines."Activity Code":=HRIndividualAppraisalLines."Activity Code";
          HRIndividualAppraisalLines."Activity Weight":=HRIndividualAppraisalLines."Activity Weight";
          HRIndividualAppraisalLines.Validate("Activity Weight");
          HRIndividualAppraisalLines."Target Value":=TargetValue;
          HRIndividualAppraisalLines."Base Unit of Measure":=BUM;

         if HRIndividualAppraisalLines.Modify then begin
           EmployeeTargetSettingLineModified:=true;
         end;
        end;
    end;

    procedure GetEmployeeTargetSettingStatus("AppraisalNo.": Code[20]) EmployeeTargetSettingStatus: Text
    begin
        EmployeeTargetSettingStatus:='';

        HREmployeeAppraisalHeader.Reset;
        HREmployeeAppraisalHeader.SetRange(HREmployeeAppraisalHeader."No.","AppraisalNo.");
        if HREmployeeAppraisalHeader.FindFirst then begin
          EmployeeTargetSettingStatus:=Format(HREmployeeAppraisalHeader.Status);
        end;
    end;

    procedure CheckEmployeeTargetSettingLinesExist("AppraisalNo.": Code[20]) EmployeeTargetSettingLinesExist: Boolean
    begin
        EmployeeTargetSettingLinesExist:=false;

        HRIndividualAppraisalLines.Reset;
        HRIndividualAppraisalLines.SetRange(HRIndividualAppraisalLines."Appraisal No","AppraisalNo.");
        if HRIndividualAppraisalLines.FindFirst then begin
          EmployeeTargetSettingLinesExist:=true;
        end;
    end;

    procedure DeleteEmployeeTargetSettingLine("AppraisalNo.": Code[20];AppraisalObjective: Code[20]) IndividualAppraisalLineDeleted: Boolean
    begin
        IndividualAppraisalLineDeleted:=false;

        HRIndividualAppraisalLines.Reset;
        HRIndividualAppraisalLines.SetRange(HRIndividualAppraisalLines."Appraisal No","AppraisalNo.");
        HRIndividualAppraisalLines.SetRange(HRIndividualAppraisalLines."Appraisal Objective",AppraisalObjective);

        if HRIndividualAppraisalLines.FindFirst then begin
          HRIndividualAppraisalLines.Delete;
          IndividualAppraisalLineDeleted:=true;
        end;
    end;

    procedure CheckEmployeeTargetSettingApprovalWorkflowEnabled("AppraisalNo.": Code[20]) ApprovalWorkflowEnabled: Boolean
    begin
        ApprovalWorkflowEnabled:=false;

        HREmployeeAppraisalHeader.Reset;
        // if HREmployeeAppraisalHeader.Get("AppraisalNo.") then
        //   ApprovalWorkflowEnabled:=ApprovalsMgmt.CheckHREmployeeAppraisalHeaderApprovalsWorkflowEnabled(HREmployeeAppraisalHeader);
    end;

    procedure SendEmployeeTargetSettingApprovalRequest("AppraisalNo.": Code[20]) ApprovalRequestSent: Boolean
    begin
        ApprovalRequestSent:=false;

        HREmployeeAppraisalHeader.Reset;
        if HREmployeeAppraisalHeader.Get("AppraisalNo.") then begin
          //ApprovalsMgmt.OnSendHREmployeeAppraisalHeaderForApproval(HREmployeeAppraisalHeader);
          Commit;
          ApprovalEntry.Reset;
          ApprovalEntry.SetRange(ApprovalEntry."Document No.",HREmployeeAppraisalHeader."No.");
          ApprovalEntry.SetRange(ApprovalEntry.Status,ApprovalEntry.Status::Open);
          if ApprovalEntry.FindFirst then
            ApprovalRequestSent:=true;
        end;
    end;

    procedure CancelEmployeeTargetSettingApprovalRequest("AppraisalNo.": Code[20]) ApprovalRequestCanceled: Boolean
    begin
        ApprovalRequestCanceled:=false;

        HREmployeeAppraisalHeader.Reset;
        if HREmployeeAppraisalHeader.Get("AppraisalNo.") then begin
         // ApprovalsMgmt.OnCancelHREmployeeAppraisalHeaderApprovalRequest(HREmployeeAppraisalHeader);
          Commit;
          ApprovalEntry.Reset;
          ApprovalEntry.SetRange(ApprovalEntry."Document No.",HREmployeeAppraisalHeader."No.");
          if ApprovalEntry.FindLast then begin
            if ApprovalEntry.Status=ApprovalEntry.Status::Canceled then
              ApprovalRequestCanceled:=true;
          end;
        end;
    end;
}

