codeunit 50013 "Inventory Management WS"
{

    trigger OnRun()
    begin
        //MESSAGE(PostStoreRequisition('ST00001296','0571'));
        /*
        StoreRequisition.RESET;
        StoreRequisition.SETRANGE(Status, StoreRequisition.Status::Open);
        StoreRequisition.SETRANGE("User ID", 'SPA');
        StoreRequisition.SETFILTER(Description, '*Mtr*');
        
        IF StoreRequisition.FINDFIRST THEN BEGIN
          REPEAT
            StoreRequisition.Status := StoreRequisition.Status::Cancelled;
            StoreRequisition.MODIFY;
            UNTIL StoreRequisition.NEXT = 0;
          END;
        
        MESSAGE('Done');*/

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
        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
        ApprovalsMgmtMain: Codeunit "Approvals Mgmt.";
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

    [Scope('Personalization')]
    procedure GetStoreRequisitiontList(var StoreRequisitionExport: XMLport "Store Requisition Export"; EmployeeNo: Code[20])
    begin
        if EmployeeNo <> '' then begin
            StoreRequisition2.Reset;
            StoreRequisition2.SetFilter("Employee No.", EmployeeNo);
            //StoreRequisition2.SETRANGE(
            if StoreRequisition2.FindFirst then;
            StoreRequisitionExport.SetTableView(StoreRequisition2);
        end
    end;

    [Scope('Personalization')]
    procedure GetStoreRequisitiontListStatus(var StoreRequisitionExport: XMLport "Store Requisition Export"; EmployeeNo: Code[20]; StatusFilter: Option Open,"Pending Approval",Approved,Rejected,Posted)
    begin
        StoreRequisition2.Reset;
        StoreRequisition2.SetRange(Status, StatusFilter);
        if EmployeeNo <> '' then begin

            StoreRequisition2.SetFilter("Employee No.", EmployeeNo);
            if StoreRequisition2.FindFirst then;
            StoreRequisitionExport.SetTableView(StoreRequisition2);
        end
    end;

    [Scope('Personalization')]
    procedure GetStoreRequisitionHeaderLines(var StoreRequisitionExport: XMLport "Store Requisition Export"; HeaderNo: Code[20])
    begin

        if HeaderNo <> '' then begin
            StoreRequisition2.Reset;
            StoreRequisition2.SetFilter("No.", HeaderNo);
            if StoreRequisition2.FindFirst then;
            StoreRequisitionExport.SetTableView(StoreRequisition2);
        end
    end;

    [Scope('Personalization')]
    procedure GetItemList(var ItemExport: XMLport "Item Export")
    begin
    end;

    [Scope('Personalization')]
    procedure CheckStoreRequisitionExists("StoreRequisitionNo.": Code[20]; "EmployeeNo.": Code[20]) StoreRequisitionExist: Boolean
    begin
        StoreRequisitionExist := false;
        StoreRequisition.Reset;
        StoreRequisition.SetRange(StoreRequisition."No.", "StoreRequisitionNo.");
        StoreRequisition.SetRange(StoreRequisition."Employee No.", "EmployeeNo.");
        if StoreRequisition.FindFirst then begin
            StoreRequisitionExist := true;
        end;
    end;

    [Scope('Personalization')]
    procedure CheckOpenStoreRequisitionExists("EmployeeNo.": Code[20]) OpenStoreRequisitionExist: Boolean
    begin
        OpenStoreRequisitionExist := false;
        StoreRequisition.Reset;
        StoreRequisition.SetRange(StoreRequisition."Employee No.", "EmployeeNo.");
        StoreRequisition.SetRange(StoreRequisition.Status, StoreRequisition.Status::Open);
        if StoreRequisition.FindFirst then begin
            OpenStoreRequisitionExist := true;
        end;
    end;

    [Scope('Personalization')]
    procedure CreateStoreRequisition("EmployeeNo.": Code[20]; RequiredDate: Date; Description: Text[100]; Department: Code[20]; Template: Option ,New,Tertiary,Cluster; DocumentName: Text) ReturnValue: Text
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
            StoreRequisition."User ID" := Employee."User ID";
            StoreRequisition."Requester ID" := Employee."User ID";
            StoreRequisition."Required Date" := RequiredDate;
            StoreRequisition.Description := Description;
            StoreRequisition."Document Name" := DocumentName;

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
    procedure ModifyStoreRequisition("StoreRequisitionNo.": Code[20]; "EmployeeNo.": Code[20]; RequiredDate: Date; Description: Text[100]; Department: Code[20]; Template: Option ,New,Tertiary,Cluster; DocumentName: Text) StoreRequisitionModified: Boolean
    var
        HREmployee: Record Employee;
    begin
        StoreRequisitionModified := false;
        StoreRequisition.Reset;
        StoreRequisition.SetRange(StoreRequisition."No.", "StoreRequisitionNo.");
        if StoreRequisition.FindFirst then begin
            StoreRequisition.TestField(Status, StoreRequisition.Status::Open);
            StoreRequisition."Document Date" := Today;
            StoreRequisition."Required Date" := RequiredDate;
            StoreRequisition.Description := Description;
            StoreRequisition."Document Name" := DocumentName;

            if StoreRequisition.Template <> Template then
                StoreRequisition.Validate(Template, Template);


            HREmployee.Reset;
            HREmployee.SetRange("No.", "EmployeeNo.");
            if HREmployee.FindFirst then begin
                StoreRequisition."Global Dimension 1 Code" := HREmployee."Global Dimension 1 Code";

                StoreRequisition."Global Dimension 2 Code" := HREmployee."Global Dimension 2 Code";
                StoreRequisition."Shortcut Dimension 3 Code" := HREmployee."Shortcut Dimension 3 Code";
                StoreRequisition.HOD := HREmployee.HOD;
                StoreRequisition."Area Manager" := HREmployee.Supervisor;
            end;
            StoreRequisitionLine.Reset;
            StoreRequisitionLine.SetRange(StoreRequisitionLine."Document No.", "StoreRequisitionNo.");
            if StoreRequisitionLine.FindFirst then begin
                StoreRequisition."Location Code" := StoreRequisitionLine."Location Code";
            end;
            StoreRequisition."Requester ID" := HREmployee."User ID";
            if StoreRequisition.Modify then
                StoreRequisitionModified := true;
        end;
    end;

    [Scope('Personalization')]
    procedure GetStoreRequisitionAmount("StoreRequisitionNo.": Code[20]) StoreRequisitionAmount: Decimal
    begin
        StoreRequisitionAmount := 0;

        StoreRequisition.Reset;
        if StoreRequisition.Get("StoreRequisitionNo.") then begin
            StoreRequisition.CalcFields("Cost Amount");
            StoreRequisitionAmount := StoreRequisition."Cost Amount";
        end;
    end;

    [Scope('Personalization')]
    procedure GetStoreRequisitionStatus("StoreRequisitionNo.": Code[20]) StoreRequisitionStatus: Text
    begin
        StoreRequisitionStatus := '';

        StoreRequisition.Reset;
        if StoreRequisition.Get("StoreRequisitionNo.") then begin
            StoreRequisitionStatus := Format(StoreRequisition.Status);
        end;
    end;

    [Scope('Personalization')]
    procedure GetStoreRequisitionGlobalDimension1Code("StoreRequisitionNo.": Code[20]) GlobalDimension1Code: Text
    begin
        GlobalDimension1Code := '';

        StoreRequisition.Reset;
        if StoreRequisition.Get("StoreRequisitionNo.") then begin
            GlobalDimension1Code := StoreRequisition."Global Dimension 1 Code";
        end;
    end;

    [Scope('Personalization')]
    procedure GetStoreRequisitionGlobalDimension2Code("StoreRequisitionNo.": Code[20]) GlobalDimension2Code: Text
    begin
        GlobalDimension2Code := '';

        StoreRequisition.Reset;
        if StoreRequisition.Get("StoreRequisitionNo.") then begin
            GlobalDimension2Code := StoreRequisition."Shortcut Dimension 3 Code";//updated on 02/09/2020
        end;
    end;

    [Scope('Personalization')]
    procedure CreateStoreRequisitionLine("StoreRequisitionNo.": Code[20]; "ItemNo.": Code[20]; LocationCode: Code[20]; Quantity: Decimal; UOM: Code[10]; Description: Text) StoreRequisitionLineCreated: Text
    begin
        StoreRequisitionLineCreated := '';
        Item.Get("ItemNo.");

        Item.CalcFields(Inventory);

        //IF Quantity> Item.Inventory THEN
        //ERROR(Text_0001);

        //IF Quantity<0 THEN ERROR('Quantity Must be Greater than 0');

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
        StoreRequisitionLine.Validate(Quantity, Quantity);
        StoreRequisitionLine."Line Amount" := StoreRequisitionLine.Quantity * StoreRequisitionLine."Unit Cost";
        //StoreRequisitionLine."Unit of Measure Code":=UOM;
        //StoreRequisitionLine.VALIDATE(StoreRequisitionLine."Unit of Measure Code");
        //StoreRequisitionLine.Description:=Description;
        if StoreRequisitionLine.Insert then begin
            StoreRequisitionLineCreated := '200: Store Requisition Line Successfully Created';
        end else
            StoreRequisitionLineCreated := GetLastErrorCode + '-' + GetLastErrorText;

    end;

    [Scope('Personalization')]
    procedure ModifyStoreRequisitionLine("LineNo.": Integer; "StoreRequisitionNo.": Code[20]; "ItemNo.": Code[20]; Quantity: Decimal; UOM: Code[10]; Description: Text; LocationCode: Code[20]) StoreRequisitionLineModified: Boolean
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
    procedure DeleteStoreRequisitionLine("LineNo.": Integer; "StoreRequisitionNo.": Code[20]) StoreRequisitionLineDeleted: Boolean
    begin
        StoreRequisitionLineDeleted := false;
        StoreRequisition.SetRange(StoreRequisition."No.", "StoreRequisitionNo.");
        if StoreRequisition.FindFirst then
            StoreRequisition.TestField(Status, StoreRequisition.Status::Open);

        StoreRequisitionLine.Reset;
        StoreRequisitionLine.SetRange(StoreRequisitionLine."Line No.", "LineNo.");
        StoreRequisitionLine.SetRange(StoreRequisitionLine."Document No.", "StoreRequisitionNo.");
        if StoreRequisitionLine.FindFirst then begin
            if StoreRequisitionLine.Delete then begin
                StoreRequisitionLineDeleted := true;
            end;
        end;
    end;

    procedure GetAvailableInventory("ItemNo.": Code[20]; UnitOfMeasure: Code[10]; LocationCode: Code[10]) AvailableInventory: Decimal
    var
        AvailableInventoryInBaseUOM: Decimal;
    begin
        AvailableInventory := 0;
        AvailableInventoryInBaseUOM := 0;

        Item.Reset;
        Item.Get("ItemNo.");

        ItemLedgerEntry.Reset;
        ItemLedgerEntry.SetRange(ItemLedgerEntry."Item No.", "ItemNo.");
        ItemLedgerEntry.SetRange(ItemLedgerEntry."Location Code", LocationCode);
        if ItemLedgerEntry.FindSet then begin
            repeat
                AvailableInventoryInBaseUOM := AvailableInventoryInBaseUOM + ItemLedgerEntry.Quantity;
            until ItemLedgerEntry.Next = 0;
        end;

        if UnitOfMeasure <> Item."Base Unit of Measure" then begin
            ItemUnitOfMeasure.Reset;
            ItemUnitOfMeasure.SetRange(ItemUnitOfMeasure."Item No.", Item."No.");
            ItemUnitOfMeasure.SetRange(ItemUnitOfMeasure.Code, UnitOfMeasure);
            if ItemUnitOfMeasure.FindFirst then begin
                AvailableInventory := AvailableInventoryInBaseUOM / ItemUnitOfMeasure."Qty. per Unit of Measure";
            end;
        end else begin
            AvailableInventory := AvailableInventoryInBaseUOM;
        end;
    end;

    procedure CheckStoreRequisitionLinesExist("StoreRequisitionNo.": Code[20]) StoreRequisitionLinesExist: Boolean
    begin
        StoreRequisitionLinesExist := false;

        StoreRequisitionLine.Reset;
        StoreRequisitionLine.SetRange(StoreRequisitionLine."Document No.", "StoreRequisitionNo.");
        if StoreRequisitionLine.FindFirst then begin
            StoreRequisitionLinesExist := true;
        end;
    end;

    procedure ValidateStoreRequisitionLines("StoreRequisitionNo.": Code[20]) StoreRequisitionLinesError: Text
    var
        "StoreRequisitionLineNo.": Integer;
    begin
        StoreRequisitionLinesError := '';
        "StoreRequisitionLineNo." := 0;

        StoreRequisitionLine.Reset;
        StoreRequisitionLine.SetRange(StoreRequisitionLine."Document No.", "StoreRequisitionNo.");
        if StoreRequisitionLine.FindSet then begin
            repeat
                "StoreRequisitionLineNo." := "StoreRequisitionLineNo." + 1;
                if StoreRequisitionLine."Item No." = '' then begin
                    StoreRequisitionLinesError := 'Item no. missing on Store requisition line no.' + Format("StoreRequisitionLineNo.") + ', it cannot be zero or empty';
                    break;
                end;

            until StoreRequisitionLine.Next = 0;
        end;
    end;

    procedure CheckStoreRequisitionApprovalWorkflowEnabled("StoreRequisitionNo.": Code[20]) ApprovalWorkflowEnabled: Boolean
    begin
        ApprovalWorkflowEnabled := false;

        StoreRequisition.Reset;
        if StoreRequisition.Get("StoreRequisitionNo.") then
            ApprovalWorkflowEnabled := ApprovalsMgmt.CheckStoreRequisitionApprovalsWorkflowEnabled(StoreRequisition);
    end;

    [Scope('Personalization')]
    procedure SendStoreRequisitionApprovalRequest("StoreRequisitionNo.": Code[20]) StoreRequisitionApprovalRequestSent: Text
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        StoreRequisitionApprovalRequestSent := '';

        StoreRequisition.Reset;
        if StoreRequisition.Get("StoreRequisitionNo.") then begin
            if CopyStr(StoreRequisition.Description, 1, StrLen('A/C No:')) <> 'A/C No:' then begin
                ApprovalsMgmt.OnSendStoreRequisitionForApproval(StoreRequisition);
                Commit;
                ApprovalEntry.Reset;
                ApprovalEntry.SetRange(ApprovalEntry."Document No.", StoreRequisition."No.");
                ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
                if ApprovalEntry.FindFirst then
                    StoreRequisitionApprovalRequestSent := '200: Approval Request sent Successfully'
                else
                    StoreRequisitionApprovalRequestSent := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
            end
            else begin
                StoreRequisition.Status := StoreRequisition.Status::Approved;
                StoreRequisition.Modify;
                StoreRequisitionApprovalRequestSent := '200: Approval Request sent Successfully';
            end
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
            ApprovalsMgmt.OnCancelStoreRequisitionApprovalRequest(StoreRequisition);
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

    procedure ReopenStoreRequisition("StoreRequisitionNo.": Code[20]) StoreRequisitionOpened: Boolean
    begin
        StoreRequisitionOpened := false;
        StoreRequisition.Reset;
        StoreRequisition.SetRange(StoreRequisition."No.", "StoreRequisitionNo.");
        if StoreRequisition.FindFirst then begin
            InventoryApprovalManager.ReOpenStoreRequisitionHeader(StoreRequisition);
            StoreRequisitionOpened := true;
        end;
    end;

    procedure CancelStoreRequisitionBudgetCommitment("StoreRequisitionNo.": Code[20]) StoreRequisitionBudgetCommitmentCanceled: Boolean
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        StoreRequisitionBudgetCommitmentCanceled := false;

        StoreRequisition.Reset;
        if StoreRequisition.Get("StoreRequisitionNo.") then begin
            StoreRequisitionBudgetCommitmentCanceled := true;
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
            ApprovalsMgmtMain.ApproveApprovalRequests(ApprovalEntry);
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
            ApprovalsMgmtMain.RejectApprovalRequests(ApprovalEntry);
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
    procedure GetEmployeeStoreReqApprovalEntries(var ApprovalEntries: XMLport "Approval Entries"; EmployeeNo: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        Employee: Record Employee;
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::"Store Requisition");
        if EmployeeNo <> '' then begin
            Employee.Get(EmployeeNo);
            Employee.TestField("User ID");
            ApprovalEntry.SetRange("Approver ID", Employee."User ID");

        end;
        //ApprovalEntry.SETRANGE("Approver ID",'77tyty');
        if ApprovalEntry.FindFirst then;
        ApprovalEntries.SetTableView(ApprovalEntry);
    end;

    [Scope('Personalization')]
    procedure GetStoreReqApprovalEntries(var ApprovalEntries: XMLport "Approval Entries"; StoreReqNo: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        Employee: Record Employee;
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::"Store Requisition");
        if StoreReqNo <> '' then begin
            ApprovalEntry.SetRange("Document No.", StoreReqNo);
        end;
        if ApprovalEntry.FindFirst then;
        ApprovalEntries.SetTableView(ApprovalEntry);
    end;

    [Scope('Personalization')]
    procedure GetGlobalDimension1Codes(var DepartmentCodes: XMLport "Department Codes")
    begin
    end;

    [Scope('Personalization')]
    procedure GetConnectionItemList(var ItemExport: XMLport "Item Export")
    begin
        Item.Reset;
        Item.SetRange("Is Connection Item", true);
        if Item.FindFirst then;
        ItemExport.SetTableView(Item);
    end;

    [Scope('Personalization')]
    procedure GetItemsByTemplate(var ItemExport: XMLport "Item Export"; Template: Option ,New,Tertiary,Cluster)
    begin
        Item.Reset;
        if Template = Template::New then begin
            Item.SetCurrentKey("Sequence New Connections");
            Item.SetRange("NEW CONNECTIONS", true);
        end
        else if Template = Template::Tertiary then begin
            Item.SetCurrentKey("Sequence Tertiary Connections");
            Item.SetRange(TERTIARY, true);
        end
        else if Template = Template::Cluster then begin
            Item.SetCurrentKey("Sequence Cluster Connections");
            Item.SetRange("CLUSTER CONNECTIONS", true);
        end
        else if Template = 0 then begin
            //Item.SETCURRENTKEY("Sequence New Connections");
            //Item.SETRANGE("NEW CONNECTIONS",TRUE);
        end;


        // Item.CALCFIELDS(Inventory);
        //Item.SETFILTER(Inventory,'>%1',0.0);

        if Item.FindFirst then;
        ItemExport.SetTableView(Item);

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
    procedure GetLocations(var LocationExport: XMLport "Location Export")
    begin
        Location.Reset;
        if Location.FindFirst then;
        LocationExport.SetTableView(Location);
    end;

    [Scope('Personalization')]
    procedure CreateFsQuestionaire("EmployeeNo.": Code[20]; StudyNo: Code[20]; Name: Text; Gender: Option ,Male,Female; EmploymentStatus: Option " ",Unemployed,"Self Employed","Works for Government Institution","Works for Private Institution"; IncomePerMonth: Decimal; YearsLivedInHouse: Integer; TypeOfHouse: Option " ",Permanent,"Temporary"; BuildingType: Option " ",Commercial,Residental,MulidWelling; HaveWaterSource: Option " ",yes,No; MainSourceOfWater: Code[50]; InstallationCost: Decimal; PrefferedWaterSource: Code[100]; PerceptionOfWaterQuality: Text; ReasonIfBad: Text; WaterUsedPerDay: Decimal; IfCurrentlyEnough: Option " ",Yes,No; NoOfDaysInWkAvailable: Code[50]; HoursPerDay: Duration; HaveStorageFacility: Option " ",Yes,No; SizeOfStorage: Decimal; Category: Option " ",Elevated,Underground; AmountYouPay: Decimal; ModeOfPayment: Option " ","Per Liter","Per Jelican"; WhenYouPay: Option " ",Daily,Monthly,"Not Applicable"; NeedImprovementOfSource: Option " ",Yes,No; AmountYouWouldPay: Decimal; WouldMigrateIfImproved: Option " ",Yes,No; HoursYouUseMostWater: Duration; MajorUseOfWater: Text) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
        LineNo: Integer;
    begin
        ReturnValue := '';
        LineNo := 0;
        FsQuestionaire.Reset;
        //StoreRequisition.GET("StoreRequisitionNo.");
        if FsQuestionaire.FindLast then
            LineNo := FsQuestionaire."Line No." + 1;

        //FsQuestionaire.RESET;
        FsQuestionaire.Init;
        FsQuestionaire."Line No." := LineNo;
        FsQuestionaire."Document No." := StudyNo;
        FsQuestionaire."Employee No." := "EmployeeNo.";
        FsQuestionaire.Validate("Employee No.");
        FsQuestionaire.Name := Name;
        FsQuestionaire.Gender := Gender;
        FsQuestionaire."Employment Status" := EmploymentStatus;
        FsQuestionaire."Income Per Month" := IncomePerMonth;
        FsQuestionaire."Years lived in the House" := YearsLivedInHouse;
        FsQuestionaire."Type of House" := TypeOfHouse;
        FsQuestionaire."Type of Building" := BuildingType;
        FsQuestionaire."Have Water Source" := HaveWaterSource;
        FsQuestionaire."Main Source of Water" := MainSourceOfWater;
        FsQuestionaire."Cost of Installation" := InstallationCost;
        FsQuestionaire."Preffered Source of Water" := PrefferedWaterSource;
        FsQuestionaire."Water Quality used Perception" := PerceptionOfWaterQuality;
        FsQuestionaire."If  bad Reason" := ReasonIfBad;
        FsQuestionaire."Water Used per Day" := WaterUsedPerDay;
        FsQuestionaire."Currently Enough" := IfCurrentlyEnough;
        FsQuestionaire."Days In a Week" := NoOfDaysInWkAvailable;
        FsQuestionaire."Hours Per Day" := HoursPerDay;
        FsQuestionaire."Have Storage Facilities" := HaveStorageFacility;
        FsQuestionaire."Size of Storage" := SizeOfStorage;
        FsQuestionaire.Category := Category;
        FsQuestionaire."Amount You Pay" := AmountYouPay;
        FsQuestionaire."Mode of Payment" := ModeOfPayment;
        FsQuestionaire."When You Pay" := WhenYouPay;
        FsQuestionaire."Need Improvement of Source" := NeedImprovementOfSource;
        FsQuestionaire."Amount You Would Pay" := AmountYouWouldPay;
        FsQuestionaire."Would Migrate if Improved" := WouldMigrateIfImproved;
        FsQuestionaire."Hours You Use Most Water" := HoursYouUseMostWater;
        FsQuestionaire."Major Use of Water" := MajorUseOfWater;

        if FsQuestionaire.Insert then begin
            ReturnValue := '200: Record Successfully Created';
        end else
            ReturnValue := '400: An Error Occured while saving.' + GetLastErrorCode + '-' + GetLastErrorText;

    end;

    [Scope('Personalization')]
    procedure ModifyFsQuestionaire("LineNo.": Integer; "EmployeeNo.": Code[20]; StudyNo: Code[20]; Name: Text; Gender: Option ,Male,Female; EmploymentStatus: Option " ",Unemployed,"Self Employed","Works for Government Institution","Works for Private Institution"; IncomePerMonth: Decimal; YearsLivedInHouse: Integer; TypeOfHouse: Option " ",Permanent,"Temporary"; BuildingType: Option " ",Commercial,Residental,MulidWelling; HaveWaterSource: Option " ",yes,No; MainSourceOfWater: Code[50]; InstallationCost: Decimal; PrefferedWaterSource: Code[10]; PerceptionOfWaterQuality: Text; ReasonIfBad: Text; WaterUsedPerDay: Decimal; IfCurrentlyEnough: Option " ",Yes,No; NoOfDaysInWkAvailable: Code[50]; HoursPerDay: Duration; HaveStorageFacility: Option " ",Yes,No; SizeOfStorage: Decimal; Category: Option " ",Elevated,Underground; AmountYouPay: Decimal; ModeOfPayment: Option " ","Per Liter","Per Jelican"; WhenYouPay: Option " ",Daily,Monthly,"Not Applicable"; NeedImprovementOfSource: Option " ",Yes,No; AmountYouWouldPay: Decimal; WouldMigrateIfImproved: Option " ",Yes,No; HoursYouUseMostWater: Duration; MajorUseOfWater: Text) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
        LineNo: Integer;
    begin
        ReturnValue := '400: Line Not found';
        FsQuestionaire.Reset;
        //StoreRequisition.GET("StoreRequisitionNo.");
        if FsQuestionaire.Get("LineNo.") then begin
            //FsQuestionaire."Document No.":=StudyNo;
            FsQuestionaire."Employee No." := "EmployeeNo.";
            FsQuestionaire.Validate("Employee No.");
            FsQuestionaire.Name := Name;
            FsQuestionaire.Gender := Gender;
            FsQuestionaire."Employment Status" := EmploymentStatus;
            FsQuestionaire."Income Per Month" := IncomePerMonth;
            FsQuestionaire."Years lived in the House" := YearsLivedInHouse;
            FsQuestionaire."Type of House" := TypeOfHouse;
            FsQuestionaire."Type of Building" := BuildingType;
            FsQuestionaire."Have Water Source" := HaveWaterSource;
            FsQuestionaire."Main Source of Water" := MainSourceOfWater;
            FsQuestionaire."Cost of Installation" := InstallationCost;
            FsQuestionaire."Preffered Source of Water" := PrefferedWaterSource;
            FsQuestionaire."Water Quality used Perception" := PerceptionOfWaterQuality;
            FsQuestionaire."If  bad Reason" := ReasonIfBad;
            FsQuestionaire."Water Used per Day" := WaterUsedPerDay;
            FsQuestionaire."Currently Enough" := IfCurrentlyEnough;
            FsQuestionaire."Days In a Week" := NoOfDaysInWkAvailable;
            FsQuestionaire."Hours Per Day" := HoursPerDay;
            FsQuestionaire."Have Storage Facilities" := HaveStorageFacility;
            FsQuestionaire."Size of Storage" := SizeOfStorage;
            FsQuestionaire.Category := Category;
            FsQuestionaire."Amount You Pay" := AmountYouPay;
            FsQuestionaire."Mode of Payment" := ModeOfPayment;
            FsQuestionaire."When You Pay" := WhenYouPay;
            FsQuestionaire."Need Improvement of Source" := NeedImprovementOfSource;
            FsQuestionaire."Amount You Would Pay" := AmountYouWouldPay;
            FsQuestionaire."Would Migrate if Improved" := WouldMigrateIfImproved;
            FsQuestionaire."Hours You Use Most Water" := HoursYouUseMostWater;
            FsQuestionaire."Major Use of Water" := MajorUseOfWater;

            if FsQuestionaire.Modify then begin
                ReturnValue := '200: Record Successfully Modified';
            end else
                ReturnValue := '400: An Error Occured while saving.' + GetLastErrorCode + '-' + GetLastErrorText;
        end;
    end;

    [Scope('Personalization')]
    procedure DeleteFsQuestionaireLine("LineNo.": Integer; StudyNo: Code[20]) FsQuestionaireLineDeleted: Boolean
    begin
        FsQuestionaireLineDeleted := false;
        TransportRequest.SetRange("Request No.", StudyNo);
        if TransportRequest.FindFirst then
            TransportRequest.TestField(Status, TransportRequest.Status::Open);

        FsQuestionaire.Reset;
        FsQuestionaire.SetRange(FsQuestionaire."Line No.", "LineNo.");
        FsQuestionaire.SetRange(FsQuestionaire."Document No.", StudyNo);
        if FsQuestionaire.FindFirst then begin
            if FsQuestionaire.Delete then begin
                FsQuestionaireLineDeleted := true;
            end;
        end;
    end;

    [Scope('Personalization')]
    procedure GetFeasilbilityStudyList(var FeasibilityStudyExport: XMLport "FeasibilityStudy Export"; ProjectNo: Code[20])
    begin
        TransportRequest.Reset;
        TransportRequest.SetFilter("Document Type", '<>%1', TransportRequest."Document Type"::" ");

        if ProjectNo <> '' then
            TransportRequest.SetRange("Project No", ProjectNo);

        if TransportRequest.FindFirst then;
        FeasibilityStudyExport.SetTableView(TransportRequest);
    end;

    [Scope('Personalization')]
    procedure CreateProjectRequest("EmployeeNo.": Code[20]; RequestedDate: Date; NatureOfRequest: Option " ","Sewer Line Extension","Water Pipeline Extension","Water Supply Project","Sewer Network Project","Contruction Works",Others; RequestReason: Option " ","Extend to new customers","Solve Pressure Issues","Replace a dilapidated line","New construction","Repair of existing masonry/concrete chamber/manhole/kiosk",Others; ProblemStatement: Text; Location: Text; NoOfConnectableCustomer: Integer; PipeDiameter: Decimal; NoOfManholes: Integer; OtherInformation: Text; SupervisorNo: Code[20]; projectNo: Text[20]; ProjectName: Text[150]) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
    begin
        ReturnValue := '';

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        HumanResSetup.Reset;

        //HumanResSetup.GET;
        //HumanResSetup.TESTFIELD(HumanResSetup."Project Request Nos");
        //"DocNo.":=NoSeriesMgt.GetNextNo(HumanResSetup."Project Implementation Nos",0D,TRUE);
        //IF "DocNo."<>'' THEN BEGIN
        TransportRequest.Init;
        TransportRequest."Request No." := projectNo;
        TransportRequest."Project No" := projectNo;
        TransportRequest."Request Date" := Today;
        TransportRequest."Project Name" := ProjectName;
        TransportRequest."Employee No." := "EmployeeNo.";
        TransportRequest.Validate("Employee No.");
        TransportRequest."User ID" := Employee."User ID";
        TransportRequest."Document Type" := TransportRequest."Document Type"::"Project Request";
        TransportRequest."P.Nature of Request" := NatureOfRequest;
        TransportRequest.Description := ProblemStatement;
        TransportRequest.Location := Location;
        TransportRequest."P.No of Customer to Connect" := NoOfConnectableCustomer;
        TransportRequest."P.Ppe Diameter" := Format(PipeDiameter);
        TransportRequest."P.No Of Manholes" := NoOfManholes;
        TransportRequest."P.Other Information" := OtherInformation;
        TransportRequest."Supervisor No." := SupervisorNo;

        if TransportRequest.Insert then begin
            ReturnValue := '200: Project Requisition No ' + "DocNo." + ' Successfully Created';
        end
        else
            ReturnValue := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
        //END;
    end;

    [Scope('Personalization')]
    procedure CreateImplementationLines("EmployeeNo.": Code[20]; ImplementationNo: Code[20]; PlanningLineNo: Integer; "Action": Code[150]; ActionDescription: Text; Cost: Decimal) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
        LineNo: Integer;
    begin
        ReturnValue := '';
        LineNo := 0;
        if ImplementationLine.FindLast then
            LineNo := ImplementationLine."Line No." + 1;

        ImplementationLine.Reset;
        ImplementationLine.Init;
        ImplementationLine."Line No." := LineNo;
        ImplementationLine."Document No." := ImplementationNo;
        ImplementationLine."Employee No" := "EmployeeNo.";
        ImplementationLine."Planning Line No." := PlanningLineNo;
        ImplementationLine.Validate("Planning Line No.");
        ImplementationLine.Action := Action;
        ImplementationLine."Action Description" := ActionDescription;

        if ImplementationLine.Insert then
            ReturnValue := 'Line Added Successfully'
        else
            ReturnValue := '400:';
    end;

    [Scope('Personalization')]
    procedure ModifyImplementationLines("EmployeeNo.": Code[20]; LineNo: Integer; ImplementationNo: Code[20]; PlanningLineNo: Integer; "Action": Code[20]; ActionDescription: Text; Cost: Decimal) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
    begin
        ReturnValue := '';
        if ImplementationLine.Get(LineNo) then begin
            ImplementationLine."Document No." := ImplementationNo;
            ImplementationLine."Employee No" := "EmployeeNo.";
            ImplementationLine."Planning Line No." := PlanningLineNo;
            ImplementationLine.Validate("Planning Line No.");
            ImplementationLine.Action := Action;
            ImplementationLine."Action Description" := ActionDescription;

            if ImplementationLine.Modify then
                ReturnValue := 'Line Added Successfully'
            else
                ReturnValue := '400:';
        end;
    end;

    [Scope('Personalization')]
    procedure GetActionPlanningLines(var ActionPlanLinesExport: XMLport "ActionPlanLines Export"; ActionPlanNo: Code[20])
    begin
        ActionPlanLine.Reset;
        ActionPlanLine.SetRange("Document No.", ActionPlanNo);
        if ActionPlanLine.FindFirst then;
        ActionPlanLinesExport.SetTableView(ActionPlanLine);
    end;

    [Scope('Personalization')]
    procedure GetImplementationLines(var ImplementationLinesExport: XMLport "ImplementationLines Export"; ImplementationNo: Code[20])
    begin
        ProjectImplementationLine.Reset;
        ProjectImplementationLine.SetRange("Document No.", ImplementationNo);
        if ProjectImplementationLine.FindFirst then;
        ImplementationLinesExport.SetTableView(ProjectImplementationLine);
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
        if InventoryUserSetup.Get(Employee."User ID") then begin
            InventoryUserSetup.TestField(InventoryUserSetup."Item Journal Template");
            InventoryUserSetup.TestField(InventoryUserSetup."Item Journal Batch");
            StoreRequisition."Posting Date" := StoreRequisition."Required Date"; //TODAY;
                                                                                 //StoreRequisition."Issued By" := StoreRequisition."User ID";
            StoreRequisition.Modify;
            JTemplate := InventoryUserSetup."Item Journal Template";
            JBatch := InventoryUserSetup."Item Journal Batch";
            InventoryManagement.PostStoreRequisitionPortal(StoreRequisition, JTemplate, JBatch);
            StoreRequisitionPost := '200: Store requistion posted successfully';
        end else begin
            StoreRequisitionPost := '400:' + StoreRequisition."User ID" + ' is not set in Inventory User Setup';//+GETLASTERRORCODE+'-'+GETLASTERRORTEXT;
                                                                                                                //ERROR(Txt_001,Employee."User ID");
        end;
    end;

    [Scope('Personalization')]
    procedure CreateStoreRequisitionII("EmployeeNo.": Code[20]; RequiredDate: Date; Description: Text[100]; Department: Code[20]; Template: Option ,New,Tertiary,Cluster; DocumentName: Text; ProjectNo: Code[20]) ReturnValue: Text
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
            StoreRequisition."User ID" := Employee."User ID";
            StoreRequisition."Requester ID" := Employee."User ID";
            StoreRequisition."Required Date" := RequiredDate;
            StoreRequisition.Description := Description;
            StoreRequisition."Document Name" := DocumentName;
            StoreRequisition."Project No" := ProjectNo;
            StoreRequisition.Validate("Project No");

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
    procedure CreateStoreRequisitionLineII("StoreRequisitionNo.": Code[20]; "ItemNo.": Code[20]; LocationCode: Code[20]; Quantity: Decimal; UOM: Code[10]; Description: Text; GlobalDimensionIV: Code[20]) StoreRequisitionLineCreated: Text
    begin
        StoreRequisitionLineCreated := '';
        Item.Get("ItemNo.");

        Item.CalcFields(Inventory);

        //IF Quantity> Item.Inventory THEN
        //ERROR(Text_0001);

        //IF Quantity<1 THEN ERROR('Quantity Must be Greater than 0');

        StoreRequisition.Reset;
        StoreRequisition.Get("StoreRequisitionNo.");

        StoreRequisitionLine.Init;
        StoreRequisitionLine."Line No." := 0;
        StoreRequisitionLine."Document No." := "StoreRequisitionNo.";
        StoreRequisitionLine.Type := StoreRequisitionLine.Type::Item;
        StoreRequisitionLine."Item No." := "ItemNo.";
        StoreRequisitionLine.Validate(StoreRequisitionLine."Item No.");

        //StoreRequisitionLine."Location Code":=LocationCode;
        //StoreRequisitionLine.VALIDATE(StoreRequisitionLine."Location Code");
        StoreRequisitionLine.Validate(Quantity, Quantity);
        StoreRequisitionLine."Line Amount" := StoreRequisitionLine.Quantity * StoreRequisitionLine."Unit Cost";
        //StoreRequisitionLine."Unit of Measure Code":=UOM;
        //StoreRequisitionLine.VALIDATE(StoreRequisitionLine."Unit of Measure Code");
        //StoreRequisitionLine.Description:=Description;
        StoreRequisitionLine."Shortcut Dimension 4 Code" := GlobalDimensionIV;
        StoreRequisitionLine.Validate("Shortcut Dimension 4 Code");

        if StoreRequisitionLine.Insert then begin
            StoreRequisitionLineCreated := '200: Store Requisition Line Successfully Created';
        end else
            StoreRequisitionLineCreated := GetLastErrorCode + '-' + GetLastErrorText;

    end;

    [Scope('Personalization')]
    procedure ModifyStoreRequisitionLineII("LineNo.": Integer; "StoreRequisitionNo.": Code[20]; "ItemNo.": Code[20]; Quantity: Decimal; UOM: Code[10]; Description: Text; LocationCode: Code[20]; GlobalDimensionIV: Code[20]) StoreRequisitionLineModified: Boolean
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
    procedure ModifyProjectRequest(ProjectNo: Code[10]; ProjectName: Text[150]; ProjectStartDate: Date; ProjectEndDate: Date; Projectstatus: Text[20]; ProjectManagerNo: Code[10]; ProjectManagerName: Text[50]; ProjectLocation: Text[150]; ProjectCost: Decimal; ProjectProblemStatement: Text[1000]) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
        LineNo: Integer;
    begin
        ReturnValue := '400: Line Not found';
        TransportRequest.Reset;
        //StoreRequisition.GET("StoreRequisitionNo.");
        if TransportRequest.Get(ProjectNo) then begin
            //FsQuestionaire."Document No.":=StudyNo;
            TransportRequest."Project Name" := ProjectName;
            TransportRequest."Start Date" := ProjectStartDate;
            TransportRequest."Construction Completion date" := ProjectEndDate;
            TransportRequest.Comments := ProjectProblemStatement;
            TransportRequest.Location := ProjectLocation;

            if TransportRequest.Modify then begin
                ReturnValue := '200: Record Successfully Modified';
            end else
                ReturnValue := '400: An Error Occured while saving.' + GetLastErrorCode + '-' + GetLastErrorText;
        end;
    end;

    [Scope('Personalization')]
    procedure GetStoreRequisitiontListPerProject(var StoreRequisitionExport: XMLport "Store Requisition Export"; ProjectNo: Code[20])
    begin
        if ProjectNo <> '' then begin
            StoreRequisition2.Reset;
            StoreRequisition2.SetFilter("Project No", ProjectNo);
            if StoreRequisition2.FindFirst then;
            StoreRequisitionExport.SetTableView(StoreRequisition2);
        end
    end;

    [Scope('Personalization')]
    procedure CreateStoreRequisitionIII("EmployeeNo.": Code[20]; RequiredDate: Date; Description: Text[100]; Department: Code[20]; Template: Option ,New,Tertiary,Cluster; DocumentName: Text; ProjectNo: Code[20]; Zone: Code[20]; Route: Code[20]; PointOfUse: Code[100]) ReturnValue: Text
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
            StoreRequisition."User ID" := Employee."User ID";
            StoreRequisition."Requester ID" := Employee."User ID";
            StoreRequisition."Required Date" := RequiredDate;
            StoreRequisition.Description := Description;
            StoreRequisition."Document Name" := DocumentName;
            StoreRequisition."Project No" := ProjectNo;
            StoreRequisition.Validate("Project No");
            StoreRequisition."Shortcut Dimension 3 Code" := Zone;
            StoreRequisition."Shortcut Dimension 4 Code" := Route;
            StoreRequisition."Point Of Use" := PointOfUse;

            StoreRequisition.Validate(Template, Template);

            HREmployee.Reset;
            HREmployee.SetRange("No.", "EmployeeNo.");
            if HREmployee.FindFirst then begin
                StoreRequisition."Global Dimension 1 Code" := HREmployee."Global Dimension 1 Code";
                StoreRequisition.Validate(StoreRequisition."Global Dimension 1 Code");
                StoreRequisition."Global Dimension 2 Code" := HREmployee."Global Dimension 2 Code";
                // StoreRequisition."Shortcut Dimension 3 Code":=HREmployee."Shortcut Dimension 3 Code";
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
}

