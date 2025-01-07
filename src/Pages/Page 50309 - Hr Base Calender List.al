namespace spaBC.spaBC;

page 50309 "Hr Base Calender List"
{
    ApplicationArea = All;
    Caption = 'Hr Base Calender List';
    PageType = List;
    CardPageId = "Hr Base Calender";
    SourceTable = "HR Base Calendar";
    UsageCategory = Lists;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
