page 50692 "Approved Casuals Payment Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    SourceTable = "Imprest Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Casual Requisition"; Rec."Casual Requisition")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Editable = false;
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
                field(HOD; Rec.HOD)
                {
                    Editable = false;
                }
                field("Area Manager"; Rec."Area Manager")
                {
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                }
                field("Job Specifications"; Rec."Job Specifications")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Date From"; Rec."Date From")
                {
                }
                field("Date To"; Rec."Date To")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = true;
                    ToolTip = 'Specifies the field name';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                }
                field("Project No"; Rec."Project No")
                {
                }
                field("Project Name"; Rec."Project Name")
                {
                }
                field("Total Amount"; Rec."Total Amount")
                {
                }
                field("Pending Approver"; Rec."Pending Approver")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the field name';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Reason for Cancellation"; Rec."Reason for Cancellation")
                {
                }
            }
            group(Payment)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Reference No."; Rec."Reference No.")
                {
                }
                field("Payment Mode"; Rec."Payment Mode")
                {
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {
                }
            }
            part(Control12; "Casuals Daily Wk Line Open")
            {
                Editable = false;
                SubPageLink = "Document No." = FIELD("No."),
                              "Casual Payment" = FILTER(false);
            }
            field("Supervisor Report"; Rec."Supervisor Report")
            {
                Editable = false;
            }
            field("Any Remaining Work"; Rec."Any Remaining Work")
            {
                Editable = false;
            }
            field("Report by Head of Section"; Rec."Report by Head of Section")
            {
                Editable = false;
            }
            field("Report by Head of Department"; Rec."Report by Head of Department")
            {
                Editable = false;
            }
            part(Control8; "Casuals Payment Line")
            {
                SubPageLink = "Document No." = FIELD("No."),
                              "Casual Payment" = FILTER(true);
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
            systempart(Control1; Links)
            {
                Visible = false;
            }
            systempart(Control2; Notes)
            {
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
                    Rec.TestField(Status, Rec.Status::Approved);
                    UserSetup.Reset;
                    UserSetup.SetRange(UserSetup."User ID", UserId);
                    if UserSetup.FindFirst then begin
                        if UserSetup."Reopen Documents" then
                            FundsApprovalManager.ReOpenImprestHeader(Rec);
                    end;
                    Message(TEXT_003);
                end;
            }
            action("Print Casual Payment")
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ImprestHeader.Reset;
                    ImprestHeader.SetRange("No.", Rec."No.");
                    if ImprestHeader.FindFirst then begin
                        REPORT.RunModal(REPORT::"Casual Payment Report", true, false, ImprestHeader);
                    end;
                end;
            }
            action("Cancel ")
            {
                Caption = 'Cancel';
                Image = CancelledEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Cancel Document';

                trigger OnAction()
                begin
                    if (Rec.Status = Rec.Status::Open) or (Rec.Status = Rec.Status::Approved) then begin
                        Rec.TestField("Reason for Cancellation");
                        if Confirm('Are you sure you want to cancel?', true) then begin
                            Rec."Cancelled By" := UserId;
                            Rec."Date Cancelled" := Today;
                            Rec."Time Cancelled" := Time;
                            Rec.Status := Rec.Status::Cancelled;
                            Rec.Modify;
                            Message('Cancelled ;');
                        end;
                    end;
                end;
            }
            group(IncomingDocument)
            {
                Caption = 'Incoming Document';
                Image = Documents;
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
                        HyperLink(PortalSetup."Server File Path" + Rec."Document Name");
                    end;
                }
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
            }
            group(ActionGroup44)
            {
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Approval Entries";
                    RunPageLink = "Document No." = FIELD("No.");
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ",Payment,Receipt,Imprest,"Imprest Surrender","Funds Refund",Requisition,"Funds Transfer","HR Document";
                    begin
                        //WorkflowsEntriesBuffer.RunWorkflowEntriesDocumentPage(RECORDID,DATABASE::"HR Employee Requisitions","No.");
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

                    trigger OnAction()
                    begin
                        FundsManagement.CheckImprestMandatoryFields(Rec, false);
                        if FundsUserSetup.Get(UserId) then begin
                            FundsUserSetup.TestField("Imprest Template");
                            FundsUserSetup.TestField("Imprest Batch");
                            JTemplate := FundsUserSetup."Imprest Template";
                            JBatch := FundsUserSetup."Imprest Batch";
                            FundsManagement.PostImprest2(Rec, JTemplate, JBatch, true);
                        end else begin
                            Error(UserAccountNotSetup, UserId);
                        end;
                    end;
                }
                action("Post Imprest")
                {
                    Caption = 'Post Casual Payment';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction()
                    begin
                        if Rec.Status = Rec.Status::Approved then begin
                            Rec.TestField("Payment Mode");
                            Rec.TestField("Bank Account No.");
                            FundsManagement.CheckImprestMandatoryFields(Rec, true);
                            if FundsUserSetup.Get(UserId) then begin
                                FundsUserSetup.TestField("Imprest Template");
                                FundsUserSetup.TestField("Imprest Batch");
                                JTemplate := FundsUserSetup."Imprest Template";
                                JBatch := FundsUserSetup."Imprest Batch";
                                FundsManagement.PostImprest2(Rec, JTemplate, JBatch, false);
                            end else begin
                                Error(UserAccountNotSetup, UserId);
                            end;
                        end;
                    end;
                }
                action("Post and Print Imprest")
                {
                    Caption = 'Post and Print Casual Payment';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';
                    Visible = false;

                    trigger OnAction()
                    begin
                        FundsManagement.CheckImprestMandatoryFields(Rec, true);
                        "DocNo." := Rec."No.";
                        if FundsUserSetup.Get(UserId) then begin
                            FundsUserSetup.TestField("Imprest Template");
                            FundsUserSetup.TestField("Imprest Batch");
                            JTemplate := FundsUserSetup."Imprest Template";
                            JBatch := FundsUserSetup."Imprest Batch";
                            FundsManagement.PostImprest(Rec, JTemplate, JBatch, false);
                            Commit;
                            ImprestHeader.Reset;
                            ImprestHeader.SetRange("No.", "DocNo.");
                            if ImprestHeader.FindFirst then begin
                                REPORT.RunModal(REPORT::"Imprest Voucher", true, false, ImprestHeader);
                            end;
                        end else begin
                            Error(UserAccountNotSetup, UserId);
                        end;
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

    var
        UserAccountNotSetup: Label 'User Account %1 is not Setup for Imprest Posting, Contact the System Administrator';
        ImprestHeader: Record "Imprest Header";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        FundsManagement: Codeunit "Funds Management";
        UserSetup: Record "User Setup";
        FundsUserSetup: Record "Funds User Setup";
        FundsApprovalManager: Codeunit "Funds Approval Manager";
        TEXT_003: Label 'Document Successfully Re-opened';
        CasulPayemntRec: Record "Imprest Header";
        JTemplate: Code[10];
        JBatch: Code[10];
        "DocNo.": Code[20];

    local procedure SetControlAppearance()
    begin
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabled := (not HasIncomingDocument) and (Rec."No." <> '');

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
    end;
}

