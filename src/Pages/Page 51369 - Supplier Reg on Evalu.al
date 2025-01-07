page 51369 "Supplier Reg on Evalu"
{
    CardPageID = "Supplier Registration Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Tender Header";
    SourceTableView = WHERE("Document Type" = FILTER("Registration of Supplier"),
                            "Tender Status" = FILTER("Tender Evaluation"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Tender Description"; Rec."Tender Description")
                {
                }
                field(Eligibility; Rec.Eligibility)
                {
                }
                field("Tender Submission (From)"; Rec."Tender Submission (From)")
                {
                }
                field("Tender Submission (To)"; Rec."Tender Submission (To)")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Tender Closing Date"; Rec."Tender Closing Date")
                {
                }
                field("Evaluation Date"; Rec."Evaluation Date")
                {
                }
                field("Award Date"; Rec."Award Date")
                {
                }
                field("Supplier Awarded"; Rec."Supplier Awarded")
                {
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                }
                field("Tender Status"; Rec."Tender Status")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control17; Notes)
            {
            }
            systempart(Control18; MyNotes)
            {
            }
            systempart(Control19; Links)
            {
            }
            chartpart("Q9151-01"; "Q9151-01")
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Purchase Requisition Lines")
            {
                Image = IndentChartOfAccounts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Requisition Line";
                RunPageLink = "Document No." = FIELD("Purchase Requisition");
            }
            action("Close Tender")
            {
                Image = "Action";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    Rec.TestField("Purchase Requisition");
                    Rec.TestField("Tender Description");
                    Rec.TestField("Tender Submission (From)");
                    Rec.TestField("Tender Submission (To)");

                    Rec.TestField("Tender Status", Rec."Tender Status"::"Tender Evaluation");

                    if Confirm(Txt061) = false then exit;

                    Rec."Tender Status" := Rec."Tender Status"::"Tender Preparation";

                    Message(TenderClosed);
                end;
            }
            action("Print Tender List")
            {
                Caption = 'Print Tender List';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ToolTip = 'Prepare to print the document. A report request window where you can specify what to include on the print-out.';

                trigger OnAction()
                begin
                    TenderHeader.Reset;
                    TenderHeader.SetRange(TenderHeader."No.", Rec."No.");
                    if TenderHeader.FindFirst then begin
                        REPORT.RunModal(REPORT::"Tender Listing", true, false, TenderHeader);
                    end;
                end;
            }
            action("Send To Tender Committee")
            {
                Image = Migration;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField("Purchase Requisition");
                    Rec.TestField("Tender Description");
                    Rec.TestField("Tender Submission (From)");
                    Rec.TestField("Tender Submission (To)");


                    Rec."Tender Status" := Rec."Tender Status"::"Tender Evaluation";


                    Message(TenderEvaluate);
                end;
            }
            action("Get Awardee")
            {
                Image = Approval;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    /*TenderLines.RESET;
                    TenderLines.SETRANGE(TenderLines."Document No.","No.");
                    TenderLines.SETCURRENTKEY(TenderLines."Document No.",TenderLines."Total Assessment MRKS");
                    TenderLines.SETASCENDING("Total Assessment MRKS",FALSE);
                    IF TenderLines.FINDFIRST THEN
                    BEGIN
                      "Supplier Awarded":=TenderLines."Supplier No.";
                      "Supplier Name":=TenderLines."Supplier Name";
                      MODIFY;
                    END
                    */

                end;
            }
            action("Make Contract Request")
            {
                Image = CalculateDiscount;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    /*
                    TESTFIELD("Tender Status","Tender Status"::"4");
                    IF CONFIRM (Txt060)=FALSE THEN EXIT;
                    ContractSetup.GET;
                    
                    Contract.RESET;
                    Contract.SETRANGE(Contract.Type,Contract.Type::"1");
                    Contract.SETRANGE(Contract."Contract Link","No.");
                    IF Contract.FINDFIRST THEN BEGIN
                      ERROR(Contractexist);
                    END;
                    
                    TempContract.INIT;
                    TempContract."Request No.":=NoSeriesMgt.GetNextNo(ContractSetup."Contract Request Nos",0D,TRUE);
                    TempContract."Document Date":=TODAY;
                    TempContract."Contract Link":="No.";
                    TempContract.Type:=TempContract.Type::"1";
                    TempContract.Description:="Tender Description";
                    TempContract."User ID":=USERID;
                    TempContract.INSERT;
                    MESSAGE(ContractCreated);
                    */

                end;
            }
            action("Contract Request Details")
            {
                Image = Certificate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Contract Request List";
                RunPageLink = "Contract Link" = FIELD("No.");
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
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                        //WorkflowsEntriesBuffer.RunWorkflowEntriesDocumentPage(RECORDID,DATABASE::"Purchase Requisition Header","No.");
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
                    begin
                        //TESTFIELD(Status,Status::Open);
                        //ProcurementManagement.CheckPurchaseRequisitionMandatoryFields(Rec);

                        //IF ApprovalsMgmt.CheckPurchaseRequisitionApprovalsWorkflowEnabled(Rec) THEN
                        //  ApprovalsMgmt.OnSendPurchaseRequisitionForApproval(Rec);
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
                        //ApprovalsMgmt.OnCancelPurchaseRequisitionApprovalRequest(Rec);
                        //WorkflowWebhookMgt.FindAndCancel(RECORDID);

                        //CanCancelApprovalForRecord OR CanCancelApprovalForFlow
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
                        /*IF IncomingDocument.GET("Incoming Document Entry No.") THEN
                          IncomingDocument.RemoveLinkToRelatedRecord;
                        "Incoming Document Entry No." := 0;
                        MODIFY(TRUE);
                        */

                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        //SETRANGE("Held By",USERID);
    end;

    var
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
        TenderHeader: Record "Tender Header";
        TenderLines: Record "Tender Lines";
        TenderClosed: Label 'Tender Successfully Closed';
        TenderEvaluate: Label 'Tender successfully now is under evaluation';
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Txt060: Label 'Are you sure you want to make contract request for this tender document?';
        Txt061: Label 'Are you sure you want to close this tender?';
        Contractexist: Label 'There exists a contract in relation to this tender';
        ContractCreated: Label 'Contract request successfully created. Proceed to the contract application and send to Legal Department';
}

