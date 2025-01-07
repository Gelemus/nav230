namespace spaBC.spaBC;

page 50234 "Hr Base Calender"
{
    ApplicationArea = All;
    Caption = 'Hr Base Calender Card';
    PageType = Card;
    SourceTable = "HR Base Calendar";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies a code for the base calendar you are setting up.';
                }
                field("Customized Changes Exist"; Rec."Customized Changes Exist")
                {
                    ToolTip = 'Specifies that the base calendar has been used to create customized calendars.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the name of the base calendar in the entry.';
                }
            }
        }
    }
}
