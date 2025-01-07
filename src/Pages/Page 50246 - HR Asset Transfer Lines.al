page 50246 "HR Asset Transfer Lines"
{
    Caption = 'Asset Transfer Lines';
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "HR Asset Transfer Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Asset No."; Rec."Asset No.")
                {
                }
                field("Asset Tag No."; Rec."Asset Tag No.")
                {
                    Editable = false;
                }
                field("Asset Description"; Rec."Asset Description")
                {
                    Editable = false;
                }
                field("Asset Serial No"; Rec."Asset Serial No")
                {
                    Editable = false;
                }
                field("FA Location"; Rec."FA Location")
                {
                    Editable = false;
                }
                field("New Asset Location"; Rec."New Asset Location")
                {
                }
                field("Responsible Employee Code"; Rec."Responsible Employee Code")
                {
                    Editable = false;
                }
                field("Responsible Employee Name"; Rec."Responsible Employee Name")
                {
                    Editable = false;
                }
                field("New Responsible Employee Code"; Rec."New Responsible Employee Code")
                {
                }
                field("New Responsible Employee Name"; Rec."New Responsible Employee Name")
                {
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Current Region';
                    Editable = false;
                }
                field("New Global Dimension 1 Code"; Rec."New Global Dimension 1 Code")
                {
                    Caption = 'New Region';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Current Department';
                    Editable = false;
                }
                field("New Global Dimension 2 Code"; Rec."New Global Dimension 2 Code")
                {
                    Caption = 'New Department';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Caption = 'Current Station';
                    Editable = false;
                }
                field("New Shortcut Dimension 3 Code"; Rec."New Shortcut Dimension 3 Code")
                {
                    Caption = 'New Station';
                }
            }
        }
    }

    actions
    {
    }
}

