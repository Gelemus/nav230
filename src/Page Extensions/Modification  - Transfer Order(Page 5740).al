pageextension 60423 pageextension60423 extends "Transfer Order"
{

    //Unsupported feature: Property Insertion (DeleteAllowed) on ""Transfer Order"(Page 5740)".

    layout
    {
        modify("No.")
        {
            Editable = false;
        }
        modify("Direct Transfer")
        {
            Visible = false;
        }
    }
    actions
    {

        //Unsupported feature: Code Modification on "Post(Action 66).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CODEUNIT.Run(CODEUNIT::"TransferOrder-Post (Yes/No)",Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CODEUNIT.Run(CODEUNIT::"TransferOrder-Post (Yes/No)",Rec);
        //added on 27/08/2020
        */
        //end;
        addafter("Inventory - Inbound Transfer")
        {
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
                    begin
                        if ApprovalsMgmt.CheckTransferOrderApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendTransferOrderForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalsMgmt.OnCancelTransferOrderApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }
            }
        }
    }
}

