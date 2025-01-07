page 56042 "CaseFile Movment Registr List"
{
    CardPageID = "Case file Movement register";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Case File Movement Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field("Movement Reason Code"; Rec."Movement Reason Code")
                {
                }
                field("Movement Reason"; Rec."Movement Reason")
                {
                }
                field("Case ID"; Rec."Case ID")
                {
                }
                field("Source Type"; Rec."Source Type")
                {
                }
                field("Source No"; Rec."Source No")
                {
                }
                field("Destination Type"; Rec."Destination Type")
                {
                }
                field("Destination No"; Rec."Destination No")
                {
                }
                field("Transaction Date"; Rec."Transaction Date")
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
            systempart(Control16; Outlook)
            {
            }
            systempart(Control17; Notes)
            {
            }
            systempart(Control18; Links)
            {
            }
        }
    }

    actions
    {
    }
}

