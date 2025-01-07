page 52266 "Overtime applier Card"
{
    DeleteAllowed = false;
    PageType = Card;
    ShowFilter = false;
    SourceTable = "Imprest Header";
    SourceTableView = WHERE(Posted = CONST(false),
                            Type = CONST(Overtime));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    Editable = false;
                }
                field("HR Job Grade"; Rec."HR Job Grade")
                {
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                }
                field("Date From"; Rec."Date From")
                {
                }
                field("Date To"; Rec."Date To")
                {
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = true;
                    ToolTip = 'Specifies the field name';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Editable = true;
                    Visible = true;
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = true;
                    ToolTip = 'Specifies the field name';
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ToolTip = 'Specifies the field name';
                }
            }
            part(Control13; "Overtime Line Approver")
            {
                SubPageLink = "Document No." = FIELD("No.");
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
                Visible = ShowWorkflowStatus;
            }
            systempart(Control26; Links)
            {
                Visible = false;
            }
            systempart(Control20; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
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
                    Rec.TestField(Status, Rec.Status::Approved);
                    UserSetup.Reset;
                    UserSetup.SetRange(UserSetup."User ID", UserId);
                    if UserSetup.FindFirst then begin
                        if UserSetup."Reopen Documents" then
                            FundsApprovalManager.ReOpenImprestHeader(Rec);
                    end;

                    //MESSAGE(TEXT_002);
                end;
            }
            group("Request Approval")
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
                    RunPageLink = "Document Type" = CONST(Imprest),
                                  "Document No." = FIELD("No.");
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                    end;
                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
                    begin
                        Rec.TestField("Global Dimension 1 Code");
                        Rec.TestField(Status, Rec.Status::Open);
                        FundsManagement.CheckImprestMandatoryFields(Rec, false);

                        if ApprovalsMgmt.CheckImprestApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendImprestHeaderForApproval(Rec);
                        CurrPage.Close;
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalsMgmt.OnCancelImprestHeaderApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }
            }
            group(Posting)
            {
                Caption = 'Posting';
                action("Preview Posting")
                {
                    Caption = 'Preview Posting';
                    Image = PreviewChecks;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';
                    Visible = false;

                    trigger OnAction()
                    begin
                        FundsManagement.CheckImprestMandatoryFields(Rec, false);
                        if FundsUserSetup.Get(UserId) then begin
                            FundsUserSetup.TestField("Imprest Template");
                            FundsUserSetup.TestField("Imprest Batch");
                            JTemplate := FundsUserSetup."Imprest Template";
                            JBatch := FundsUserSetup."Imprest Batch";
                            FundsManagement.PostImprest(Rec, JTemplate, JBatch, true);
                        end else begin
                            Error(UserAccountNotSetup, UserId);
                        end;
                    end;
                }
                action("Print Subsistence")
                {
                    Caption = 'Print Subsistence';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        /*ImprestHeader.RESET;
                        ImprestHeader.SETRANGE(ImprestHeader."No.","No.");
                        IF ImprestHeader.FINDFIRST THEN BEGIN
                          REPORT.RUNMODAL(REPORT::"Subsistence Voucher",TRUE,FALSE,ImprestHeader);
                        END;*/

                    end;
                }
            }
            group(IncomingDocument)
            {
                Caption = 'Incoming Document';
                Image = Documents;
                action(IncomingDocCard)
                {
                    ApplicationArea = Suite;
                    Caption = 'View Incoming Document';
                    Enabled = HasIncomingDocument;
                    Image = ViewOrder;
                    ToolTip = 'View any incoming document records and file attachments that exist for the entry or document, for example for auditing purposes';

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        IncomingDocument.ShowCardFromEntryNo(Rec."Incoming Document Entry No.");
                    end;
                }
                action(SelectIncomingDoc)
                {
                    AccessByPermission = TableData "Incoming Document" = R;
                    ApplicationArea = Suite;
                    Caption = 'Select Incoming Document';
                    Image = SelectLineToApply;
                    ToolTip = 'Select an incoming document record and file attachment that you want to link to the entry or document.';

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        Rec.Validate("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument(Rec."Incoming Document Entry No.", Rec.RecordId));
                    end;
                }
                action(IncomingDocAttachFile)
                {
                    ApplicationArea = Suite;
                    Caption = 'Create Incoming Document from File';
                    Ellipsis = true;
                    Enabled = CreateIncomingDocumentEnabled;
                    Image = Attach;
                    ToolTip = 'Create an incoming document from a file that you select from the disk. The file will be attached to the incoming document record.';

                    trigger OnAction()
                    var
                        IncomingDocumentAttachment: Record "Incoming Document Attachment";
                    begin
                        IncomingDocumentAttachment.NewAttachmentFromImprestDocument(Rec);
                    end;
                }
                action(RemoveIncomingDoc)
                {
                    ApplicationArea = Suite;
                    Caption = 'Remove Incoming Document';
                    Enabled = HasIncomingDocument;
                    Image = RemoveLine;
                    ToolTip = 'Remove any incoming document records and file attachments.';

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        if IncomingDocument.Get(Rec."Incoming Document Entry No.") then
                            IncomingDocument.RemoveLinkToRelatedRecord;
                        Rec."Incoming Document Entry No." := 0;
                        Rec.Modify(true);
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

                        //FileManagement.UploadFile_Imprest(Rec);
                    end;
                }
                action("View Attachement")
                {
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //FileManagement.DownloadFile("Document Path");
                    end;
                }
            }
            group(ActionGroup6)
            {
                action("Check Budget")
                {
                    Caption = 'Check Budget';
                    Image = Balance;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        //FundsManagement.CheckGLBudget(Rec);
                        //MESSAGE('Budget Balance Amount is 23300');
                        //MESSAGE('Budget Balance Amount is %1',
                        //FundsManagement.HrRequestBudgetAmount(Rec."Global Dimension 1 Code",'NORMAL HOLIDAY O/T',Rec."Date From"));
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(Rec.RecordId);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RecordId);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        /*ImprestHeader.RESET;
        ImprestHeader.SETRANGE("User ID",USERID);
        ImprestHeader.SETRANGE(ImprestHeader.Status,ImprestHeader.Status::Open);
        IF ImprestHeader.FINDFIRST THEN BEGIN
          ERROR(TEXT_001);
        END;*/
        Rec.Type := Rec.Type::Overtime;

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
        TEXT_001: Label 'There is an Open Imprest Card Under your name, use it before you create a new one';
        TEXT_002: Label 'Document Successfully Re-opened';
        FileManagement: Codeunit "Fleet Management";

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabled := (not HasIncomingDocument) and (Rec."No." <> '');

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;
}

