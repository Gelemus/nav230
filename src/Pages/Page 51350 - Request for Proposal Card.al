page 51350 "Request for Proposal Card"
{
    PageType = Card;
    SourceTable = "Tender Header";
    ApplicationArea = All;
    SourceTableView = WHERE("Document Type" = CONST("Request for Proposal"));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Tender Description"; Rec."Tender Description")
                {
                }
                field(Eligibility; Rec.Eligibility)
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
                field("Type of supply"; Rec."Type of supply")
                {
                }
                field("Tender Submission (From)"; Rec."Tender Submission (From)")
                {
                }
                field("Tender Submission (To)"; Rec."Tender Submission (To)")
                {
                }
                field("Tender Status"; Rec."Tender Status")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Tender Closing Date"; Rec."Tender Closing Date")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Tender Preparation Approved"; Rec."Tender Preparation Approved")
                {
                }
                field("Held By"; Rec."Held By")
                {
                }
                field("Name of the Procuring Entity"; Rec."Name of the Procuring Entity")
                {
                }
                field("Tender No"; Rec."Tender No")
                {
                }
                field("Date Tender Invited"; Rec."Date Tender Invited")
                {
                }
                field("Date Tender Opened"; Rec."Date Tender Opened")
                {
                }
                field("No. of Tendererd Issued with"; Rec."No. of Tendererd Issued with")
                {
                }
                field("Any relevant information"; Rec."Any relevant information")
                {
                }
                field("Special Condition"; Rec."Special Condition")
                {
                }
            }
            part(Control41; "RFP Subform")
            {
                ApplicationArea =All;
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Type" := Rec."Document Type"::"Request for Proposal";
    end;

    var
        PurchaseRequisitionLines: Record "Purchase Requisition Line";
        ProcurementManagement: Codeunit "Procurement Management";
        ProcurementApprovalWorkflow: Codeunit "Procurement Approval Manager";
        RequestforQuotationHeader: Record "Request for Quotation Header";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
        ReportSelections: Record "Report Selections";
        RFQLines: Record "Request for Quotation Line";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        VendorSelection: Record "Request for Quotation Vendors";
        Lineno: Integer;
        PurchaseHeader: Record "Purchase Header";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        PurchaseLine2: Record "Purchase Line";
        PurchaseLine: Record "Purchase Line";
}

