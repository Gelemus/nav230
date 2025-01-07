page 50788 "Pre-Trip Driver II Card"
{
    DeleteAllowed = false;
    Editable = true;
    PageType = Card;
    SourceTable = "Transport Request";

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
                field("Driver II Employee No"; Rec."Employee No.")
                {
                    Caption = 'Driver II Employee No';
                }
                field("Driver II Employee Name"; Rec."Employee Name")
                {
                    Caption = 'Driver II Employee Name';
                }
                field("Driver II Start Miles"; Rec."Driver 1 Start Miles")
                {
                    Caption = 'Driver II Start Miles';
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
        area(factboxes)
        {
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = Advanced;
                Visible = false;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Advanced;
                ShowFilter = false;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
            }
            systempart(Control15; Links)
            {
                Visible = false;
            }
            systempart(Control14; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

