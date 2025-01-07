page 50321 "Transport Request Card"
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
                field("Travel Details"; Rec."Travel Details")
                {
                    Caption = 'Purpose of Travel';
                    NotBlank = true;
                }
                field("Type of Request"; Rec."Type of Request")
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
                field("Return Time"; Rec."Return Time")
                {
                    NotBlank = true;
                }
                field("No. of Personnel"; Rec."No. of Personnel")
                {
                    Caption = 'No. of Employees Travelling';
                    Editable = false;
                    NotBlank = true;
                }
                field(Status; Rec.Status)
                {
                    Editable = true;
                }
                field("Classes Of Driving License"; Rec."Classes Of Driving License")
                {
                }
                field("No. of Approvals"; Rec."No. of Approvals")
                {
                    Editable = false;
                    NotBlank = true;
                }
                group("For Official Use")
                {
                    Caption = 'For Official Use';
                    Editable = false;
                    field("Vehicle Allocated"; Rec."Vehicle Allocated")
                    {
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
                    field(Taxi; Rec.Taxi)
                    {
                    }
                    field("Outsourced Vehicle Reg No."; Rec."Outsourced Vehicle Reg No.")
                    {
                    }
                    field("Vehicle Owner"; Rec."Vehicle Owner")
                    {
                    }
                    field("Odometer Reading Before"; Rec."Odometer Reading Before")
                    {
                    }
                    field("Odometer Reading After"; Rec."Odometer Reading After")
                    {
                    }
                }
            }
            part(Control1; "Travelling Employees  Subform")
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

                        // if ApprovalMgt.CheckTransportRequestApprovalsWorkflowEnabled(Rec) then
                        //   ApprovalMgt.OnSendTransportRequestForApproval(Rec);
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
                        // ApprovalMgt.OnCancelTransportRequestApprovalRequest(Rec);
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

    var
        ApprovalMgt: Codeunit "Approvals Mgmt.";
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
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;
}

