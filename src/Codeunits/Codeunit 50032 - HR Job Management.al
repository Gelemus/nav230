codeunit 50032 "HR Job Management"
{

    trigger OnRun()
    begin
    end;

    var
        HRJobs: Record "HR Jobs";

    procedure CheckHRJobMandatoryFields("HR Job": Record "HR Jobs")
    var
        HRJob: Record "HR Jobs";
        EmptyPaymentLine: Label 'You cannot Post Payment with empty Line';
    begin
        HRJob.TransferFields("HR Job",true);
        HRJob.TestField("Job Title");
        HRJob.TestField("Job Grade");
        HRJob.TestField("Maximum Positions");
        //HRJob.TESTFIELD("Global Dimension 1 Code");
    end;

    procedure ReOpenReleasedJobs(var "HR Jobs": Record "HR Jobs")
    var
        HRJobs: Record "HR Jobs";
        JobReopenedMessage: Label 'The Job has Successfully been Reopened and Deactivated';
    begin
        HRJobs.Reset;
        HRJobs.SetRange(HRJobs."No.","HR Jobs"."No.");
        if HRJobs.FindFirst then begin
          HRJobs.Status:=HRJobs.Status::Open;
          HRJobs.Validate(HRJobs.Status);
          HRJobs.Active:=false;
          HRJobs.Modify;
          Message(JobReopenedMessage);
        end;
    end;

    procedure DeactivateReleasedJobs(var "HR Jobs": Record "HR Jobs")
    var
        HRJobs: Record "HR Jobs";
        Txt001: Label 'The Job has been sucessfully deactivated';
    begin
        HRJobs.Reset;
        HRJobs.SetRange(HRJobs."No.","HR Jobs"."No.");
        if HRJobs.FindFirst then begin
           HRJobs.Active:=false;
           HRJobs.Modify;
           Message(Txt001);
        end;
    end;

    procedure CheckOpenJobExists(EmployeeUserID: Code[50]) OpenJobExist: Boolean
    begin
        OpenJobExist:=false;
        HRJobs.Reset;
        HRJobs.SetRange(HRJobs."User ID",EmployeeUserID);
        HRJobs.SetRange(HRJobs.Status,HRJobs.Status::Open);
        if HRJobs.FindFirst then begin
          OpenJobExist:=true;
        end;
    end;

    procedure ReactivateReleasedJobs(var "HR Jobs": Record "HR Jobs")
    var
        HRJobs: Record "HR Jobs";
        Txt001: Label 'The Job has been sucessfully Activated';
    begin
        HRJobs.Reset;
        HRJobs.SetRange(HRJobs."No.","HR Jobs"."No.");
        if HRJobs.FindFirst then begin
           HRJobs.Active:=true;
           HRJobs.Modify;
           Message(Txt001);
        end;
    end;
}

