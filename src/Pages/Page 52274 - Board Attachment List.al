page 52274 "Board Attachment List"
{
    DeleteAllowed = true;
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Board Meeting Attachments";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Meeting No"; Rec."Meeting No")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(FileName; Rec.FileName)
                {
                    Editable = false;
                }
                field(Comments; Rec.Comments)
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(ReOpen)
            {
                Caption = 'ReOpen';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                trigger OnAction()
                begin
                    /*TESTFIELD(Status,Status::Approved);
                    UserSetup.RESET;
                    UserSetup.SETRANGE(UserSetup."User ID",USERID);
                    IF UserSetup.FINDFIRST THEN BEGIN
                      IF UserSetup."Reopen Documents" THEN
                        FundsApprovalManager.ReOpenImprestHeader(Rec);
                    END;
                    MESSAGE(TEXT_003);*/

                end;
            }
            action("Import Attachment")
            {
                Image = UpdateXML;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    FileManagement.UploadFile_BoardAttachment(Rec);
                end;
            }
            action(AttachedDoc)
            {
                ApplicationArea = Suite;
                Caption = 'View  Attached Document';
                Image = ViewOrder;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'View any incoming document records and file attachments that exist for the entry or document, for example for auditing purposes';

                trigger OnAction()
                var
                    IncomingDocument: Record "Incoming Document";
                    PortalSetup: Record "Portal Setup";
                begin
                    //IncomingDocument.ShowCardFromEntryNo("Incoming Document Entry No.");
                    PortalSetup.Get;
                    HyperLink(PortalSetup."Server File Path" + Rec.FileName);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        /*SetControlAppearance;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(RECORDID);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
        */

    end;

    trigger OnOpenPage()
    begin
        //SETRANGE("User ID",USERID);
    end;

    var
        UserAccountNotSetup: Label 'User Account %1 is not Setup for Imprest Posting, Contact the System Administrator';
        FundsManagement: Codeunit "Funds Management";
        UserSetup: Record "User Setup";
        FundsUserSetup: Record "Funds User Setup";
        FundsApprovalManager: Codeunit "Funds Approval Manager";
        JTemplate: Code[10];
        JBatch: Code[10];
        "DocNo.": Code[20];
        ImprestHeader: Record "Imprest Header";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
        Txt_002: Label 'There is an open imprest document under your name, use it before you create a new one';
        TEXT_003: Label 'Document Successfully Re-opened';
        FileManagement: Codeunit "File Management Upload";

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        /*
        HasIncomingDocument := "Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabled := (NOT HasIncomingDocument) AND ("No." <> '');
        
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(RECORDID,CanRequestApprovalForFlow,CanCancelApprovalForFlow);
        */

    end;
}

