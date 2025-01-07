page 50328 "Fleet Accident Log"
{
    CardPageID = "Fleet Accident Card";
    Editable = false;
    PageType = List;
    SourceTable = "Fleet Accident Log";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Accident No."; Rec."Accident No.")
                {
                }
                field("Accident Description"; Rec."Accident Description")
                {
                }
                field("Fixed Asset No."; Rec."Fixed Asset No.")
                {
                }
                field("Fixed Asset Name"; Rec."Fixed Asset Name")
                {
                }
                field("Date of Accident"; Rec."Date of Accident")
                {
                }
                field("Cause of Accident"; Rec."Cause of Accident")
                {
                }
                field("Damage Description"; Rec."Damage Description")
                {
                }
                field("Total Occupants"; Rec."Total Occupants")
                {
                }
                field("Occupants Injured"; Rec."Occupants Injured")
                {
                }
                field("Occupants Killed"; Rec."Occupants Killed")
                {
                }
                field("Item Class Code"; Rec."Item Class Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}

