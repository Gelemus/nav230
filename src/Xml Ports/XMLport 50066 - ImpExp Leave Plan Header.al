xmlport 50066 "Imp/Exp Leave Plan Header"
{
    // FieldDelimiter = '<None>';
    // FieldSeparator = '<TAB>';
    Format = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(HRLeavePlannerHeader)
        {
            tableelement("HR Leave Planner Header";"HR Leave Planner Header")
            {
                XmlName = 'HRLeavePlannerHeader';
                fieldelement(VNo;"HR Leave Planner Header"."No.")
                {
                }
                fieldelement(VEmployeeNo;"HR Leave Planner Header"."Employee No.")
                {
                }
                fieldelement(VEmployeeName;"HR Leave Planner Header"."Employee Name")
                {
                }
                fieldelement(VJobNo;"HR Leave Planner Header"."Job No.")
                {
                }
                fieldelement(VJobTitle;"HR Leave Planner Header"."Job Title")
                {
                }
                fieldelement(VJobDescription;"HR Leave Planner Header"."Job Description")
                {
                }
                fieldelement(VJobGrade;"HR Leave Planner Header"."Job Grade")
                {
                }
                fieldelement(VLeaveType;"HR Leave Planner Header"."Leave Type")
                {
                }
                fieldelement(VLeavePeriod;"HR Leave Planner Header"."Leave Period")
                {
                }
                fieldelement(VDescription;"HR Leave Planner Header".Description)
                {
                }
                fieldelement(VGlobalDimension1Code;"HR Leave Planner Header"."Global Dimension 1 Code")
                {
                }
                fieldelement(VGlobalDimension2Code;"HR Leave Planner Header"."Global Dimension 2 Code")
                {
                }
                fieldelement(VShortcutDimension3Code;"HR Leave Planner Header"."Shortcut Dimension 3 Code")
                {
                }
                fieldelement(VShortcutDimension4Code;"HR Leave Planner Header"."Shortcut Dimension 4 Code")
                {
                }
                fieldelement(VShortcutDimension5Code;"HR Leave Planner Header"."Shortcut Dimension 5 Code")
                {
                }
                fieldelement(VShortcutDimension6Code;"HR Leave Planner Header"."Shortcut Dimension 6 Code")
                {
                }
                fieldelement(VShortcutDimension7Code;"HR Leave Planner Header"."Shortcut Dimension 7 Code")
                {
                }
                fieldelement(VShortcutDimension8Code;"HR Leave Planner Header"."Shortcut Dimension 8 Code")
                {
                }
                fieldelement(VResponsibilityCenter;"HR Leave Planner Header"."Responsibility Center")
                {
                }
                fieldelement(VStatus;"HR Leave Planner Header".Status)
                {
                }
                fieldelement(VUserID;"HR Leave Planner Header"."User ID")
                {
                }
                fieldelement(VNoSeries;"HR Leave Planner Header"."No. Series")
                {
                }
                fieldelement(VIncomingDocumentEntryNo;"HR Leave Planner Header"."Incoming Document Entry No.")
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

