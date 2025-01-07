page 50411 "Purchase Requisition Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Purchase Requisitions";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique document number for the purchase requisition';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the date when the purchase requisition was created';
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the user expects to receive the items on the purchase requisition';
                }
                field(Budget; Rec.Budget)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Supplimentary; Rec.Supplimentary)
                {
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the currency used for the amounts on the purchase requisition';
                    Visible = false;
                }

                field("Reference Document No."; Rec."Reference Document No.")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                }
                field(HOD; Rec.HOD)
                {
                    Visible = false;
                }
                field("Vendor No"; Rec."Vendor No")
                {
                    Visible = false;
                }
                field(Template; Rec.Template)
                {
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description for the purchase requisition';
                }
                field("Procurement Method"; Rec."Procurement Method")
                {
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the approval status for the purchase requisition';
                }
                field("Amount(LCY)"; Rec."Amount(LCY)")
                {
                }
                field("Reason for Cancellation"; Rec."Reason for Cancellation")
                {
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the user who created the purchase requisition';
                }
            }
            part("Purchase Requisition Line"; "Purchase Requisition Line")
            {
                Caption = 'Purchase Requisition Line';
                SubPageLink = "Document No." = FIELD("No.");
                ToolTip = 'Purchase Requisition Line';
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
            systempart(Control29; Links)
            {
                Visible = false;
            }
            systempart(Control26; Notes)
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
                Visible = false;

                trigger OnAction()
                begin
                    /*TESTFIELD("User ID",USERID);
                    IF CONFIRM(Txt_003,FALSE,"No.") THEN BEGIN
                      ProcurementApprovalWorkflow.ReOpenPurchaseRequisitionHeader(Rec);
                      ApprovalsMgmt.OnCancelPurchaseRequisitionApprovalRequest(Rec);
                      WorkflowWebhookMgt.FindAndCancel(RECORDID);
                    END;*/

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
                            Message('Cancelled Successfully');
                        end;
                    end;
                end;
            }
            action("Create PO")
            {
                Image = CreateDocument;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to create a purchase order from this requisition?') then
                        ProcurementManagement.CreatePurchaseOrder(Rec);
                end;
            }
            action("Requisition Lines Specifications")
            {
                Image = AddWatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Requisition Line";
                RunPageLink = "Document No." = FIELD("No.");
                Visible = false;
            }
            action("Create Imprest Requisition")
            {
                Image = CreateJobSalesInvoice;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    if DIALOG.Confirm('Are you sure you want to create an Imprest Requisition from Purchase Requisition No  %1', true, Rec."No.") then begin
                        PurchaseRequisitionHeader.Reset;
                        PurchaseRequisitionHeader.SetRange("No.", Rec."No.");
                        if PurchaseRequisitionHeader.FindSet then begin
                            FundsSetup.Reset;
                            FundsSetup.Get;

                            ImprestRec.Init;
                            ImprestRec."No." := NoSeriesMgt.GetNextNo(FundsSetup."Imprest Nos.", 0D, true);
                            ImprestRec."No. Series" := FundsSetup."Imprest Nos.";
                            ImprestRec."Document Type" := ImprestRec."Document Type"::Imprest;
                            ImprestRec."Posting Date" := Today;
                            ImprestRec."Date From" := Today;
                            ImprestRec."Date To" := Today;
                            ImprestRec."User ID" := UserId;
                            ImprestRec."Document Date" := Today;
                            ImprestRec.Type := ImprestRec.Type::Imprest;

                            EmployeeRec.Reset;
                            //EmployeeRec.SETRANGE("User ID","User ID");
                            EmployeeRec.SetRange(EmployeeRec."No.", Rec."Employee No.");
                            if EmployeeRec.FindSet then begin
                                ImprestRec."Employee No." := EmployeeRec."No.";
                                ImprestRec."Employee Name" := EmployeeRec."First Name" + ' ' + EmployeeRec."Middle Name" + ' ' + EmployeeRec."Last Name";
                                ImprestRec."Employee Posting Group" := EmployeeRec."Imprest Posting Group";
                                ImprestRec.position := EmployeeRec.Position;
                                ImprestRec."Position Title" := EmployeeRec."Position Title";
                                ImprestRec."Global Dimension 1 Code" := EmployeeRec."Global Dimension 1 Code";
                                ImprestRec."Global Dimension 2 Code" := EmployeeRec."Global Dimension 2 Code";
                                ImprestRec."Phone No." := EmployeeRec."Phone No.";
                                ImprestRec."HR Job Grade" := EmployeeRec."Employee Grade";
                            end;
                            ImprestRec.Description := PurchaseRequisitionHeader.Description;
                            ImprestRec."Purchase Requisition No" := PurchaseRequisitionHeader."No.";
                            ImprestRec.Insert(true);

                            //lines
                            PurchaseReqline.Reset;
                            PurchaseReqline.SetRange("Document No.", PurchaseRequisitionHeader."No.");
                            if PurchaseReqline.FindSet then begin
                                repeat
                                    ImprestLines.Init;
                                    ImprestLines."Document No." := ImprestRec."No.";
                                    ImprestLines."Line No." := PurchaseReqline."Line No.";
                                    ImprestLines."Document Type" := ImprestLines."Document Type"::Imprest;
                                    ImprestLines."Imprest Code" := PurchaseReqline."Requisition Code";
                                    ImprestLines."Imprest Code Description" := PurchaseReqline.Name;
                                    ImprestLines."Account Type" := ImprestLines."Account Type"::"G/L Account";
                                    ImprestLines."Account No." := PurchaseReqline."No.";
                                    ImprestLines."Account Name" := PurchaseReqline.Name;
                                    ImprestLines.Description := PurchaseReqline.Description;
                                    ImprestLines."Posting Date" := Today;
                                    ImprestLines."Net Amount" := PurchaseReqline."Total Cost";
                                    ImprestLines.Quantity := PurchaseReqline.Quantity;
                                    ImprestLines."Unit Amount" := PurchaseReqline."Unit Cost";
                                    ImprestLines."Global Dimension 1 Code" := PurchaseRequisitionHeader."Global Dimension 1 Code";
                                    ImprestLines."Global Dimension 2 Code" := PurchaseRequisitionHeader."Global Dimension 2 Code";
                                    ImprestLines."Employee No" := PurchaseRequisitionHeader."Employee No.";
                                    ImprestLines."Gross Amount" := PurchaseReqline."Total Cost";
                                    ImprestLines."Gross Amount(LCY)" := PurchaseReqline."Total Cost(LCY)";
                                    ImprestLines.Insert(true);
                                until PurchaseReqline.Next = 0;
                            end;
                            //update the requisition to closed
                            PurchaseRequisitionHeader.Status := PurchaseRequisitionHeader.Status::Closed;
                            PurchaseRequisitionHeader.Modify;

                            Message('Imprest Requisition %1 created successfully', ImprestRec."No.");
                            ImprestRec1.Reset;
                            ImprestRec1.SetRange("No.", ImprestRec."No.");
                            PAGE.Run(50023, ImprestRec1);
                            CurrPage.Close();
                        end;
                    end;
                end;
            }
            action("Create Petty Cash Requisition")
            {
                Image = CreateReminders;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    if DIALOG.Confirm('Are you sure you want to create a Petty Cash Requisition from Purchase Requisition No  %1', true, Rec."No.") then begin
                        PurchaseRequisitionHeader.Reset;
                        PurchaseRequisitionHeader.SetRange("No.", Rec."No.");
                        if PurchaseRequisitionHeader.FindSet then begin
                            FundsSetup.Reset;
                            FundsSetup.Get;

                            ImprestRec.Init;
                            ImprestRec."No." := NoSeriesMgt.GetNextNo(FundsSetup."Petty Cash Nos", 0D, true);
                            ImprestRec."No. Series" := FundsSetup."Petty Cash Nos";
                            ImprestRec."Document Type" := ImprestRec."Document Type"::"Petty Cash";
                            ImprestRec."Posting Date" := Today;
                            ImprestRec."Date From" := Today;
                            ImprestRec."Date To" := Today;
                            ImprestRec."User ID" := UserId;
                            ImprestRec."Document Date" := Today;
                            ImprestRec.Type := ImprestRec.Type::"Petty Cash";

                            EmployeeRec.Reset;
                            EmployeeRec.SetRange("User ID", UserId);
                            if EmployeeRec.FindSet then begin
                                ImprestRec."Employee No." := EmployeeRec."No.";
                                ImprestRec."Employee Name" := EmployeeRec."First Name" + ' ' + EmployeeRec."Middle Name" + ' ' + EmployeeRec."Last Name";
                                ImprestRec."Employee Posting Group" := EmployeeRec."Imprest Posting Group";
                                ImprestRec.position := EmployeeRec.Position;
                                ImprestRec."Position Title" := EmployeeRec."Position Title";
                                ImprestRec."Global Dimension 1 Code" := EmployeeRec."Global Dimension 1 Code";
                                ImprestRec."Global Dimension 2 Code" := EmployeeRec."Global Dimension 2 Code";
                                ImprestRec."Phone No." := EmployeeRec."Phone No.";
                                ImprestRec."HR Job Grade" := EmployeeRec."Employee Grade";
                            end;
                            ImprestRec.Description := PurchaseRequisitionHeader.Description;
                            ImprestRec."Purchase Requisition No" := PurchaseRequisitionHeader."No.";
                            ImprestRec.Insert(true);

                            //lines
                            PurchaseReqline.Reset;
                            PurchaseReqline.SetRange("Document No.", PurchaseRequisitionHeader."No.");
                            if PurchaseReqline.FindSet then begin
                                repeat
                                    ImprestLines.Init;
                                    ImprestLines."Document No." := ImprestRec."No.";
                                    ImprestLines."Line No." := PurchaseReqline."Line No.";
                                    ImprestLines."Document Type" := ImprestLines."Document Type"::Imprest;
                                    ImprestLines."Imprest Code" := PurchaseReqline."Requisition Code";
                                    ImprestLines."Imprest Code Description" := PurchaseReqline.Name;
                                    ImprestLines."Account Type" := ImprestLines."Account Type"::"G/L Account";
                                    ImprestLines."Account No." := PurchaseReqline."No.";
                                    ImprestLines."Account Name" := PurchaseReqline.Name;
                                    ImprestLines.Description := PurchaseReqline.Description;
                                    ImprestLines."Posting Date" := Today;
                                    ImprestLines."Net Amount" := PurchaseReqline."Total Cost";
                                    ImprestLines.Quantity := PurchaseReqline.Quantity;
                                    ImprestLines."Unit Amount" := PurchaseReqline."Unit Cost";
                                    ImprestLines."Global Dimension 1 Code" := PurchaseRequisitionHeader."Global Dimension 1 Code";
                                    ImprestLines."Global Dimension 2 Code" := PurchaseRequisitionHeader."Global Dimension 2 Code";
                                    ImprestLines."Employee No" := PurchaseRequisitionHeader."Employee No.";
                                    ImprestLines."Gross Amount" := PurchaseReqline."Total Cost";
                                    ImprestLines."Gross Amount(LCY)" := PurchaseReqline."Total Cost(LCY)";
                                    ImprestLines.Insert(true);
                                until PurchaseReqline.Next = 0;
                            end;
                            //update the requisition to closed
                            PurchaseRequisitionHeader.Status := PurchaseRequisitionHeader.Status::Closed;
                            PurchaseRequisitionHeader.Modify;

                            Message('Petty Cash Requisition %1 created successfully', ImprestRec."No.");
                            ImprestRec1.Reset;
                            ImprestRec1.SetRange("No.", ImprestRec."No.");
                            PAGE.Run(50130, ImprestRec1);
                            CurrPage.Close();
                        end;
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
                    RunPageLink = "Document No." = FIELD("No.");
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
                    Description = 'NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        //ProcurementManagement.CheckPurchaseRequisitionMandatoryFields(Rec);
                        // if ApprovalsMgmt.CheckPurchaseRequisitionApprovalsWorkflowEnabled(Rec) then
                        //   ApprovalsMgmt.OnSendPurchaseRequisitionForApproval(Rec);
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
                    begin
                        // ApprovalsMgmt.OnCancelPurchaseRequisitionApprovalRequest(Rec);
                        // WorkflowWebhookMgt.FindAndCancel(RecordId);

                        //CanCancelApprovalForRecord OR CanCancelApprovalForFlow
                    end;
                }
                action("Budget Committment Lines")
                {
                    Image = BinJournal;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "Budget Committment Lines";
                    RunPageLink = "Document No." = FIELD("No.");
                }
                action("Cancel Transaction")
                {

                    trigger OnAction()
                    begin
                        if Rec.Status = Rec.Status::Open then
                            Rec.Status := Rec.Status::Cancelled;
                    end;
                }
                action("Check Budget Availability")
                {
                    Image = Balance;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        BudgetarySetup.Get;
                        if not BudgetarySetup.Mandatory then
                            exit;

                        if Rec.Status = Rec.Status::Approved then
                            Error(Text001);

                        if CheckIfSomeLinesCommitted(Rec."No.") then begin
                            if not Confirm(Text002, true) then
                                Error(Text003);
                            BudgetCommitment.Reset;
                            BudgetCommitment.SetRange(BudgetCommitment."Document No.", Rec."No.");
                            if BudgetCommitment.FindSet then
                                BudgetCommitment.DeleteAll;
                        end;

                        // Commitment.CheckBudgetPurchaseRequisition(Rec);
                        Message(Text004);
                    end;
                }
                action("Cancel Budget Commitment")
                {
                    Image = CancelAllLines;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if not Confirm(Text005, true) then
                            Error(Text006);

                        /*BudgetCommitment.RESET;
                        BudgetCommitment.SETRANGE(BudgetCommitment."Document No.","No.");
                        BudgetCommitment.DELETEALL;*/

                        Commitment.CancelBudgetCommitmentPurchaseRequisition(Rec);

                        PurchLine.Reset;
                        PurchLine.SetRange(PurchLine."Document No.", Rec."No.");
                        if PurchLine.Find('-') then begin
                            repeat
                                PurchLine.Committed := false;
                                PurchLine.Modify;
                            until PurchLine.Next = 0;
                        end;

                        Message(Text007, Rec."No.");

                    end;
                }
            }
            group("Report")
            {
                Caption = 'Report';
                action("Print Purchase Requisition")
                {
                    Caption = 'Print Purchase Requisition';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ToolTip = 'Prepare to print the document. A report request window where you can specify what to include on the print-out.';

                    trigger OnAction()
                    begin
                        PurchaseRequisitionHeader.Reset;
                        PurchaseRequisitionHeader.SetRange(PurchaseRequisitionHeader."No.", Rec."No.");
                        if PurchaseRequisitionHeader.FindFirst then begin
                            REPORT.RunModal(REPORT::"Purchase Requisition", true, false, PurchaseRequisitionHeader);
                        end;
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
                        //IncomingDocument.ShowCardFromEntryNo("Incoming Document Entry No.");
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
                        //VALIDATE("Incoming Document Entry No.",IncomingDocument.SelectIncomingDocument("Incoming Document Entry No.",RECORDID));
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
                        //IncomingDocumentAttachment.NewAttachmentFromPurchaseRequisitionDocument(Rec);
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
                action(Approve)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Reject the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
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
        /*PurchaseRequisitionHeader.RESET;
        PurchaseRequisitionHeader.SETRANGE("User ID",USERID);
        PurchaseRequisitionHeader.SETRANGE(Status,PurchaseRequisitionHeader.Status::Open);
        IF PurchaseRequisitionHeader.FINDFIRST THEN BEGIN
          ERROR(Txt_002);
        END;
        */
        Rec."Purchase Requisition" := true;

    end;

    var
        Txt_002: Label 'There is an open purchase requisition under your name, use it before you create a new one';
        Txt_003: Label 'Reopen Purchase Requisition No.:%1. All approval requests for this document will be cancelled. Continue?';
        Text001: Label 'This document has already been released. This functionality is available for open documents only';
        Text002: Label 'Some or All the Lines Are already Committed do you want to continue';
        Text003: Label 'Budget Availability Check and Commitment Aborted';
        Text004: Label 'Budget Availability Checking Complete';
        Text005: Label 'Are you sure you want to Cancel All Commitments Done for this document';
        Text006: Label 'Budget Availability Check and Commitment Aborted';
        Text007: Label 'Commitments Cancelled Successfully for Doc. No %1';
        Text008: Label 'Check Budget Availability Before Sending for Approval.';
        Error0001: Label 'Document is under Approval Process, Cancel Approval instead!';
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        ProcurementManagement: Codeunit "Procurement Management";
        ProcurementApprovalWorkflow: Codeunit "Procurement Approval Manager";
        PurchaseRequisitionHeader: Record "Purchase Requisitions";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ",Payment,Receipt,Imprest,"Imprest Surrender","Funds Refund","Purchase Requisition";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
        IsEditable: Boolean;
        BudgetarySetup: Record "Budget Control Setup";
        BudgetCommitment: Record "Budget Committment";
        Commitment: Codeunit "Procurement Management";
        SomeLinesCommitted: Boolean;
        PurchLine: Record "Purchase Requisition Line";
        ImprestRec: Record "Imprest Header";
        ImprestLines: Record "Imprest Line";
        PurchaseReqline: Record "Purchase Requisition Line";
        EmployeeRec: Record Employee;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FundsSetup: Record "Funds General Setup";
        ImprestRec1: Record "Imprest Header";

    procedure CheckIfSomeLinesCommitted(PurchReqNo: Code[20]) SomeLinesCommitted: Boolean
    begin
        SomeLinesCommitted := false;
        PurchLine.Reset;
        PurchLine.SetRange("Document No.", PurchReqNo);
        if PurchLine.FindSet then begin
            repeat
                if PurchLine.Committed = true then
                    SomeLinesCommitted := true;
            until PurchLine.Next = 0;
        end;
    end;

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
