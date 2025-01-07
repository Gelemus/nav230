page 51227 "Payroll Period Card1"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = Periods;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Period ID"; Rec."Period ID")
                {
                }
                field("Period Month"; Rec."Period Month")
                {
                }
                field("Period Year"; Rec."Period Year")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field(Hours; Rec.Hours)
                {
                }
                field(Days; Rec.Days)
                {
                }
                field("Tax Penalties"; Rec."Tax Penalties")
                {
                }
                field("Low Interest Benefit %"; Rec."Low Interest Benefit %")
                {
                }
                field("NHIF Period Start"; Rec."NHIF Period Start")
                {
                }
                field("Payroll Code"; Rec."Payroll Code")
                {
                }
                field("Annualize TAX"; Rec."Annualize TAX")
                {
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(51151),
                              "No." = FIELD("Document No");
            }
            systempart(Control47; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action(OverallCompanyPayslip)
            {
                Caption = 'Overall Company Payslip';
                Image = "Report";
                Promoted = false;
                Visible = false;

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        OverallCompanyPayslip.SetTableView(Periods);
                        OverallCompanyPayslip.Run;
                    end;
                end;
            }
            action(CompanyPayslip)
            {
                Caption = 'CompanyPayslip';
                Image = "Report";

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        CompanyPayslip.SetTableView(Periods);
                        CompanyPayslip.Run;
                    end;
                end;
            }
            action("Master Roll Report")
            {
                Caption = 'Master Roll Report';
                Image = "Report";

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        MasterRollReport.SetTableView(Periods);
                        MasterRollReport.Run;
                    end;
                end;
            }
            separator(Separator43)
            {
            }
            action(PayrollAllowanceReport)
            {
                Caption = 'Leave Allowance Report';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                Visible = false;

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        PayrollAllowanceReport.SetTableView(Periods);
                        PayrollAllowanceReport.Run;
                    end;
                end;
            }
            action(EdReport)
            {
                Caption = ' ED Report';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        EDReport.SetTableView(Periods);
                        EDReport.Run;
                    end;
                end;
            }
            action(Payslips)
            {
                Caption = 'Payslips';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                Visible = false;

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        Payslips.SetTableView(Periods);
                        Payslips.Run;
                    end;
                end;
            }
            separator(Separator40)
            {
            }
            action(PayrollReconciliation)
            {
                Caption = 'Payroll Reconciliation-All ED';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        PayrollReconciliationAllED.SetTableView(Periods);
                        PayrollReconciliationAllED.Run;
                    end;
                end;
            }
            action(PayrollReconciliationPerEd)
            {
                Caption = 'Payroll Reconciliation-Per ED';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        PayrollReconciliationPerED.SetTableView(Periods);
                        PayrollReconciliationPerED.Run;
                    end;
                end;
            }
            action(BankPaymentList)
            {
                Caption = 'Bank Payment List';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        BankPaymentList.SetTableView(Periods);
                        BankPaymentList.Run;
                    end;
                end;
            }
            action(BankPaymentReport)
            {
                Caption = 'Salaries Bank Payment';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                Visible = false;

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        BankPaymentReport.SetTableView(Periods);
                        BankPaymentReport.Run;
                    end;
                end;
            }
            separator(Separator31)
            {
            }
            action(PensionReport)
            {
                Caption = 'Pension Report';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        PensionReport.SetTableView(Periods);
                        PensionReport.Run;
                    end;
                end;
            }
            action(NSSFReport)
            {
                Caption = 'NSSF Report';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                Visible = false;

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        NSSFReport.SetTableView(Periods);
                        NSSFReport.Run;
                    end;
                end;
            }
            action(NHIFReport)
            {
                Caption = 'NHIF Report';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                Visible = false;

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        NHIFReport.SetTableView(Periods);
                        NHIFReport.Run;
                    end;
                end;
            }
            action(PayeReport)
            {
                Caption = 'PAYE Report';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                Visible = false;

                trigger OnAction()
                begin
                    Periods.Reset;
                    Periods.SetRange("Period ID", Rec."Period ID");
                    if Periods.FindFirst then begin
                        PAYEReport.SetTableView(Periods);
                        PAYEReport.Run;
                    end;
                end;
            }
        }
        area(processing)
        {
            action("Send Approval Request")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //check substitute
                    //TESTFIELD("Substitute No.");
                    Rec.TestField("Approval Status", "Approval Status"::Open);
                    //TESTFIELD(appro

                    //HRLeaveManagement.CheckLeaveApplicationMandatoryFields(Rec,FALSE);

                    if ApprovalsMgmt.CheckPayrollApprovalsWorkflowEnabled(Rec) then
                        ApprovalsMgmt.CheckPayrollApprovalsWorkflowEnabled(Rec);
                end;
            }
            action(ReOpen)
            {
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    /*
                    IF CONFIRM(ReOpenLeaveApplication,FALSE,"No.") THEN BEGIN
                      Status:=Status::Open;
                      MODIFY;
                    END;
                    */

                end;
            }
            action(Approvals)
            {
                AccessByPermission = TableData "Approval Entry" = R;
                ApplicationArea = Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Approval Entries";
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                trigger OnAction()
                var
                    WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ",Payment,Receipt,Imprest,"Imprest Surrender","Funds Refund",Requisition,"Funds Transfer","HR Document",Property,CRM,"Transport Request",Leave,"Leave Plan","Store Requisition","Salary Advance",Allowance,Payroll;
                begin
                    // WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId,DATABASE::Periods,DocType::Payroll,Rec."Period ID"+'-'+Rec."Payroll Code");
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Cancel the approval request.';

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
                    WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                begin
                    ApprovalsMgmt.CheckPayrollApprovalsWorkflowEnabled(Rec);
                    ApprovalsMgmt.OnCancelPayrollApprovalRequest(Rec);
                    WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
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
                    PromotedOnly = true;
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
                    PromotedOnly = true;
                    ToolTip = 'Reject the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'Delegate the requested changes to the substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
    end;

    var
        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        NHIFReport: Report "NHIF Report";
        NSSFReport: Report "NSSF Report";
        CompanyPayslip: Report "Company Payslip";
        PayrollReconciliationAllED: Report "Payroll Reconciliation-All ED";
        PayrollReconciliationPerED: Report "Payroll Reconciliation-Per ED";
        PAYEReport: Report "PAYE Report";
        Payslips: Report Payslips;
        Periods: Record Periods;
        EDReport: Report "ED Report";
        MasterRollReport: Report "Master Roll Report";
        PayrollAllowanceReport: Report "Payroll Allowance Report";
        PensionReport: Report "Pension Report";
        BankPaymentList: Report "Bank Payment List";
        BankPaymentReport: Report "Bank Payment Report";
        OverallCompanyPayslip: Report "Overall Company Payslip";

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);

        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        WorkflowWebhookManagement.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;
}

