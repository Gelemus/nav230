codeunit 50077 "Invst. WF Response Handling"
{

    trigger OnRun()
    begin
    end;

    var
        WFEventHandler: Codeunit "Workflow Event Handling";
        WFResponseHandler: Codeunit "Workflow Response Handling";

    procedure AddResponsesToLibrary()
    begin
    end;

    procedure AddResponsePredecessors()
    begin
        //--------------------------------------Investment Management Response Predecessors------------------------------------------------
        //Investment Application
        /*WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnSendInvestmentApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnSendInvestmentApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnSendInvestmentApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnCancelInvestmentApplicationApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnCancelInvestmentApplicationApprovalRequestCode);
        
        //Research Analysis
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnSendResearchAnalysisForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnSendResearchAnalysisForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnSendResearchAnalysisForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnCancelResearchAnalysisApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnCancelResearchAnalysisApprovalRequestCode);
        
        //Application Screening
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnSendApplicationScreeningForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnSendApplicationScreeningForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnSendApplicationScreeningForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnCancelApplicationScreeningApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnCancelApplicationScreeningApprovalRequestCode);
        
        //Application Appraisal
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnSendApplicationAppraisalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnSendApplicationAppraisalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnSendApplicationAppraisalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnCancelApplicationAppraisalApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnCancelApplicationAppraisalApprovalRequestCode);
        
        //Legal Due Diligence
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnSendLegalDueDiligenceForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnSendLegalDueDiligenceForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnSendLegalDueDiligenceForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnCancelLegalDueDiligenceApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnCancelLegalDueDiligenceApprovalRequestCode);
        
        //Risk Analysis
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnSendRiskAnalysisForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnSendRiskAnalysisForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnSendRiskAnalysisForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnCancelRiskAnalysisApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnCancelRiskAnalysisApprovalRequestCode);
        
        //Loan Account
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnSendLoanAccountForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnSendLoanAccountForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnSendLoanAccountForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnCancelLoanAccountApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnCancelLoanAccountApprovalRequestCode);
        
        //Disbursement Request
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnSendDisbursementRequestForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnSendDisbursementRequestForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnSendDisbursementRequestForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnCancelDisbursementRequestApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnCancelDisbursementRequestApprovalRequestCode);
        
        //Account Closure
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnSendAccountClosureForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnSendAccountClosureForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnSendAccountClosureForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnCancelAccountClosureApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                  InvestmentWorkflowEvents.RunWorkflowOnCancelAccountClosureApprovalRequestCode);
        
        */
        
        //------------------------------------End Investment Management Response Predecessors----------------------------------------------

    end;
}

