page 50226 "Posted Leave Allocations"
{
    CardPageID = "Posted Leave Allocation Card";
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    ShowFilter = false;
    SourceTable = "HR Leave Allocation Header";
    SourceTableView = WHERE(Status = CONST(Posted));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'No.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the posting Date.';
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ToolTip = 'Specifies the Leave Type.';
                }
                field("Leave Period"; Rec."Leave Period")
                {
                    ToolTip = 'Species the Leave period.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Species the Global Dimension 1 Code.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Species the status.';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Species the User ID that created the document.';
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
            systempart(Control13; Links)
            {
                Visible = false;
            }
            systempart(Control12; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Auto Generate Allocation Lines")
            {
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Auto Generate Leave Allocation Lines based on Employee Default Annual Leave Type';

                trigger OnAction()
                begin
                    Rec.TestField("Leave Type");
                    Rec.TestField("Leave Period");
                    Rec.TestField(Description);
                    if HRLeaveManagement.AutoFillLeaveAllocationLines(Rec."No.") then begin
                        Message(AutoGenerateAllocationLineSuccessful);
                    end;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if HRLeaveManagement.CheckOpenLeaveAllocationExists(UserId) then
            Error(OpenLeaveAllocationExist, UserId);
    end;

    trigger OnOpenPage()
    begin
        //SETRANGE("User ID",USERID);
    end;

    var
        HRLeaveManagement: Codeunit "HR Leave Management";
        AutoGenerateAllocationLineSuccessful: Label 'Leave Allocation Lines Generated Successully';
        OpenLeaveAllocationExist: Label 'Open Leave Allocation Exists for User ID:%1';
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
}

