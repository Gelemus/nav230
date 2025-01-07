codeunit 50005 "Funds Workflow Responses"
{

    trigger OnRun()
    begin
    end;

    var
        WFEventHandler: Codeunit "Workflow Event Handling";
        WFResponseHandler: Codeunit "Workflow Response Handling";
        FundsWorkflowEvents: Codeunit "Funds Workflow Events";

    procedure AddResponsesToLibrary()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    procedure AddResponsePredecessors(ResponseFunctionName: Code[128])
    begin
        //--------------------------------------Funds Management Response Predecessors------------------------------------------------
        //Payment Header
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  FundsWorkflowEvents.RunWorkflowOnSendPaymentHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  FundsWorkflowEvents.RunWorkflowOnSendPaymentHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  FundsWorkflowEvents.RunWorkflowOnSendPaymentHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  FundsWorkflowEvents.RunWorkflowOnCancelPaymentHeaderApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  FundsWorkflowEvents.RunWorkflowOnCancelPaymentHeaderApprovalRequestCode);

        //Receipt Header
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  FundsWorkflowEvents.RunWorkflowOnSendReceiptHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  FundsWorkflowEvents.RunWorkflowOnSendReceiptHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  FundsWorkflowEvents.RunWorkflowOnSendReceiptHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  FundsWorkflowEvents.RunWorkflowOnCancelReceiptHeaderApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  FundsWorkflowEvents.RunWorkflowOnCancelReceiptHeaderApprovalRequestCode);
        //Funds Tranfer Header
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  FundsWorkflowEvents.RunWorkflowOnSendFundsTransferHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  FundsWorkflowEvents.RunWorkflowOnSendFundsTransferHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  FundsWorkflowEvents.RunWorkflowOnSendFundsTransferHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  FundsWorkflowEvents.RunWorkflowOnCancelFundsTransferHeaderApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  FundsWorkflowEvents.RunWorkflowOnCancelFundsTransferHeaderApprovalRequestCode);
        //Imprest Header
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode(),
                                                  FundsWorkflowEvents.RunWorkflowOnSendImprestHeaderForApprovalCode());
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode(),
                                                  FundsWorkflowEvents.RunWorkflowOnSendImprestHeaderForApprovalCode());
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode(),
                                                  FundsWorkflowEvents.RunWorkflowOnSendImprestHeaderForApprovalCode());
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode(),
                                                  FundsWorkflowEvents.RunWorkflowOnCancelImprestHeaderApprovalRequestCode());
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode(),
                                                  FundsWorkflowEvents.RunWorkflowOnCancelImprestHeaderApprovalRequestCode());

        //Imprest Surrender Header
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  FundsWorkflowEvents.RunWorkflowOnSendImprestSurrenderHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  FundsWorkflowEvents.RunWorkflowOnSendImprestSurrenderHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  FundsWorkflowEvents.RunWorkflowOnSendImprestSurrenderHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  FundsWorkflowEvents.RunWorkflowOnCancelImprestSurrenderHeaderApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  FundsWorkflowEvents.RunWorkflowOnCancelImprestSurrenderHeaderApprovalRequestCode);

        //Funds Claim Header
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  FundsWorkflowEvents.RunWorkflowOnSendFundsClaimHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  FundsWorkflowEvents.RunWorkflowOnSendFundsClaimHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  FundsWorkflowEvents.RunWorkflowOnSendFundsClaimHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  FundsWorkflowEvents.RunWorkflowOnCancelFundsClaimHeaderApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  FundsWorkflowEvents.RunWorkflowOnCancelFundsClaimHeaderApprovalRequestCode);

        //Document Reversal Header
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  FundsWorkflowEvents.RunWorkflowOnSendDocumentReversalHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  FundsWorkflowEvents.RunWorkflowOnSendDocumentReversalHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  FundsWorkflowEvents.RunWorkflowOnSendDocumentReversalHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  FundsWorkflowEvents.RunWorkflowOnCancelDocumentReversalHeaderApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  FundsWorkflowEvents.RunWorkflowOnCancelDocumentReversalHeaderApprovalRequestCode);


        //Journal Voucher
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  FundsWorkflowEvents.RunWorkflowOnSendJournalVoucherForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  FundsWorkflowEvents.RunWorkflowOnSendJournalVoucherForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  FundsWorkflowEvents.RunWorkflowOnSendJournalVoucherForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  FundsWorkflowEvents.RunWorkflowOnCancelJournalVoucherApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  FundsWorkflowEvents.RunWorkflowOnCancelJournalVoucherApprovalRequestCode);
        //Salary Advance
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  FundsWorkflowEvents.RunWorkflowOnSendSalaryAdvanceForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  FundsWorkflowEvents.RunWorkflowOnSendSalaryAdvanceForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  FundsWorkflowEvents.RunWorkflowOnSendSalaryAdvanceForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  FundsWorkflowEvents.RunWorkflowOnCancelSalaryAdvanceApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  FundsWorkflowEvents.RunWorkflowOnCancelSalaryAdvanceApprovalRequestCode);
        //Payroll
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  FundsWorkflowEvents.RunWorkflowOnSendPayrollForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  FundsWorkflowEvents.RunWorkflowOnSendPayrollForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  FundsWorkflowEvents.RunWorkflowOnSendPayrollForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  FundsWorkflowEvents.RunWorkflowOnCancelPayrollApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  FundsWorkflowEvents.RunWorkflowOnCancelPayrollApprovalRequestCode);

        //------------------------------------End Funds Management Response Predecessors----------------------------------------------
    end;
}