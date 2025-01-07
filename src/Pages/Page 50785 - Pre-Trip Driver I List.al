page 50785 "Pre-Trip Driver I List"
{
    CardPageID = "Pre-Trip Driver I Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = ListPart;
    SourceTable = "Transport Request";
    SourceTableView = WHERE(Status = CONST(Open),
                            "Document Type" = CONST("Pre-Trip"),
                            "Pre-Trip" = FILTER('YES'));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("File No"; Rec."Request No.")
                {
                    Caption = 'File No';
                }
                field("Driver I Employee No"; Rec."Employee No.")
                {
                    Caption = 'Driver I Employee No';
                }
                field("Driver I Employee Name"; Rec."Employee Name")
                {
                    Caption = 'Driver I Employee Name';
                }
                field("Driver I Start Miles"; Rec."Driver 1 Start Miles")
                {
                    Caption = 'Driver I Start Miles';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Vehicle Reg No"; Rec."Vehicle Allocated")
                {
                    Caption = 'Vehicle Reg No';
                }
                field(Status; Rec.Status)
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
            }
        }
    }

    actions
    {
    }
}

