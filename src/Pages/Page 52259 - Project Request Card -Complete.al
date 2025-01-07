page 52259 "Project Request Card -Complete"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Transport Request";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                field("Request No."; Rec."Request No.")
                {
                    Caption = 'Project No.';
                    Editable = false;
                }
                field("Project Name"; Rec."Project Name")
                {
                }
                field("Request Date"; Rec."Request Date")
                {
                    Editable = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Editable = true;
                    NotBlank = true;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field("P.Nature of Request"; Rec."P.Nature of Request")
                {
                    Caption = 'Nature of Request';
                }
                field("P.Request Reason"; Rec."P.Request Reason")
                {
                    Caption = 'Request Reason';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Project Description';
                    MultiLine = true;
                }
                field("P.No of Customer to Connect"; Rec."P.No of Customer to Connect")
                {
                    Caption = 'No of Customer to Connect';
                }
                field("P.Ppe Diameter"; Rec."P.Ppe Diameter")
                {
                    Caption = 'Pipe Diameter';
                }
                field("P.No Of Manholes"; Rec."P.No Of Manholes")
                {
                    Caption = 'No Of Manholes';
                }
                field("P.Other Information"; Rec."P.Other Information")
                {
                    Caption = 'Other Information';
                }
                field("P.Job No"; Rec."P.Job No")
                {
                    Caption = 'Job No';
                    Visible = false;
                }
                field("P.Job Name"; Rec."P.Job Name")
                {
                    Caption = 'Job Name';
                    Visible = false;
                }
                field("Supervisor No."; Rec."Supervisor No.")
                {
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
            group(Details)
            {
                Caption = 'Details';
                field("Project Financier"; Rec."Project Financier")
                {
                }
                field(Contractor; Rec.Contractor)
                {
                }
                field("Construction Start date"; Rec."Construction Start date")
                {
                }
                field("Construction Completion date"; Rec."Construction Completion date")
                {
                }
                field("Project Status"; Rec."Project Status")
                {
                }
            }
            part(Control29; "Bill Items Details")
            {
                SubPageLink = "Job ID" = FIELD("Request No.");
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
            systempart(Control12; Links)
            {
                Visible = false;
            }
            systempart(Control13; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Project Life Cycle")
            {
                Caption = 'Project Life Cycle';
                action("Feasiblity Study")
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Feasiblity Study';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Feasiblity Study";
                    RunPageLink = "Project No" = FIELD("Request No.");
                    ToolTip = 'Feasiblity Study';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                    end;
                }
                action("Feasiblity Study - Submitted")
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Feasiblity Study - Submitted';
                    Image = AnalysisView;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Feasiblity Study - Submitted";
                    RunPageLink = "Project No" = FIELD("Request No.");
                    ToolTip = 'Feasiblity Study - Submitted';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                    end;
                }
                action("Concept Design")
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Concept Design';
                    Image = BarChart;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Concept Design";
                    RunPageLink = "Project No" = FIELD("Request No.");
                    ToolTip = 'Concept Design';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                    end;
                }
                action("Concept Design Approved")
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Concept Design Approved';
                    Image = BarCode;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Concept Design Approved";
                    RunPageLink = "Project No" = FIELD("Request No.");
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                    end;
                }
                action("Project Proposal")
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Project Proposal';
                    Image = BeginningText;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Project Proposal";
                    RunPageLink = "Project No" = FIELD("Request No.");
                    ToolTip = 'Project Proposal';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                    end;
                }
                action("Project Proposal -Approved")
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Project Proposal -Approved';
                    Image = BinJournal;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Project Proposal -Approved";
                    RunPageLink = "Project No" = FIELD("Request No.");
                    ToolTip = 'Project Proposal -Approved';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                    end;
                }
                action("Actual Design")
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Actual Design';
                    Image = AvailableToPromise;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Actual Design";
                    RunPageLink = "Project No" = FIELD("Request No.");
                    ToolTip = 'Actual Design';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                    end;
                }
                action("Project Implementation")
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Project Implementation';
                    Image = AlternativeAddress;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Project Implementation";
                    RunPageLink = "Project No" = FIELD("Request No.");
                    ToolTip = 'Project Implementation';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    Enabled = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        ComInfo.Get;
                        // ComInfo.TESTFIELD(ComInfo."HR Support Email");
                        // ComInfo.TESTFIELD(ComInfo."HR Support Email");
                        Rec.TestField(Status, Rec.Status::Open);
                        if ApprovalMgt.CheckTransportRequestApprovalsWorkflowEnabled(Rec) then
                            ApprovalMgt.OnSendTransportRequestForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalMgt.OnCancelTransportRequestApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }
                action(submit)
                {
                    Caption = 'Complete Project';
                    Image = Save;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = true;

                    trigger OnAction()
                    begin
                        //IF Status = Status::Open THEN
                        if Confirm('Are you sure you want to complete the project?') then begin
                            Rec.Status := Rec.Status::Completed;
                            Rec."Project Status" := Rec."Project Status"::Completed;
                            Rec.Modify;
                            Message('Project completed successfully');
                        end;
                    end;
                }
            }
        }
        area(navigation)
        {
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
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
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
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
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
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    ToolTip = 'Create an incoming document from a file that you select from the disk. The file will be attached to the incoming document record.';

                    trigger OnAction()
                    var
                        IncomingDocumentAttachment: Record "Incoming Document Attachment";
                    begin
                        IncomingDocumentAttachment.NewAttachmentFromTransportRequestDocument(Rec);
                    end;
                }
                action(RemoveIncomingDoc)
                {
                    ApplicationArea = Suite;
                    Caption = 'Remove Incoming Document';
                    Enabled = HasIncomingDocument;
                    Image = RemoveLine;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
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
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
        //incoming  document
        //SetControlAppearance;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(Rec.RecordId);
        //ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
    end;

    trigger OnInit()
    begin
        Rec."User ID" := UserId;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Document Type" := Rec."Document Type"::"Project Request";
    end;

    var
        ApprovalMgt: Codeunit "Custom Workflow Mgmt";
        ComInfo: Record "Company Information";
        Hrmail: Text[120];
        Text19003756: Label 'For Official Use Only';
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        //incoming document
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabled := (not HasIncomingDocument) and (Rec."Request No." <> '');
        //end

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;
}

