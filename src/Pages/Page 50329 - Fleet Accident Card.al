page 50329 "Fleet Accident Card"
{
    PageType = Card;
    SourceTable = "Fleet Accident Log";

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Accident No."; Rec."Accident No.")
                {
                    Editable = false;
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
            }
        }
    }

    actions
    {
    }
}

