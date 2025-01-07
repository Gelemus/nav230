page 50245 "HR Asset Transfer Card"
{
    // 

    Caption = 'Asset Transfer Card';
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "HR Asset Transfer Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Activity Type"; Rec."Activity Type")
                {
                }
                field("Transfer Reason"; Rec."Transfer Reason")
                {
                    Caption = 'Reason';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Transfer Effected"; Rec."Transfer Effected")
                {
                    Editable = false;
                }
                field("Date Transfered"; Rec."Date Transfered")
                {
                    Editable = false;
                }
                field("Transfered By"; Rec."Transfered By")
                {
                    Editable = false;
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                }
            }
            part(Control9; "HR Asset Transfer Lines")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
        area(factboxes)
        {
            systempart(Control16; Links)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Effect Transfer")
            {
                Caption = 'Effect Transfer';
                Image = PostTaxInvoice;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField("Transfer Effected", false);
                    if Confirm(Txt060) = false then exit;
                    AssetTransferLines.Reset;
                    AssetTransferLines.SetRange("Document No.", Rec."No.");
                    if AssetTransferLines.FindSet then begin
                        repeat
                            //  AssetTransferLines.TESTFIELD("New Asset Location");
                            EmployeeManagement.TransferAsset(AssetTransferLines);
                            Rec."Transfer Effected" := true;
                            Rec."Transfered By" := UserId;
                            Rec."Date Transfered" := Today;
                            Rec."Time Posted" := Time;
                        until AssetTransferLines.Next = 0;
                    end;
                    Message(AssetAssign);
                end;
            }
            action("Asset Assignment Form")
            {
                Caption = 'Asset Assignment Form';
                Image = ReturnOrder;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ToolTip = 'Prepare to print the document. A report request window where you can specify what to include on the print-out.';

                trigger OnAction()
                begin
                    TransferDocument.Reset;
                    TransferDocument.SetRange(TransferDocument."No.", Rec."No.");
                    if TransferDocument.FindSet then begin
                        REPORT.RunModal(REPORT::"Fixed Asset Assignment II", true, false, TransferDocument);
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
                    ToolTip = 'Reject the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        /*IF "Transfer Effected"=TRUE THEN
          CurrPage.EDITABLE(FALSE);
          */

    end;

    trigger OnOpenPage()
    begin
        if Rec."Transfer Effected" = true then
            CurrPage.Editable(false);
    end;

    var
        Txt060: Label 'Effect Transfer?';
        AssetTransferLines: Record "HR Asset Transfer Lines";
        EmployeeManagement: Codeunit "HR Employee Management";
        AssetAssign: Label 'Asset Assignment/Transfer effected.';
        TransferDocument: Record "HR Asset Transfer Header";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
}

