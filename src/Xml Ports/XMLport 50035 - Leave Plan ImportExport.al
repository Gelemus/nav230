xmlport 50035 "Leave Plan Import/Export"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(LeavePlanroot)
        {
            tableelement("HR Leave Planner Header";"HR Leave Planner Header")
            {
                XmlName = 'LeavePLanHeader';
                fieldelement(No;"HR Leave Planner Header"."No.")
                {
                }
                fieldelement(EmployeeNo;"HR Leave Planner Header"."Employee No.")
                {
                }
                fieldelement(EmployeeName;"HR Leave Planner Header"."Employee Name")
                {
                }
                fieldelement(Description;"HR Leave Planner Header".Description)
                {
                }
                fieldelement(JobTitle;"HR Leave Planner Header"."Job Title")
                {
                }
                fieldelement(Leavetype;"HR Leave Planner Header"."Leave Type")
                {
                }
                fieldelement(GlobalDimension1;"HR Leave Planner Header"."Global Dimension 1 Code")
                {
                }
                fieldelement(GlobalDimension2;"HR Leave Planner Header"."Global Dimension 2 Code")
                {
                }
                fieldelement(ShortcutDimension3;"HR Leave Planner Header"."Shortcut Dimension 3 Code")
                {
                }
                fieldelement(Status;"HR Leave Planner Header".Status)
                {
                }
                fieldelement(JobGrade;"HR Leave Planner Header"."Job Grade")
                {
                }
                fieldelement(Level;"HR Leave Planner Header".Level)
                {
                }
                fieldelement(LeavePeriod;"HR Leave Planner Header"."Leave Period")
                {
                }
                fieldelement(CreatedBy;"HR Leave Planner Header"."Created By Employee")
                {
                }
                fieldelement(Leavebalance;"HR Leave Planner Header"."Leave Balance")
                {
                }
                tableelement("HR Leave Planner Line";"HR Leave Planner Line")
                {
                    LinkFields = "Leave Planner No."=FIELD("No.");
                    LinkTable = "HR Leave Planner Header";
                    XmlName = 'LeavePlannerLine';
                    fieldelement(Month;"HR Leave Planner Line".Month)
                    {
                    }
                    fieldelement(NoofDays;"HR Leave Planner Line"."No. of Days")
                    {
                    }
                    fieldelement(RelieverNo;"HR Leave Planner Line"."Reliever No.")
                    {
                    }
                    fieldelement(RelieverName;"HR Leave Planner Line"."Reliever Name")
                    {
                    }
                    fieldelement(Designation;"HR Leave Planner Line".Designation)
                    {
                    }
                    fieldelement(ReliverLevel;"HR Leave Planner Line".Level)
                    {
                    }
                    fieldelement(RelieverGrade;"HR Leave Planner Line"."Reliever Grade")
                    {
                    }
                    fieldelement(StartDate;"HR Leave Planner Line"."Start Date")
                    {
                    }
                    fieldelement(EndDate;"HR Leave Planner Line"."End Date")
                    {
                    }
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

