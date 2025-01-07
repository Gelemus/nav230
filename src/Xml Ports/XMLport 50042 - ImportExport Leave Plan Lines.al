xmlport 50042 "Import/Export Leave Plan Lines"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(LeavePlanLines)
        {
            tableelement("HR Leave Planner Line";"HR Leave Planner Line")
            {
                XmlName = 'LeavePlanLines';
                fieldattribute("LeavePlanNo.";"HR Leave Planner Line"."Leave Planner No.")
                {
                }
                fieldattribute(StartDate;"HR Leave Planner Line"."Start Date")
                {
                }
                fieldattribute(EndDate;"HR Leave Planner Line"."End Date")
                {
                }
                fieldattribute(NoOfDays;"HR Leave Planner Line"."No. of Days")
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

