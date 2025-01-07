page 50462 "Completed Repair  Card"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = true;
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
                field("Request No."; Rec."Request No.")
                {
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
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
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                }
                field("Supplier No"; Rec."Supplier No")
                {

                    trigger OnValidate()
                    begin
                        Rec."Supplier Name" := FixedAsset.Description;
                    end;
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    Editable = false;
                }
                field("Supplier Address"; Rec."Supplier Address")
                {
                }
                field("Vehicle No"; Rec."Vehicle No")
                {
                }
                field("Vehicle Name"; Rec."Vehicle Name")
                {
                }
                field("Job No"; Rec."Job No")
                {
                    Editable = false;
                }
                field("Motor Vehicle/Motor Cycle"; Rec."Motor Vehicle/Motor Cycle")
                {
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = true;
                }
            }
            part(Control1; "Repair Order Subform")
            {
                SubPageLink = "Request No." = FIELD("Request No.");
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
        }
    }

    actions
    {
        area(processing)
        {
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

                    trigger OnAction()
                    begin
                        /*TESTFIELD("Trip Planned Start Date");
                        TESTFIELD("Trip Planned End Date");
                        TESTFIELD("Return Time");
                        TESTFIELD("Start Time");
                        TESTFIELD(Destination);
                        //TESTFIELD("Reason for Travel");
                        
                        IF "Trip Planned Start Date" > "Trip Planned End Date" THEN BEGIN
                            ERROR('You cannot go to a Trip after the before the Trip Start date');
                        END;*/
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

                    trigger OnAction()
                    var
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalMgt.OnCancelTransportRequestApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }
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
                    RunPageLink = "Document No." = FIELD("Request No.");
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ",Payment,Receipt,Imprest,"Imprest Surrender","Funds Refund","Purchase Requisition";
                    begin
                        //WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RECORDID,DATABASE::"Transport Request",DocType::" ","Request No.");
                    end;
                }
                action(submit)
                {
                    Caption = 'SUBMIT REQUEST';
                    Image = Save;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Rec.Status = Rec.Status::Open then
                            Rec.Status := Rec.Status::Released;
                    end;
                }
                action("Repair Order Report")
                {
                    Caption = 'Repair Order Report';
                    Image = Receipt;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Rec.SetRange("Request No.", xRec."Request No.");
                        REPORT.Run(REPORT::"Repair Order", true, true, Rec);
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
                            ProcurementManagement.CreateServiceOrder(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Repair Order" := true;
        Rec."Document Type" := Rec."Document Type"::"Repair Order";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Repair Order" := true;
        Rec."Document Type" := Rec."Document Type"::"Repair Order";
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
        ProcurementManagement: Codeunit "Procurement Management";
        FixedAsset: Record "Fixed Asset";

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;
}

