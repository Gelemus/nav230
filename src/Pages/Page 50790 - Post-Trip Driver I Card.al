page 50790 "Post-Trip Driver I Card"
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
            systempart(Control4; Links)
            {
                Visible = false;
            }
            systempart(Control3; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

