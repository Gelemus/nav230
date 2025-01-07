page 50244 "HR Asset Transfer List"
{
    Caption = 'Asset Transfer List';
    CardPageID = "HR Asset Transfer Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "HR Asset Transfer Header";
    SourceTableView = WHERE(Status = FILTER(<> Approved));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Activity Type"; Rec."Activity Type")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Transfer Effected"; Rec."Transfer Effected")
                {
                }
                field("Date Transfered"; Rec."Date Transfered")
                {
                }
                field("Transfered By"; Rec."Transfered By")
                {
                }
                field("Time Posted"; Rec."Time Posted")
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

    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
}

