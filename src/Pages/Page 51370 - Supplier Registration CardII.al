page 51370 "Supplier Registration CardII"
{
    PageType = Card;
    SourceTable = "Tender Header";
    ApplicationArea = All;
    SourceTableView = WHERE("Document Type" = CONST("Registration of Supplier"));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Tender No"; Rec."Tender No")
                {
                    Caption = 'Prequalification Registration  No.';
                }
                field("Tender Description"; Rec."Tender Description")
                {
                    Caption = 'Prequalification Description';
                    MultiLine = true;
                    ShowMandatory = true;
                }
                field("Special Condition"; Rec."Special Condition")
                {
                    Visible = false;
                }
                field("Document Type"; Rec."Document Type")
                {
                }
                field("Financial Year"; Rec."Financial Year")
                {
                }
                field(Eligibility; Rec.Eligibility)
                {
                }
                field("Financial Year Start Date"; Rec."Financial Year Start Date")
                {
                }
                field("Financial Year End Date"; Rec."Financial Year End Date")
                {
                }
                field("Tender Closing Date"; Rec."Tender Closing Date")
                {
                    Caption = 'Prequalification Closing Date';
                }
                field("Tender Closing Time"; Rec."Tender Closing Time")
                {
                    Caption = 'Prequalification Closing Time';
                }
                field("Tender Opening Date"; Rec."Tender Opening Date")
                {
                    Caption = 'Prequalification Opening Date';
                }
                field("Tender Opening Time"; Rec."Tender Opening Time")
                {
                    Caption = 'Prequalification Opening Time';
                }
                field("Supplier Category Description"; Rec."Supplier Category Description")
                {
                    Visible = false;
                }
                field("Supplier Category"; Rec."Supplier Category")
                {
                }
                field("Tender Submission (From)"; Rec."Tender Submission (From)")
                {
                    Caption = 'Prequalification Submission (From)';
                }
                field("Tender Submission (To)"; Rec."Tender Submission (To)")
                {
                    Caption = 'Prequalification Submission (To)';
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Held By"; Rec."Held By")
                {
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    Visible = false;
                }
                field("Award Date"; Rec."Award Date")
                {
                }
                field("Tender Status"; Rec."Tender Status")
                {
                    Caption = 'Prequalification Status';
                    Editable = false;
                    OptionCaption = 'Prequalification Preparation,Prequalification Opening,Prequalification Evaluation, Closed';
                }
                field("Approval Status"; Rec.Status)
                {
                    Editable = false;
                }
            }
            part("Prequalification Registration Line"; "Tender Lines")
            {
                Caption = 'Prequalification Registration Line';
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
            part("Prequalification Registration Evaluators Committee"; "Tender Evaluators")
            {
                Caption = 'Prequalification Registration Evaluators Committee';
                SubPageLink = "Tender No" = FIELD("No.");
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            systempart(Control12; Notes)
            {
            }
            systempart(Control10; Links)
            {
            }
            systempart(Control11; MyNotes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Initiate Evaluation")
            {
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;

                trigger OnAction()
                begin
                    TenderEvaluators.TestField("Committee Chairperson", TenderEvaluators."Committee Chairperson" = true);
                    Rec.TestField("Tender Description");
                    Rec.TestField("Tender Submission (From)");
                    Rec.TestField("Award Date");
                    Rec.TestField("Tender Submission (To)");
                    Rec.TestField("Tender Status", Rec."Tender Status"::"Tender Opening");
                    //Check required documents attached.
                    /*ProcurementUploadDocuments.RESET;
                    ProcurementUploadDocuments.SETRANGE(ProcurementUploadDocuments.Type,ProcurementUploadDocuments.Type::"Supplier Registration");
                    ProcurementUploadDocuments.SETRANGE(ProcurementUploadDocuments."Tender Stage",ProcurementUploadDocuments."Tender Stage"::"Tender Opening");
                    IF ProcurementUploadDocuments.FINDSET THEN BEGIN
                      REPEAT
                        VendorRequiredDocuments.RESET;
                        VendorRequiredDocuments.SETRANGE(VendorRequiredDocuments.Code,"No.");
                        VendorRequiredDocuments.SETRANGE(VendorRequiredDocuments."Document Code",ProcurementUploadDocuments."Document Code");
                        IF VendorRequiredDocuments.FINDFIRST THEN BEGIN
                          IF NOT VendorRequiredDocuments.HASLINKS THEN BEGIN
                            ERROR(ProcurementUploadDocuments."Document Code"+' has not been attached. This is a required document.');
                            BREAK;
                            EXIT;
                          END;
                        END ELSE BEGIN
                            ERROR(ProcurementUploadDocuments."Document Code"+' has not been attached. This is a required document.');
                            BREAK;
                            EXIT;
                        END;
                      UNTIL ProcurementUploadDocuments.NEXT=0;
                    END;
                    COMMIT;
                    
                    
                    
                    TenderEvaluators.RESET;
                    TenderEvaluators.SETRANGE(TenderEvaluators."Tender No","No.");
                    TenderEvaluators.SETRANGE(TenderEvaluators."Committee Chairperson",TRUE);
                    IF NOT TenderEvaluators.FINDFIRST THEN BEGIN
                      ERROR(Txt100003);
                      END ELSE BEGIN
                        "Held By":=TenderEvaluators."User ID";
                        "Tender Status":="Tender Status"::"Tender Evaluation";
                        Status:=Status::Open;
                        MODIFY;
                    END;
                    
                    TenderLines.RESET;
                    TenderLines.SETRANGE(TenderLines."Document No.","No.");
                    IF TenderLines.FINDSET THEN BEGIN
                      REPEAT
                        TenderEvaluationResults.RESET;
                        IF TenderEvaluationResults.FINDLAST THEN
                        TenderEvaluationResults."Line No.":=TenderEvaluationResults."Line No."+1;
                        TenderEvaluationResults."Tender No.":="No.";
                        TenderEvaluationResults."Supplier Name":=TenderLines."Supplier Name";
                        TenderEvaluationResults.INSERT;
                     UNTIL TenderLines.NEXT=0;
                    END;
                    
                    
                    
                    ProcurementUploadDocuments2.RESET;
                    ProcurementUploadDocuments2.SETRANGE(ProcurementUploadDocuments2.Type,ProcurementUploadDocuments2.Type::Tender);
                    ProcurementUploadDocuments2.SETRANGE(ProcurementUploadDocuments2."Tender Stage",ProcurementUploadDocuments2."Tender Stage"::"Tender Evaluation");
                    IF ProcurementUploadDocuments2.FINDSET THEN BEGIN
                      REPEAT
                        VendorDocs.INIT;
                        VendorDocs.Code:="No.";
                        VendorDocs."Document Code":=ProcurementUploadDocuments2."Document Code";
                        VendorDocs."Document Description":=ProcurementUploadDocuments2."Document Description";
                        VendorDocs."Document Attached":=FALSE;
                        VendorDocs.INSERT;
                      UNTIL ProcurementUploadDocuments2.NEXT=0;
                    END;
                    
                    //ProcurementManagement.SenderTenderEvaluationEmail("No.");
                    MESSAGE(TenderEvaluate);
                    CurrPage.CLOSE;
                    */








                    if Confirm('Do you wish to initaite Evaluation for this Tender') then begin
                        Employee.Reset;
                        if Employee.FindFirst then begin
                            Employee.SetRange("No.", Employee."User ID", UserId);
                            Message(EprocurementCodeunit.CreateTenderEvaluations(Rec."No.", Today, Employee."No."));
                        end;
                    end;

                end;
            }
            action("View Evaluations")
            {
                Image = "Page";
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Supplier Evaluation";
                RunPageLink = "Tender No." = FIELD("No.");
            }
            action(Open)
            {
                Caption = 'Open Supplier Registration';
                Image = Certificate;
                Promoted = true;
                PromotedCategory = Category8;

                trigger OnAction()
                begin
                    if Confirm('Do you wish to Open This Prequalification Registration Application') then begin
                        Rec."Tender Opening Date" := Today;
                        Rec."Tender Opening Time" := Time;
                        Rec."Tender Status" := Rec."Tender Status"::"Tender Opening";
                    end;
                end;
            }
            action("Prequalification  Required Attachments")
            {
                Image = ApprovalSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Vendor Required Documents";
                RunPageLink = Code = FIELD("No.");
            }
            action("Purchase Requisition Lines")
            {
                Image = IndentChartOfAccounts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Requisition Line";
                RunPageLink = "Document No." = FIELD("Purchase Requisition");
                Visible = false;
            }
            action("Close Prequalification Registration")
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
            action("Print Registration")
            {
                Caption = 'Print Registration';
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
            action("Send To Registration  Open. Committee")
            {
                Caption = 'Send to Registration Opening committee';
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
                Caption = 'Send to Registration Evaluation committee';
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
                Visible = false;

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
                Visible = false;
            }
            action("Tender Evaluation Result")
            {
                Caption = 'Registration  Evaluation Results';
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
                        /*TESTFIELD("Supplier Category");
                        TESTFIELD("Tender Description");
                        TESTFIELD("Purchase Requisition");
                        TESTFIELD("Tender Submission (From)");
                        TESTFIELD("Tender Submission (To)");*/


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
        Rec."Document Type" := Rec."Document Type"::"Registration of Supplier";
    end;

    var
        Employee: Record Employee;
        TenderLine: Record "Tender Lines";
        SupplierProfile: Record "Supplier Profile";
        Vendors: Record Vendor;
        TenderHeader: Record "Tender Header";
        ClosingTime: DateTime;
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
        TenderLines: Record "Tender Lines";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ProcurementUploadDocuments: Record "Procurement Upload Documents";
        VendorRequiredDocuments: Record "Vendor Required Documents";
        VendorDocs: Record "Vendor Required Documents";
        ProcurementUploadDocuments2: Record "Procurement Upload Documents";
        TenderEvaluators: Record "Tender Evaluators";
        TenderEvaluationResults: Record "Tender Evaluation Results";
        ApprovalEditable: Boolean;
        ContractGroup: Record "Contract Group";
        ContractSetup: Record "Contract Setup";
        TempContract: Record "Contract Request Header";
        Contract: Record "Contract Request Header";
        EprocurementCodeunit: Codeunit "E Procurement Management WS";
        TenderClosed: Label 'Tender Successfully Closed';
        TenderEvaluate: Label 'Supplier  Prequalification  Successfully Sent To  Committee For Evaluation.';
        Txt060: Label 'Are you sure you want to make contract request for this tender document?';
        Txt061: Label 'Are you sure you want to close this tender?';
        Contractexist: Label 'There exists a contract in relation to this tender';
        ContractCreated: Label 'Contract request successfully created. Proceed to the contract application and send to Legal Department';
        TenderOpening: Label 'Tender successfully Now Under Tender Opening Committee';
        Txt100003: Label 'You must elect a chaiperson for the evaluation committee!';
}

