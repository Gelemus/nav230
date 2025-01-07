page 50248 "HR Employee Exit Interviews"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Exit Interview';
    SourceTable = "HR Employee Exit Interviews";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Exit Interview No"; Rec."Exit Interview No")
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Importance = Promoted;

                    trigger OnValidate()
                    begin



                        if HREmp.Get(Rec."Employee No.") then begin
                            JobTitle := HREmp."Job Title";
                            sUserID := HREmp."User ID";
                        end else begin
                            JobTitle := '';
                            sUserID := '';
                            Rec."Global Dimension 2 Code" := HREmp."Global Dimension 2 Code";
                        end;

                        RecalcDates;
                        EmployeeNoOnAfterValidate;
                    end;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field("HR Job Title"; Rec."HR Job Title")
                {
                }
                field("National ID No."; Rec."National ID No.")
                {
                    Editable = false;
                }
                field("Passport No."; Rec."Passport No.")
                {
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                }
                field("Employement Date"; Rec."Employement Date")
                {
                    Editable = false;
                }
                field("Date Of Interview"; Rec."Date Of Interview")
                {
                    Importance = Promoted;
                }
                field("Interview Done By"; Rec."Interview Done By")
                {
                    Importance = Promoted;
                }
                field("Interviewer Name"; Rec."Interviewer Name")
                {
                }
                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                    Importance = Promoted;
                }
                field("Reason For Leaving (Other)"; Rec."Reason For Leaving (Other)")
                {
                    Importance = Promoted;
                }
                field("Date Of Separation"; Rec."Date Of Separation")
                {
                    Importance = Promoted;
                }
                field("Employement Years of Service"; Rec."Employement Years of Service")
                {
                }
                field("Re Employ In Future"; Rec."Re Employ In Future")
                {
                    Importance = Promoted;
                }
                field("Clearance Form Submitted"; Rec."Clearance Form Submitted")
                {
                    Caption = 'Clearance Form Submitted';
                }
            }
            group("Pension Details")
            {
                Caption = 'Pension Details';
                field("Vendor No."; Rec."Vendor No.")
                {
                }
                field("Pension Provider"; Rec."Pension Provider")
                {
                    ShowMandatory = true;
                }
                field("Pension Letter Recipient Name"; Rec."Pension Letter Recipient Name")
                {
                    ShowMandatory = true;
                }
                field("Pension Provider Address"; Rec."Pension Provider Address")
                {
                    ShowMandatory = true;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1; Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Exit Interview")
            {
                Caption = '&Exit Interview';
                action("Print Exit Int. Questionnare")
                {
                    Caption = 'Print Exit Interview Questionnaire';
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin

                        Rec.SetRange("Exit Interview No", Rec."Exit Interview No");
                        //ReportSelections.Print(ReportSelections.Usage::"Exit Interview",Rec,0);
                    end;
                }
                action("Print Departmental Clearance")
                {
                    Caption = 'Print Departmental Clearance';
                    Image = CheckList;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin

                        Rec.SetRange("Exit Interview No", Rec."Exit Interview No");
                        // ReportSelections.Print(ReportSelections.Usage::"Clearance Form",Rec,0);
                    end;
                }
                action("Retirement From Pension Letter")
                {
                    Image = CreateJobSalesCreditMemo;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Headers.Reset;
                        Headers.SetRange(Headers."Exit Interview No", Rec."Exit Interview No");
                        if Headers.FindFirst then begin
                            REPORT.RunModal(REPORT::"Retirement From Pension Letter", true, false, Headers);
                        end;
                    end;
                }
                action("EmployeeCertificate of Service")
                {
                    Image = Certificate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Headers.Reset;
                        Headers.SetRange(Headers."Exit Interview No", Rec."Exit Interview No");
                        if Headers.FindFirst then begin
                            REPORT.RunModal(REPORT::"EmployeeCertificate of Service", true, false, Headers);
                        end;
                    end;
                }
                action("Post Separation Details")
                {
                    Caption = 'Post Separation Details';
                    Image = ConfidentialOverview;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Rec.TestField("Date Of Separation");
                        Rec.TestField("Interview Done By");
                        Rec.TestField("Grounds for Term. Code");
                        if Rec."Grounds for Term. Code" = 'OTHER' then begin
                            Rec.TestField("Reason For Leaving (Other)");
                        end;

                        if Confirm(ConfirmPostIng, false, Rec."Exit Interview No") then begin
                            Headers.Reset;
                            Headers.SetRange(Headers."Exit Interview No", Rec."Exit Interview No");
                            if Headers.FindFirst then begin
                                Employee.Get(Headers."Employee No.");
                                Employee.Status := Employee.Status::Inactive;
                                Employee."Grounds for Term. Code" := Headers."Grounds for Term. Code";
                                Employee."Reason For Leaving (Other)" := Headers."Reason For Leaving (Other)";
                                Employee."Date of Leaving" := Headers."Date Of Separation";
                                Employee."Termination Date" := Headers."Date Of Separation";
                                Employee.Modify;
                                Rec.Posted := true;
                            end;
                        end;
                        Message(SeparationDetailsPosted);
                    end;
                }
                action("Calculate Years of Service")
                {
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        HREmployeeExitInterviews.Reset;
                        HREmployeeExitInterviews.SetRange(HREmployeeExitInterviews."Employee No.", Rec."Employee No.");
                        if HREmployeeExitInterviews.FindFirst then
                            HREmployeeExitInterviews."Employement Years of Service" := Dates.DetermineAge_Years(Rec."Employement Date", Rec."Date Of Separation");
                    end;
                }
                action("Employee Leave Ledger")
                {
                    Image = ItemLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Leave Ledger Entries";
                    RunPageLink = "Employee No." = FIELD("Employee No.");
                }
                action("Confirm Employee Clearance")
                {
                    Image = Confirm;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //Confirm Employee Clearance
                        if Confirm(Txt_001) = false then exit;
                        Rec."Clearance Form Submitted" := true;
                        Rec.Modify;
                        Message(Txt_002);
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
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        if HREmp.Get(Rec."Employee No.") then begin
            JobTitle := HREmp."Job Title";
            sUserID := HREmp."User ID";
        end else begin
            JobTitle := '';
            sUserID := '';
        end;


        Rec.SetRange("Employee No.");
        DAge := '';
        DService := '';
        DPension := '';
        DMedical := '';

        RecalcDates;
    end;

    var
        JobTitle: Text[30];
        Supervisor: Text[60];
        HREmp: Record Employee;
        Date: Codeunit "Calc. G/L Acc. Where-Used";
        DAge: Text[100];
        DService: Text[100];
        DPension: Text[100];
        DMedical: Text[100];
        HREmpForm: Page "Interview Panel Subform";
        sUserID: Code[30];
        DoclLink: Record Attachment;
        InteractTemplLanguage: Record "Interaction Tmpl. Language";
        D: Date;
        Misc: Record "Misc. Article Information";
        Text19062217: Label 'Misc Articles';
        Headers: Record "HR Employee Exit Interviews";
        Employee: Record Employee;
        ConfirmPostIng: Label 'On posting the employee will be inactive in all transactions. However He/She will be under the list of incative employees';
        SeparationDetailsPosted: Label 'Separation Details Posted Successfully';
        Txt_001: Label 'Are you sure the Employee has been cleared by all relevant Departments?';
        Txt_002: Label 'Employee clearance has been confirmed.';
        Dates: Codeunit Dates;
        HREmployeeExitInterviews: Record "HR Employee Exit Interviews";
        ReportSelections: Record "Report Selections";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;

    procedure RecalcDates()
    begin

        /*//Recalculate Important Dates
          IF (HREmp."Date of Leaving" = 0D) THEN BEGIN
            IF  (HREmp."Birth Date" <> 0D) THEN
            //DAge:= Dates.DetermineAge(HREmp."Date Of Birth",TODAY);
            IF  (HREmp."Employment Date" <> 0D) THEN
            DService:= Dates.DetermineAge(HREmp."Date Of Joining the Company",TODAY);
            IF  (HREmp."Pension Scheme Join Date" <> 0D) THEN
            DPension:= Dates.DetermineAge(HREmp."Pension Scheme Join Date",TODAY);
            IF  (HREmp."Medical Scheme Join Date" <> 0D) THEN
            DMedical:= Dates.DetermineAge(HREmp."Medical Scheme Join Date",TODAY);
            MODIFY;
          END ELSE BEGIN
            IF  (HREmp."Birth Date" <> 0D) THEN
            //DAge:= Dates.DetermineAge(HREmp."Date Of Birth",HREmp."Date Of Leaving the Company");
            IF  (HREmp."Employement Date" <> 0D) THEN
            //DService:= Dates.DetermineAge(HREmp."Date Of Joining the Company",HREmp."Date Of Leaving the Company");
            IF  (HREmp."Pension Scheme Join Date" <> 0D) THEN
            DPension:= Dates.DetermineAge(HREmp."Pension Scheme Join Date",HREmp."Date Of Leaving the Company");
            IF  (HREmp."Medical Scheme Join Date" <> 0D) THEN
            DMedical:= Dates.DetermineAge(HREmp."Medical Scheme Join Date",HREmp."Date Of Leaving the Company");
            //MODIFY;
          END;
          */

    end;

    local procedure EmployeeNoOnAfterValidate()
    begin
        CurrPage.SaveRecord;
        Rec.FilterGroup := 2;
        Misc.SetRange(Misc."Employee No.", Rec."Employee No.");
        Rec.FilterGroup := 0;
        if Misc.Find('-') then;
        CurrPage.Update(false);
    end;
}

