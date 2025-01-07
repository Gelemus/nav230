page 50327 "Fuel Filling Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Vehicle Filling";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Filling No"; Rec."Filling No")
                {
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Registration No"; Rec."Registration No")
                {
                    ShowMandatory = true;
                }
                field(Make; Rec.Make)
                {
                    Visible = false;
                }
                field("Transport Type"; Rec."Transport Type")
                {
                }
                field(Type; Rec.Type)
                {
                    ShowMandatory = true;
                    Visible = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ShowMandatory = true;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ShowMandatory = true;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                }
                field("Filling Date"; Rec."Filling Date")
                {
                    ShowMandatory = true;
                }
                field("Voucher No."; Rec."Voucher No.")
                {
                    Caption = 'Receipt No.';
                    ShowMandatory = true;
                }
                field("Kms Covered"; Rec."Kms Covered")
                {
                    ShowMandatory = true;
                    Visible = false;
                }
                field("KM/LT"; Rec."KM/LT")
                {
                    Visible = false;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                }
                field("Other Services"; Rec."Other Services")
                {
                    Editable = true;
                }
                field("Oil Drawn (Litres)"; Rec."Oil Drawn (Litres)")
                {
                }
                field("Others description"; Rec."Others description")
                {
                    Visible = false;
                }
                field("Others Amount"; Rec."Others Amount")
                {
                }
                field("Fueling Officer"; Rec."Fueling Officer")
                {
                    Visible = false;
                }
                field("Previoust Kms"; Rec."Previoust Kms")
                {
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                }
                field(Details; Rec.Details)
                {
                    Visible = false;
                }
                field("Fuel Type"; Rec."Fuel Type")
                {
                }
                field("Cost per Litre"; Rec."Cost per Litre")
                {
                    Editable = false;

                    trigger OnValidate()
                    begin

                        Rec.Amount := Rec."Fuel Drawn (Litres)" * Rec."Cost per Litre";
                    end;
                }
                field("Fuel Drawn (Litres)"; Rec."Fuel Drawn (Litres)")
                {
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec.Amount := Rec."Fuel Drawn (Litres)" * Rec."Cost per Litre";
                    end;
                }
                field("Paraffin (Litres)"; Rec."Paraffin (Litres)")
                {
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field(Remarks; Rec.Remarks)
                {
                    Visible = false;
                }
                field("Reason for Cancellation"; Rec."Reason for Cancellation")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
        }
        area(processing)
        {
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
                    RunPageLink = "Document No." = FIELD("Filling No");
                    RunPageView = ORDER(Descending);
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ",Payment,Receipt,Imprest,"Imprest Surrender","Funds Refund","Purchase Requisition";
                    begin
                        //WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RECORDID,DATABASE::"Payment Header",DocType::Payment,"No.");
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
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Status, Rec.Status::Open);

                        // if ApprovalsMgmt.CheckVehicleFillingApprovalsWorkflowEnabled(Rec) then
                        //   ApprovalsMgmt.OnSendVehicleFillingForApproval(Rec);

                        CurrPage.Close;
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        // ApprovalsMgmt.OnCancelVehicleFillingApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }
                action(Release)
                {
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';
                    Visible = true;

                    trigger OnAction()
                    begin
                        /*UserSetup.RESET;
                        TESTFIELD(Status,Status::Open);
                        TESTFIELD("Total Amount");
                        UserSetup.SETRANGE(UserSetup."User ID",USERID);
                        IF UserSetup.FINDFIRST THEN BEGIN
                         // IF UserSetup. THEN
                          FleetManagementCu.ReleaseVehicleFilling(Rec);
                         // MESSAGE(Txt_003);
                        END;*/
                        if (Rec.Status = Rec.Status::Open) then begin
                            Rec.TestField("Total Amount");
                            if Confirm('Are you sure you want to Release?', true) then begin
                                /* "Cancelled By" :=USERID;
                                 "Date Cancelled" := TODAY;
                                 "Time Cancelled" := TIME;*/
                                Rec.Status := Rec.Status::Released;
                                Rec.Modify;
                                Message('Reopened successfully');
                            end;
                        end;

                    end;
                }
                action(ReOpen)
                {
                    Caption = 'ReOpen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Released);
                        UserSetup.Reset;
                        UserSetup.SetRange(UserSetup."User ID", UserId);
                        if UserSetup.FindFirst then begin
                            if UserSetup."Reopen Documents" then
                                FleetManagementCu.ReOpenVehicleFIlling(Rec);
                            Message('Reopened successfully');
                            CurrPage.Close;
                        end;
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
                        if (Rec.Status = Rec.Status::Open) or (Rec.Status = Rec.Status::Released) then begin
                            Rec.TestField("Reason for Cancellation");
                            if Confirm('Are you sure you want to cancel?', true) then begin
                                Rec."Cancelled By" := UserId;
                                Rec."Date Cancelled" := Today;
                                Rec."Time Cancelled" := Time;
                                Rec.Status := Rec.Status::Cancelled;
                                Rec.Modify;
                                Message('Cancelled ;');
                            end;
                        end;
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
                    PromotedOnly = true;
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
                    PromotedOnly = true;
                    ToolTip = 'Reject the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
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
                    ToolTip = 'Delegate the requested changes to the substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

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
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

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

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
    end;

    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
        FleetManagementCu: Codeunit "Fleet Approval Manager";
        UserSetup: Record "User Setup";

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
        /*
        IF (Status=Status::Open) OR (Status=Status::"Pending Approval") THEN BEGIN
          PageEditable:=TRUE;
        END ELSE BEGIN
          PageEditable:=FALSE;
        END;
        */

    end;
}

