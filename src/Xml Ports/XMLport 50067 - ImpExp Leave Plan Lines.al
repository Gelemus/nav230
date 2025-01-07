xmlport 50067 "Imp/Exp Leave Plan Lines"
{
    // FieldDelimiter = '<None>';
    // FieldSeparator = '<TAB>';
    Format = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(HRLeavePlanLine)
        {
            tableelement("HR Leave Planner Line";"HR Leave Planner Line")
            {
                XmlName = 'HRLeavePlanLine';
                fieldelement(VLeavePlannerNo;"HR Leave Planner Line"."Leave Planner No.")
                {
                }
                fieldelement(VStartDate;"HR Leave Planner Line"."Start Date")
                {
                }
                fieldelement(VEndDate;"HR Leave Planner Line"."End Date")
                {
                }
                fieldelement(VSubstituteNo;"HR Leave Planner Line"."Reliever No.")
                {
                }
                fieldelement(VSubstituteName;"HR Leave Planner Line"."Reliever Name")
                {
                }
                fieldelement(VNoofDays;"HR Leave Planner Line"."No. of Days")
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

