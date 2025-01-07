page 50819 "Tender Card II."
{
    PageType = Card;
    SourceTable = "Tender Header";
    SourceTableView = WHERE("Document Type" = CONST("Open Tender"));

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
                field("Tender Description"; Rec."Tender Description")
                {
                    MultiLine = true;
                    ShowMandatory = true;
                }
                field("Purchase Requisition"; Rec."Purchase Requisition")
                {
                }
                field("Purchase Req. Description"; Rec."Purchase Req. Description")
                {
                }
                field("Tender Submission (From)"; Rec."Tender Submission (From)")
                {
                }
                field("Tender Submission (To)"; Rec."Tender Submission (To)")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Held By"; Rec."Held By")
                {
                }
                field("Tender Closing Date"; Rec."Tender Closing Date")
                {
                }
                field("Award Date"; Rec."Award Date")
                {
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                }
                field("Tender Status"; Rec."Tender Status")
                {
                    Editable = false;
                }
                field("Approval Status"; Rec.Status)
                {
                    Editable = false;
                }
            }
            part(Control8; "Tender Evaluators")
            {
            }
            part(Control11; "Supplier Profile Document")
            {
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
        }
    }

    actions
    {
        area(processing)
        {
            action("Tender Required Attachments")
            {
                Image = ApprovalSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Posted Ndovu Pay Card";
            }
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

                    Rec."Tender Status" := Rec."Tender Status"::Closed;

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
            action("Send To Tender Open. Committee")
            {
                Caption = 'Send to Tender Opening committee';
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
                    Rec.TestField("Supplier Category");
                    Rec.TestField(Status, Rec.Status::Approved);

                    //Check required documents attached.
                    ProcurementUploadDocuments.Reset;
                    ProcurementUploadDocuments.SetRange(ProcurementUploadDocuments.Type, ProcurementUploadDocuments.Type::Tender);
                    ProcurementUploadDocuments.SetRange(ProcurementUploadDocuments."Tender Stage", ProcurementUploadDocuments."Tender Stage"::"Tender Preparation");
                    if ProcurementUploadDocuments.FindSet then begin
                        repeat
                            VendorRequiredDocuments.Reset;
                            VendorRequiredDocuments.SetRange(VendorRequiredDocuments.Code, Rec."No.");
                            VendorRequiredDocuments.SetRange(VendorRequiredDocuments."Document Code", ProcurementUploadDocuments."Document Code");
                            if VendorRequiredDocuments.FindFirst then begin
                                if not VendorRequiredDocuments.HasLinks then begin
                                    Error(ProcurementUploadDocuments."Document Code" + ' has not been attached. This is a required document.');
                                    break;
                                    exit;
                                end;
                            end else begin
                                Error(ProcurementUploadDocuments."Document Code" + ' has not been attached. This is a required document.');
                                break;
                                exit;
                            end;
                        until ProcurementUploadDocuments.Next = 0;
                    end;


                    Rec."Tender Status" := Rec."Tender Status"::"Tender Opening";
                    Rec."Tender Preparation Approved" := true;
                    if Rec.Modify then begin

                        ProcurementUploadDocuments2.Reset;
                        ProcurementUploadDocuments2.SetRange(ProcurementUploadDocuments2.Type, ProcurementUploadDocuments2.Type::Tender);
                        ProcurementUploadDocuments2.SetRange(ProcurementUploadDocuments2."Tender Stage", ProcurementUploadDocuments2."Tender Stage"::"Tender Opening");
                        if ProcurementUploadDocuments2.FindSet then begin
                            repeat
                                VendorDocs.Init;
                                VendorDocs.Code := Rec."No.";
                                VendorDocs."Document Code" := ProcurementUploadDocuments2."Document Code";
                                VendorDocs."Document Description" := ProcurementUploadDocuments2."Document Description";
                                VendorDocs."Document Attached" := false;
                                VendorDocs.Insert;
                            until ProcurementUploadDocuments2.Next = 0;
                        end;
                    end;

                    Message(TenderOpening);
                    CurrPage.Close;
                end;
            }
            action("Send To Tender Eval. Committee")
            {
                Caption = 'Send to Tender Evaluation committee';
                Image = MoveDown;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField("Purchase Requisition");
                    Rec.TestField("Tender Description");
                    Rec.TestField("Tender Submission (From)");
                    Rec.TestField("Tender Submission (To)");
                    Rec.TestField("Tender Status", Rec."Tender Status"::"Tender Opening");

                    //Check required documents attached.
                    ProcurementUploadDocuments.Reset;
                    ProcurementUploadDocuments.SetRange(ProcurementUploadDocuments.Type, ProcurementUploadDocuments.Type::Tender);
                    ProcurementUploadDocuments.SetRange(ProcurementUploadDocuments."Tender Stage", ProcurementUploadDocuments."Tender Stage"::"Tender Opening");
                    if ProcurementUploadDocuments.FindSet then begin
                        repeat
                            VendorRequiredDocuments.Reset;
                            VendorRequiredDocuments.SetRange(VendorRequiredDocuments.Code, Rec."No.");
                            VendorRequiredDocuments.SetRange(VendorRequiredDocuments."Document Code", ProcurementUploadDocuments."Document Code");
                            if VendorRequiredDocuments.FindFirst then begin
                                if not VendorRequiredDocuments.HasLinks then begin
                                    Error(ProcurementUploadDocuments."Document Code" + ' has not been attached. This is a required document.');
                                    break;
                                    exit;
                                end;
                            end else begin
                                Error(ProcurementUploadDocuments."Document Code" + ' has not been attached. This is a required document.');
                                break;
                                exit;
                            end;
                        until ProcurementUploadDocuments.Next = 0;
                    end;
                    Commit;



                    TenderEvaluators.Reset;
                    TenderEvaluators.SetRange(TenderEvaluators."Tender No", Rec."No.");
                    TenderEvaluators.SetRange(TenderEvaluators."Committee Chairperson", true);
                    if not TenderEvaluators.FindFirst then begin
                        Error(Txt100003);
                    end else begin
                        Rec."Held By" := TenderEvaluators."User ID";
                        Rec."Tender Status" := Rec."Tender Status"::"Tender Evaluation";
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                    end;

                    TenderLines.Reset;
                    TenderLines.SetRange(TenderLines."Document No.", Rec."No.");
                    if TenderLines.FindSet then begin
                        repeat
                            TenderEvaluationResults.Reset;
                            if TenderEvaluationResults.FindLast then
                                TenderEvaluationResults."Line No." := TenderEvaluationResults."Line No." + 1;
                            TenderEvaluationResults."Tender No." := Rec."No.";
                            TenderEvaluationResults."Supplier Name" := TenderLines."Supplier Name";
                            TenderEvaluationResults.Insert;
                        until TenderLines.Next = 0;
                    end;



                    ProcurementUploadDocuments2.Reset;
                    ProcurementUploadDocuments2.SetRange(ProcurementUploadDocuments2.Type, ProcurementUploadDocuments2.Type::Tender);
                    ProcurementUploadDocuments2.SetRange(ProcurementUploadDocuments2."Tender Stage", ProcurementUploadDocuments2."Tender Stage"::"Tender Evaluation");
                    if ProcurementUploadDocuments2.FindSet then begin
                        repeat
                            VendorDocs.Init;
                            VendorDocs.Code := Rec."No.";
                            VendorDocs."Document Code" := ProcurementUploadDocuments2."Document Code";
                            VendorDocs."Document Description" := ProcurementUploadDocuments2."Document Description";
                            VendorDocs."Document Attached" := false;
                            VendorDocs.Insert;
                        until ProcurementUploadDocuments2.Next = 0;
                    end;

                    //ProcurementManagement.SenderTenderEvaluationEmail("No.");
                    Message(TenderEvaluate);
                    CurrPage.Close;
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
                    /*
                    TenderLines.RESET;
                    TenderLines.SETRANGE(TenderLines."Document No.","No.");
                    TenderLines.SETCURRENTKEY(TenderLines."Document No.",TenderLines.to);
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
                    Rec.TestField(Status, Rec.Status::Approved);
                    Rec.TestField("Tender Status", Rec."Tender Status"::"Tender Evaluation");
                    if Confirm(Txt060) = false then exit;

                    ContractSetup.Get;

                    Contract.Reset;
                    Contract.SetRange(Contract.Type, Contract.Type::Procurement);
                    Contract.SetRange(Contract."Contract Link", Rec."No.");
                    if Contract.FindFirst then begin
                        Error(Contractexist);
                    end;

                    TempContract.Init;
                    TempContract."Request No." := NoSeriesMgt.GetNextNo(ContractSetup."Contract Request Nos", 0D, true);
                    TempContract."Document Date" := Today;
                    TempContract."Contract Link" := Rec."No.";
                    TempContract.Type := TempContract.Type::Procurement;
                    TempContract.Description := Rec."Tender Description";
                    TempContract."User ID" := UserId;
                    TempContract.Insert;
                    Message(ContractCreated);
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
            action("Tender Evaluation Result")
            {
                Caption = 'Tender Evaluation Results';
                Image = QuestionaireSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Tender Evaluation Results";
                RunPageLink = "Tender No." = FIELD("No.");
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
                    end;
                }
                action(Release)
                {
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        ProcurementApprovalWorkflow.ReleaseTenderHeader(Rec);
                    end;
                }
                action(Reopen)
                {
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        ProcurementApprovalWorkflow.ReopenTenderHeader(Rec);
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
                        Rec.TestField("Supplier Category");
                        Rec.TestField("Tender Description");
                        Rec.TestField("Purchase Requisition");
                        Rec.TestField("Tender Submission (From)");
                        Rec.TestField("Tender Submission (To)");


                        if Rec."Tender Status" = Rec."Tender Status"::"Tender Preparation" then begin
                            //Check required documents attached.
                            ProcurementUploadDocuments.Reset;
                            ProcurementUploadDocuments.SetRange(ProcurementUploadDocuments.Type, ProcurementUploadDocuments.Type::Tender);
                            ProcurementUploadDocuments.SetRange(ProcurementUploadDocuments."Tender Stage", ProcurementUploadDocuments."Tender Stage"::"Tender Preparation");
                            if ProcurementUploadDocuments.FindSet then begin
                                repeat
                                    VendorRequiredDocuments.Reset;
                                    VendorRequiredDocuments.SetRange(VendorRequiredDocuments.Code, Rec."No.");
                                    VendorRequiredDocuments.SetRange(VendorRequiredDocuments."Document Code", ProcurementUploadDocuments."Document Code");
                                    if VendorRequiredDocuments.FindFirst then begin
                                        if not VendorRequiredDocuments.HasLinks then begin
                                            Error(ProcurementUploadDocuments."Document Code" + ' has not been attached. This is a required document.');
                                            break;
                                            exit;
                                        end;
                                    end else begin
                                        Error(ProcurementUploadDocuments."Document Code" + ' has not been attached. This is a required document.');
                                        break;
                                        exit;
                                    end;
                                until ProcurementUploadDocuments.Next = 0;
                            end;
                        end;

                        if Rec."Tender Status" = Rec."Tender Status"::"Tender Evaluation" then begin
                            //Check required documents attached.
                            ProcurementUploadDocuments.Reset;
                            ProcurementUploadDocuments.SetRange(ProcurementUploadDocuments.Type, ProcurementUploadDocuments.Type::Tender);
                            ProcurementUploadDocuments.SetRange(ProcurementUploadDocuments."Tender Stage", ProcurementUploadDocuments."Tender Stage"::"Tender Evaluation");
                            if ProcurementUploadDocuments.FindSet then begin
                                repeat
                                    VendorRequiredDocuments.Reset;
                                    VendorRequiredDocuments.SetRange(VendorRequiredDocuments.Code, Rec."No.");
                                    //MESSAGE(VendorRequiredDocuments.Code);
                                    //  ERROR("No.");
                                    VendorRequiredDocuments.SetRange(VendorRequiredDocuments."Document Code", ProcurementUploadDocuments."Document Code");
                                    if VendorRequiredDocuments.FindFirst then begin
                                        if not VendorRequiredDocuments.HasLinks then begin
                                            Error(ProcurementUploadDocuments."Document Code" + ' has not been attached. This is a required document.');
                                            break;
                                            exit;
                                        end;
                                    end else begin
                                        Error(ProcurementUploadDocuments."Document Code" + ' has not been attached. This is a required document.');
                                        break;
                                        exit;
                                    end;
                                until ProcurementUploadDocuments.Next = 0;
                            end;
                        end;

                        if ApprovalsMgmt.CheckTenderHeaderApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendTenderHeaderForApproval(Rec);

                        Commit;
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
                        ApprovalsMgmt.OnCancelTenderHeaderApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);

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

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Type" := Rec."Document Type"::"Open Tender";
    end;

    var
        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
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
        NoSeriesMgt: Codeunit NoSeriesManagement;
        TenderClosed: Label 'Tender Successfully Closed';
        TenderEvaluate: Label 'Tender successfully Now Under Tender Evaluation Committee';
        Txt060: Label 'Are you sure you want to make contract request for this tender document?';
        Txt061: Label 'Are you sure you want to close this tender?';
        Contractexist: Label 'There exists a contract in relation to this tender';
        ContractCreated: Label 'Contract request successfully created. Proceed to the contract application and send to Legal Department';
        ProcurementUploadDocuments: Record "Procurement Upload Documents";
        VendorRequiredDocuments: Record "Vendor Required Documents";
        TenderOpening: Label 'Tender successfully Now Under Tender Opening Committee';
        VendorDocs: Record "Vendor Required Documents";
        ProcurementUploadDocuments2: Record "Procurement Upload Documents";
        TenderEvaluators: Record "Tender Evaluators";
        Txt100003: Label 'You must elect a chaiperson for the evaluation committee!';
        TenderEvaluationResults: Record "Tender Evaluation Results";
        ApprovalEditable: Boolean;
        ContractGroup: Record "Contract Group";
        ContractSetup: Record "Contract Setup";
        TempContract: Record "Contract Request Header";
        Contract: Record "Contract Request Header";
}

