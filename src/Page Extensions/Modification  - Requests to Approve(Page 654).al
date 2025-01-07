pageextension 60541 pageextension60541 extends "Requests to Approve"
{



    layout
    {
        addafter(Details)
        {
            field(Remarks; Rec.Remarks)
            {
            }
        }
    }
    actions
    {
        addfirst(Processing)
        {
            action(ApproveRequest)
            {
                ApplicationArea = Suite;
                Caption = 'Approve Request';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = true;
                Visible = true;
                Image = Approve;
                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    IF CONFIRM('Are you sure you want to Approve the Request?', TRUE) THEN BEGIN
                        CurrPage.SetSelectionFilter(ApprovalEntry);
                        ApprovalsMgmt.ApproveApprovalRequests(ApprovalEntry);
                    END;
                end;

            }
            action(RejectRequest)
            {
                ApplicationArea = Suite;
                Caption = 'Reject Request';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = true;
                Visible = true;
                Image = Reject;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    IF not Rec.Comment then begin
                        ERROR('Kindly add a comments');
                    end else
                        IF CONFIRM('Are you sure you want to Reject the Request?', TRUE) THEN BEGIN
                            CurrPage.SetSelectionFilter(ApprovalEntry);
                            ApprovalsMgmt.RejectApprovalRequests(ApprovalEntry);
                        END;
                end;

            }

        }
        modify(Approve)
        {
            Enabled = false;
            Visible = false;

        }
        modify(Reject)
        {
            Enabled = false;
            Visible = false;

        }
    }
}