page 50346 "Inspection Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Inspection Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Inspection No"; Rec."Inspection No")
                {
                    Editable = false;
                }
                field("Inspection Date"; Rec."Inspection Date")
                {
                }
                field("Prepared by"; Rec."Prepared by")
                {
                    Editable = false;
                }
                field("Order No"; Rec."Order No")
                {
                }
                field("End User Approval"; Rec."End User Approval")
                {
                    Visible = false;
                }
                field("Commitee Appointment No"; Rec."Commitee Appointment No")
                {
                    Visible = false;
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    Caption = 'Supplier Name/Contractor';
                }
                field("Value of contract"; Rec."Value of contract")
                {
                }
                field("Requisition No"; Rec."Requisition No")
                {
                }
                field("Procuring Department"; Rec."Procuring Department")
                {
                }
                field("Procuring Department Name"; Rec."Procuring Department Name")
                {
                }
                field("Requisitioned By"; Rec."Requisitioned By")
                {
                }
                field("Requisitioned By Name"; Rec."Requisitioned By Name")
                {
                }
                field("Ref No"; Rec."Ref No")
                {
                    Visible = false;
                }
                field("Ref No From Appointment Letter"; Rec."Ref No From Appointment Letter")
                {
                    Visible = false;
                }
                field("Date of Appointment Letter"; Rec."Date of Appointment Letter")
                {
                    Visible = false;
                }
                field("Contract Title"; Rec."Contract Title")
                {
                }
                field("Date of Contract"; Rec."Date of Contract")
                {
                }
                field("Contract Delivery Due Date"; Rec."Contract Delivery Due Date")
                {
                }
                field("Actual Delivery Date"; Rec."Actual Delivery Date")
                {
                }
                field("Tender No"; Rec."Tender No")
                {
                }
                field("Tender Name"; Rec."Tender Name")
                {
                }
                field(Conclusion; Rec.Conclusion)
                {
                }
                field("Patriculars of the Invoice"; Rec."Patriculars of the Invoice")
                {
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                }
                field("Delivery No"; Rec."Delivery No")
                {
                }
                field("Rejection Reason"; Rec."Rejection Reason")
                {
                    Caption = 'Inspection Committee Minutes';
                    Visible = false;
                }
            }
            part("Inspection Lines"; "Inspection Lines Subform")
            {
                Caption = 'Inspection Lines';
                SubPageLink = "Inspection No" = FIELD("Inspection No");
                ApplicationArea = All;
            }
            part(Control5; "Commitee Members Subform")
            {
                SubPageLink = "Appointment No" = FIELD("Inspection No");
                ApplicationArea = All;
            }

        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action("Forward to Chair for Approval")
                {
                    Caption = 'Forward to Chair for Approval';
                    Image = Approval;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin

                        Rec.TestField("Order No");
                        Rec.TestField("Commitee Appointment No");

                        if Confirm(StrSubstNo('Do you want to forward %1 to the Inspection Chair for Approval?', Rec."Inspection No"), true) then begin
                            Rec.Status := Rec.Status::"Pending Approval";
                            Message('The Inspection %1 has been sent to Inspection Chair', Rec."Inspection No");
                            Rec.Modify;
                            CurrPage.Close;
                        end;
                    end;
                }
                action("Cancel Request for Approval")
                {
                    Caption = 'Cancel Request for Approval';
                    Visible = false;

                    trigger OnAction()
                    begin

                        //IF ApprovalMgt.CancelInspectApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
                action("View Order")
                {
                    Caption = 'View Order';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Purchase Order";
                    RunPageLink = "No." = FIELD("Order No");
                    RunPageMode = View;
                }
                action("View Inspection Certificate")
                {
                    Caption = 'View Inspection Certificate';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        Rec.Reset;
                        Rec.SetFilter("Inspection No", Rec."Inspection No");
                        REPORT.Run(50196, true, true, Rec);
                        Rec.Reset;
                    end;
                }
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
                    RunPageLink = "Document No." = FIELD("Inspection No");
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ",Payment,Receipt,Imprest,"Imprest Surrender","Funds Refund",Requisition,"Funds Transfer","HR Document";
                    begin
                        //WorkflowsEntriesBuffer.RunWorkflowEntriesDocumentPage(RECORDID,DATABASE::"Store Requisition Header","No.");
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
                        Rec.TestField(Status, Rec.Status::Open);
                        Rec.TestField("End User Approval");
                        if ApprovalsMgmt.CheckInspectionApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendInspectionForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
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
                        ApprovalsMgmt.OnCancelInspectionApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RECORDID);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
        /*CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(RECORDID);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
        */

    end;

    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
        ApprovalEntry: Record "Approval Entry";
        ProcurementWorkflowEvents: Codeunit "Procurement Workflow Events";

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        /*HasIncomingDocument := "Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabled := (NOT HasIncomingDocument) AND ("No." <> '');
        */
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);

    end;
}

