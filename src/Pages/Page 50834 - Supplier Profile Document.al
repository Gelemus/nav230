page 50834 "Supplier Profile Document"
{
    PageType = ListPart;
    SourceTable = "Supplier Profile Documents";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Type; Rec.Type)
                {
                }
                field("Actual File"; Rec."Actual File")
                {
                }
                field(FilePath; Rec.FilePath)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //"Document Type":= "Document Type"::"Open Tender";
    end;

    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        ProcurementManagement: Codeunit "Procurement Management";
        ProcurementApprovalWorkflow: Codeunit "Procurement Approval Manager";
        PurchaseRequisitionHeader: Record "Purchase Requisitions";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ",Payment,Receipt,Imprest,"Imprest Surrender","Funds Refund","Purchase Requisition";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
        IsEditable: Boolean;
        TenderHeader: Record "Tender Header";
        TenderLines: Record "Tender Lines";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        TenderClosed: Label 'Tender Successfully Closed';
        TenderEvaluate: Label 'Tender successfully Now Under Tender Evaluation Committee';
        Txt060: Label 'Are you sure you want to make contract request for this tender document?';
        Txt061: Label 'Are you sure you want to close this tender?';
        Contractexist: Label 'There exists a contract in relation to this tender';
        ContractCreated: Label 'Contract request successfully created. Proceed to the contract application and send to Legal Department';
        ProcurementUploadDocuments: Record "Procurement Upload Documents";
        VendorRequiredDocuments: Record "Vendor Required Documents";
        TenderOpening: Label 'Tender successfully Now Under Tender Opening Committee';
        VendorDocs: Record "Vendor Required Documents";
        ProcurementUploadDocuments2: Record "Procurement Upload Documents";
        TenderEvaluators: Record "Tender Evaluators";
        Txt100003: Label 'You must elect a chaiperson for the evaluation committee!';
        TenderEvaluationResults: Record "Tender Evaluation Results";
        ApprovalEditable: Boolean;
        ContractGroup: Record "Contract Group";
        ContractSetup: Record "Contract Setup";
        TempContract: Record "Contract Request Header";
        Contract: Record "Contract Request Header";
}

