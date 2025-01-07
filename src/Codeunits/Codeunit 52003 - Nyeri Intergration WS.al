codeunit 52003 "Nyeri Intergration WS"
{
    // 


    trigger OnRun()
    begin
       // Message(CreateStoreRequisitionLineII('ST00000021', 'MM16', 'CENTRAL', 1.0, '', 'TEST', '', '', ''));
        MESSAGE(CreateProjects('22','test','test',TODAY,TODAY,'james','test','test','test','test','test','test'))
        /*ProjetNo : Code[20];ProjectTitle : Text;ProjectDescription : Text;StartDate : Date;EndDate : Date;
        Supervisor : Code[50];Location : Text;ContractorName : Text;ContractorPhoneNo : Text;ContractorLocation : Text;
        BudgetGL : Code[20];BudgetGLName : Text*/
       


    end;

    var
        Item: Record Item;
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        StoreRequisition: Record "Store Requisition Header";
        StoreRequisitionLine: Record "Store Requisition Line";
        InventorySetup: Record "Inventory Setup";
        InventoryUserSetup: Record "Inventory User Setup";
        Employee: Record Employee;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        InventoryApprovalManager: Codeunit "Inventory Approval Manager";
        Text_0001: Label 'The inventory is insufficient';
        StoreRequisition2: Record "Store Requisition Header";
        ApprovalEntry: Record "Approval Entry";
        Location: Record Location;
        FsQuestionaire: Record "Fs. Questionaire";
        TransportRequest: Record "Transport Request";
        HumanResSetup: Record "Human Resources Setup";
        ImplementationLine: Record "Project Implementation Lines";
        ActionPlanLine: Record "Action Planning Lines";
        ProjectImplementationLine: Record "Project Implementation Lines";
        JTemplate: Code[10];
        JBatch: Code[10];
        InventoryManagement: Codeunit "Inventory Management";
        Projects: Record "Transport Request";
        jobs: Record Job;
        DimensionValue: Record "Dimension Value";
        ProjectNo: Text;

    [Scope('Personalization')]
    procedure SendStoreRequisitionApprovalRequest("StoreRequisitionNo.": Code[20]) StoreRequisitionApprovalRequestSent: Text
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        StoreRequisitionApprovalRequestSent := '';

        StoreRequisition.Reset;
        if StoreRequisition.Get("StoreRequisitionNo.") then begin
            //ApprovalsMgmt.OnSendStoreRequisitionForApproval(StoreRequisition);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", StoreRequisition."No.");
            ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            if ApprovalEntry.FindFirst then
                StoreRequisitionApprovalRequestSent := '200: Approval Request sent Successfully'
            else
                StoreRequisitionApprovalRequestSent := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
        end
    end;

    [Scope('Personalization')]
    procedure CancelStoreRequisitionApprovalRequest("StoreRequisitionNo.": Code[20]) StoreRequisitionApprovalRequestCanceled: Text
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        StoreRequisitionApprovalRequestCanceled := '';

        StoreRequisition.Reset;
        if StoreRequisition.Get("StoreRequisitionNo.") then begin
            // ApprovalsMgmt.OnCancelStoreRequisitionApprovalRequest(StoreRequisition);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", StoreRequisition."No.");
            if ApprovalEntry.FindLast then begin
                if ApprovalEntry.Status = ApprovalEntry.Status::Canceled then
                    StoreRequisitionApprovalRequestCanceled := '200: Approval Request Cancelled Successfully'
                else
                    StoreRequisitionApprovalRequestCanceled := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
            end;
        end;
    end;

    [Scope('Personalization')]
    procedure ApproveStoreReqApplication("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]) Approved: Text
    var
        "EntryNo.": Integer;
    begin
        Approved := '';
        "EntryNo." := 0;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", Employee."User ID");
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "DocumentNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst then begin
            "EntryNo." := ApprovalEntry."Entry No.";
            ApprovalEntry."Web Portal Approval" := true;
            ApprovalEntry.Modify;
            ApprovalsMgmt.ApproveApprovalRequests(ApprovalEntry);
        end;
        Commit;

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Entry No.", "EntryNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
        if ApprovalEntry.FindFirst then
            Approved := '200: Store Requisition Approved Successfully '
        else
            Approved := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure RejectStoreReqApplication("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]; RejectionComments: Text) Rejected: Text
    var
        "EntryNo.": Integer;
    begin
        Rejected := '';
        "EntryNo." := 0;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", Employee."User ID");
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "DocumentNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst then begin
            "EntryNo." := ApprovalEntry."Entry No.";
            ApprovalEntry."Web Portal Approval" := true;
            ApprovalEntry."Rejection Comments" := RejectionComments;
            ApprovalEntry.Modify;
            ApprovalsMgmt.RejectApprovalRequests(ApprovalEntry);
        end;
        Commit;

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Entry No.", "EntryNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Rejected);
        if ApprovalEntry.FindFirst then
            Rejected := '200: Store requisition Rejected Successfully '
        else
            Rejected := '400:' + GetLastErrorCode + '-' + GetLastErrorText;

        //**************************************** HR Leave Reimbursement ********************************************************************************************************************************************************
    end;

    [Scope('Personalization')]
    procedure CancelStoreRequisition("StoreRequisitionNo.": Code[20]; "EmployeeNo.": Code[20]) StoreRequisitionCancelled: Boolean
    var
        HREmployee: Record Employee;
    begin
        StoreRequisitionCancelled := false;
        StoreRequisition.Reset;
        StoreRequisition.SetRange(StoreRequisition."No.", "StoreRequisitionNo.");
        if StoreRequisition.FindFirst then begin

            HREmployee.Reset;
            HREmployee.SetRange("No.", "EmployeeNo.");
            if HREmployee.FindFirst then begin
                StoreRequisition."Cancelled By" := HREmployee."User ID";
                StoreRequisition."Date Cancelled" := Today;
                StoreRequisition."Time Cancelled" := Time;
                StoreRequisition.Status := StoreRequisition.Status::Cancelled;
                if StoreRequisition.Modify then
                    StoreRequisitionCancelled := true;
            end;
        end;
    end;

    [Scope('Personalization')]
    procedure PostStoreRequisition(StoreRequisitionNo: Code[20]; EmployeeNo: Code[20]) StoreRequisitionPost: Text
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        StoreRequisitionPost := '';
        StoreRequisition.Reset;
        StoreRequisition.Get(StoreRequisitionNo);
        Employee.Get(EmployeeNo);
        if Employee."User ID" = '' then begin
            StoreRequisitionPost := 'Field User ID in Employee Table must have a value';
            exit;
        end;
        if InventoryUserSetup.Get(StoreRequisition."Issued By") then begin
            InventoryUserSetup.TestField(InventoryUserSetup."Item Journal Template");
            InventoryUserSetup.TestField(InventoryUserSetup."Item Journal Batch");
            //StoreRequisition."Posting Date" := StoreRequisition."Required Date"; //TODAY;
            //StoreRequisition."Issued By" := StoreRequisition."User ID";
            StoreRequisition.Modify;
            JTemplate := InventoryUserSetup."Item Journal Template";
            JBatch := InventoryUserSetup."Item Journal Batch";
            InventoryManagement.PostStoreRequisitionPortal(StoreRequisition, JTemplate, JBatch);
            StoreRequisitionPost := '200: Store requistion posted successfully';
        end else begin
            StoreRequisitionPost := '400:' + StoreRequisition."Issued By" + ' is not set in Inventory User Setup';//+GETLASTERRORCODE+'-'+GETLASTERRORTEXT;
                                                                                                                  //ERROR(Txt_001,Employee."User ID");
        end;
    end;

    [Scope('Personalization')]
    procedure CreateStoreRequisitionII("EmployeeNo.": Code[20]; RequiredDate: Date; Description: Text; Department: Code[20]; Template: Option ,New,Tertiary,Cluster; DocumentName: Text; ProjectNo: Code[20]; UserId: Code[20]; RequesterId: Code[20]; PostingDate: Date; PointOfUse: Text; Route: Code[20]; Zone: Code[20]) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
    begin
        ReturnValue := '';

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        InventorySetup.Reset;
        InventorySetup.Get;

        "DocNo." := NoSeriesMgt.GetNextNo(InventorySetup."Stores Requisition Nos.", 0D, true);
        if "DocNo." <> '' then begin
            StoreRequisition.Init;
            StoreRequisition."No." := "DocNo.";
            StoreRequisition."Document Date" := Today;
            StoreRequisition."Employee No." := "EmployeeNo.";
            StoreRequisition.Validate(StoreRequisition."Employee No.");
            StoreRequisition."User ID" := RequesterId; //Employee."User ID";
            StoreRequisition."Requester ID" := RequesterId;//Employee."User ID";
            StoreRequisition."Issued By" := UserId;
            StoreRequisition."Required Date" := RequiredDate;

            StoreRequisition.Description := Description;
            StoreRequisition."Document Name" := DocumentName;
            StoreRequisition."Project No" := ProjectNo;
            StoreRequisition.Validate("Project No");
            StoreRequisition."Posting Date" := PostingDate;
            StoreRequisition."Shortcut Dimension 3 Code" := Zone;
            StoreRequisition."Shortcut Dimension 4 Code" := Route;

            StoreRequisition.Validate(Template, Template);

            HREmployee.Reset;
            HREmployee.SetRange("No.", "EmployeeNo.");
            if HREmployee.FindFirst then begin
                StoreRequisition."Global Dimension 1 Code" := HREmployee."Global Dimension 1 Code";
                StoreRequisition.Validate(StoreRequisition."Global Dimension 1 Code");
                StoreRequisition."Global Dimension 2 Code" := HREmployee."Global Dimension 2 Code";
                StoreRequisition."Shortcut Dimension 3 Code" := HREmployee."Shortcut Dimension 3 Code";
                StoreRequisition.HOD := HREmployee.HOD;
                StoreRequisition."Area Manager" := HREmployee.Supervisor;
            end;
            if StoreRequisition.Insert then begin
                ReturnValue := '200: Store Requisition No ' + "DocNo." + ' Successfully Created';
            end
            else
                ReturnValue := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
        end;
    end;

    [Scope('Personalization')]
    procedure GetJobsTask(var JobTaskExport: XMLport JobTaskExport)
    begin
        jobs.Reset;
        if jobs.FindFirst then;
        JobTaskExport.SetTableView(jobs);
    end;

    [Scope('Personalization')]
    procedure CreateStoreRequisitionLineII("StoreRequisitionNo.": Code[20]; "ItemNo.": Code[20]; LocationCode: Code[20]; Quantity: Decimal; UOM: Code[10]; Description: Text; GlobalDimensionIV: Code[20]; Zone: Code[20]; Route: Code[20]) StoreRequisitionLineCreated: Text
    begin
        StoreRequisitionLineCreated := '';
        Item.Get("ItemNo.");

        Item.SetRange("Location Code", LocationCode);
        Item.CalcFields(Inventory);

        if Item.Blocked = true then begin
            StoreRequisitionLineCreated := '400: The Item is Blocked';
            exit;
        end;

        /*
        IF Quantity> Item.Inventory THEN BEGIN
          StoreRequisitionLineCreated := '400: The inventory is insufficient';
          EXIT;
          END;*/

        //ERROR(Text_0001);

        if Quantity < 1 then Error('Quantity Must be Greater than 0');

        StoreRequisition.Reset;
        StoreRequisition.Get("StoreRequisitionNo.");

        StoreRequisitionLine.Init;
        StoreRequisitionLine."Line No." := 0;
        StoreRequisitionLine."Document No." := "StoreRequisitionNo.";
        StoreRequisitionLine.Type := StoreRequisitionLine.Type::Item;
        StoreRequisitionLine."Item No." := "ItemNo.";
        StoreRequisitionLine.Validate(StoreRequisitionLine."Item No.");

        StoreRequisitionLine."Location Code" := LocationCode;
        StoreRequisitionLine.Validate(StoreRequisitionLine."Location Code");
        StoreRequisitionLine.Quantity := 1;
        StoreRequisitionLine.Validate(Quantity);
        StoreRequisitionLine."Line Amount" := StoreRequisitionLine.Quantity * StoreRequisitionLine."Unit Cost";
        //StoreRequisitionLine."Unit of Measure Code":=UOM;
        //StoreRequisitionLine.VALIDATE(StoreRequisitionLine."Unit of Measure Code");
        StoreRequisitionLine.Description := Description;
        StoreRequisitionLine."Shortcut Dimension 3 Code" := Zone;
        StoreRequisitionLine."Shortcut Dimension 4 Code" := Route;
        //StoreRequisitionLine."Shortcut Dimension 4 Code" := GlobalDimensionIV;
        //StoreRequisitionLine.VALIDATE("Shortcut Dimension 4 Code");

        if StoreRequisitionLine.Insert then begin
            StoreRequisitionLineCreated := '200: Store Requisition Line Successfully Created';
        end else
            StoreRequisitionLineCreated := '400: ' + GetLastErrorCode + '-' + GetLastErrorText;


    end;

    [Scope('Personalization')]
    procedure ModifyStoreRequisitionLineII("LineNo.": Integer; "StoreRequisitionNo.": Code[20]; "ItemNo.": Code[20]; Quantity: Decimal; UOM: Code[10]; Description: Text; LocationCode: Code[20]; GlobalDimensionIV: Code[20]; Zone: Code[20]; Route: Code[20]) StoreRequisitionLineModified: Boolean
    begin
        StoreRequisitionLineModified := false;
        StoreRequisition.SetRange(StoreRequisition."No.", "StoreRequisitionNo.");
        if StoreRequisition.FindFirst then
            StoreRequisition.TestField(Status, StoreRequisition.Status::Open);
        StoreRequisitionLine.Reset;
        StoreRequisitionLine.SetRange(StoreRequisitionLine."Line No.", "LineNo.");
        StoreRequisitionLine.SetRange(StoreRequisitionLine."Document No.", "StoreRequisitionNo.");


        if StoreRequisitionLine.FindFirst then begin
            StoreRequisitionLine.Type := StoreRequisitionLine.Type::Item;
            StoreRequisitionLine."Item No." := "ItemNo.";
            StoreRequisitionLine.Validate(StoreRequisitionLine."Item No.");
            StoreRequisitionLine."Location Code" := LocationCode;
            StoreRequisitionLine.Validate(StoreRequisitionLine."Location Code");
            StoreRequisitionLine.Quantity := Quantity;
            StoreRequisitionLine.Validate(StoreRequisitionLine.Quantity);
            StoreRequisitionLine."Shortcut Dimension 4 Code" := GlobalDimensionIV;
            StoreRequisition.Validate("Shortcut Dimension 4 Code");

            Item.SetRange("No.", "ItemNo.");
            if Item.FindFirst then
                StoreRequisitionLine."Unit of Measure Code" := Item."Base Unit of Measure";

            StoreRequisitionLine.Validate(StoreRequisitionLine."Unit of Measure Code");
            StoreRequisitionLine.Description := Description;
            if StoreRequisitionLine.Modify then begin
                StoreRequisitionLineModified := true;
            end;
        end;
    end;

    [Scope('Personalization')]
    procedure GetGlobalDimension4Codes(var DimensionValuesExport: XMLport "Dimension Values")
    begin
        DimensionValue.Reset;
        DimensionValue.SetRange("Global Dimension No.", 4);
        if DimensionValue.FindFirst then;
        DimensionValuesExport.SetTableView(DimensionValue);
    end;

    [Scope('Personalization')]
    procedure GetProjectsList(var ProjectReqExport: XMLport ProjectsReqExport)
    var
        Projects: Record Job;
    begin
    end;

    [Scope('Personalization')]
    procedure GetImprestList(var ProjectImprestExport: XMLport ProjectImprestExport; ProjectNo: Code[50])
    var
        ImprestHeader: Record "Imprest Header";
    begin
        ImprestHeader.Reset;
        ImprestHeader.SetRange("Project No", ProjectNo);
        if ImprestHeader.FindFirst then;
        ProjectImprestExport.SetTableView(ImprestHeader);
    end;

    [Scope('Personalization')]
    procedure GetPettyCashList(var ProjectPettyCashExport: XMLport ProjectPettyCashExport; ProjectNo: Code[50])
    var
        ImprestHeader: Record "Imprest Header";
    begin
        ImprestHeader.Reset;
        ImprestHeader.SetRange("Project No", ProjectNo);
        if ImprestHeader.FindFirst then;
        ProjectPettyCashExport.SetTableView(ImprestHeader);
    end;

    [Scope('Personalization')]
    procedure GetCasualRequisitionList(var ProjectCasualReqExport: XMLport ProjectCasualReqExport; ProjectNo: Code[50])
    var
        CasualReq: Record "HR Employee Requisitions";
    begin
        CasualReq.Reset;
        CasualReq.SetRange("Project No", ProjectNo);
        if CasualReq.FindFirst then;
        ProjectCasualReqExport.SetTableView(CasualReq);
    end;

    [Scope('Personalization')]
    procedure GetCasualPaymentList(var ProjectCasualPayExport: XMLport ProjectCasualPayExport; ProjectNo: Code[50])
    var
        ImprestHeader: Record "Imprest Header";
    begin
        ImprestHeader.Reset;
        ImprestHeader.SetRange("Project No", ProjectNo);
        if ImprestHeader.FindFirst then;
        ProjectCasualPayExport.SetTableView(ImprestHeader);
    end;

    [Scope('Personalization')]
    procedure GetStoreRequisitionList(var ProjectStoreRequisitionExport: XMLport ProjectStoreReqExport; ProjectNo: Code[50])
    var
        StoreRequisition: Record "Store Requisition Header";
    begin
        StoreRequisition.Reset;
        StoreRequisition.SetRange("Project No", ProjectNo);
        if StoreRequisition.FindFirst then;
        ProjectStoreRequisitionExport.SetTableView(StoreRequisition);
    end;

    [Scope('Personalization')]
    procedure GetRequisitionList(var ProjectRequistionExport: XMLport ProjectRequisitionExport; ProjectNo: Code[50])
    var
        Requisitions: Record "Purchase Requisitions";
    begin
        Requisitions.Reset;
        Requisitions.SetRange("Project No", ProjectNo);
        if Requisitions.FindFirst then;
        ProjectRequistionExport.SetTableView(Requisitions);
    end;

    [Scope('Personalization')]
    procedure CreateProjects(ProjetNo: Code[20]; ProjectTitle: Text; ProjectDescription: Text; StartDate: Date; EndDate: Date; Supervisor: Code[50]; Location: Text; ContractorName: Text; ContractorPhoneNo: Text; ContractorLocation: Text; BudgetGL: Code[20]; BudgetGLName: Text) ReturnValue: Text
    var
        Projects: Record Job;
        JobSetup: Record "Jobs Setup";
        "DocNo.": Code[30];
       

    begin
        ReturnValue := '';
        if "DocNo." <> '' then begin
            "DocNo." := NoSeriesMgt.GetNextNo(JobSetup."Job Nos.", 0D, TRUE);
        end;
        projects.Init();
        Projects."No." := ProjetNo;//'10';
        Projects.Description := ProjectTitle;
        Projects."Search Description" := ProjectDescription;
        Projects."Description 2" := ProjetNo;
        Projects."Starting Date" := StartDate;
        Projects."Ending Date" := EndDate;
        Projects."Project Manager" := Supervisor;
        Projects.Location := Location;
        Projects.Contractor := ContractorName;
        Projects."Contractor Location" := ContractorLocation;
        Projects."Contractor Phone No" := ContractorPhoneNo;
        Projects."Budget G/L" := BudgetGL;
        Projects."Budget G/L Name" := BudgetGLName;
        //Projects.Insert;

        IF Projects.INSERT THEN
            ReturnValue := '200: Project ' + ProjetNo + ' Created Successfully'
        ELSE
            ReturnValue := '400:' + GETLASTERRORCODE + '-' + GETLASTERRORTEXT;


    end;

    [Scope('Personalization')]
    procedure ModifyProjects(ProjetNo: Code[20]; ProjectTitle: Text; ProjectDescription: Text; StartDate: Date; EndDate: Date; Supervisor: Code[50]; Location: Text; ContractorName: Text; ContractorPhoneNo: Text; ContractorLocation: Text; BudgetGL: Code[20]; BudgetGLName: Text) ReturnValue: Text
    var
        Projects: Record Job;
    begin
        ReturnValue := '';
        Projects.Get(ProjetNo);
        Projects."No." := ProjetNo;
        Projects.Description := ProjectTitle;
        Projects."Description 2" := ProjectDescription;
        Projects."Starting Date" := StartDate;
        Projects."Ending Date" := EndDate;
        Projects."Project Manager" := Supervisor;
        Projects.Location := Location;
        Projects.Contractor := ContractorName;
        Projects."Contractor Location" := ContractorLocation;
        Projects."Contractor Phone No" := ContractorPhoneNo;
        Projects."Budget G/L" := BudgetGL;
        Projects."Budget G/L Name" := BudgetGLName;
        if Projects.Modify then
            ReturnValue := '200: Project ' + ProjetNo + ' Updated Successfully'
        else
            ReturnValue := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
    end;
}

