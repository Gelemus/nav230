xmlport 50040 "Import & Export Leave Plan"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(LeavePlan)
        {
            tableelement("HR Leave Planner Header";"HR Leave Planner Header")
            {
                XmlName = 'LeavePlan';
                fieldattribute(LeavePlanNo;"HR Leave Planner Header"."No.")
                {
                }
                fieldattribute(EmployeeNo;"HR Leave Planner Header"."Employee No.")
                {
                }
                fieldattribute(EmployeeName;"HR Leave Planner Header"."Employee Name")
                {
                }
                fieldattribute(LeaveType;"HR Leave Planner Header"."Leave Type")
                {
                }
                fieldattribute(LeaveDescription;"HR Leave Planner Header".Description)
                {
                }
            }
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
}

