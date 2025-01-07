page 50787 "Pre-Trip Driver II List"
{
    CardPageID = "Pre-Trip Driver II Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = ListPart;
    SourceTable = "Transport Request";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Driver II Employee No"; Rec."Employee No.")
                {
                    Caption = 'Driver II Employee No';
                }
                field("Driver II Employee Name"; Rec."Employee Name")
                {
                    Caption = 'Driver II Employee Name';
                }
                field("Driver II Start Miles"; Rec."Driver 2 Start Miles")
                {
                    Caption = 'Driver II Start Miles';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Vehicle No"; Rec."Vehicle No")
                {
                }
            }
        }
    }

    actions
    {
    }
}

