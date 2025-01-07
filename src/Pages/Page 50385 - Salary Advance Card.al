page 50385 "Salary Advance Card"
{
    DeleteAllowed = true;
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
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field(Employee; Rec.Employee)
                {
                }
                field("First Name"; Rec."First Name")
                {
                }
                field("Last Name"; Rec."Last Name")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("USER ID"; Rec."USER ID")
                {
                }
                field(HOD; Rec.HOD)
                {
                }
                field(Supervisor; Rec.Supervisor)
                {
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                }
                field("Advance Type"; Rec."Advance Type")
                {
                }
                field("Loan Types"; Rec."Loan Types")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                }
                field(Principal; Rec.Principal)
                {
                }
                field("Principal (LCY)"; Rec."Principal (LCY)")
                {
                }
                field("Start Period"; Rec."Start Period")
                {
                }
                field(Installments; Rec.Installments)
                {
                }
                field("Purpose of Salary Advance"; Rec."Purpose of Salary Advance")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = true;
                }
                field("Installment Amount"; Rec."Installment Amount")
                {

                    trigger OnValidate()
                    begin
                        CheckAthirdRule
                    end;
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                }
                field("1/3 Basic Pay"; Rec."1/3 Basic Pay")
                {
                }
                field("Gross Amount"; Rec."Gross Amount")
                {
                }
                field("Total Deductions"; Rec."Total Deductions")
                {
                }
                field("Net Pay"; Rec."Net Pay")
                {
                }
                field("Net Pay after Advance"; Rec."Net Pay after Advance")
                {
                }
                field("Terms of Employement"; Rec."Terms of Employement")
                {
                }
                field("File Name"; Rec."File Name")
                {
                }
                field("Document Name"; Rec."Document Name")
                {
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                }
            }
        }
        area(factboxes)
        {
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = Advanced;
                Visible = false;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Advanced;
                ShowFilter = false;
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
            group(ActionGroup4)
            {
                action("Create Loan")
                {
                    Caption = 'Create Loan';
                    Image = CreateDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        //TESTFIELD(Status,Status::Approved);
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
                    RunObject = Page "Approval Entries";
                    RunPageLink = "Document No." = FIELD(ID);
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
                        if (Rec."Advance Type" = Rec."Advance Type"::"Salary Advance") and (Rec."Net Pay after Advance" < Rec."1/3 Basic Pay") then begin
                            Error('This will violate a third rule,Kindly talk to HR Manager or Reduce the amount you are Requesting');
                        end else if (Rec."Advance Type" = Rec."Advance Type"::"Salary in Advance") and (Rec."Net Pay after Advance" <> 0) then begin
                            Error('This will violate a third rule,Kindly talk to HR Manager');
                        end else
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
                        // ApprovalsMgmt.OnCancelSalaryAdvanceApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }
            }
        }
        area(reporting)
        {
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
            action(Release)
            {
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Open then
                        Rec.Status := Rec.Status::Approved;
                    Rec.Modify;
                end;
            }
            separator(Separator16)
            {
            }
            action("Salary Advance")
            {
                Caption = 'Salary Advance';
                Image = CustomerLedger;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Rec.SetRange(ID, Rec.ID);
                    REPORT.Run(REPORT::"Salary Advance", true, true, Rec);
                end;
            }
            action(AttachedDoc)
            {
                ApplicationArea = Suite;
                Caption = 'View  Attached Document';
                Image = ViewOrder;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'View any incoming document records and file attachments that exist for the entry or document, for example for auditing purposes';
                Visible = false;

                trigger OnAction()
                var
                    IncomingDocument: Record "Incoming Document";
                    PortalSetup: Record "Portal Setup";
                begin
                    //IncomingDocument.ShowCardFromEntryNo("Incoming Document Entry No.");
                    PortalSetup.Get;
                    HyperLink(PortalSetup."Server File Path" + Rec."File Name");
                end;
            }
            action(AttachedDoc1)
            {
                ApplicationArea = Suite;
                Caption = 'View  Attached Document';
                Image = ViewOrder;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'View any incoming document records and file attachments that exist for the entry or document, for example for auditing purposes';

                trigger OnAction()
                var
                    IncomingDocument: Record "Incoming Document";
                    PortalSetup: Record "Portal Setup";
                begin
                    //IncomingDocument.ShowCardFromEntryNo("Incoming Document Entry No.");
                    PortalSetup.Get;
                    HyperLink(PortalSetup."Server File Path" + Rec."File Name");
                end;
            }
        }
        area(navigation)
        {
            group(IncomingDocument)
            {
                Caption = 'Incoming Document';
                Image = Documents;
                action(IncomingDocCard)
                {
                    ApplicationArea = Suite;
                    Caption = 'View Incoming Document';
                    Enabled = HasIncomingDocument;
                    Image = ViewOrder;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    ToolTip = 'View any incoming document records and file attachments that exist for the entry or document, for example for auditing purposes';

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        IncomingDocument.ShowCardFromEntryNo(Rec."Incoming Document Entry No.");
                    end;
                }
                action(SelectIncomingDoc)
                {
                    AccessByPermission = TableData "Incoming Document" = R;
                    ApplicationArea = Suite;
                    Caption = 'Select Incoming Document';
                    Image = SelectLineToApply;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    ToolTip = 'Select an incoming document record and file attachment that you want to link to the entry or document.';

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        Rec.Validate("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument(Rec."Incoming Document Entry No.", Rec.RecordId));
                    end;
                }
                action(IncomingDocAttachFile)
                {
                    ApplicationArea = Suite;
                    Caption = 'Create Incoming Document from File';
                    Ellipsis = true;
                    Enabled = CreateIncomingDocumentEnabled;
                    Image = Attach;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    ToolTip = 'Create an incoming document from a file that you select from the disk. The file will be attached to the incoming document record.';

                    trigger OnAction()
                    var
                        IncomingDocumentAttachment: Record "Incoming Document Attachment";
                    begin
                        IncomingDocumentAttachment.NewAttachmentFromSalaryAdvanceDocument(Rec);
                    end;
                }
                action(RemoveIncomingDoc)
                {
                    ApplicationArea = Suite;
                    Caption = 'Remove Incoming Document';
                    Enabled = HasIncomingDocument;
                    Image = RemoveLine;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    ToolTip = 'Remove any incoming document records and file attachments.';

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        if IncomingDocument.Get(Rec."Incoming Document Entry No.") then
                            IncomingDocument.RemoveLinkToRelatedRecord;
                        Rec."Incoming Document Entry No." := 0;
                        Rec.Modify(true);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Advance;
        Rec."Advance Type" := Rec."Advance Type"::"Salary Advance";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Advance;
        Rec."Advance Type" := Rec."Advance Type"::"Salary in Advance";
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
        FileManagement: Codeunit "File Management Upload";

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
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabled := (not HasIncomingDocument) and (Rec.ID <> '');

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);

        if (Rec.Status = Rec.Status::Open) or (Rec.Status = Rec.Status::"Pending Approval") then begin
            PageEditable := true;
        end else begin
            PageEditable := false;
        end;
    end;
}

