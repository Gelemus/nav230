page 50670 "Casual Requisition Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "HR Employee Requisitions";
    SourceTableView = WHERE(Status = FILTER(<> Closed));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                    Visible = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field(Voted; Rec.Voted)
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field(Department; Rec.Department)
                {
                    Caption = 'Division';
                    Visible = false;
                }
                field("Budget GL"; Rec."Budget GL")
                {
                }
                field("Budget GL Name"; Rec."Budget GL Name")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = true;
                }
                field(Section; Rec.Section)
                {
                    Caption = 'Unit';
                    Visible = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                }
                field("Project No"; Rec."Project No")
                {
                }
                field("Project Name"; Rec."Project Name")
                {
                }
            }
            group(Requirements)
            {
                field("Job Title"; Rec."Job Title")
                {
                }
                field("Date Required"; Rec."Date Required")
                {
                    Visible = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Skilled Casual Rate"; Rec."Skilled Casual Rate")
                {
                }
                field("Number Required - Skilled"; Rec."Number Required - Skilled")
                {
                }
                field("Days for Engagement - Skilled"; Rec."Days for Engagement - Skilled")
                {
                }
                field("Daily Rate Skilled"; Rec."Daily Rate Skilled")
                {
                    Caption = 'Daily Rate Skilled';
                }
                field("Total Skilled"; Rec."Total Skilled")
                {
                }
                field("Unskilled Casual Rate"; Rec."Unskilled Casual Rate")
                {
                }
                field("Number Required - Unskilled"; Rec."Number Required - Unskilled")
                {
                }
                field("Days for Engagement - Unkilled"; Rec."Days for Engagement - Unkilled")
                {
                }
                field("Daily Rate Unskilled"; Rec."Daily Rate Unskilled")
                {
                }
                field("Number Required"; Rec."Number Required")
                {
                    Visible = false;
                }
                field("Total Unskilled"; Rec."Total Unskilled")
                {
                }
                field("Piece Work"; Rec."Piece Work")
                {
                }
                field("Other Casual Rate"; Rec."Other Casual Rate")
                {
                }
                field("No of Meters/others"; Rec."No of Meters/others")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Total Piece Work"; Rec."Total Piece Work")
                {
                    Editable = false;
                }
                field("Estimated Total Cost of Work"; Rec."Estimated Total Cost of Work")
                {
                }
                field("Reason for engagement"; Rec."Reason for engagement")
                {
                    Caption = 'Reason for engaging casual labour';
                }
                field("Main Duties"; Rec."Main Duties")
                {
                    MultiLine = true;
                }
                field("Qualifications Required"; Rec."Qualifications Required")
                {
                    Visible = false;
                }
                field("No of Years of Experience"; Rec."No of Years of Experience")
                {
                    MultiLine = true;
                    Visible = false;
                }
                field("Specific Experience Required"; Rec."Specific Experience Required")
                {
                    MultiLine = true;
                    Visible = false;
                }
                field("Specific Skills Required"; Rec."Specific Skills Required")
                {
                    MultiLine = true;
                    Visible = false;
                }
                field("Age bracket"; Rec."Age bracket")
                {
                    Visible = false;
                }
            }
            part("Approval Enttries I"; "Approval Enttries I")
            {
                Caption = 'Approval Entries';
                SubPageLink = "Document No." = FIELD("No.");
                ToolTip = 'Approval Entries';
            }
        }
        area(factboxes)
        {
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
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(Control32; Links)
            {
                Visible = false;
            }
            systempart(Control28; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(ActionGroup37)
            {
                action("Vote Casual Requisition")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vote Casual Requisition';
                    ToolTip = 'Vote Casual Requisition';

                    trigger OnAction()
                    begin
                        /*TESTFIELD(Status,Status::"Pending Approval");
                        TESTFIELD("Start Date");
                        TESTFIELD("End Date");*/
                        //END;justo 01022024
                        if UserSetup.Get(UserId) then
                            if not UserSetup.CommitBudget then begin

                                Error('Ooops!Kindly Contact ICT for Permission to Vote');
                                //TESTFIELD("Requested Employees");}
                                if DIALOG.Confirm('Are you sure you wish to vote this Casual Requisition') then
                                    //HrEcodeumployeeManagt.commitCasualGLBudget(Rec);
                                Message('Voted Successfully');
                            end;


                        /*HRMandatoryDocChecklist.RESET;
                        HRMandatoryDocChecklist.SETRANGE(HRMandatoryDocChecklist."Document No.","No.");
                        IF HRMandatoryDocChecklist.FINDSET THEN BEGIN
                         REPEAT
                         UNTIL HRMandatoryDocChecklist.NEXT=0;
                        END;
                        
                        IF ApprovalsMgmt.CheckHREmployeeRequisitionApprovalsWorkflowEnabled(Rec) THEN
                        ApprovalsMgmt.OnSendHREmployeeRequisitionForApproval(Rec);
                        CurrPage.CLOSE*/

                    end;
                }
                action("UnVote/Decommit Casual Requisition")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'UnVote/Decommit Casual Requisition';
                    ToolTip = 'UnVote/Decommit Casual Requisition';

                    trigger OnAction()
                    begin
                        /*TESTFIELD(Status,Status::"Pending Approval");
                        TESTFIELD("Start Date");
                        TESTFIELD("End Date");*/
                        //END;justo 01022024
                        if UserSetup.Get(UserId) then
                            if not UserSetup.CommitBudget then begin

                                Error('Ooops!Kindly Contact ICT for Permission to Vote');
                                //TESTFIELD("Requested Employees");}
                                if DIALOG.Confirm('Are you sure you wish to vote this Casual Requisition') then
                                    HrEcodeumployeeManagt.ReverseCasualRequisitions(Rec);
                                Message('UnVoted Successfully');
                            end;


                        /*HRMandatoryDocChecklist.RESET;
                        HRMandatoryDocChecklist.SETRANGE(HRMandatoryDocChecklist."Document No.","No.");
                        IF HRMandatoryDocChecklist.FINDSET THEN BEGIN
                         REPEAT
                         UNTIL HRMandatoryDocChecklist.NEXT=0;
                        END;
                        
                        IF ApprovalsMgmt.CheckHREmployeeRequisitionApprovalsWorkflowEnabled(Rec) THEN
                        ApprovalsMgmt.OnSendHREmployeeRequisitionForApproval(Rec);
                        CurrPage.CLOSE*/

                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;
                    ToolTip = 'Send Approval Request';

                    trigger OnAction()
                    begin
                        if Rec."Requisition Approved" = false then begin
                            Rec.TestField(Status, Rec.Status::Open);
                            Rec.TestField("Start Date");
                            Rec.TestField("End Date");
                        end;
                        //TESTFIELD("Requested Employees");

                        HREmployeeManagement.commitCasualGLBudget(Rec);
                        HRMandatoryDocChecklist.Reset;
                        HRMandatoryDocChecklist.SetRange(HRMandatoryDocChecklist."Document No.", Rec."No.");
                        if HRMandatoryDocChecklist.FindSet then begin
                            repeat
                            until HRMandatoryDocChecklist.Next = 0;
                        end;

                        if ApprovalsMgmt.CheckHREmployeeRequisitionApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendHREmployeeRequisitionForApproval(Rec);
                        CurrPage.Close
                    end;
                }
                action("Budget Committment Lines")
                {
                    ApplicationArea = Suite;
                    Caption = 'Budget Committment Lines';
                    RunObject = Page "Budget Committment Lines";
                    RunPageLink = "Document No." = FIELD("No.");

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ",Payment,Receipt,Imprest,"Imprest Surrender","Funds Refund",Requisition,"Funds Transfer","HR Document";
                    begin
                        //WorkflowsEntriesBuffer.RunWorkflowEntriesDocumentPage(RECORDID,DATABASE::"HR Employee Requisitions","No.");
                    end;
                }
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Approval Entries";
                    RunPageLink = "Document No." = FIELD("No.");
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ",Payment,Receipt,Imprest,"Imprest Surrender","Funds Refund",Requisition,"Funds Transfer","HR Document";
                    begin
                        //WorkflowsEntriesBuffer.RunWorkflowEntriesDocumentPage(RECORDID,DATABASE::"HR Employee Requisitions","No.");
                    end;
                }
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
                    ToolTip = 'Reject the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action("Print Casual Requisition")
                {
                    Caption = 'Print Casual Requisition';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        CasualRec.Reset;
                        CasualRec.SetRange(CasualRec."No.", Rec."No.");
                        if CasualRec.FindFirst then begin
                            REPORT.RunModal(REPORT::"Casual Requisition", true, false, CasualRec);
                        end;
                    end;
                }
                group(ActionGroup29)
                {
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        //IF HREmployeeManagement.ReverseCasualRequisitions(Rec),TRUE THEN
                        //ApprovalsMgmt.OnCancelHREmployeeRequisitionApprovalRequest(Rec);
                        HREmployeeManagement.ReverseCasualRequisitions(Rec);
                        //WorkflowWebhookMgt.FindAndCancel(RECORDID);
                        //CurrPage.CLOSE
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Type" := Rec."Document Type"::"Casual Request";
    end;

    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::Open then begin
            EmployeeContractCodeEditable := false;
            RequisitionTypeEditable := false;
            ClosingDateEditable := false;
            InterviewDateEditable := false;
            InterviewTimeEditable := false;
            InterviewLocationEditable := false;
        end;

        if Rec.Status = Rec.Status::Released then begin
            EmployeeContractCodeEditable := true;
            RequisitionTypeEditable := true;
            ClosingDateEditable := true;
            InterviewDateEditable := true;
            InterviewTimeEditable := true;
            InterviewLocationEditable := true;
        end;
    end;

    var
        ApproveRequisitionForJobApplication: Label 'Approve Employee Requisition Form %1 for Job Application?';
        ApproveRequisitionSuccessful: Label 'Employee Requisition Approved Successfully.';
        JobApplicantShortlisting: Label 'Job Applicant Shortlisting is Successful.';
        HRJobManagement: Codeunit "HR Job Management";
        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
        EmployeeRecruitment: Codeunit "HR Employee Recruitment";
        HREmployeeRequisitions: Record "HR Employee Requisitions";
        PurchaseRequisitions: Record "Purchase Requisitions";
        "Purchases&PayablesSetup": Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HRJobApplications: Record "HR Job Applications";
        EmployeeContractCodeEditable: Boolean;
        RequisitionTypeEditable: Boolean;
        ClosingDateEditable: Boolean;
        InterviewDateEditable: Boolean;
        InterviewTimeEditable: Boolean;
        InterviewLocationEditable: Boolean;
        PurchaseRequisitionLine: Record "Purchase Requisition Line";
        Txt080: Label 'Are you sure you want to Publish the Job Advertisement? Please note this will make the Job Advertisement to be visible on the portal for Applications.';
        Txt081: Label 'Are you sure you want to drop the Published Job Advertisement? Please note this will make the Job Advertisement not to be visible on the portal for Applications.';
        ERROR_001: Label 'You need send a regret Email to unsucessful Job applicants before closing the Employee requisition process. Please send a regret Email to unsuccessful candidates to Proceed with the Job Closing process.';
        HRJobs: Record "HR Jobs";
        Txt082: Label 'A purchase requisition has already been created';
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        Txt083: Label 'Job succesfully published for advetisement on the portal and an E-mail has been sent to ICT department';
        Txt084: Label 'Job advertisement has succesfully been pulled down from the Job application portal';
        HRJobLookupValue: Record "HR Job Lookup Value";
        HRMandatoryDocChecklist: Record "HR Mandatory Doc. Checklist";
        ERROR_002: Label 'Please Attach the Mandatory Documents required to proceed';
        CasualRec: Record "HR Employee Requisitions";
        UserSetup: Record "User Setup";
        HrEcodeumployeeManagt: Codeunit "HR Employee Management";
        HREmployeeManagement: Codeunit "HR Employee Management";
}

