page 50662 "Work Ticket Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Work Ticket";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Ticket No"; Rec."Ticket No")
                {
                }
                field("Vehicle No"; Rec."Vehicle No")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Issue Voucher No."; Rec."Issue Voucher No.")
                {
                }
                field("Oil Drawn (Litres)"; Rec."Oil Drawn (Litres)")
                {
                }
                field("Fuel Drawn (Litres)"; Rec."Fuel Drawn (Litres)")
                {
                }
                field("Start Speedometer Reading"; Rec."Start Speedometer Reading")
                {
                }
                field("Last Mileage Reading"; Rec."Last Mileage Reading")
                {
                    Caption = 'Return Mileage Reading';
                }
                field("Kms Covered"; Rec."Kms Covered")
                {
                }
                field("Driver No"; Rec."Driver No")
                {
                }
                field("Driver Name"; Rec."Driver Name")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Registration No"; Rec."Registration No")
                {
                }
                field("Journey Details"; Rec."Journey Details")
                {
                }
                field("Start Time"; Rec."Start Time")
                {
                }
                field("Return TIme"; Rec."Return TIme")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Inspection Remarks"; Rec."Inspection Remarks")
                {
                }
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
                Image = SendApprovalRequest;
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
                    RunPageLink = "Document No." = FIELD("Ticket No");
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                    end;
                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
                    begin
                        if Rec.Status = Rec.Status::Open then begin
                            if ApprovalsMgmt.CheckWorkTicketApprovalsWorkflowEnabled(Rec) then
                                ApprovalsMgmt.OnSendWorkTicketForApproval(Rec);
                        end;

                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalsMgmt.OnCancelWorkTicketApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }
            }
            action("Print Work Ticket")
            {
                Image = PrintChecklistReport;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Clear(WorkTicketRec);
                    WorkTicketRec.Reset;
                    WorkTicketRec.SetRange("Ticket No", Rec."Ticket No");
                    WorkTicket.SetTableView(WorkTicketRec);
                    WorkTicket.Run;
                end;
            }
            action(Close)
            {
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    MileageRegistrationRec: Record "Mileage Registration";
                begin
                    if Confirm('Are you sure you want to close this Ticket?') then begin
                        Rec.TestField("Kms Covered");
                        Rec.TestField("Inspection Remarks");
                        Rec.TestField("Return TIme");
                        Rec.TestField("Last Mileage Reading");
                        /*MileageRegistrationRec.INIT;
                        MileageRegistrationRec."Vehicle No.":="Vehicle No";
                        MileageRegistrationRec."Work Ticket No.":="Ticket No";
                        MileageRegistrationRec.Date:=TODAY;
                        MileageRegistrationRec."Curent Reading":="Last Mileage Reading";
                        MileageRegistrationRec."Previous Reading":="Current Mileage Reading";
                        MileageRegistrationRec."User ID":=USERID;
                        MileageRegistrationRec.INSERT;*/
                        Message('successfully closed');
                        Rec.Status := Rec.Status::Closed;
                        Rec.Modify;
                        CurrPage.Close;
                    end;

                end;
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
                    PromotedOnly = true;
                    Scope = Repeater;
                    ToolTip = 'Approve the requested changes.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                        CurrPage.Close;
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
                    PromotedOnly = true;
                    Scope = Repeater;
                    ToolTip = 'Reject the requested changes.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                        CurrPage.Close;
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    Scope = Repeater;
                    ToolTip = 'Delegate the requested changes to the substitute approver.';
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    RunObject = Page "Requests to Approve";
                    RunPageLink = "Approver ID" = FIELD("User ID");
                    ToolTip = 'View or add comments for the record.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
        }
    }

    var
        WorkTicketRec: Record "Work Ticket";
        WorkTicket: Report "Work Ticket";
        UserSetup: Record "User Setup";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
        FileManagement: Codeunit "File Management Upload";

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        //HasIncomingDocument := "Incoming Document Entry No." <> 0;
        //CreateIncomingDocumentEnabled := (NOT HasIncomingDocument) AND ("No." <> '');

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;
}

