page 50706 "Safari Notice Card"
{
    DeleteAllowed = false;
    Editable = true;
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
                field(Designation; Rec.Designation)
                {
                }
                field("Financial Year"; Rec."Financial Year")
                {
                }
                field("Travel Details"; Rec."Travel Details")
                {
                    Caption = 'Purpose of Travel';
                    NotBlank = true;
                    Visible = false;
                }
                field("Type of Request"; Rec."Type of Request")
                {
                    Visible = false;
                }
                field("Reason for Travel"; Rec."Reason for Travel")
                {
                }
                field(Destination; Rec.Destination)
                {
                    Caption = 'Destination/Itinerary';
                    NotBlank = true;
                }
                field("Trip Planned Start Date"; Rec."Trip Planned Start Date")
                {
                }
                field("Trip Planned End Date"; Rec."Trip Planned End Date")
                {
                }
                field("Start Time"; Rec."Start Time")
                {
                    NotBlank = true;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Return Time"; Rec."Return Time")
                {
                    NotBlank = true;
                }
                field("Where Stationed"; Rec."Where Stationed")
                {
                }
                field("Number of Night away"; Rec."Number of Night away")
                {
                }
                field("No. of Personnel"; Rec."No. of Personnel")
                {
                    Caption = 'No. of Employees Travelling';
                    Editable = false;
                    NotBlank = true;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = true;
                }
                field("No. of Approvals"; Rec."No. of Approvals")
                {
                    Editable = false;
                    NotBlank = true;
                    Visible = false;
                }
                field("Private/Public/Official Car"; Rec."Private/Public/Official Car")
                {
                }
                field("Vehicle Allocated"; Rec."Vehicle Allocated")
                {
                    Visible = false;
                }
                field("Vehicle Description"; Rec."Vehicle Description")
                {
                }
                field(Driver; Rec.Driver)
                {
                    Editable = true;
                    NotBlank = true;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    Editable = false;
                    NotBlank = true;
                }
            }
            part(Control1; "Safari Notice Subform")
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
            systempart(Control7; Links)
            {
                Visible = false;
            }
            systempart(Control6; Notes)
            {
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
                        Rec.TestField("Trip Planned Start Date");
                        Rec.TestField("Trip Planned End Date");
                        Rec.TestField("Return Time");
                        Rec.TestField("Start Time");
                        Rec.TestField(Destination);
                        //TESTFIELD("Reason for Travel");

                        if Rec."Trip Planned Start Date" > Rec."Trip Planned End Date" then begin
                            Error('You cannot go to a Trip after the before the Trip Start date');
                        end;
                        ComInfo.Get;
                        // ComInfo.TESTFIELD(ComInfo."HR Support Email");
                        // ComInfo.TESTFIELD(ComInfo."HR Support Email");

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
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
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
                action("Safari Notice Report")
                {
                    Caption = 'Safari Notice Report';
                    Image = Receipt;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Rec.SetRange("Request No.", xRec."Request No.");
                        REPORT.Run(REPORT::"Safari Notice Order", true, true, Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
    end;

    trigger OnInit()
    begin
        Rec."User ID" := UserId;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Safari Notice" := true;
        Rec."Document Type" := Rec."Document Type"::"Safari Notice";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Safari Notice" := true;
        Rec."Document Type" := Rec."Document Type"::"Safari Notice";
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

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin

        // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);

        // WorkflowWebhookMgt.GetCanRequestAndCanCancel(RecordId,CanRequestApprovalForFlow,CanCancelApprovalForFlow);
    end;
}

