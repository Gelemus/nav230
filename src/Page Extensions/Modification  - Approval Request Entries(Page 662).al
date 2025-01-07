pageextension 60546 pageextension60546 extends "Approval Request Entries"
{
    layout
    {

        //Unsupported feature: Property Deletion (Visible) on ""Document No."(Control 6)".
        modify("Document No.")
        {
            Visible = true;
        }

    }
    actions
    {
        addafter("&Delegate")
        {
            action("Approval User Setup")
            {
                AccessByPermission = TableData "Approval Entry" = R;
                ApplicationArea = Suite;
                Caption = 'Approval User Setup';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Approval User Setup";
                RunPageLink = "User ID" = FIELD("Approver ID");
                ToolTip = 'Feasiblity Study';

                trigger OnAction()
                var
                    WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                begin
                end;
            }
        }
    }
}

