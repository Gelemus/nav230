report 50085 "Allocate Portal Leave Types"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Allocate Portal Leave Types.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {

            trigger OnAfterGetRecord()
            begin
                /*EmployeeLeaveType.RESET;
                IF EmployeeLeaveType.FINDSET THEN
                  EmployeeLeaveType.DELETEALL;*/
                //get current period
                LeavePeriods.Reset;
                LeavePeriods.SetRange(Closed, false);
                if LeavePeriods.FindFirst then
                    CurrentPeriod := LeavePeriods.Code;

                //insert common to both
                LeaveTypes.Reset;
                LeaveTypes.SetRange("Show in Portal", LeaveTypes."Show in Portal"::Yes);
                LeaveTypes.SetRange(Gender, LeaveTypes.Gender::Both);
                if LeaveTypes.FindSet then begin
                    repeat
                        EmployeeLeaveType2.Reset;
                        EmployeeLeaveType2.SetRange("Employee No.", Employee."No.");
                        EmployeeLeaveType2.SetRange("Leave Type", LeaveTypes.Code);
                        if not EmployeeLeaveType2.FindFirst then begin
                            EmployeeLeaveType.Init;
                            EmployeeLeaveType."Employee No." := Employee."No.";
                            EmployeeLeaveType."Leave Type" := LeaveTypes.Code;
                            EmployeeLeaveType.Description := LeaveTypes.Description;
                            EmployeeLeaveType."Current Period" := CurrentPeriod;
                            EmployeeLeaveType.Insert;
                        end;
                    until LeaveTypes.Next = 0;
                end;

                //insert specific to gender
                LeaveTypes.Reset;
                LeaveTypes.SetRange("Show in Portal", LeaveTypes."Show in Portal"::Yes);
                LeaveTypes.SetRange(Gender, Employee.Gender);
                if LeaveTypes.FindSet then begin
                    repeat
                        EmployeeLeaveType2.Reset;
                        EmployeeLeaveType2.SetRange("Employee No.", Employee."No.");
                        EmployeeLeaveType2.SetRange("Leave Type", LeaveTypes.Code);
                        if not EmployeeLeaveType2.FindFirst then begin
                            EmployeeLeaveType.Init;
                            EmployeeLeaveType."Employee No." := Employee."No.";
                            EmployeeLeaveType."Leave Type" := LeaveTypes.Code;
                            EmployeeLeaveType.Description := LeaveTypes.Description;
                            EmployeeLeaveType."Current Period" := CurrentPeriod;
                            EmployeeLeaveType.Insert;
                        end;
                    until LeaveTypes.Next = 0;
                end;

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        LeaveTypes: Record "HR Leave Types";
        EmployeeLeaveType: Record "Employee Leave Type";
        EmployeeLeaveType2: Record "Employee Leave Type";
        LeavePeriods: Record "HR Leave Periods";
        CurrentPeriod: Code[20];
}

