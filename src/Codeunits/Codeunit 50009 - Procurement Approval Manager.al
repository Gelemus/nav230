codeunit 50009 "Procurement Approval Manager"
{

    trigger OnRun()
    begin
    end;

    var
        ApprovalEntryRec: Record "Approval Entry";
        ProcuremntMangt: Codeunit "Procurement Management";

    procedure ReleasePurchaseRequisitionHeader(var "Purchase Requisition Header": Record "Purchase Requisitions")
    var
        PurchaseRequisitionHeader: Record "Purchase Requisitions";
    begin
        PurchaseRequisitionHeader.Reset;
        PurchaseRequisitionHeader.SetRange(PurchaseRequisitionHeader."No.", "Purchase Requisition Header"."No.");
        if PurchaseRequisitionHeader.FindFirst then begin
            PurchaseRequisitionHeader.Status := PurchaseRequisitionHeader.Status::Approved;
            PurchaseRequisitionHeader.Validate(PurchaseRequisitionHeader.Status);
            PurchaseRequisitionHeader.Modify;
            //ProcuremntMangt.CommitBudgetPurchaseRequisition(PurchaseRequisitionHeader);
            //Update approval entries
            ApprovalEntryRec.Reset;
            ApprovalEntryRec.SetRange(ApprovalEntryRec."Document No.", PurchaseRequisitionHeader."No.");
            ApprovalEntryRec.SetFilter(Status, '%1|%2', ApprovalEntryRec.Status::Created, ApprovalEntryRec.Status::Open);
            if ApprovalEntryRec.FindFirst then
                repeat
                    ApprovalEntryRec.Validate(ApprovalEntryRec.Status, ApprovalEntryRec.Status::Approved);
                    ApprovalEntryRec.Modify;

                until ApprovalEntryRec.Next = 0;
        end;
    end;

    procedure ReOpenPurchaseRequisitionHeader(var "Purchase Requisition Header": Record "Purchase Requisitions")
    var
        PurchaseRequisitionHeader: Record "Purchase Requisitions";
    begin
        PurchaseRequisitionHeader.Reset;
        PurchaseRequisitionHeader.SetRange(PurchaseRequisitionHeader."No.", "Purchase Requisition Header"."No.");
        if PurchaseRequisitionHeader.FindFirst then begin
            PurchaseRequisitionHeader.Status := PurchaseRequisitionHeader.Status::Open;
            PurchaseRequisitionHeader.Validate(PurchaseRequisitionHeader.Status);
            PurchaseRequisitionHeader.Modify;
        end;
    end;

    procedure ReOpenRequestforQuotation(RequestforQuotation: Record "Request for Quotation Header")
    var
        RequestforQuotationHeader: Record "Request for Quotation Header";
        RequestforQuotationLine: Record "Request for Quotation Line";
    begin
        RequestforQuotationHeader.Reset;
        RequestforQuotationHeader.SetRange("No.", RequestforQuotation."No.");
        if RequestforQuotationHeader.FindFirst then begin
            RequestforQuotationHeader.Status := RequestforQuotationHeader.Status::Open;
            RequestforQuotationHeader.Validate(Status);
            RequestforQuotationHeader.Modify;
        end;
    end;

    procedure ReleaseRequestforQuotation(var RequestforQuotation: Record "Request for Quotation Header")
    var
        RequestforQuotationHeader: Record "Request for Quotation Header";
        RequestforQuotationLine: Record "Request for Quotation Line";
    begin
        RequestforQuotationHeader.Reset;
        RequestforQuotationHeader.SetRange("No.", RequestforQuotation."No.");
        if RequestforQuotationHeader.FindFirst then begin
            RequestforQuotationHeader.Status := RequestforQuotationHeader.Status::Released;
            RequestforQuotationHeader.Validate(Status);
            RequestforQuotationHeader.Modify;
        end;
    end;

    procedure ReopenBidAnalysis("Bid Analysis Header": Record "Bid Analysis Header")
    var
        BidAnalysisHeader: Record "Bid Analysis Header";
        BidAnalysisLine: Record "Bid Analysis Line";
    begin
        BidAnalysisHeader.Reset;
        BidAnalysisHeader.SetRange(BidAnalysisHeader."RFQ No.", "Bid Analysis Header"."RFQ No.");
        if BidAnalysisHeader.FindFirst then begin
            BidAnalysisHeader.Status := BidAnalysisHeader.Status::Open;
            BidAnalysisHeader.Validate(Status);
            BidAnalysisHeader.Modify;
        end;
    end;

    procedure ReleaseBidAnalysis(var "Bid Analysis Header": Record "Bid Analysis Header")
    var
        BidAnalysisHeader: Record "Bid Analysis Header";
        BidAnalysisLine: Record "Bid Analysis Line";
    begin
        BidAnalysisHeader.Reset;
        BidAnalysisHeader.SetRange(BidAnalysisHeader."RFQ No.", "Bid Analysis Header"."RFQ No.");
        if BidAnalysisHeader.FindFirst then begin
            BidAnalysisHeader.Status := BidAnalysisHeader.Status::Released;
            BidAnalysisHeader.Validate(Status);
            BidAnalysisHeader.Modify;
        end;
    end;

    procedure ReopenProcurementPlan(ProcurementPlanningHeaders: Record "Procurement Planning Header")
    var
        ProcurementPlanningHeader: Record "Procurement Planning Header";
    begin
        ProcurementPlanningHeader.Reset;
        ProcurementPlanningHeader.SetRange(ProcurementPlanningHeader."No.", ProcurementPlanningHeaders."No.");
        if ProcurementPlanningHeader.FindFirst then begin
            ProcurementPlanningHeader.Status := ProcurementPlanningHeader.Status::Open;
            ProcurementPlanningHeader.Validate(Status);
            ProcurementPlanningHeader.Modify;
        end;
    end;

    procedure ReleaseProcurementPlan(ProcurementPlanningHeaders: Record "Procurement Planning Header")
    var
        ProcurementPlanningHeader: Record "Procurement Planning Header";
    begin
        ProcurementPlanningHeader.Reset;
        ProcurementPlanningHeader.SetRange(ProcurementPlanningHeader."No.", ProcurementPlanningHeaders."No.");
        if ProcurementPlanningHeader.FindFirst then begin
            ProcurementPlanningHeader.Status := ProcurementPlanningHeader.Status::Approved;
            ProcurementPlanningHeader.Validate(Status);
            ProcurementPlanningHeader.Modify;
        end;
    end;

    procedure ReopenTenderHeader(TenderHeader: Record "Tender Header")
    var
        TenderHeaders: Record "Tender Header";
    begin
        TenderHeaders.Reset;
        TenderHeaders.SetRange(TenderHeaders."No.", TenderHeader."No.");
        if TenderHeaders.FindFirst then begin
            TenderHeaders.Status := TenderHeaders.Status::Open;
            TenderHeaders.Validate(Status);
            TenderHeaders.Modify;
        end;
    end;

    procedure ReleaseTenderHeader(TenderHeader: Record "Tender Header")
    var
        TenderHeaders: Record "Tender Header";
    begin
        TenderHeaders.Reset;
        TenderHeaders.SetRange(TenderHeaders."No.", TenderHeader."No.");
        if TenderHeaders.FindFirst then begin
            TenderHeaders.Status := TenderHeaders.Status::Approved;
            TenderHeaders.Validate(Status);
            TenderHeaders.Modify;
        end;
    end;

    procedure ReleaseTransferHeader(TransferHeader: Record "Transfer Header")
    var
        TenderHeaders: Record "Tender Header";
    begin
        TransferHeader.Reset;
        TransferHeader.SetRange(TransferHeader."No.", TransferHeader."No.");
        if TransferHeader.FindFirst then begin
            TransferHeader.Status := TransferHeader.Status::Released;
            TransferHeader.Validate(Status);
            TransferHeader.Modify;
        end;
    end;

    procedure ReopenTransferHeader(TransferHeader: Record "Transfer Header")
    var
        TenderHeaders: Record "Tender Header";
    begin
        TransferHeader.Reset;
        TransferHeader.SetRange(TransferHeader."No.", TransferHeader."No.");
        if TransferHeader.FindFirst then begin
            TransferHeader.Status := TransferHeader.Status::Open;
            TransferHeader.Validate(Status);
            TransferHeader.Modify;
        end;
    end;
}

