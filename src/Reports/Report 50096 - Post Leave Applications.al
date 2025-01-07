report 50096 "Post Leave Applications"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("HR Leave Application";"HR Leave Application")
        {
            DataItemTableView = WHERE(Status=CONST(Released));

            trigger OnAfterGetRecord()
            begin
                if "HR Leave Application".Status="HR Leave Application".Status::Released then begin
                   HRLeaveManagement.PostLeaveApplication("No.");
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
        HRLeaveManagement: Codeunit "HR Leave Management";
}

