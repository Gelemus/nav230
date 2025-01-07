page 50783 "Status Casual Payment List"
{
    CardPageID = "Casuals Payment Card Status";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Imprest Header";
    SourceTableView = SORTING("No.")
                      ORDER(Descending)
                      WHERE("Document Type" = FILTER("Casuals Payment"),
                            Status = FILTER(<> Open));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Casual Requisition"; Rec."Casual Requisition")
                {
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
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the field name';
                }
                field("HR Job Grade"; Rec."HR Job Grade")
                {
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
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
                    Editable = false;
                    ToolTip = 'Specifies the field name';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
                field("Total Amount"; Rec."Total Amount")
                {
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Posted By"; Rec."Posted By")
                {
                }
                field(Surrendered; Rec.Surrendered)
                {
                }
                field("Surrender status"; Rec."Surrender status")
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
                Visible = ShowWorkflowStatus;
            }
            systempart(Control24; Links)
            {
                Visible = false;
            }
            systempart(Control23; Notes)
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
                    UserSetup.SetRange(UserSetup."User ID", Rec."User ID");
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
                PromotedCategory = Process;
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
            }
            group(Approval)
            {
                Caption = 'Approval';
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
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        //UserSetup.GET(USERID);
        //IF NOT UserSetup."View Imprest"  THEN
        //SETFILTER("User ID",UserSetup."User ID");
        //SETRANGE("User ID",USERID);
    end;

    var
        ImprestHeader: Record "Imprest Header";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
        UserSetup: Record "User Setup";
        Fundmanagement: Codeunit "Funds Management";
        FundsApprovalManager: Codeunit "Funds Approval Manager";
        FundUserSetup: Record "Funds User Setup";
        UserAccountNotSetup: Label 'User Account %1 is not Setup for Imprest Posting, Contact the System Administrator';
        Txt_002: Label 'There is an open imprest document under your name, use it before you create a new one';
        TEXT_003: Label 'Document Successfully Re-opened';

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

