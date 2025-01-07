page 50265 "Disciplinary Case Card"
{
    PageType = Card;
    SourceTable = "HR Disciplinary Case";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Case Number"; Rec."Case Number")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                }
                field("Type of Displinary Cases"; Rec."Type of Displinary Cases")
                {
                }
                field("<Employee Accuser >"; Rec."Employee No")
                {
                    Caption = 'Employee Accuser No';
                }
                field("<Employee Accuser Name >"; Rec."Employee Name")
                {
                    Caption = 'Employee Accuser Name';
                }
                field("Employer Accuser"; Rec."Employer Accuser")
                {
                }
                field("Outsider Accuser"; Rec."Outsider Accuser")
                {
                }
                field("Case Description"; Rec."Case Description")
                {
                    MultiLine = true;
                }
                field("Witness #1"; Rec."Witness #1")
                {
                }
                field("Witness #2"; Rec."Witness #2")
                {
                }
                field("Witness#3"; Rec."Witness#3")
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
                    MultiLine = true;
                }
                field(Status; Rec.Status)
                {
                }
                field("Closed By"; Rec."Closed By")
                {
                    Editable = false;
                }
                field("Closed Date"; Rec."Closed Date")
                {
                    Editable = false;
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
            systempart(Control22; Links)
            {
                ToolTip = 'Record Links';
                Visible = false;
            }
            systempart(Control21; Notes)
            {
                ToolTip = 'Notes';
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Close Case")
            {
                Caption = 'Close Case';
                Image = CloseYear;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm(Txt060) = false then exit;
                    Rec.Status := Rec.Status::Closed;
                    Rec."Closed By" := UserId;
                    Rec."Closed Date" := Today;
                    Rec.Modify;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::Closed then
            CurrPage.Editable(false);
    end;

    var
        Txt060: Label 'Close Case?';
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
}

