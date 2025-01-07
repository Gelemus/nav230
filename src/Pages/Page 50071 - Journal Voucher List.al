page 50071 "Journal Voucher List"
{
    CardPageID = "Journal Voucher";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Journal Voucher Header";
    SourceTableView = WHERE(Status = FILTER(<> Approved));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("JV No."; Rec."JV No.")
                {
                }
                field("Document date"; Rec."Document date")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Date Created"; Rec."Date Created")
                {
                }
                field(Voted; Rec.Voted)
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Posted; Rec.Posted)
                {
                }
            }
        }
        area(factboxes)
        {
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = Advanced;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Advanced;
                ShowFilter = false;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(Control12; Links)
            {
                Visible = false;
            }
            systempart(Control11; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        /*Rec.RESET;
        Rec.SETRANGE("User ID",USERID);
        Rec.SETRANGE(Rec.Status,Rec.Status::Open);
        IF Rec.FINDFIRST THEN BEGIN
          ERROR(Txt_002);
        END;
        */

    end;

    var
        Txt_002: Label 'There is an open imprest document under your name, use it before you create a new one';
        PageEditable: Boolean;
        ActionsVisible: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
}

