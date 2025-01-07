codeunit 50008 "Procurement Management WS"
{

    trigger OnRun()
    begin
    end;

    var
        PurchaseRequisition: Record "Purchase Requisitions";
        PurchaseRequisitionLine: Record "Purchase Requisition Line";
        "Purchases&PayablesSetup": Record "Purchases & Payables Setup";
        Employee: Record Employee;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ApprovalsMgmtMain: Codeunit "Approvals Mgmt.";
        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
        ProcurementApprovalManager: Codeunit "Procurement Approval Manager";
        Text0001: Label 'You Have exceeded the Budget by ';
        Text0002: Label 'Do you want to Continue?';
        Text0003: Label 'There is no Budget to Check against do you wish to continue?';
        Text0004: Label 'The Current Date %1 In The Order Does Not Fall Within Budget Dates %2 - %3';
        Text0005: Label 'The Current Date %1 In The Order Does Not Fall Within Budget Dates %2 - %3';
        Text0006: Label 'No Budget To Check Against';
        Text0007: Label 'Item Does not Exist';
        Text0008: Label 'Ensure Fixed Asset No %1 has the Maintenance G/L Account';
        Text0009: Label 'Ensure Fixed Asset No %1 has the Acquisition G/L Account';
        Text0010: Label 'No Budget To Check Against';
        Text0011: Label 'The Amount On Purchase Requisition No %1  %2 %3  Exceeds The Budget By %4';
        PurchaseRequisitions2: Record "Purchase Requisitions";
        ApprovalEntry: Record "Approval Entry";
        ProcurementManagement: Codeunit "Procurement Management";

    [Scope('Personalization')]
    procedure GetItemList(var ItemExport: XMLport "Item Export")
    begin
    end;

    [Scope('Personalization')]
    procedure GetPurchaseRequisitionList(var PurchaseRequisitionExport: XMLport "Purchase Requisition Export"; EmployeeNo: Code[20])
    begin
        if EmployeeNo <> '' then begin
            PurchaseRequisitions2.Reset;
            PurchaseRequisitions2.SetFilter("Employee No.", EmployeeNo);
            if PurchaseRequisitions2.FindFirst then;
            PurchaseRequisitionExport.SetTableView(PurchaseRequisitions2);
        end
    end;

    [Scope('Personalization')]
    procedure GetPurchaseRequisitionHeaderLines(var PurchaseRequisitionExport: XMLport "Purchase Requisition Export"; HeaderNo: Code[20])
    begin
        if HeaderNo <> '' then begin
            PurchaseRequisitions2.Reset;
            PurchaseRequisitions2.SetFilter("No.", HeaderNo);
            if PurchaseRequisitions2.FindFirst then;
            PurchaseRequisitionExport.SetTableView(PurchaseRequisitions2);
        end
    end;

    [Scope('Personalization')]
    procedure GetPurchaseRequisitionListStatus(var PurchaseRequisitionExport: XMLport "Purchase Requisition Export"; EmployeeNo: Code[20]; PRQStatus: Option Open,"Pending Approval",Approved,Rejected,Closed)
    begin

        PurchaseRequisitions2.Reset;
        PurchaseRequisitions2.SetRange(Status, PRQStatus);
        if EmployeeNo <> '' then begin
            PurchaseRequisitions2.SetFilter("Employee No.", EmployeeNo);
            if PurchaseRequisitions2.FindFirst then;
            PurchaseRequisitionExport.SetTableView(PurchaseRequisitions2);
        end
    end;

    [Scope('Personalization')]
    procedure GetFixedAssetList(var FixedAssetExport: XMLport "Fixed Asset Export")
    begin
    end;

    [Scope('Personalization')]
    procedure GetServicecodes(var PurchaseReqCodesExport: XMLport "Purchase Req Codes Export")
    begin
    end;

    [Scope('Personalization')]
    procedure CheckPurchaseRequisitionExists("PurchaseRequisitionNo.": Code[20]; "EmployeeNo.": Code[20]) PurchaseRequisitionExist: Boolean
    begin
        PurchaseRequisitionExist := false;
        PurchaseRequisition.Reset;
        PurchaseRequisition.SetRange(PurchaseRequisition."No.", "PurchaseRequisitionNo.");
        PurchaseRequisition.SetRange(PurchaseRequisition."Employee No.", "EmployeeNo.");
        if PurchaseRequisition.FindFirst then begin
            PurchaseRequisitionExist := true;
        end;
    end;

    [Scope('Personalization')]
    procedure CheckOpenPurchaseRequisitionExists("EmployeeNo.": Code[20]) OpenPurchaseRequisitionExist: Boolean
    begin
        OpenPurchaseRequisitionExist := false;
        PurchaseRequisition.Reset;
        PurchaseRequisition.SetRange(PurchaseRequisition."Employee No.", "EmployeeNo.");
        PurchaseRequisition.SetFilter(PurchaseRequisition.Status, '=%1|%2', 0, 1);
        if PurchaseRequisition.FindFirst then begin
            OpenPurchaseRequisitionExist := true;
        end;
    end;

    [Scope('Personalization')]
    procedure CreatePurchaseRequisition("EmployeeNo.": Code[20]; RequestedReceiptDate: Date; Description: Text[1000]; Department: Code[20]; ProjectNo: Code[20]) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
        PurchaseRequisition2: Record "Purchase Requisitions";
        ProcurementPortalDocuments: Record "Procurement  Portal Documents";
    begin
        ReturnValue := '';

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        "Purchases&PayablesSetup".Reset;
        "Purchases&PayablesSetup".Get;

        "DocNo." := NoSeriesMgt.GetNextNo("Purchases&PayablesSetup"."Purchase Requisition Nos.", 0D, true);
        if "DocNo." <> '' then begin
            PurchaseRequisition.Init;
            PurchaseRequisition."No." := "DocNo.";
            PurchaseRequisition."Document Date" := Today;
            PurchaseRequisition."Employee No." := "EmployeeNo.";
            PurchaseRequisition.Validate(PurchaseRequisition."Employee No.");
            PurchaseRequisition."User ID" := Employee."User ID";
            PurchaseRequisition.Description := Description;
            PurchaseRequisition.Validate("Project No", ProjectNo);
            HREmployee.Reset;
            HREmployee.SetRange(HREmployee."No.", "EmployeeNo.");
            if HREmployee.FindFirst then begin
                PurchaseRequisition."Global Dimension 1 Code" := HREmployee."Global Dimension 1 Code";
                PurchaseRequisition."Global Dimension 2 Code" := HREmployee."Global Dimension 2 Code";
                PurchaseRequisition."Shortcut Dimension 3 Code" := HREmployee."Shortcut Dimension 3 Code";
                PurchaseRequisition."Shortcut Dimension 4 Code" := HREmployee."Shortcut Dimension 4 Code";
                PurchaseRequisition.HOD := HREmployee.HOD;
                PurchaseRequisition."Area Manager" := HREmployee.Supervisor;
            end;
            if PurchaseRequisition.Insert then begin
                ReturnValue := '200: Procurement Requistion No ' + "DocNo." + ' Successfully Created';
            end
            else
                ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;

            /*
            IF PurchaseRequisition.INSERT THEN BEGIN
             //Insert procurement upload documents
              PurchaseRequisition2.RESET;
              PurchaseRequisition2.SETRANGE(PurchaseRequisition2."Employee No.","EmployeeNo.");
              PurchaseRequisition2.SETRANGE(PurchaseRequisition2.Status,PurchaseRequisition2.Status::Open);
              IF PurchaseRequisition2.FINDFIRST THEN BEGIN
                REPEAT
                  ProcurementPortalDocuments.INIT;
                  ProcurementPortalDocuments."DocumentNo.":=PurchaseRequisition."No.";
                  ProcurementPortalDocuments."Document Code":=UPPERCASE('Requisition Document');
                  ProcurementPortalDocuments."Document Description":=UPPERCASE('Detailed Document');
                  ProcurementPortalDocuments."Document Attached":=FALSE;
                  ProcurementPortalDocuments.INSERT;
                UNTIL ProcurementPortalDocuments.NEXT=0;
              "PurchaseRequisitionNo.":="DocNo.";
              END;
             END;
             */
        end;

    end;

    [Scope('Personalization')]
    procedure ModifyPurchaseRequisition("PurchaseRequisitionNo.": Code[20]; "EmployeeNo.": Code[20]; RequestedReceiptDate: Date; Description: Text[1000]; Department: Code[20]; DocumentName: Text; ProjectNo: Code[20]) PurchaseRequisitionModified: Boolean
    var
        HREmployee: Record Employee;
    begin
        //Check requisition document is attached
        //CheckProcurementUploadedDocumentAttached("PurchaseRequisitionNo.");
        PurchaseRequisitionModified := false;
        PurchaseRequisition.Reset;
        PurchaseRequisition.SetRange(PurchaseRequisition."No.", "PurchaseRequisitionNo.");
        if PurchaseRequisition.FindFirst then begin
            PurchaseRequisition."Requested Receipt Date" := RequestedReceiptDate;
            PurchaseRequisition.Validate(PurchaseRequisition."Currency Code");
            PurchaseRequisition.Description := Description;
            PurchaseRequisition."Document Name" := DocumentName;
            PurchaseRequisition.Validate("Project No", ProjectNo);
            HREmployee.Reset;
            HREmployee.SetRange(HREmployee."No.", "EmployeeNo.");
            if HREmployee.FindFirst then begin
                PurchaseRequisition."Global Dimension 1 Code" := HREmployee."Global Dimension 1 Code";
                PurchaseRequisition."Global Dimension 2 Code" := HREmployee."Global Dimension 2 Code";
                PurchaseRequisition."Shortcut Dimension 3 Code" := HREmployee."Shortcut Dimension 3 Code";
                PurchaseRequisition."Shortcut Dimension 4 Code" := HREmployee."Shortcut Dimension 4 Code";
            end;
            if PurchaseRequisition.Modify then
                PurchaseRequisitionModified := true;
        end;
    end;

    [Scope('Personalization')]
    procedure GetPurchaseRequisitionAmount("PurchaseRequisitionNo.": Code[20]) PurchaseRequisitionAmount: Decimal
    begin
        PurchaseRequisitionAmount := 0;

        PurchaseRequisition.Reset;
        if PurchaseRequisition.Get("PurchaseRequisitionNo.") then begin
            PurchaseRequisition.CalcFields(Amount);
            PurchaseRequisitionAmount := PurchaseRequisition.Amount;
        end;
    end;

    [Scope('Personalization')]
    procedure GetPurchaseRequisitionStatus("PurchaseRequisitionNo.": Code[20]) PurchaseRequisitionStatus: Text
    begin
        PurchaseRequisitionStatus := '';

        PurchaseRequisition.Reset;
        if PurchaseRequisition.Get("PurchaseRequisitionNo.") then begin
            PurchaseRequisitionStatus := Format(PurchaseRequisition.Status);
        end;
    end;

    [Scope('Personalization')]
    procedure GetPurchaseRequisitionGlobalDimension1Code("PurchaseRequisitionNo.": Code[20]) GlobalDimension1Code: Text
    begin
        GlobalDimension1Code := '';

        PurchaseRequisition.Reset;
        if PurchaseRequisition.Get("PurchaseRequisitionNo.") then begin
            GlobalDimension1Code := PurchaseRequisition."Global Dimension 1 Code";
        end;
    end;

    [Scope('Personalization')]
    procedure GetPurchaseRequisitionGlobalDimension2Code("PurchaseRequisitionNo.": Code[20]) GlobalDimension2Code: Text
    begin
        GlobalDimension2Code := '';

        PurchaseRequisition.Reset;
        if PurchaseRequisition.Get("PurchaseRequisitionNo.") then begin
            GlobalDimension2Code := PurchaseRequisition."Global Dimension 2 Code";
        end;
    end;

    [Scope('Personalization')]
    procedure CreatePurchaseRequisitionLine("PurchaseRequisitionNo.": Code[20]; RequisitionType: Code[20]; RequisitionCode: Code[50]; Quantity: Decimal; UnitCost: Decimal; Description: Text[1000]) PurchaseRequisitionLineCreated: Boolean
    var
        StockItem: Record Item;
        HREmployee: Record Employee;
    begin
        PurchaseRequisitionLineCreated := false;

        PurchaseRequisition.Reset;
        PurchaseRequisition.Get("PurchaseRequisitionNo.");

        PurchaseRequisitionLine.Init;
        PurchaseRequisitionLine."Line No." := 0;
        PurchaseRequisitionLine."Document Date" := PurchaseRequisition."Document Date";
        PurchaseRequisitionLine."Document No." := "PurchaseRequisitionNo.";


        if RequisitionType = UpperCase(Format(PurchaseRequisitionLine."Requisition Type"::Service)) then
            PurchaseRequisitionLine."Requisition Type" := PurchaseRequisitionLine."Requisition Type"::Service;
        if RequisitionType = UpperCase(Format(PurchaseRequisitionLine."Requisition Type"::Item)) then
            PurchaseRequisitionLine."Requisition Type" := PurchaseRequisitionLine."Requisition Type"::Item;
        if RequisitionType = UpperCase(Format(PurchaseRequisitionLine."Requisition Type"::"Fixed Asset")) then
            PurchaseRequisitionLine."Requisition Type" := PurchaseRequisitionLine."Requisition Type"::"Fixed Asset";

        if RequisitionCode <> 'N/A' then begin
            PurchaseRequisitionLine."Requisition Code" := RequisitionCode;
            PurchaseRequisitionLine.Validate(PurchaseRequisitionLine."Requisition Code");
        end;

        StockItem.Reset;
        StockItem.SetRange(StockItem."No.", RequisitionCode);
        if StockItem.FindFirst then begin
            PurchaseRequisitionLine."Location Code" := StockItem."Location Code";
            PurchaseRequisitionLine.Validate(PurchaseRequisitionLine."Location Code");
        end;

        PurchaseRequisitionLine.Quantity := Quantity;
        PurchaseRequisitionLine.Validate(PurchaseRequisitionLine.Quantity);
        PurchaseRequisitionLine."Unit Cost" := UnitCost;
        PurchaseRequisitionLine.Validate(PurchaseRequisitionLine."Unit Cost");
        PurchaseRequisitionLine.Description := Description;
        /*HREmployee.RESET;
        HREmployee.SETRANGE(HREmployee."No.","EmployeeNo.");
          IF HREmployee.FINDFIRST THEN BEGIN
            PurchaseRequisition."Global Dimension 1 Code":=HREmployee."Global Dimension 1 Code";
            PurchaseRequisition.VALIDATE(PurchaseRequisition."Global Dimension 1 Code");
            PurchaseRequisition."Global Dimension 2 Code":=HREmployee."Global Dimension 2 Code";
            PurchaseRequisition.VALIDATE(PurchaseRequisition."Global Dimension 2 Code");
        END;*/
        /*
      PurchaseRequisitionLine."Global Dimension 1 Code":=GlobalDimension1Code;
      PurchaseRequisitionLine."Global Dimension 2 Code":=GlobalDimension2Code;
      PurchaseRequisitionLine."Shortcut Dimension 3 Code":=ShortcutDimension3Code;
      PurchaseRequisitionLine."Shortcut Dimension 4 Code":=ShortcutDimension4Code;
      PurchaseRequisitionLine."Shortcut Dimension 5 Code":=ShortcutDimension5Code;
      PurchaseRequisitionLine."Shortcut Dimension 6 Code":=ShortcutDimension6Code;
      PurchaseRequisitionLine."Shortcut Dimension 7 Code":=ShortcutDimension7Code;
      PurchaseRequisitionLine."Shortcut Dimension 8 Code":=ShortcutDimension8Code;*/
        if PurchaseRequisitionLine.Insert then begin
            PurchaseRequisitionLineCreated := true;
        end;

    end;

    [Scope('Personalization')]
    procedure ModifyPurchaseRequisitionLine("LineNo.": Integer; "PurchaseRequisitionNo.": Code[20]; RequisitionType: Code[20]; RequisitionCode: Code[50]; Quantity: Decimal; UnitCost: Decimal; Description: Text[1000]) PurchaseRequisitionLineModified: Boolean
    var
        StockItem: Record Item;
    begin
        PurchaseRequisitionLineModified := false;

        PurchaseRequisitionLine.Reset;
        PurchaseRequisitionLine.SetRange(PurchaseRequisitionLine."Line No.", "LineNo.");
        PurchaseRequisitionLine.SetRange(PurchaseRequisitionLine."Document No.", "PurchaseRequisitionNo.");
        if PurchaseRequisitionLine.FindFirst then begin
            if RequisitionType = UpperCase(Format(PurchaseRequisitionLine."Requisition Type"::Service)) then
                PurchaseRequisitionLine."Requisition Type" := PurchaseRequisitionLine."Requisition Type"::Service;
            if RequisitionType = UpperCase(Format(PurchaseRequisitionLine."Requisition Type"::Item)) then
                PurchaseRequisitionLine."Requisition Type" := PurchaseRequisitionLine."Requisition Type"::Item;
            if RequisitionType = UpperCase(Format(PurchaseRequisitionLine."Requisition Type"::"Fixed Asset")) then
                PurchaseRequisitionLine."Requisition Type" := PurchaseRequisitionLine."Requisition Type"::"Fixed Asset";
            PurchaseRequisitionLine."Requisition Code" := RequisitionCode;
            // PurchaseRequisitionLine.VALIDATE(PurchaseRequisitionLine."Requisition Code");

            StockItem.Reset;
            StockItem.SetRange(StockItem."No.", RequisitionCode);
            if StockItem.FindFirst then begin
                PurchaseRequisitionLine."Location Code" := StockItem."Location Code";
                PurchaseRequisitionLine.Validate(PurchaseRequisitionLine."Location Code");
            end;
            PurchaseRequisitionLine.Quantity := Quantity;
            PurchaseRequisitionLine.Validate(PurchaseRequisitionLine.Quantity);
            PurchaseRequisitionLine."Unit Cost" := UnitCost;
            PurchaseRequisitionLine.Validate(PurchaseRequisitionLine."Unit Cost");
            PurchaseRequisitionLine.Description := Description;
            /*PurchaseRequisitionLine."Global Dimension 1 Code":=GlobalDimension1Code;
            PurchaseRequisitionLine."Global Dimension 2 Code":=GlobalDimension2Code;
            PurchaseRequisitionLine."Shortcut Dimension 3 Code":=ShortcutDimension3Code;
            PurchaseRequisitionLine."Shortcut Dimension 4 Code":=ShortcutDimension4Code;
            PurchaseRequisitionLine."Shortcut Dimension 5 Code":=ShortcutDimension5Code;
            PurchaseRequisitionLine."Shortcut Dimension 6 Code":=ShortcutDimension6Code;
            PurchaseRequisitionLine."Shortcut Dimension 7 Code":=ShortcutDimension7Code;
            PurchaseRequisitionLine."Shortcut Dimension 8 Code":=ShortcutDimension8Code;*/
            if PurchaseRequisitionLine.Modify then begin
                PurchaseRequisitionLineModified := true;
            end;
        end;

    end;

    [Scope('Personalization')]
    procedure DeletePurchaseRequisitionLine("LineNo.": Integer; "PurchaseRequisitionNo.": Code[20]) PurchaseRequisitionLineDeleted: Boolean
    begin
        PurchaseRequisitionLineDeleted := false;

        PurchaseRequisitionLine.Reset;
        PurchaseRequisitionLine.SetRange(PurchaseRequisitionLine."Line No.", "LineNo.");
        PurchaseRequisitionLine.SetRange(PurchaseRequisitionLine."Document No.", "PurchaseRequisitionNo.");
        if PurchaseRequisitionLine.FindFirst then begin
            if PurchaseRequisitionLine.Delete then begin
                PurchaseRequisitionLineDeleted := true;
            end;
        end;
    end;

    [Scope('Personalization')]
    procedure CheckPurchaseRequisitionLinesExist("PurchaseRequisitionNo.": Code[20]) PurchaseRequisitionLinesExist: Boolean
    begin
        PurchaseRequisitionLinesExist := false;

        PurchaseRequisitionLine.Reset;
        PurchaseRequisitionLine.SetRange(PurchaseRequisitionLine."Document No.", "PurchaseRequisitionNo.");
        if PurchaseRequisitionLine.FindFirst then begin
            PurchaseRequisitionLinesExist := true;
        end;
    end;

    [Scope('Personalization')]
    procedure ValidatePurchaseRequisitionLines("PurchaseRequisitionNo.": Code[20]) PurchaseRequisitionLinesError: Text
    var
        "PurchaseRequisitionLineNo.": Integer;
    begin
        PurchaseRequisitionLinesError := '';
        "PurchaseRequisitionLineNo." := 0;

        PurchaseRequisitionLine.Reset;
        PurchaseRequisitionLine.SetRange(PurchaseRequisitionLine."Document No.", "PurchaseRequisitionNo.");
        if PurchaseRequisitionLine.FindSet then begin
            repeat
                "PurchaseRequisitionLineNo." := "PurchaseRequisitionLineNo." + 1;
                if PurchaseRequisitionLine."Requisition Code" = '' then begin
                    PurchaseRequisitionLinesError := 'Requisition code missing on purchase requisition line no.' + Format("PurchaseRequisitionLineNo.") + ', it cannot be zero or empty';
                    break;
                end;

            until PurchaseRequisitionLine.Next = 0;
        end;
    end;

    [Scope('Personalization')]
    procedure CheckPurchaseRequisitionApprovalWorkflowEnabled("PurchaseRequisitionNo.": Code[20]) ApprovalWorkflowEnabled: Boolean
    begin
        ApprovalWorkflowEnabled := false;

        PurchaseRequisition.Reset;
        if PurchaseRequisition.Get("PurchaseRequisitionNo.") then
            ApprovalWorkflowEnabled := ApprovalsMgmt.CheckPurchaseRequisitionApprovalsWorkflowEnabled(PurchaseRequisition);
    end;

    [Scope('Personalization')]
    procedure SendPurchaseRequisitionApprovalRequest("PurchaseRequisitionNo.": Code[20]) PurchaseRequisitionApprovalRequestSent: Text
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        PurchaseRequisitionApprovalRequestSent := '';

        PurchaseRequisition.Reset;
        if PurchaseRequisition.Get("PurchaseRequisitionNo.") then begin
            // ProcurementManagement.CheckBudgetPurchaseRequisition(PurchaseRequisition);//          //commit budget prn by justo 08/02/2023

            ApprovalsMgmt.OnSendPurchaseRequisitionForApproval(PurchaseRequisition);
            Commit;


            // COMMIT;

            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", PurchaseRequisition."No.");
            ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);

            if ApprovalEntry.FindFirst then
                PurchaseRequisitionApprovalRequestSent := '200: Purchase Requisition Approval Request sent Successfully '
            else
                PurchaseRequisitionApprovalRequestSent := '400:' + GetLastErrorCode + '-' + GetLastErrorText;

        end;
    end;

    [Scope('Personalization')]
    procedure CancelPurchaseRequisitionApprovalRequest("PurchaseRequisitionNo.": Code[20]) PurchaseRequisitionApprovalRequestCanceled: Text
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        PurchaseRequisitionApprovalRequestCanceled := '';

        PurchaseRequisition.Reset;
        if PurchaseRequisition.Get("PurchaseRequisitionNo.") then begin
            ApprovalsMgmt.OnCancelPurchaseRequisitionApprovalRequest(PurchaseRequisition);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", PurchaseRequisition."No.");
            if ApprovalEntry.FindLast then begin
                if ApprovalEntry.Status = ApprovalEntry.Status::Canceled then
                    PurchaseRequisitionApprovalRequestCanceled := '200:Approval Request Cancelled Successfully '
                else
                    PurchaseRequisitionApprovalRequestCanceled := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
            end;
        end;
    end;

    procedure ReopenPurchaseRequisition("PurchaseRequisitionNo.": Code[20]) PurchaseRequisitionOpened: Boolean
    begin
        PurchaseRequisitionOpened := false;
        PurchaseRequisition.Reset;
        PurchaseRequisition.SetRange(PurchaseRequisition."No.", "PurchaseRequisitionNo.");
        if PurchaseRequisition.FindFirst then begin
            ProcurementApprovalManager.ReOpenPurchaseRequisitionHeader(PurchaseRequisition);
            PurchaseRequisitionOpened := true;
        end;
    end;

    procedure CheckBudgetPurchaseRequisition(PurchReqNo: Code[20]; DocumentDate: Date)
    var
        PurchLine: Record "Purchase Requisition Line";
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        Items: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        BCSetup: Record "Budget Control Setup";
        BudgetGL: Code[20];
    begin
        /*BCSetup.GET;
        //check if the dates are within the specified range
        IF (DocumentDate< BCSetup."Current Budget Start Date") OR (DocumentDate> BCSetup."Current Budget End Date") THEN BEGIN
          ERROR(Text0004,DocumentDate,
          BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        END;
        
        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");
        
        //get the lines related to the purchase requisition header
        PurchLine.RESET;
        PurchLine.SETRANGE(PurchLine."Document No.",PurchReqNo);
        IF PurchLine.FINDSET THEN BEGIN
          REPEAT
            //Items
            IF PurchLine."Requisition Type"=PurchLine."Requisition Type"::Item THEN BEGIN
              Items.RESET;
              IF NOT Items.GET(PurchLine."Requisition Code") THEN
              ERROR(Text0007);
              Items.TESTFIELD("Item G/L Budget Account");
              BudgetGL:=Items."Item G/L Budget Account";
            END;
        
            //Fixed Asset
            IF PurchLine."Requisition Type"=PurchLine."Requisition Type"::"Fixed Asset" THEN BEGIN
              FixedAssets.RESET;
              FixedAssets.SETRANGE(FixedAssets."No.",PurchLine."No.");
              IF FixedAssets.FINDFIRST THEN BEGIN
                FAPostingGroup.RESET;
                FAPostingGroup.SETRANGE(FAPostingGroup.Code,FixedAssets."FA Posting Group");
                IF FAPostingGroup.FINDFIRST THEN
                IF PurchLine."FA Posting Type"=PurchLine."FA Posting Type"::Maintenance THEN BEGIN
                  BudgetGL:=FAPostingGroup."Maintenance Expense Account";
                  IF BudgetGL ='' THEN
                  ERROR(Text0008,PurchLine."No.");
                END ELSE BEGIN
                  BudgetGL:=FAPostingGroup."Acquisition Cost Account";
                  IF BudgetGL ='' THEN
                  ERROR(Text0009,PurchLine."No.");
                END;
              END;
            END;
        
           //G/L Account
            IF PurchLine."Requisition Type"=PurchLine."Requisition Type"::Service THEN BEGIN
              BudgetGL:=PurchLine."No.";
              IF GLAccount.GET(PurchLine."No.") THEN
              GLAccount.TESTFIELD(GLAccount."Budget Controlled",TRUE);
            END;
        
            //check the votebook now
            FirstDay:=DMY2DATE(1,DATE2DMY(DocumentDate,2),DATE2DMY(DocumentDate,3));
            CurrMonth:=DATE2DMY(DocumentDate,2);
            IF CurrMonth=12 THEN BEGIN
              LastDay:=DMY2DATE(1,1,DATE2DMY(DocumentDate,3) +1);
              LastDay:=CALCDATE('-1D',LastDay);
            END ELSE BEGIN
              CurrMonth:=CurrMonth +1;
              LastDay:=DMY2DATE(1,CurrMonth,DATE2DMY(DocumentDate,3));
              LastDay:=CALCDATE('-1D',LastDay);
            END;
        
            //check the summation of the budget
            BudgetAmount:=0;
            Budget.RESET;
            Budget.SETRANGE(Budget."Budget Name",BCSetup."Current Budget Code");
            Budget.SETFILTER(Budget.Date,'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
            Budget.SETRANGE(Budget."G/L Account No.",BudgetGL);
            {Budget.SETRANGE(Budget."Global Dimension 1 Code",PurchLine."Global Dimension 1 Code");
            Budget.SETRANGE(Budget."Global Dimension 2 Code",PurchLine."Global Dimension 2 Code");
            IF PurchLine."Shortcut Dimension 3 Code" <> '' THEN
             Budget.SETRANGE(Budget."Budget Dimension 3 Code",PurchLine."Shortcut Dimension 3 Code");
            IF PurchLine."Shortcut Dimension 4 Code" <> '' THEN
             Budget.SETRANGE(Budget."Budget Dimension 4 Code",PurchLine."Shortcut Dimension 4 Code");}
            IF Budget.FINDSET THEN BEGIN
             Budget.CALCSUMS(Amount);
             BudgetAmount:=Budget.Amount;
            END;
        
            //get the committments
            CommitmentAmount:=0;
            Commitments.RESET;
            Commitments.SETRANGE(Commitments.Budget,BCSetup."Current Budget Code");
            Commitments.SETRANGE(Commitments."G/L Account No.",BudgetGL);
            Commitments.SETRANGE(Commitments."Posting Date",BCSetup."Current Budget Start Date",LastDay);
            Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code",PurchLine."Global Dimension 1 Code");
            Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code",PurchLine."Global Dimension 2 Code");
            IF PurchLine."Shortcut Dimension 3 Code" <> '' THEN
             Commitments.SETRANGE(Commitments."Shortcut Dimension 3 Code",PurchLine."Shortcut Dimension 3 Code");
            IF PurchLine."Shortcut Dimension 4 Code" <> '' THEN
             Commitments.SETRANGE(Commitments."Shortcut Dimension 4 Code",PurchLine."Shortcut Dimension 4 Code");
            Commitments.CALCSUMS(Commitments.Amount);
            CommitmentAmount:= Commitments.Amount;
        
            //check if there is any budget
            IF (BudgetAmount<=0) THEN
             ERROR(Text0010);
        
            //check if the actuals plus the amount is greater then the budget amount
            IF ((CommitmentAmount + PurchLine."Total Cost(LCY)") > BudgetAmount) AND (BCSetup."Allow OverExpenditure"=FALSE) THEN BEGIN
              ERROR(Text0011,
              PurchLine."Document No.",PurchLine.Type ,PurchLine."No.",
              FORMAT(ABS(BudgetAmount-(CommitmentAmount + ActualsAmount+PurchLine."Total Cost"))));
            END ELSE BEGIN
            //commit Amounts
            Commitments.INIT;
            Commitments."Line No.":=0;
            Commitments.Date:=TODAY;
            Commitments."Posting Date":=DocumentDate;
            Commitments."Document Type":=Commitments."Document Type"::Requisition;
            Commitments."Document No.":=PurchReqNo;
            Commitments.Amount:=PurchLine."Total Cost(LCY)";
            Commitments."Month Budget":=BudgetAmount;
            Commitments.Committed:=TRUE;
            Commitments."Committed By":=USERID;
            Commitments."Committed Date":=DocumentDate;
            Commitments."G/L Account No.":=BudgetGL;
            Commitments."Committed Time":=TIME;
            Commitments."Shortcut Dimension 1 Code":=PurchLine."Global Dimension 1 Code";
            Commitments."Shortcut Dimension 2 Code":=PurchLine."Global Dimension 2 Code";
            Commitments."Shortcut Dimension 3 Code":=PurchLine."Shortcut Dimension 3 Code";
            Commitments."Shortcut Dimension 4 Code":=PurchLine."Shortcut Dimension 4 Code";
            Commitments.Budget:=BCSetup."Current Budget Code";
            Commitments.Type:=Commitments.Type::Vendor;
            Commitments.Committed:=TRUE;
            IF Commitments.INSERT THEN BEGIN
              PurchLine.Committed:=TRUE;
              PurchLine.MODIFY;
             END;
            END;
          UNTIL PurchLine.NEXT=0;
        END;*/

    end;

    procedure CancelBudgetCommitmentPurchaseRequisition(PurchReqNo: Code[20])
    var
        Commitments: Record "Budget Committment";
        EntryNo: Integer;
        PurchLine: Record "Purchase Requisition Line";
        BudgetAmount: Decimal;
        Items: Record Item;
        FixedAsset: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        BudgetGL: Code[20];
        BCSetup: Record "Budget Control Setup";
    begin
        Clear(BudgetAmount);
        BudgetGL := '';
        BCSetup.Get();
        PurchLine.Reset;
        PurchLine.SetRange("Document No.", PurchReqNo);
        PurchLine.SetRange(Committed, true);
        if PurchLine.FindSet then begin
            if PurchLine.Type = PurchLine.Type::Item then
                if Items.Get(PurchLine."No.") then
                    BudgetGL := Items."Item G/L Budget Account"
                else if PurchLine.Type = PurchLine.Type::"Fixed Asset" then
                    if FixedAsset.Get(PurchLine."No.") then
                        FAPostingGroup.Reset;
            FAPostingGroup.SetRange(Code, FixedAsset."FA Posting Group");
            if FAPostingGroup.FindFirst then
                BudgetGL := FAPostingGroup."Acquisition Cost Account"
            else if PurchLine.Type = PurchLine.Type::"G/L Account" then
                BudgetGL := PurchLine."No.";

            repeat
                BudgetAmount := PurchLine.Quantity * PurchLine."Unit Cost";
                Commitments.Reset;
                Commitments.Init;
                Commitments."Line No." := 0;
                Commitments.Date := Today;
                Commitments."Posting Date" := Today;
                Commitments."Document Type" := Commitments."Document Type"::Requisition;
                Commitments."Document No." := PurchReqNo;
                Commitments.Amount := -BudgetAmount;
                Commitments.Committed := true;
                Commitments."Committed By" := UserId;
                Commitments."Committed Date" := Today;
                Commitments."G/L Account No." := BudgetGL;
                Commitments."Committed Time" := Time;
                Commitments."Shortcut Dimension 1 Code" := PurchLine."Global Dimension 1 Code";
                Commitments."Shortcut Dimension 2 Code" := PurchLine."Global Dimension 2 Code";
                Commitments."Shortcut Dimension 3 Code" := PurchLine."Shortcut Dimension 3 Code";
                Commitments."Shortcut Dimension 4 Code" := PurchLine."Shortcut Dimension 4 Code";
                Commitments.Committed := true;
                Commitments.Budget := BCSetup."Current Budget Code";
                if Commitments.Insert then begin
                    PurchLine.Committed := false;
                    PurchLine.Modify;
                end;
            until PurchLine.Next = 0;
        end;
    end;

    procedure CheckIfGLAccountBlocked(BudgetName: Code[20])
    var
        GLBudgetName: Record "G/L Budget Name";
    begin
        GLBudgetName.Get(BudgetName);
        GLBudgetName.TestField(Blocked, false);
    end;

    procedure ModifyProcurementUploadedDocumentLocalURL("DocumentNo.": Code[20]; DocumentCode: Code[50]; LocalURL: Text[250]) UploadedDocumentModified: Boolean
    var
        ProcurementPortalDocuments: Record "Procurement  Portal Documents";
    begin
        UploadedDocumentModified := false;
        ProcurementPortalDocuments.Reset;
        ProcurementPortalDocuments.SetRange(ProcurementPortalDocuments."DocumentNo.", "DocumentNo.");
        ProcurementPortalDocuments.SetRange(ProcurementPortalDocuments."Document Code", DocumentCode);
        if ProcurementPortalDocuments.FindFirst then begin
            ProcurementPortalDocuments."Local File URL" := LocalURL;
            ProcurementPortalDocuments."Document Attached" := true;
            if ProcurementPortalDocuments.Modify then
                UploadedDocumentModified := true;
        end;
    end;

    procedure CheckProcurementUploadedDocumentAttached("DocumentNo.": Code[20]) UploadedDocumentAttached: Boolean
    var
        ProcurementPortalDocuments: Record "Procurement  Portal Documents";
        Error0001: Label '%1 must be attached.';
    begin
        UploadedDocumentAttached := false;
        ProcurementPortalDocuments.Reset;
        ProcurementPortalDocuments.SetRange(ProcurementPortalDocuments."DocumentNo.", "DocumentNo.");
        if ProcurementPortalDocuments.FindSet then begin
            repeat
                if ProcurementPortalDocuments."Local File URL" = '' then
                    Error(Error0001, ProcurementPortalDocuments."Document Description");
            until ProcurementPortalDocuments.Next = 0;
            UploadedDocumentAttached := true;
        end;
    end;

    procedure DeleteProcurementUploadedDocument("DocumentNo.": Code[20]) UploadedDocumentDeleted: Boolean
    var
        ProcurementPortalDocuments: Record "Procurement  Portal Documents";
    begin
        UploadedDocumentDeleted := false;
        ProcurementPortalDocuments.Reset;
        ProcurementPortalDocuments.SetRange(ProcurementPortalDocuments."DocumentNo.", "DocumentNo.");
        if ProcurementPortalDocuments.FindSet then begin
            ProcurementPortalDocuments.DeleteAll;
            UploadedDocumentDeleted := true;
        end;
    end;

    [Scope('Personalization')]
    procedure ApprovePurchaseReqApplication("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]) Approved: Text
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
            Approved := '200: Purchase Requisition Approved Successfully '
        else
            Approved := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure RejectPurchaseReqApplication("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]; "Reject Comments": Text) Rejected: Text
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
            ApprovalEntry."Rejection Comments" := "Reject Comments";
            ApprovalEntry.Modify;
            ApprovalsMgmtMain.RejectApprovalRequests(ApprovalEntry);
        end;
        Commit;

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Entry No.", "EntryNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Rejected);
        if ApprovalEntry.FindFirst then
            Rejected := '200: Purchase requisition Rejected Successfully '
        else
            Rejected := '400:' + GetLastErrorCode + '-' + GetLastErrorText;

        //**************************************** HR Leave Reimbursement ********************************************************************************************************************************************************
    end;

    [Scope('Personalization')]
    procedure GetEmployeePurchaseReqApprovalEntries(var ApprovalEntries: XMLport "Approval Entries"; EmployeeNo: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        Employee: Record Employee;
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::Requisition);
        if EmployeeNo <> '' then begin
            Employee.Get(EmployeeNo);
            Employee.TestField("User ID");
            ApprovalEntry.SetRange("Approver ID", Employee."User ID");
        end;
        if ApprovalEntry.FindFirst then;
        ApprovalEntries.SetTableView(ApprovalEntry);
    end;

    [Scope('Personalization')]
    procedure GetPurchaseReqApprovalEntries(var ApprovalEntries: XMLport "Approval Entries"; LeaveNo: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        Employee: Record Employee;
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::Requisition);
        if LeaveNo <> '' then begin
            ApprovalEntry.SetRange("Document No.", LeaveNo);
        end;
        if ApprovalEntry.FindFirst then;
        ApprovalEntries.SetTableView(ApprovalEntry);
    end;

    [Scope('Personalization')]
    procedure GetGlobalDimension1Codes(var DepartmentCodes: XMLport "Department Codes")
    begin
    end;
}

