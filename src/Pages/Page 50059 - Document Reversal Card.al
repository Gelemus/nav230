page 50059 "Document Reversal Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Document Reversal Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Doc. Posting date"; Rec."Doc. Posting date")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Account No."; Rec."Account No.")
                {
                }
                field("Account Name"; Rec."Account Name")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Reversal Posted"; Rec."Reversal Posted")
                {
                }
                field("Reversal Posted By"; Rec."Reversal Posted By")
                {
                }
                field("Reversal Posting Date"; Rec."Reversal Posting Date")
                {
                }
            }
            part(Control21; "Document Reversal Lines")
            {
                SubPageLink = "No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Preview Posting")
            {
                Caption = 'Preview Posting';
                Image = PreviewChecks;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                trigger OnAction()
                begin
                    if FundsUserSetup.Get(UserId) then begin
                        FundsUserSetup.TestField("Reversal Template");
                        FundsUserSetup.TestField("Reversal Batch");
                        JTemplate := FundsUserSetup."Reversal Template";
                        JBatch := FundsUserSetup."Reversal Batch";
                        FundsManagement.PostDocumentReversal(Rec, JTemplate, JBatch, true);
                    end else begin
                        Error(UserAccountNotSetup, UserId);
                    end;
                end;
            }
            action("Post Reversal")
            {
                Caption = 'Post Reversal';
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                trigger OnAction()
                begin
                    //TESTFIELD(Status,Status::Approved);

                    if FundsUserSetup.Get(UserId) then begin
                        FundsUserSetup.TestField("Reversal Template");
                        FundsUserSetup.TestField("Reversal Batch");
                        JTemplate := FundsUserSetup."Reversal Template";
                        JBatch := FundsUserSetup."Reversal Batch";
                        FundsManagement.PostDocumentReversal(Rec, JTemplate, JBatch, false);
                    end else begin
                        Error(UserAccountNotSetup, UserId);
                    end;
                end;
            }
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Approval Entries";
                    RunPageLink = "Document No." = FIELD("No."),
                                  "Document Type" = FILTER(Payment);
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                        //WorkflowsEntriesBuffer.RunWorkflowEntriesDocumentPage(RECORDID,DATABASE::"Purchase Requisition Header","No.");
                        //WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RECORDID,DATABASE::"Purchase Requisition Header","No.");
                    end;
                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        Rec.TestField("Document No.");
                        Rec.TestField("Document Type");

                        // if ApprovalsMgmt.CheckDocumentReversalApprovalsWorkflowEnabled(Rec) then
                        //   ApprovalsMgmt.OnSendDocumentReversalHeaderForApproval(Rec);

                        CurrPage.Close;
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        Rec.TestField(Status, Rec.Status::"Pending Approval");
                        // ApprovalsMgmt.OnCancelDocumentReversalHeaderApprovalRequest(Rec);
                        // WorkflowWebhookMgt.FindAndCancel(RecordId);

                        //CanCancelApprovalForRecord OR CanCancelApprovalForFlow
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable(false);
    end;

    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        FundsManagement: Codeunit "Funds Management";
        UserSetup: Record "User Setup";
        FundsUserSetup: Record "Funds User Setup";
        JTemplate: Code[30];
        JBatch: Code[30];
        UserAccountNotSetup: Label 'User Account %1 is not Setup for Receipt Posting, Contact the System Administrator';
}

