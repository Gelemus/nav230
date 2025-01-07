page 50390 "Salary Advance Card Approved"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Salary Advance";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(ID; Rec.ID)
                {
                    Editable = false;
                    Visible = false;
                }
                field(Employee; Rec.Employee)
                {
                    Editable = false;
                }
                field("First Name"; Rec."First Name")
                {
                    Editable = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Loan Types"; Rec."Loan Types")
                {
                    Editable = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Editable = false;
                }
                field(Principal; Rec.Principal)
                {
                    Editable = false;
                }
                field("Principal (LCY)"; Rec."Principal (LCY)")
                {
                    Editable = false;
                }
                field(Installments; Rec.Installments)
                {
                }
                field("Purpose of Salary Advance"; Rec."Purpose of Salary Advance")
                {
                    Editable = false;
                }
                field("Installment Amount"; Rec."Installment Amount")
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        CheckAthirdRule
                    end;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                group("Official Use Only")
                {
                    field("Basic Pay"; Rec."Basic Pay")
                    {
                    }
                    field("1/3 Basic Pay"; Rec."1/3 Basic Pay")
                    {
                    }
                    field("Net Pay"; Rec."Net Pay")
                    {
                    }
                    field("Net Pay after Advance"; Rec."Net Pay after Advance")
                    {
                    }
                    field("Start Period"; Rec."Start Period")
                    {
                    }
                    field("Terms of Employement"; Rec."Terms of Employement")
                    {
                    }
                    field("Contract End Date"; Rec."Contract End Date")
                    {
                    }
                    field("USER ID"; Rec."USER ID")
                    {
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(ActionGroup43)
            {
                Caption = 'Approvals';
            }
            action(Payslip)
            {
                Caption = 'Payslip';
                Image = PrintCheck;
                Promoted = true;
                PromotedCategory = "Report";
                Visible = false;

                trigger OnAction()
                var
                    lvPeriods: Record Periods;
                    lvEmployee: Record Employee;
                    lvPayslip: Report "Portal Payslips";
                begin
                    lvPeriods.SetRange("Period ID", Rec."Start Period");
                    lvEmployee.SetRange("No.", Rec.Employee);
                    lvPayslip.SetTableView(lvPeriods);
                    lvPayslip.SetTableView(lvEmployee);
                    lvPayslip.RunModal;
                end;
            }
            action("Salary Advance Report")
            {
                Caption = 'Salary Advance';
                Image = CustomerContact;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Rec.SetRange(ID, xRec.ID);
                    REPORT.Run(REPORT::"Salary Advance", true, true, Rec);
                end;
            }
            action("Phone Advance Report")
            {
                Caption = 'Phone Advance';
                Image = DateRange;
                Promoted = true;
                PromotedCategory = "Report";
                Visible = false;

                trigger OnAction()
                begin
                    Rec.SetRange(ID, xRec.ID);
                    REPORT.Run(REPORT::"Phone Advance", true, true, Rec);
                end;
            }
            action("Laptop Advance Report")
            {
                Caption = 'Laptop Advance';
                Image = CustomerRating;
                Promoted = true;
                PromotedCategory = "Report";
                Visible = false;

                trigger OnAction()
                begin
                    Rec.SetRange(ID, xRec.ID);
                    REPORT.Run(REPORT::"Laptop Advance", true, true, Rec);
                end;
            }
            group(ActionGroup4)
            {
                action("Create Loan")
                {
                    Caption = 'Create Loan';
                    Image = CreateDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);
                        Rec.CreateLoan;
                    end;
                }
            }
            group(RequestApproval)
            {
                Caption = 'Request Approval';
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
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ",Payment,Receipt,Imprest,"Imprest Surrender","Funds Refund","Purchase Requisition";
                    begin
                        //WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RECORDID,DATABASE::"Payment Header",DocType::Payment,"No.");
                    end;
                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField("Installment Amount");
                        Rec.TestField(Principal);
                        Rec.TestField(Employee);
                        Rec.TestField("Start Period");
                        Rec.TestField(Status, Rec.Status::Open);
                        // if ApprovalsMgmt.CheckSalaryAdvanceApprovalsWorkflowEnabled(Rec) then
                        //   ApprovalsMgmt.OnSendSalaryAdvanceForApproval(Rec);

                        CurrPage.Close;
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        //ApprovalsMgmt.OnCancelSalaryAdvanceApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }
                action(Reopen)
                {

                    trigger OnAction()
                    begin
                        if Rec.Status = Rec.Status::Approved then
                            Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Advance
    end;

    var
        gvAllowedPayrolls: Record "Allowed Payrolls";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
        PageEditable: Boolean;
        UserSetup: Record "User Setup";
        FundsApprovalManager: Codeunit "Funds Approval Manager";

    procedure MarkClearedLoans()
    var
        lvLoan: Record "Loans/Advances";
    begin
        //skm 130405
        lvLoan.SetRange(Cleared, false);
        lvLoan.SetRange(Created, true);
        if lvLoan.Find('-') then
            repeat
                lvLoan.CalcFields("Remaining Debt");
                if lvLoan."Remaining Debt" = 0 then begin
                    lvLoan.Cleared := true;
                    lvLoan.Modify
                end
            until lvLoan.Next = 0;

        Rec.SetRange(Cleared, false);
    end;

    procedure CreateBatch()
    begin
        if not Confirm('Create all loans with a tick on Create field and within your current filters?', false) then exit;
        gvAllowedPayrolls.SetRange("User ID", UserId);
        gvAllowedPayrolls.SetRange("Last Active Payroll", true);
        gvAllowedPayrolls.FindFirst;
        Rec.SetRange(Create, true);
        Rec.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
        if Rec.Find('-') then
            repeat
                Rec.CreateLoan
            until Rec.Next = 0;

        Rec.Reset;
        Rec.SetRange(Cleared, false);
        Message('Loans successfully created.')
    end;

    procedure PayBatch()
    begin
        if not Confirm('Pay all loans with a tick on Pay field and within your current filters?', false) then exit;
        gvAllowedPayrolls.SetRange("User ID", UserId);
        gvAllowedPayrolls.SetRange("Last Active Payroll", true);
        gvAllowedPayrolls.FindFirst;
        Rec.SetRange(Pay, true);
        Rec.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
        if Rec.Find('-') then
            repeat
                Rec.PayLoan
            until Rec.Next = 0;

        Rec.Reset;
        Rec.SetRange(Cleared, false);
        Message('Loans successfully paid.')
    end;

    procedure gsSegmentPayrollData()
    var
        lvAllowedPayrolls: Record "Allowed Payrolls";
        lvPayrollUtilities: Codeunit "Payroll Posting";
        UsrID: Code[10];
        UsrID2: Code[10];
        StringLen: Integer;
        lvActiveSession: Record "Active Session";
    begin
        /*lvSession.SETRANGE("My Session", TRUE);
        lvSession.FINDFIRST; //fire error in absence of a login
        IF lvSession."Login Type" = lvSession."Login Type"::Database THEN
          lvAllowedPayrolls.SETRANGE("User ID", USERID)
        ELSE*/

        lvActiveSession.Reset;
        lvActiveSession.SetRange("Server Instance ID", ServiceInstanceId);
        lvActiveSession.SetRange("Session ID", SessionId);
        lvActiveSession.FindFirst;


        lvAllowedPayrolls.SetRange("User ID", lvActiveSession."User ID");
        lvAllowedPayrolls.SetRange("Last Active Payroll", true);
        if lvAllowedPayrolls.FindFirst then
            Rec.SetRange("Payroll Code", lvAllowedPayrolls."Payroll Code")
        else
            Error('You are not allowed access to this payroll dataset.');
        Rec.FilterGroup(100);

    end;

    local procedure CheckAthirdRule()
    begin
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        //HasIncomingDocument := "Incoming Document Entry No." <> 0;
        //CreateIncomingDocumentEnabled := (NOT HasIncomingDocument) AND ("No." <> '');

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
        /*
        IF (Status=Status::Open) OR (Status=Status::"Pending Approval") THEN BEGIN
          PageEditable:=TRUE;
        END ELSE BEGIN
          PageEditable:=FALSE;
        END;
        */

    end;
}

