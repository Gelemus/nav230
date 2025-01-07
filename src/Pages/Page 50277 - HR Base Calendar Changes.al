page 50277 "HR Base Calendar Changes"
{
    Caption = 'Base Calendar Changes';
    DataCaptionFields = "Base Calendar Code";
    PageType = List;
    SourceTable = "HR Base Calendar Change";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Base Calendar Code"; Rec."Base Calendar Code")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the code of the base calendar in the entry.';
                    Visible = false;
                }
                field("Recurring System"; Rec."Recurring System")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Recurring System';
                    ToolTip = 'Specifies a date or day as a recurring nonworking day.';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the date to change associated with the base calendar in this entry.';
                }
                field(Day; Rec.Day)
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the day of the week associated with this change entry.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies a description of the change in this entry.';
                }
                field(Nonworking; Rec.Nonworking)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Nonworking';
                    ToolTip = 'Specifies that the day is not a working day.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
    }
}

