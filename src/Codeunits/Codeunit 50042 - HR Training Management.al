codeunit 50042 "HR Training Management"
{

    trigger OnRun()
    begin
    end;

    var
        TrainingType: Option " ","Individual Training","Group Training";
        TrainingGroups: Record "HR Training Group";
        Txt001: Label 'Process Complete';

    procedure LoadTrainingAttendeesfromTrainingGroups(TrainingApplications: Record "HR Training Applications")
    var
        TrainingAttendees: Record "HR Training Attendees";
        TrainingGroupParticipants: Record "HR Training Group Participants";
    begin
        TrainingAttendees.Reset;
        TrainingAttendees.SetRange("Application No.",TrainingApplications."Application No.");
        if TrainingAttendees.FindSet then
          TrainingAttendees.DeleteAll;

        TrainingGroupParticipants.Reset;
        TrainingGroupParticipants.SetRange("Training Group No.",TrainingApplications."No.");
        if TrainingGroupParticipants.FindSet then begin
          repeat
            TrainingAttendees.Init;
            TrainingAttendees."Application No.":=TrainingApplications."Application No.";
            TrainingAttendees."Employee No":=TrainingGroupParticipants."Employee No.";
            TrainingAttendees."Employee Name":=TrainingGroupParticipants."Employee Name";
            TrainingAttendees."Job Title":=TrainingGroupParticipants."Job Tittle";
            TrainingAttendees."E-mail Address":=TrainingGroupParticipants."E-mail Address";
            TrainingAttendees."Estimated Cost":=TrainingGroupParticipants."Estimated Cost";
            TrainingAttendees.Insert;
          until TrainingGroupParticipants.Next =0;
        end;
        Message(Txt001);
    end;

    procedure InsertProposedTrainingForEmployees(AppraisalPeriod: Code[20];No: Code[20])
    var
        HRTrainingNeedsLine: Record "HR Training Needs Line";
        EmployeesApprovedTraining: Record "Approved Training Needs Line";
        HRTrainingNeedsHeader: Record "HR Training Needs Header";
    begin
        HRTrainingNeedsHeader.Reset;
        HRTrainingNeedsHeader.SetRange("Calendar Year",AppraisalPeriod);
        if HRTrainingNeedsHeader.FindSet then begin
          repeat
         HRTrainingNeedsLine.Reset;
         HRTrainingNeedsLine.SetRange("No.",HRTrainingNeedsHeader."No.");
         if HRTrainingNeedsLine.FindSet then begin
           repeat
             EmployeesApprovedTraining.Init;
             EmployeesApprovedTraining."No.":=No;
             EmployeesApprovedTraining."Line No.":=0;
             EmployeesApprovedTraining."Employee No.":=HRTrainingNeedsLine."Employee No.";
             EmployeesApprovedTraining."Employee Name":=HRTrainingNeedsLine."Employee Name";
             EmployeesApprovedTraining."Official Mail":=HRTrainingNeedsLine."Official Email Address";
             EmployeesApprovedTraining."Intervention Required":=HRTrainingNeedsLine."Intervention Required";
             EmployeesApprovedTraining."Development Needs":=HRTrainingNeedsLine."Development Needs";
             EmployeesApprovedTraining.Objectives:=HRTrainingNeedsLine.Objectives;
             EmployeesApprovedTraining.Description:=HRTrainingNeedsLine.Description;
             EmployeesApprovedTraining."Proposed Training Provider":=HRTrainingNeedsLine."Proposed Training Provider";
             EmployeesApprovedTraining."Training Location & Venue":=HRTrainingNeedsLine."Training Location & Venue";
             EmployeesApprovedTraining."Proposed Period":=HRTrainingNeedsLine."Proposed Period";
             EmployeesApprovedTraining."Calendar Year":=HRTrainingNeedsLine."Calendar Year";
             EmployeesApprovedTraining."Training Scheduled Date":=HRTrainingNeedsLine."Training Scheduled Date";
             EmployeesApprovedTraining."Training Scheduled Date To":=HRTrainingNeedsLine."Training Scheduled Date To";
             EmployeesApprovedTraining."Estimated Cost":=HRTrainingNeedsLine."Estimated Cost";
             EmployeesApprovedTraining."Global Dimension 1 Code":=HRTrainingNeedsLine."Global Dimension 1 Code";
             EmployeesApprovedTraining."Global Dimension 2 Code":=HRTrainingNeedsLine."Global Dimension 2 Code";
             EmployeesApprovedTraining."Shortcut Dimension 3 Code":=HRTrainingNeedsLine."Shortcut Dimension 3 Code";
             EmployeesApprovedTraining."Shortcut Dimension 4 Code":=HRTrainingNeedsLine."Shortcut Dimension 4 Code";
             EmployeesApprovedTraining."Shortcut Dimension 5 Code":=HRTrainingNeedsLine."Shortcut Dimension 5 Code";
             EmployeesApprovedTraining."Shortcut Dimension 6 Code":=HRTrainingNeedsLine."Shortcut Dimension 6 Code";
             EmployeesApprovedTraining."Shortcut Dimension 7 Code":=HRTrainingNeedsLine."Shortcut Dimension 7 Code";
             EmployeesApprovedTraining."Shortcut Dimension 8 Code":=HRTrainingNeedsLine."Shortcut Dimension 8 Code";
             EmployeesApprovedTraining.Insert;
           until HRTrainingNeedsLine.Next = 0;
         end;
         until HRTrainingNeedsHeader.Next =0;
        end;
    end;

    procedure ValidateTrainingDetails(TrainingApplications: Record "HR Training Applications")
    var
        TrainingApplications2: Record "HR Training Applications";
        TrainingAttendees: Record "HR Training Attendees";
        HREmployee: Record Employee;
    begin
        case TrainingApplications."Type of Training" of
          TrainingApplications."Type of Training"::"Group Training":
            begin
              TrainingGroups.Reset;
              TrainingGroups.SetRange("Training Group App. No.",TrainingApplications."No.");
              if TrainingGroups.FindFirst then begin
                LoadTrainingAttendeesfromTrainingGroups(TrainingApplications);
                ModifyTrainingApplication(TrainingApplications);
              end;
            end;
        end;

        case TrainingApplications."Type of Training" of
          TrainingApplications."Type of Training"::"Individual Training":
            begin
              TrainingAttendees.Reset;
              TrainingAttendees.SetRange("Application No.",TrainingApplications."Application No.");
              if TrainingAttendees.FindSet then
              TrainingAttendees.DeleteAll;

              TrainingApplications2.Reset;
              TrainingApplications2.SetRange("Application No.",TrainingApplications."Application No.");
              if TrainingApplications2.FindFirst then begin
                if HREmployee.Get(TrainingApplications."No.") then
                  TrainingAttendees.Init;
                  TrainingAttendees."Application No.":=TrainingApplications2."Application No.";
                  TrainingAttendees."Employee No":=TrainingApplications2."Employee No.";
                  TrainingAttendees."Employee Name":=TrainingApplications2."Employee Name";
                  TrainingAttendees."Job Title":=HREmployee.Title;
                  TrainingAttendees."Phone Number":=HREmployee."Phone No.";
                  TrainingAttendees."E-mail Address":=HREmployee."Company E-Mail";
                  TrainingAttendees.Insert;
              end;
            end;
        end;
    end;

    procedure ModifyTrainingApplication(TrainingApplications: Record "HR Training Applications")
    var
        TrainingApplications2: Record "HR Training Applications";
    begin
        TrainingApplications2.Reset;
        TrainingApplications2.SetRange("Application No.",TrainingApplications."Application No.");
        if TrainingApplications2.FindFirst then begin
          TrainingApplications2.Name:=TrainingGroups."Training Group Name";
         // MESSAGE(TrainingApplications2.Name);
          TrainingApplications2."Calendar Year":=TrainingGroups."Calendar Year";
          TrainingApplications2.Description:=TrainingGroups."Training Needs Description";
          TrainingApplications2."Development Need":=TrainingGroups."Development Need";
          TrainingApplications2."Purpose of Training":=TrainingGroups.Objective;
          TrainingApplications2."From Date":=TrainingGroups."From Date";
          TrainingApplications2."To Date":=TrainingGroups."To Date";
          TrainingApplications2.Modify;
        end;
    end;
}

