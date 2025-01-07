page 50266 "Closed Disciplinary Cases"
{
    CardPageID = "Disciplinary Case Card";
    PageType = List;
    SourceTable = "HR Disciplinary Case";
    SourceTableView = WHERE(Status = CONST(Closed));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Case Number"; Rec."Case Number")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Type of Disciplinary Case"; Rec."Type of Disciplinary Case")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Case Description"; Rec."Case Description")
                {
                }
                field("Accuser Name"; Rec."Accuser Name")
                {
                }
                field("Witness #1"; Rec."Witness #1")
                {
                }
                field("Witness #2"; Rec."Witness #2")
                {
                }
                field("Action Taken"; Rec."Action Taken")
                {
                }
                field("Disciplinary Remarks"; Rec."Disciplinary Remarks")
                {
                }
                field(Comments; Rec.Comments)
                {
                }
                field(Recomendations; Rec.Recomendations)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Closed By"; Rec."Closed By")
                {
                }
            }
        }
        area(factboxes)
        {
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = Advanced;
                ToolTip = 'Approvals FactBox';
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Advanced;
                ShowFilter = false;
                ToolTip = 'Incoming Document Attach FactBox';
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                ToolTip = 'Workflow Status';
                Visible = ShowWorkflowStatus;
            }
            systempart(Control19; Links)
            {
                ToolTip = 'Record Links';
                Visible = false;
            }
            systempart(Control18; Notes)
            {
                ToolTip = 'Notes';
            }
        }
    }

    actions
    {
    }

    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;

    local procedure SetControlAppearance()
    begin
    end;
}

