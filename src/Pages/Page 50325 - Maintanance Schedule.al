page 50325 "Maintanance Schedule"
{
    DeleteAllowed = false;
    Editable = false;
    SourceTable = "Maintanance and Repair";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Date of Service"; Rec."Date of Service")
                {
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                }
                field("Vehicle Description"; Rec."Vehicle Description")
                {
                }
                field("Actual Mileage KM"; Rec."Actual Mileage KM")
                {
                }
                field("Service Mileage KM"; Rec."Service Mileage KM")
                {
                }
                field("Next Service Mileage KM"; Rec."Next Service Mileage KM")
                {
                }
                field("Type of Service Carried A,B,C,"; Rec."Type of Service Carried A,B,C,")
                {
                }
                field("Remarks/service done"; Rec."Remarks/service done")
                {
                }
                field("Driver No"; Rec."Driver No")
                {
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

