codeunit 50004 "Funds Workflow Events"
{

    trigger OnRun()
    begin
    end;

    var
        WFHandler: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure AddEventsToLibrary()
    begin
        //---------------------------------------------1. Approval Events--------------------------------------------------------------
        //Payment Header
        WFHandler.AddEventToLibrary(RunWorkflowOnSendPaymentHeaderForApprovalCode,
                                    DATABASE::"Payment Header", 'Approval of a payment document is requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelPaymentHeaderApprovalRequestCode,
                                    DATABASE::"Payment Header", 'An approval request for a payment document is canceled.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnChangePaymentHeaderDocumentCode,
                                    DATABASE::"Payment Header", 'A payment document is changed.', 0, false);
        //Receipt Header
        WFHandler.AddEventToLibrary(RunWorkflowOnSendReceiptHeaderForApprovalCode,
                                    DATABASE::"Receipt Header", 'Approval of a receipt is requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelReceiptHeaderApprovalRequestCode,
                                    DATABASE::"Receipt Header", 'An approval request for a receipt is canceled.', 0, false);
        //Funds Transfer Header
        WFHandler.AddEventToLibrary(RunWorkflowOnSendFundsTransferHeaderForApprovalCode,
                                    DATABASE::"Funds Transfer Header", 'Approval of a funds transfer is requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelFundsTransferHeaderApprovalRequestCode,
                                    DATABASE::"Funds Transfer Header", 'An approval request for a funds transfer is canceled.', 0, false);
        //Imprest Header
        WFHandler.AddEventToLibrary(RunWorkflowOnSendImprestHeaderForApprovalCode,
                                    DATABASE::"Imprest Header", 'Approval of an imprest is requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelImprestHeaderApprovalRequestCode,
                                    DATABASE::"Imprest Header", 'An approval request for an imprest is canceled.', 0, false);
        //Imprest Surrender Header
        WFHandler.AddEventToLibrary(RunWorkflowOnSendImprestSurrenderHeaderForApprovalCode,
                                    DATABASE::"Imprest Surrender Header", 'Approval of an imprest surrender is requested.', 0, false);

        WFHandler.AddEventToLibrary(RunWorkflowOnCancelImprestSurrenderHeaderApprovalRequestCode,
                                    DATABASE::"Imprest Surrender Header", 'An approval request for an imprest surrender is canceled.', 0, false);
        //Funds Claim Header
        WFHandler.AddEventToLibrary(RunWorkflowOnSendFundsClaimHeaderForApprovalCode,
                                    DATABASE::"Funds Claim Header", 'Approval of a funds claim document is requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelFundsClaimHeaderApprovalRequestCode,
                                    DATABASE::"Funds Claim Header", 'An approval request for a funds claim document is canceled.', 0, false);

        //Budget Allocation Header
        WFHandler.AddEventToLibrary(RunWorkflowOnSendBudgetAllocationHeaderForApprovalCode,
                                    DATABASE::"Budget Allocation Header", 'Approval of a budget allocation document is requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelBudgetAllocationHeaderApprovalRequestCode,
                                    DATABASE::"Budget Allocation Header", 'An approval request for a budget allocation document is canceled.', 0, false);

        //Document Reversal Header
        WFHandler.AddEventToLibrary(RunWorkflowOnSendDocumentReversalHeaderForApprovalCode,
                                    DATABASE::"Document Reversal Header", 'Approval of a Document Reversal document is requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelDocumentReversalHeaderApprovalRequestCode,
                                    DATABASE::"Document Reversal Header", 'An approval request for a Document Reversal document is canceled.', 0, false);

        //Journal Voucher
        WFHandler.AddEventToLibrary(RunWorkflowOnSendJournalVoucherForApprovalCode,
                                    DATABASE::"Journal Voucher Header", 'Approval of a Journal Voucher is requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelJournalVoucherApprovalRequestCode,
                                    DATABASE::"Journal Voucher Header", 'An approval request for a Journal Voucher is canceled.', 0, false);
        //Salary advance
        WFHandler.AddEventToLibrary(RunWorkflowOnSendSalaryAdvanceForApprovalCode,
                                    DATABASE::"Salary Advance", 'Approval of a salary advance is requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelSalaryAdvanceApprovalRequestCode,
                                    DATABASE::"Salary Advance", 'An approval request for salary advane is canceled.', 0, false);
        //Allowance

        //Allowance
        WFHandler.AddEventToLibrary(RunWorkflowOnSendSalaryAdvanceForApprovalCode,
                                    DATABASE::"Allowance Header", 'Approval of allowance is requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelAllowanceHeaderApprovalRequestCode,
                                    DATABASE::"Allowance Header", 'An approval request for allowance is canceled.', 0, false);
        //Payroll
        WFHandler.AddEventToLibrary(RunWorkflowOnSendPayrollForApprovalCode,
                                    DATABASE::Periods, 'Approval of payroll is requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelPayrollApprovalRequestCode,
                                    DATABASE::Periods, 'An approval request for payroll is canceled.', 0, false);
        //-------------------------------------------End Approval Events-------------------------------------------------------------
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    procedure AddEventsPredecessor(EventFunctionName: Code[128])
    begin
        //--------------------------------------1.Approval,Rejection,Delegation Predecessors------------------------------------------------
        //Payment Header
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendPaymentHeaderForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendPaymentHeaderForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendPaymentHeaderForApprovalCode);//Delegate

        //Receipt Header
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendReceiptHeaderForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendReceiptHeaderForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendReceiptHeaderForApprovalCode);//Delegate

        //Funds Transfer Header
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendFundsTransferHeaderForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendFundsTransferHeaderForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendFundsTransferHeaderForApprovalCode);//Delegate

        //Imprest Header
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendImprestHeaderForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendImprestHeaderForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendImprestHeaderForApprovalCode);//Delegate

        //Imprest Surrender Header
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendImprestSurrenderHeaderForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendImprestSurrenderHeaderForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendImprestSurrenderHeaderForApprovalCode);//Delegate

        //Funds Claim Header
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendFundsClaimHeaderForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendFundsClaimHeaderForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendFundsClaimHeaderForApprovalCode);//Delegate

        //Budget Allocation Header
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendBudgetAllocationHeaderForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendBudgetAllocationHeaderForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendBudgetAllocationHeaderForApprovalCode);//Delegate

        //Document Reversal Header
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendDocumentReversalHeaderForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendDocumentReversalHeaderForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendDocumentReversalHeaderForApprovalCode);//Delegate

        //Journal Voucher
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendJournalVoucherForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendJournalVoucherForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendJournalVoucherForApprovalCode);//Delegate

        //Salary Advance
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendSalaryAdvanceForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendSalaryAdvanceForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendSalaryAdvanceForApprovalCode);//Delegate

        //Allowance
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendAllowanceHeaderForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendAllowanceHeaderForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendAllowanceHeaderForApprovalCode);//Delegate

        //Payroll
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendPayrollForApprovalCode);//Approve
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendPayrollForApprovalCode);//Reject
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendPayrollForApprovalCode);//Delegate

        //---------------------------------------End Approval,Rejection,Delegation Predecessors-----------------------------------------------
    end;

    procedure RunWorkflowOnSendPaymentHeaderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPaymentHeaderForApproval'));
    end;

    procedure RunWorkflowOnCancelPaymentHeaderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPaymentHeaderApprovalRequest'));
    end;

    procedure RunWorkflowOnChangePaymentHeaderDocumentCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnChangePaymentHeaderDocument'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendPaymentHeaderForApproval', '', false, false)]
    procedure RunWorkflowOnSendPaymentHeaderForApproval(var PaymentHeader: Record "Payment Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPaymentHeaderForApprovalCode, PaymentHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelPaymentHeaderApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelPaymentHeaderApprovalRequest(var PaymentHeader: Record "Payment Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPaymentHeaderApprovalRequestCode, PaymentHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendPaymentHeaderForApproval', '', false, false)]
    procedure RunWorkflowOnChangePaymentHeaderDocument(var PaymentHeader: Record "Payment Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnChangePaymentHeaderDocumentCode, PaymentHeader);
    end;

    procedure RunWorkflowOnSendReceiptHeaderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendReceiptHeaderForApproval'));
    end;

    procedure RunWorkflowOnCancelReceiptHeaderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelReceiptHeaderApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendReceiptHeaderForApproval', '', false, false)]
    procedure RunWorkflowOnSendReceiptHeaderForApproval(var ReceiptHeader: Record "Receipt Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendReceiptHeaderForApprovalCode, ReceiptHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelReceiptHeaderApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelReceiptHeaderApprovalRequest(var ReceiptHeader: Record "Receipt Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelReceiptHeaderApprovalRequestCode, ReceiptHeader);
    end;

    procedure RunWorkflowOnSendFundsTransferHeaderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendFundsTransferHeaderForApproval'));
    end;

    procedure RunWorkflowOnCancelFundsTransferHeaderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelFundsTransferHeaderApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendFundsTransferHeaderForApproval', '', false, false)]
    procedure RunWorkflowOnSendFundsTransferHeaderForApproval(var FundsTransferHeader: Record "Funds Transfer Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendFundsTransferHeaderForApprovalCode, FundsTransferHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelFundsTransferHeaderApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelFundsTransferHeaderApprovalRequest(var FundsTransferHeader: Record "Funds Transfer Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelFundsTransferHeaderApprovalRequestCode, FundsTransferHeader);
    end;

    procedure RunWorkflowOnSendImprestHeaderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendImprestHeaderForApproval'));
    end;

    procedure RunWorkflowOnCancelImprestHeaderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelImprestHeaderApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendImprestHeaderForApproval', '', false, false)]
    procedure RunWorkflowOnSendImprestHeaderForApproval(var ImprestHeader: Record "Imprest Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendImprestHeaderForApprovalCode, ImprestHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelImprestHeaderApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelImprestHeaderApprovalRequest(var ImprestHeader: Record "Imprest Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelImprestHeaderApprovalRequestCode, ImprestHeader);
    end;

    procedure RunWorkflowOnSendAllowanceHeaderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendAllowanceHeaderForApproval'));
    end;

    procedure RunWorkflowOnCancelAllowanceHeaderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelAllowanceHeaderApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendAllowanceHeaderForApproval', '', false, false)]
    procedure RunWorkflowOnSendAllowanceHeaderForApproval(var AllowanceHeader: Record "Allowance Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendAllowanceHeaderForApprovalCode, AllowanceHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelAllowanceApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelAllowanceHeaderApprovalRequest(var AllowanceHeader: Record "Allowance Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelAllowanceHeaderApprovalRequestCode, AllowanceHeader);
    end;

    procedure RunWorkflowOnSendImprestSurrenderHeaderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendImprestSurrenderHeaderForApproval'));
    end;

    procedure RunWorkflowOnCancelImprestSurrenderHeaderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelImprestSurrenderHeaderApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendImprestSurrenderHeaderForApproval', '', false, false)]
    procedure RunWorkflowOnSendImprestSurrenderHeaderForApproval(var ImprestSurrender: Record "Imprest Surrender Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendImprestSurrenderHeaderForApprovalCode, ImprestSurrender);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelImprestSurrenderHeaderApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelImprestSurrenderHeaderApprovalRequest(var ImprestSurrender: Record "Imprest Surrender Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelImprestSurrenderHeaderApprovalRequestCode, ImprestSurrender);
    end;

    procedure RunWorkflowOnSendFundsClaimHeaderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendFundsClaimHeaderForApproval'));
    end;

    procedure RunWorkflowOnCancelFundsClaimHeaderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelFundsClaimHeaderApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendFundsClaimHeaderForApproval', '', false, false)]
    procedure RunWorkflowOnSendFundsClaimHeaderForApproval(var FundsClaimHeader: Record "Funds Claim Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendFundsClaimHeaderForApprovalCode, FundsClaimHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelFundsClaimHeaderApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelFundsClaimHeaderApprovalRequest(var FundsClaimHeader: Record "Funds Claim Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelFundsClaimHeaderApprovalRequestCode, FundsClaimHeader);
    end;

    procedure RunWorkflowOnSendBudgetAllocationHeaderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendBudgetAllocationHeaderForApproval'));
    end;

    procedure RunWorkflowOnCancelBudgetAllocationHeaderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelBudgetAllocationHeaderApprovalRequest'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendPaymentHeaderForApproval', '', false, false)]
    // procedure RunWorkflowOnSendBudgetAllocationHeaderForApproval(var BudgetAllocationHeader: Record "Budget Allocation Header")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendBudgetAllocationHeaderForApprovalCode, BudgetAllocationHeader);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelPaymentHeaderApprovalRequest', '', false, false)]
    // procedure RunWorkflowOnCancelBudgetAllocationHeaderApprovalRequest(var BudgetAllocationHeader: Record "Budget Allocation Header")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelBudgetAllocationHeaderApprovalRequestCode, BudgetAllocationHeader);
    // end;

    procedure RunWorkflowOnSendDocumentReversalHeaderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendDocumentReversalHeaderForApproval'));
    end;

    procedure RunWorkflowOnCancelDocumentReversalHeaderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelDocumentReversalHeaderApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendDocumentReversalHeaderForApproval', '', false, false)]
    procedure RunWorkflowOnSendDocumentReversalHeaderForApproval(var DocumentReversalHeader: Record "Document Reversal Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendDocumentReversalHeaderForApprovalCode, DocumentReversalHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelDocumentReversalHeaderApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelDocumentReversalHeaderApprovalRequest(var DocumentReversalHeader: Record "Document Reversal Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelDocumentReversalHeaderApprovalRequestCode, DocumentReversalHeader);
    end;

    procedure RunWorkflowOnSendJournalVoucherForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendJournalVoucherForApproval'));
    end;

    procedure RunWorkflowOnCancelJournalVoucherApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelJournalVoucherApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendJournalVoucherForApproval', '', false, false)]
    procedure RunWorkflowOnSendJournalVoucherForApproval(var JournalVoucherHeader: Record "Journal Voucher Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendJournalVoucherForApprovalCode, JournalVoucherHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelJournalVoucherApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelJournalVoucherApprovalRequest(var JournalVoucherHeader: Record "Journal Voucher Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelJournalVoucherApprovalRequestCode, JournalVoucherHeader);
    end;

    procedure RunWorkflowOnSendSalaryAdvanceForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendSalaryAdvanceForApproval'));
    end;

    procedure RunWorkflowOnCancelSalaryAdvanceApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelSalaryAdvanceApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendSalaryAdvanceForApproval', '', false, false)]
    procedure RunWorkflowOnSendSalaryAdvanceForApproval(var SalaryAdvance: Record "Salary Advance")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendSalaryAdvanceForApprovalCode, SalaryAdvance);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelSalaryAdvanceApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelSalaryAdvanceApprovalRequest(var SalaryAdvance: Record "Salary Advance")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelSalaryAdvanceApprovalRequestCode, SalaryAdvance);
    end;

    procedure RunWorkflowOnSendPayrollForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPayrollForApproval'));
    end;

    procedure RunWorkflowOnCancelPayrollApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPayrollApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnSendPayrollForApproval', '', false, false)]
    procedure RunWorkflowOnSendPayrollForApproval(var Periods: Record Periods)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPayrollForApprovalCode, Periods);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", 'OnCancelPayrollApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelPayrollApprovalRequest(var Periods: Record Periods)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPayrollApprovalRequestCode, Periods);
    end;
}