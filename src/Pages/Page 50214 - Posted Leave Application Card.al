page 50214 "Posted Leave Application Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "HR Leave Application";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Printed; Rec.Printed)
                {
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'No.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the Document Date.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the posting Date.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the Employee No.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the Employee Name.';
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    Editable = false;
                    ToolTip = 'Specifies the Leave Type.';
                }
                field("Leave Period"; Rec."Leave Period")
                {
                    Editable = false;
                    ToolTip = 'Specifies the Leave Period.';
                }
                field("Leave Balance"; Rec."Leave Balance")
                {
                    Editable = false;
                    ToolTip = 'Specifies the Leave Balance.';
                }
                field("Leave Start Date"; Rec."Leave Start Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the Leave start Date.';
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    Editable = false;
                    ToolTip = 'Specifies the Days Applied.';
                }
                field("Days Approved"; Rec."Days Approved")
                {
                    ToolTip = 'Specifies the Days approved.';
                }
                field("Leave End Date"; Rec."Leave End Date")
                {
                    ToolTip = 'Specifies the Leave End Date.';
                }
                field("Leave Return Date"; Rec."Leave Return Date")
                {
                    ToolTip = 'Specifies the Leave return date.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                }
                field(HOD; Rec.HOD)
                {
                }
                field("Area Manager"; Rec."Area Manager")
                {
                }
                field(MD; Rec.MD)
                {
                }
                field("Substitute No."; Rec."Substitute No.")
                {
                    ToolTip = 'Specifies the Substitute Employee Number.';
                }
                field("Substitute Name"; Rec."Substitute Name")
                {
                    ToolTip = 'Specifies the Employee Name.';
                }
                field("Substitute No2"; Rec."Substitute No2")
                {
                }
                field("Substitute Name2"; Rec."Substitute Name2")
                {
                }
                field("Substitute No3"; Rec."Substitute No3")
                {
                }
                field("Substitute Name3"; Rec."Substitute Name3")
                {
                }
                field("Reason for Leave"; Rec."Reason for Leave")
                {
                    ToolTip = 'Specifies the reason for Leave.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the status.';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the User ID that created the document.';
                }
            }
        }
        area(factboxes)
        {
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
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
            systempart(Control25; Links)
            {
                Visible = false;
            }
            systempart(Control24; Notes)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Print Leave Application")
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    HRLeaveApplication.Reset;
                    HRLeaveApplication.SetRange(HRLeaveApplication."No.", Rec."No.");
                    if HRLeaveApplication.FindFirst then begin
                        REPORT.RunModal(REPORT::"HR Leave Application Report", true, false, HRLeaveApplication);
                    end;
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
                RunPageLink = "Document No." = FIELD("No.");
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                trigger OnAction()
                var
                    WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ",Payment,Receipt,Imprest,"Imprest Surrender","Funds Refund",Requisition,"Funds Transfer","HR Document";
                begin
                    //WorkflowsEntriesBuffer.RunWorkflowEntriesDocumentPage(RECORDID,DATABASE::"HR Leave Application","No.");
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlappearance;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(Rec.RecordId);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RecordId);
    end;

    var
        OpenLeaveApplicationExist: Label 'Open Leave Application Exists for User ID:%1';
        ReOpenLeaveApplication: Label 'Reopen Leave Application No.%1, the Status will be changed to Open. Continue?';
        ConfirmPostLeaveApplication: Label 'Post Leave Application. Identification Fields and Values, Document No.:%1,  Leave Type:%2, Leave Period:%3. Continue?';
        LeavePostedSuccessfully: Label 'Leave Application No. %1, Posted Successfully.';
        HRLeaveApplication: Record "HR Leave Application";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;

    local procedure SetControlappearance()
    begin
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabled := (not HasIncomingDocument) and (Rec."No." <> '');
    end;
}

