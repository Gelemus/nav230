xmlport 50134 "Attendance Export"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(AttendanceRoot)
        {
            tableelement("Attendance Punches";"Attendance Punches")
            {
                XmlName = 'Attendance';
                fieldelement(No;"Attendance Punches".No)
                {
                }
                fieldelement(EmployeeNo;"Attendance Punches"."Employee No")
                {
                }
                fieldelement(EmployeeName;"Attendance Punches"."Employee Name")
                {
                }
                fieldelement(Time;"Attendance Punches"."String Time")
                {
                }
                fieldelement(WorkStatus;"Attendance Punches"."Work Status")
                {
                }
                fieldelement(TerminalName;"Attendance Punches"."Terminal Name")
                {
                }
                fieldelement(TerminalNo;"Attendance Punches"."Terminal No")
                {
                }
                fieldelement(TerminalLocation;"Attendance Punches"."Terminal Location")
                {
                }
                fieldelement(AttendanceStatus;"Attendance Punches"."Attendance Status")
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

