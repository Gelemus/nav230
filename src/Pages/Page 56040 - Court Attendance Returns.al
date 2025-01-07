page 56040 "Court Attendance Returns"
{
    CardPageID = "Court Attendance Return Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Document registration";
    SourceTableView = WHERE(RegistrationType = CONST(Return));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; Rec."Entry No")
                {
                    Editable = false;
                }
                field("Registration Entry No"; Rec."Registration Entry No")
                {
                }
                field("Case ID"; Rec."Case ID")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Next Court Date"; Rec."Court Date")
                {
                }
                field("Prosecutor No."; Rec."Prosecutor No.")
                {
                }
                field("Next Cause of Action"; Rec."Next Cause of Action")
                {
                }
                field("Court Attendance Date"; Rec."Court Attendance Date")
                {
                    Caption = 'Court Attendance Date';
                }
                field("Start time"; Rec."Start time")
                {
                }
                field("End Time"; Rec."End Time")
                {
                }
                field("Before Type"; Rec."Before Type")
                {
                }
                field("Before Name"; Rec."Before Name")
                {
                }
                field("Date Created"; Rec."Date Created")
                {
                }
                field("Time Created"; Rec."Time Created")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control20; Outlook)
            {
            }
            systempart(Control21; Notes)
            {
            }
            systempart(Control22; Links)
            {
            }
        }
    }

    actions
    {
    }
}

