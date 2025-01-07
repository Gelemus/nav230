tableextension 60095 tableextension60095 extends "Incoming Document Attachment" 
{

    //Unsupported feature: Property Modification (Attributes) on "NewAttachment(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "NewAttachmentFromGenJnlLine(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "NewAttachmentFromSalesDocument(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "NewAttachmentFromPurchaseDocument(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "NewAttachmentFromDocument(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "NewAttachmentFromPostedDocument(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "Import(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "Export(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "DeleteAttachment(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "SendToOCR(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "GetFullName(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "OnAttachBinaryFile(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "OnGetBinaryContent(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "ExtractHeaderFields(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "SetFiltersFromMainRecord(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "AddFieldToFieldBuffer(PROCEDURE 28)".


    //Unsupported feature: Property Modification (Attributes) on "SendNotifActionCompleted(PROCEDURE 162)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeExtractHeaderFields(PROCEDURE 30)".

    local procedure "//Custom"()
    begin
    end;

    [Scope('Personalization')]
    procedure NewAttachmentFromPaymentDocument(PaymentHeader: Record "Payment Header")
    begin
        //Sysre NextGen Addon
        //Attach Payment Document support documents
        NewAttachmentFromDocument(
          PaymentHeader."Incoming Document Entry No.",
          DATABASE::"Payment Header",
          PaymentHeader."Document Type",
          PaymentHeader."No.");
    end;

    [Scope('Personalization')]
    procedure NewAttachmentFromFundsTransferDocument(FundsTransferHeader: Record "Funds Transfer Header")
    begin
        //Sysre NextGen Addon
        //Attach Funds Transfer Document support documents
        NewAttachmentFromDocument(
          FundsTransferHeader."Incoming Document Entry No.",
          DATABASE::"Funds Transfer Header",
          FundsTransferHeader."Document Type",
          FundsTransferHeader."No.");
    end;

    [Scope('Personalization')]
    procedure NewAttachmentFromImprestDocument(ImprestHeader: Record "Imprest Header")
    begin
        //Sysre NextGen Addon
        //Attach Imprest Document support documents
        NewAttachmentFromDocument(
          ImprestHeader."Incoming Document Entry No.",
          DATABASE::"Imprest Header",
          ImprestHeader."Document Type",
          ImprestHeader."No.");
    end;

    [Scope('Personalization')]
    procedure NewAttachmentFromImprestSurrenderDocument(ImprestSurrenderHeader: Record "Imprest Surrender Header")
    begin
        //Sysre NextGen Addon
        //Attach Imprest Surrender Document support documents
        NewAttachmentFromDocument(
          ImprestSurrenderHeader."Incoming Document Entry No.",
          DATABASE::"Imprest Surrender Header",
          ImprestSurrenderHeader."Document Type",
          ImprestSurrenderHeader."No.");
    end;

    [Scope('Personalization')]
    procedure NewAttachmentFromFundsClaimDocument(FundsClaimHeader: Record "Funds Claim Header")
    begin
        //Sysre NextGen Addon
        //Attach Funds Claim Document support documents
        NewAttachmentFromDocument(
          FundsClaimHeader."Incoming Document Entry No.",
          DATABASE::"Funds Claim Header",
          FundsClaimHeader."Document Type",
          FundsClaimHeader."No.");
    end;

    [Scope('Personalization')]
    procedure NewAttachmentFromPurchaseRequisitionDocument(PurchaseRequisition: Record "Purchase Requisitions")
    var
        DocumentType: Option;
    begin
        //Sysre NextGen Addon
        //Attach Purchase Requisition Document support documents
        NewAttachmentFromDocument(
          PurchaseRequisition."Incoming Document Entry No.",
          DATABASE::"Purchase Requisitions",
          PurchaseRequisition."Document Type",
          PurchaseRequisition."No.");
        //MESSAGE('%1document no %2 checking',PurchaseRequisition."No.", PurchaseRequisition."Document Type");
    end;

    [Scope('Personalization')]
    procedure NewAttachmentFromBidAnalysisDocument("Bid Analysis": Record "Bid Analysis Header")
    var
        DocumentType: Option;
    begin
        //Sysre Addon
        //Attach Bid Analysis Document support documents
        NewAttachmentFromDocument(
          "Bid Analysis"."Incoming Document Entry No.",
          DATABASE::"Bid Analysis Header",
          DocumentType,
          "Bid Analysis"."RFQ No.");
    end;

    [Scope('Personalization')]
    procedure NewAttachmentFromRequestForQuotationDocument(RequestforQuotation: Record "Request for Quotation Header")
    var
        DocumentType: Option;
    begin
        //Sysre NextGen Addon
        //Attach Request for Quotation Document support documents
        NewAttachmentFromDocument(
          RequestforQuotation."Incoming Document Entry No.",
          DATABASE::"Request for Quotation Header",
          DocumentType,
          RequestforQuotation."No.");
    end;

    [Scope('Personalization')]
    procedure NewAttachmentFromStoreRequisitionDocument(StoreRequisition: Record "Store Requisition Header")
    var
        DocumentType: Option;
    begin
        //Sysre NextGen Addon
        //Attach Store Requisition Document support documents
        NewAttachmentFromDocument(
          StoreRequisition."Incoming Document Entry No.",
          DATABASE::"Store Requisition Header",
          StoreRequisition."Document Type",
          StoreRequisition."No.");
    end;

    [Scope('Personalization')]
    procedure NewAttachmentFromTransferAllowanceDocument(TransferAllowanceHeader: Record "Allowance Header")
    begin
        //Sysre NextGen Addon
        //Attach Imprest Document support documents
        NewAttachmentFromDocument(
          TransferAllowanceHeader."Incoming Document Entry No.",
          DATABASE::"Imprest Header",
          TransferAllowanceHeader."Document Type",
          TransferAllowanceHeader."No.");
    end;

    [Scope('Personalization')]
    procedure NewAttachmentFromLeaveAllowanceDocument(HRLeaveApplication: Record "HR Leave Application")
    var
        DocumentType: Option;
    begin
        //Sysre NextGen Addon
        //Attach Imprest Document support documents
          NewAttachmentFromDocument(
          HRLeaveApplication."Incoming Document Entry No.",
          DATABASE::"HR Leave Application",
          DocumentType,
          HRLeaveApplication."No.");
    end;

    [Scope('Personalization')]
    procedure NewAttachmentFromTransportRequestDocument(TransportRequest: Record "Transport Request")
    var
        DocumentType: Option;
    begin
        //Sysre NextGen Addon
        //Attach Imprest Document support documents
          NewAttachmentFromDocument(
          TransportRequest."Incoming Document Entry No.",
          DATABASE::"Transport Request",
          DocumentType,
          TransportRequest."Request No.");

    end;

    [Scope('Personalization')]
    procedure NewAttachmentFromSalaryAdvanceDocument(SalaryAdvance: Record "Salary Advance")
    var
        DocumentType: Option;
    begin
        //Sysre NextGen Addon
        //Attach Store Requisition Document support documents
        NewAttachmentFromDocument(
          SalaryAdvance."Incoming Document Entry No.",
          DATABASE::"Salary Advance",
          SalaryAdvance."Document Type",
          SalaryAdvance.ID);
    end;
}

