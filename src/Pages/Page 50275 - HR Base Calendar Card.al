page 50275 "HR Base Calendar Card"
{
    Caption = 'Base Calendar Card';
    PageType = ListPlus;
    SourceTable = "HR Base Calendar";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Code';
                    ToolTip = 'Specifies a code for the base calendar you are setting up.';

                    trigger OnValidate()
                    begin
                        CurrPage.BaseCalendarEntries.PAGE.SetCalendarCode(Rec.Code);
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the name of the base calendar in the entry.';
                }
                field("Customized Changes Exist"; Rec."Customized Changes Exist")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Customized Changes Exist';
                    ToolTip = 'Specifies that the base calendar has been used to create customized calendars.';
                }
            }
            part(BaseCalendarEntries; "HR Base Cal. Entries Subform")
            {
                ApplicationArea = Advanced;
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
        area(navigation)
        {
            group("&Base Calendar")
            {
                Caption = '&Base Calendar';
                Image = Calendar;
                action("&Where-Used List")
                {
                    ApplicationArea = Advanced;
                    Caption = '&Where-Used List';
                    Image = Track;
                    ToolTip = 'View a list of the BOMs that the selected items are components of.';

                    trigger OnAction()
                    var
                        CalendarMgt: Codeunit "Calendar Management";
                        WhereUsedList: Page "Where-Used Base Calendar";
                    begin
                        CalendarMgt.CreateWhereUsedEntries(Rec.Code);
                        WhereUsedList.RunModal;
                        Clear(WhereUsedList);
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("&Maintain Base Calendar Changes")
                {
                    ApplicationArea = Advanced;
                    Caption = '&Maintain Base Calendar Changes';
                    Image = Edit;
                    RunObject = Page "HR Base Calendar Changes";
                    RunPageLink = "Base Calendar Code" = FIELD(Code);
                    ToolTip = 'View or edit a base calendar. You would typically enter any nonworking days that you want to apply to a base calendar that you are setting up, to change their status from working to nonworking. You can also use this window to edit a base calendar that has already been set up.';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CurrPage.BaseCalendarEntries.PAGE.SetCalendarCode(Rec.Code);
    end;
}

