codeunit 50002 "Funds Management WS"
{

    trigger OnRun()
    begin
        //CreateImprestSurrenderHeader('0162','IMPRN0013','');

        //MESSAGE(CancelImprestApprovalRequest('IMPRN00095'));

        Message(SendImprestApprovalRequest('IMPRN00296'))
    end;

    var
        ImprestHeader: Record "Imprest Header";
        ImprestLine: Record "Imprest Line";
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
        ImprestSurrenderLine: Record "Imprest Surrender Line";
        FundsGeneralSetup: Record "Funds General Setup";
        Employee: Record Employee;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
        ApprovalsMgmtMain: Codeunit "Approvals Mgmt.";
        FundsApprovalManager: Codeunit "Funds Approval Manager";
        ImprestHeader2: Record "Imprest Header";
        ApprovalEntry: Record "Approval Entry";
        FundsTransactionCode: Record "Funds Transaction Code";
        AllowanceHeader: Record "Allowance Header";
        AllowanceLine: Record "Allowance Line";
        FundManagement: Codeunit "Funds Management";

    [Scope('Personalization')]
    procedure GetImprestList(var ImprestsExportandImport: XMLport "Imprests Export and Import"; EmployeeNo: Code[20])
    begin
        if EmployeeNo <> '' then begin
            ImprestHeader2.Reset;
            ImprestHeader2.SetFilter("Employee No.", EmployeeNo);
            if ImprestHeader2.FindFirst then;
            ImprestsExportandImport.SetTableView(ImprestHeader2);
        end
    end;

    [Scope('Personalization')]
    procedure GetImprestHeaderLines(var ImprestsExportandImport: XMLport "Imprests Export and Import"; HeaderNo: Code[20])
    begin
        if HeaderNo <> '' then begin
            ImprestHeader2.Reset;
            ImprestHeader2.SetFilter("No.", HeaderNo);
            if ImprestHeader2.FindFirst then;
            ImprestsExportandImport.SetTableView(ImprestHeader2);
        end
    end;

    [Scope('Personalization')]
    procedure GetImprestListStatus(var ImprestsExportandImport: XMLport "Imprests Export and Import"; EmployeeNo: Code[20]; ImpStatus: Option Open,"Pending Approval",Approved,Rejected,Posted,Reversed)
    begin
        ImprestHeader2.Reset;
        ImprestHeader2.SetRange(Status, ImpStatus);
        if EmployeeNo <> '' then begin

            ImprestHeader2.SetFilter("Employee No.", EmployeeNo);
            if ImprestHeader2.FindFirst then;
            ImprestsExportandImport.SetTableView(ImprestHeader2);
        end
    end;

    [Scope('Personalization')]
    procedure GetImprestcodes(var ImprestCodes: XMLport "Imprest Codes")
    begin
    end;

    [Scope('Personalization')]
    procedure CreateImprestHeaderAndLines(var ImprestsExportandImport: XMLport "Imprests Export and Import"; EmployeeNo: Code[20])
    begin
    end;

    [Scope('Personalization')]
    procedure GetLocalCurrencyCode() LocalCurrencyCode: Code[10]
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        LocalCurrencyCode := '';
        GeneralLedgerSetup.Reset;
        if GeneralLedgerSetup.Get then
            LocalCurrencyCode := GeneralLedgerSetup."LCY Code";
    end;

    [Scope('Personalization')]
    procedure CheckImprestRequestExists("ImprestNo.": Code[20]; "EmployeeNo.": Code[20]) ImprestRequestExist: Boolean
    begin
        ImprestRequestExist := false;
        ImprestHeader.Reset;
        ImprestHeader.SetRange(ImprestHeader."No.", "ImprestNo.");
        ImprestHeader.SetRange(ImprestHeader."Employee No.", "EmployeeNo.");
        if ImprestHeader.FindFirst then begin
            ImprestRequestExist := true;
        end;
    end;

    [Scope('Personalization')]
    procedure CheckOpenImprestRequestExists("EmployeeNo.": Code[20]) OpenImprestRequestExist: Boolean
    begin
        OpenImprestRequestExist := false;
        ImprestHeader.Reset;
        ImprestHeader.SetRange(ImprestHeader."Employee No.", "EmployeeNo.");
        if ImprestHeader.FindFirst then begin
            if (ImprestHeader.Status = ImprestHeader.Status::Open) or (ImprestHeader.Status = ImprestHeader.Status::"Pending Approval") then
                OpenImprestRequestExist := true;
        end;
    end;

    [Scope('Personalization')]
    procedure CheckImprestNotSurrendered("EmployeeNo.": Code[20]) ImprestNotSurrendered: Boolean
    var
        Text001: Label 'You are not able make this request. You are required to surrender your previous imprest before making a new request.';
    begin
        ImprestNotSurrendered := false;
        ImprestHeader.Reset;
        ImprestHeader.SetRange(ImprestHeader."Employee No.", "EmployeeNo.");
        if ImprestHeader.FindFirst then begin
            if ImprestHeader."Surrender status" = ImprestHeader."Surrender status"::"Not Surrendered" then
                Error(Text001);
            ImprestNotSurrendered := true;
        end;
    end;

    [Scope('Personalization')]
    procedure CheckImprestPartiallySurrendered("EmployeeNo.": Code[20]) ImprestPartiallySurrendered: Boolean
    var
        Text001: Label 'You are not able make this request. You have surrendered your imprest partially. Ensure you submit your imprest fully before requesting for a new one.';
    begin
        ImprestPartiallySurrendered := false;
        ImprestHeader.Reset;
        ImprestHeader.SetRange(ImprestHeader."Employee No.", "EmployeeNo.");
        if ImprestHeader.FindFirst then begin
            if ImprestHeader."Surrender status" = ImprestHeader."Surrender status"::"Partially Surrendered" then
                Error(Text001);
            ImprestPartiallySurrendered := true;
        end;
    end;

    [Scope('Personalization')]
    procedure CreateImprestHeader("Employee No.": Code[20]; DateFrom: Date; DateTo: Date; Description: Text[250]; Type: Option " ",Imprest,"Petty Cash","Casual Payment"; Department: Code[20]; ProjectNo: Code[20]) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
        ImprestType: Option " ",Imprest,"Petty Cash";
    begin

        //Check imprest not surrendered
        //CheckImprestNotSurrendered("Employee No.");

        //Check imprest partially surrendered
        //CheckImprestPartiallySurrendered("Employee No.");
        ReturnValue := '';

        Employee.Reset;
        Employee.Get("Employee No.");

        FundsGeneralSetup.Reset;
        FundsGeneralSetup.Get;


        //ADDED ON 06/02/2020
        "DocNo." := NoSeriesMgt.GetNextNo(FundsGeneralSetup."Imprest Nos.", 0D, true);

        if Type = Type::Imprest then begin
            "DocNo." := NoSeriesMgt.GetNextNo(FundsGeneralSetup."Imprest Nos.", 0D, true);
            ImprestHeader.CheckImprestNotSurrendered("Employee No.");
        end else
            if Type = Type::"Petty Cash" then begin
                "DocNo." := NoSeriesMgt.GetNextNo(FundsGeneralSetup."Petty Cash Nos", 0D, true);
            end else
                if Type = Type::"Casual Payment" then begin
                    "DocNo." := NoSeriesMgt.GetNextNo(FundsGeneralSetup."Casual Payment Nos", 0D, true);
                end;
        ;

        //
        if "DocNo." <> '' then begin

            ImprestHeader.Init;
            ImprestHeader."No." := "DocNo.";
            ImprestHeader.Type := Type;

            ImprestHeader."Document Type" := ImprestHeader."Document Type"::Imprest;
            ImprestHeader."Employee No." := "Employee No.";
            ImprestHeader.Validate(ImprestHeader."Employee No.");
            ImprestHeader."User ID" := Employee."User ID";
            ImprestHeader."Document Date" := Today;
            ImprestHeader."Posting Date" := Today;

            if Type = Type::"Casual Payment" then begin
                ImprestHeader."Document Type" := ImprestHeader."Document Type"::"Casuals Payment";
                ImprestHeader.Type := ImprestHeader.Type::"Casuals Payment";
            end;
            ImprestHeader."Date From" := DateFrom;
            ImprestHeader."Date To" := DateTo;
            ImprestHeader.Description := Description;
            ImprestHeader."Project No" := ProjectNo;
            ImprestHeader.Validate("Project No");
            if Department = 'NONE' then
                ImprestHeader."Approving Department" := ImprestHeader."Approving Department"::" "
            else if Department = 'MANAGING DIRECTOR' then
                ImprestHeader."Approving Department" := ImprestHeader."Approving Department"::"Managing Director"
            else if Department = 'COMMERCIAL' then
                ImprestHeader."Approving Department" := ImprestHeader."Approving Department"::Commercial;

            HREmployee.Reset;
            HREmployee.SetRange("No.", "Employee No.");
            if HREmployee.FindFirst then begin
                ImprestHeader."Global Dimension 1 Code" := HREmployee."Global Dimension 1 Code";
                ImprestHeader.Validate(ImprestHeader."Global Dimension 1 Code");
                ImprestHeader."Global Dimension 2 Code" :=/*Department;"*/HREmployee."Global Dimension 2 Code";
                ImprestHeader."Shortcut Dimension 3 Code" := HREmployee."Shortcut Dimension 3 Code";
                ImprestHeader."Shortcut Dimension 4 Code" := HREmployee."Shortcut Dimension 4 Code";
                ImprestHeader."Shortcut Dimension 5 Code" := HREmployee."Shortcut Dimension 5 Code";
            end;

            /*ImprestHeader."Project No" := ProjectNo;
            ImprestHeader.VALIDATE("Project No");*/
            if ImprestHeader.Insert then begin
                ReturnValue := '200: Imprest No ' + "DocNo." + ' Successfully Created';
            end
            else
                ReturnValue := '4000:' + GetLastErrorCode + '-' + GetLastErrorText;
        end
        else
            ReturnValue := '400: Doc No is empty';// +GETLASTERRORCODE+'-'+GETLASTERRORTEXT;

    end;

    [Scope('Personalization')]
    procedure ModifyImprestHeader("ImprestNo.": Code[20]; "Employee No.": Code[20]; DateFrom: Date; DateTo: Date; Description: Text[250]; DocumentName: Text; Department: Code[20]; ProjectNo: Code[20]) ImprestHeaderModified: Boolean
    var
        HREmployee: Record Employee;
        ImprestType: Option " ",Imprest,"Petty Cash";
    begin
        ImprestHeaderModified := false;
        ImprestHeader.Reset;
        ImprestHeader.SetRange(ImprestHeader."No.", "ImprestNo.");
        if ImprestHeader.FindFirst then begin
            ImprestHeader."Posting Date" := Today;
            ImprestHeader."Document Type" := ImprestHeader."Document Type"::Imprest;
            ImprestHeader."Date From" := DateFrom;
            ImprestHeader."Date To" := DateTo;
            ImprestHeader.Description := Description;
            ImprestHeader."Document Name" := DocumentName;
            ImprestHeader.Validate("Project No", ProjectNo);
            HREmployee.Reset;
            HREmployee.SetRange("No.", "Employee No.");
            if HREmployee.FindFirst then begin
                ImprestHeader."Global Dimension 1 Code" := HREmployee."Global Dimension 1 Code";
                ImprestHeader.Validate(ImprestHeader."Global Dimension 1 Code");
                ImprestHeader.Validate("Global Dimension 2 Code", HREmployee."Global Dimension 2 Code");
            end;

            if ImprestHeader.Modify then
                ImprestHeaderModified := true;
        end;
    end;

    [Scope('Personalization')]
    procedure GetImprestAmount("ImprestNo.": Code[20]) ImprestAmount: Decimal
    begin
        ImprestAmount := 0;

        ImprestHeader.Reset;
        if ImprestHeader.Get("ImprestNo.") then begin
            ImprestHeader.CalcFields(Amount);
            ImprestAmount := ImprestHeader.Amount;
        end;
    end;

    [Scope('Personalization')]
    procedure GetImprestLineAmount(EmployeeNo: Code[20]; Imprestcode: Code[20]) ImprestAmount: Decimal
    var
        AllowanceMatrix: Record "Allowance Matrix";
        Employee: Record Employee;
    begin
        ImprestAmount := 0;
        Employee.Get(EmployeeNo);
        Employee.TestField("Salary Scale");
        AllowanceMatrix.Reset;
        AllowanceMatrix.SetRange(AllowanceMatrix."Allowance Code", Imprestcode);
        AllowanceMatrix.SetRange("Job Group", Employee."Salary Scale");
        if AllowanceMatrix.FindFirst then begin
            ImprestAmount := AllowanceMatrix.Amount;

        end;
    end;

    [Scope('Personalization')]
    procedure GetImprestStatus("ImprestNo.": Code[20]) ImprestStatus: Text
    begin
        ImprestStatus := '';

        ImprestHeader.Reset;
        if ImprestHeader.Get("ImprestNo.") then begin
            ImprestStatus := Format(ImprestHeader.Status);
        end;

        //GetImprestGlobalDimension1Code
        /*GlobalDimension1Code:='';
        
        ImprestHeader.RESET;
        IF ImprestHeader.GET("ImprestNo.") THEN BEGIN
          GlobalDimension1Code:=ImprestHeader."Global Dimension 1 Code";
        END;*/

    end;

    [Scope('Personalization')]
    procedure CreateImprestLine("ImprestNo.": Code[20]; ImprestCode: Code[50]; Description: Text; Amount: Decimal; Quantity: Decimal; BankName: Text; BankBranch: Text; BankAccNo: Code[20]) ImprestLineCreated: Text
    var
        HREmployee: Record Employee;
    begin
        ImprestLineCreated := '';

        ImprestHeader.Reset;
        ImprestHeader.Get("ImprestNo.");

        ImprestLine.Init;
        ImprestLine."Line No." := 0;
        ImprestLine."Document No." := "ImprestNo.";
        ImprestLine."Imprest Code" := ImprestCode;
        ImprestLine.Validate(ImprestLine."Imprest Code");
        ImprestLine.Quantity := Quantity;
        ImprestLine."Unit Amount" := Amount;
        ImprestLine.Description := Description;
        ImprestLine."Gross Amount" := Amount * ImprestLine.Quantity;
        ImprestLine.Validate(ImprestLine."Gross Amount");
        ImprestLine."Bank Name" := BankName;
        ImprestLine."Bank Branch" := BankBranch;
        ImprestLine."Bank A/C No." := BankAccNo;
        /*ImprestLine."Global Dimension 1 Code":=GlobalDimension1Code;
        ImprestLine."Global Dimension 2 Code":=GlobalDimension2Code;
        ImprestLine."Shortcut Dimension 3 Code":=ShortcutDimension3Code;
        ImprestLine."Shortcut Dimension 4 Code":=ShortcutDimension4Code;
        ImprestLine."Shortcut Dimension 5 Code":=ShortcutDimension5Code;
        ImprestLine."Shortcut Dimension 6 Code":=ShortcutDimension6Code;
        ImprestLine."Shortcut Dimension 7 Code":=ShortcutDimension7Code;
        ImprestLine."Shortcut Dimension 8 Code":=ShortcutDimension8Code;*/

        if ImprestLine.Insert then begin
            ImprestLineCreated := '200: Imprest Line Successfully Created';
        end else
            ImprestLineCreated := GetLastErrorCode + '-' + GetLastErrorText;

    end;

    [Scope('Personalization')]
    procedure ModifyImprestLine("LineNo.": Integer; "ImprestNo.": Code[20]; ImprestCode: Code[50]; Description: Text; Amount: Decimal; Quantity: Decimal; BankName: Text; BankBranch: Text; BankAccNo: Code[20]) ImprestLineModified: Boolean
    begin
        ImprestLineModified := false;

        ImprestLine.Reset;
        ImprestLine.SetRange(ImprestLine."Line No.", "LineNo.");
        ImprestLine.SetRange(ImprestLine."Document No.", "ImprestNo.");
        if ImprestLine.FindFirst then begin
            ImprestLine."Imprest Code" := ImprestCode;
            ImprestLine.Validate(ImprestLine."Imprest Code");
            ImprestLine.Description := Description;
            ImprestLine.Quantity := Quantity;
            ImprestLine."Unit Amount" := Amount;
            //Bank Details
            ImprestLine."Bank Name" := BankName;
            ImprestLine."Bank Branch" := BankBranch;
            ImprestLine."Bank A/C No." := BankAccNo;

            ImprestLine."Gross Amount" := Amount * Quantity;
            ImprestLine.Validate(ImprestLine."Gross Amount");

            ImprestHeader.Reset;
            ImprestHeader.SetRange(ImprestHeader."No.", "ImprestNo.");
            if ImprestHeader.FindFirst then begin
                ImprestLine."Global Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
                ImprestLine."Global Dimension 2 Code" := ImprestHeader."Global Dimension 2 Code";
                ImprestLine."Shortcut Dimension 3 Code" := ImprestHeader."Shortcut Dimension 3 Code";
            end;
            if ImprestLine.Modify then begin
                ImprestLineModified := true;
            end;
        end;
    end;

    [Scope('Personalization')]
    procedure DeleteImprestLine("LineNo.": Integer; "ImprestNo.": Code[20]) ImprestLineDeleted: Boolean
    begin
        ImprestLineDeleted := false;

        ImprestLine.Reset;
        ImprestLine.SetRange(ImprestLine."Line No.", "LineNo.");
        ImprestLine.SetRange(ImprestLine."Document No.", "ImprestNo.");
        if ImprestLine.FindFirst then begin
            if ImprestLine.Delete then begin
                ImprestLineDeleted := true;
            end;
        end;
    end;

    procedure CheckImprestLinesExist("ImprestNo.": Code[20]) ImprestLinesExist: Boolean
    begin
        ImprestLinesExist := false;

        ImprestLine.Reset;
        ImprestLine.SetRange(ImprestLine."Document No.", "ImprestNo.");
        if ImprestLine.FindFirst then begin
            ImprestLinesExist := true;
        end;
    end;

    procedure ValidateImprestLines("ImprestNo.": Code[20]) ImprestLinesError: Text
    var
        "ImprestLineNo.": Integer;
    begin
        ImprestLinesError := '';
        "ImprestLineNo." := 0;

        ImprestLine.Reset;
        ImprestLine.SetRange(ImprestLine."Document No.", "ImprestNo.");
        if ImprestLine.FindSet then begin
            repeat
                "ImprestLineNo." := "ImprestLineNo." + 1;
                if ImprestLine."Imprest Code" = '' then begin
                    ImprestLinesError := 'Imprest code missing on imprest line no.' + Format("ImprestLineNo.") + ', it cannot be zero or empty';
                    break;
                end;
            /*IF ImprestLine."Global Dimension 1 Code"='' THEN BEGIN
              ImprestLinesError:='Project code missing on imprest line no.'+FORMAT("ImprestLineNo.")+', it cannot be zero or empty';
              BREAK;
            END;*/

            until ImprestLine.Next = 0;
        end;

    end;

    procedure CheckImprestApprovalWorkflowEnabled("ImprestNo.": Code[20]) ApprovalWorkflowEnabled: Boolean
    begin
        ApprovalWorkflowEnabled := false;

        ImprestHeader.Reset;
        if ImprestHeader.Get("ImprestNo.") then
            ApprovalWorkflowEnabled := ApprovalsMgmt.CheckImprestApprovalsWorkflowEnabled(ImprestHeader);
    end;

    [Scope('Personalization')]
    procedure SendImprestApprovalRequest("ImprestNo.": Code[20]) ImprestApprovalRequestSent: Text
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ImprestApprovalRequestSent := '';

        ImprestHeader.Reset;
        if ImprestHeader.Get("ImprestNo.") then begin
            //FundManagement.CheckGLBudget(ImprestHeader);
            ApprovalsMgmt.OnSendImprestHeaderForApproval(ImprestHeader);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", ImprestHeader."No.");
            ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            if ApprovalEntry.FindFirst then
                ImprestApprovalRequestSent := '200: Imprest Approval Request sent Successfully '
            else
                ImprestApprovalRequestSent := '400:' + GetLastErrorCode + '-' + GetLastErrorText;

        end;
    end;

    [Scope('Personalization')]
    procedure CancelImprestApprovalRequest("ImprestNo.": Code[20]) ImprestApprovalRequestCanceled: Text
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ImprestApprovalRequestCanceled := '';

        ImprestHeader.Reset;
        if ImprestHeader.Get("ImprestNo.") then begin
            ApprovalsMgmt.OnCancelImprestHeaderApprovalRequest(ImprestHeader);
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", ImprestHeader."No.");
            if ApprovalEntry.FindLast then begin
                if ApprovalEntry.Status = ApprovalEntry.Status::Canceled then
                    ImprestApprovalRequestCanceled := '200: Imprest Cancelled Request sent Successfully '
                else
                    ImprestApprovalRequestCanceled := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
            end;
        end;
    end;

    procedure ReopenImprestRequest("ImprestNo.": Code[20]) ImprestRequestOpened: Boolean
    begin
        ImprestRequestOpened := false;
        ImprestHeader.Reset;
        ImprestHeader.SetRange(ImprestHeader."No.", "ImprestNo.");
        if ImprestHeader.FindFirst then begin
            FundsApprovalManager.ReOpenImprestHeader(ImprestHeader);
            ImprestRequestOpened := true;
        end;
    end;

    procedure CancelImprestBudgetCommitment("ImprestNo.": Code[20]) ImprestBudgetCommitmentCanceled: Boolean
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ImprestBudgetCommitmentCanceled := false;

        ImprestHeader.Reset;
        if ImprestHeader.Get("ImprestNo.") then begin
            ImprestBudgetCommitmentCanceled := true;
        end;
    end;

    [Scope('Personalization')]
    procedure GetEmployeeImprestBalance("EmployeeNo.": Code[20]) EmployeeImprestBalance: Decimal
    begin
        EmployeeImprestBalance := 0;

        Employee.Reset;
        if Employee.Get("EmployeeNo.") then begin
            Employee.CalcFields(Employee.Balance);
            EmployeeImprestBalance := Employee.Balance;
        end;
    end;

    [Scope('Personalization')]
    procedure CheckImprestSurrenderExists("ImprestSurrenderNo.": Code[20]; "EmployeeNo.": Code[20]) ImprestSurrenderExist: Boolean
    begin
        ImprestSurrenderExist := false;
        ImprestSurrenderHeader.Reset;
        ImprestSurrenderHeader.SetRange(ImprestSurrenderHeader."No.", "ImprestSurrenderNo.");
        ImprestSurrenderHeader.SetRange(ImprestSurrenderHeader."Employee No.", "EmployeeNo.");
        if ImprestSurrenderHeader.FindFirst then begin
            ImprestSurrenderExist := true;
        end;
    end;

    [Scope('Personalization')]
    procedure CheckOpenImprestSurrenderExists("EmployeeNo.": Code[20]) OpenImprestSurrenderExist: Boolean
    begin
        OpenImprestSurrenderExist := false;
        ImprestSurrenderHeader.Reset;
        ImprestSurrenderHeader.SetRange(ImprestSurrenderHeader."Employee No.", "EmployeeNo.");
        ImprestSurrenderHeader.SetRange(ImprestSurrenderHeader.Status, ImprestSurrenderHeader.Status::Open);
        if ImprestSurrenderHeader.FindFirst then begin
            OpenImprestSurrenderExist := true;
        end;
    end;

    [Scope('Personalization')]
    procedure GetImprestSurrenderList(var ImprestsSurrExportImport: XMLport "Imprests Surr Export & Import"; EmployeeNo: Code[20])
    var
        ImprestSurrHeader: Record "Imprest Surrender Header";
    begin
        if EmployeeNo <> '' then begin
            ImprestSurrHeader.Reset;
            ImprestSurrHeader.SetFilter("Employee No.", EmployeeNo);
            if ImprestSurrHeader.FindFirst then;
            ImprestsSurrExportImport.SetTableView(ImprestSurrHeader);
        end
    end;

    [Scope('Personalization')]
    procedure GetImprestSurrenderHeaderLines(var ImprestsSurrExportImport: XMLport "Imprests Surr Export & Import"; HeaderNo: Code[20])
    var
        ImprestSurrHeader: Record "Imprest Surrender Header";
    begin
        if HeaderNo <> '' then begin
            ImprestSurrHeader.Reset;
            ImprestSurrHeader.SetFilter("No.", HeaderNo);
            if ImprestSurrHeader.FindFirst then;
            ImprestsSurrExportImport.SetTableView(ImprestSurrHeader);
        end
    end;

    [Scope('Personalization')]
    procedure CreateImprestSurrenderHeader("EmployeeNo.": Code[20]; "ImprestNo.": Code[20]; Description: Text[100]; DocumentType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Surrender","Petty Cash Surrender") ReturnValue: Text
    var
        "DocNo.": Code[20];
        ImprestSurrenderHeader2: Record "Imprest Surrender Header";
        ImprestSurrenderDocuments: Record "Imprest Surrender Documents";
    begin
        ReturnValue := '';
        Employee.Reset;
        Employee.Get("EmployeeNo.");

        FundsGeneralSetup.Reset;
        FundsGeneralSetup.Get;

        //added on 10/02/2020
        if DocumentType = DocumentType::"Imprest Surrender" then begin
            "DocNo." := NoSeriesMgt.GetNextNo(FundsGeneralSetup."Imprest Surrender Nos.", 0D, true);
        end else
            if DocumentType = DocumentType::"Petty Cash Surrender" then begin
                "DocNo." := NoSeriesMgt.GetNextNo(FundsGeneralSetup."Petty Cash Surrender Nos", 0D, true);
            end;
        //

        if "DocNo." <> '' then begin
            ImprestSurrenderHeader.Reset;
            ImprestSurrenderHeader."No." := "DocNo.";
            ImprestSurrenderHeader."Document Date" := Today;
            ImprestSurrenderHeader."Posting Date" := Today;
            ImprestSurrenderHeader."Document Type" := DocumentType;
            ImprestSurrenderHeader."Employee No." := "EmployeeNo.";
            ImprestSurrenderHeader.Validate(ImprestSurrenderHeader."Employee No.");
            ImprestSurrenderHeader."Imprest No." := "ImprestNo.";
            ImprestSurrenderHeader.Validate(ImprestSurrenderHeader."Imprest No.");
            ImprestSurrenderHeader.Description := Description;
            ImprestSurrenderHeader."User ID" := Employee."User ID";
            if ImprestSurrenderHeader.Insert then begin
                ReturnValue := '200: Imprest Surrender No ' + "DocNo." + ' Successfully Created';
            end
            else
                ReturnValue := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
            /*
          //Insert Imprest Surrender Receipts
            ImprestSurrenderHeader2.RESET;
            ImprestSurrenderHeader2.SETRANGE(ImprestSurrenderHeader2."Employee No.","EmployeeNo.");
            ImprestSurrenderHeader2.SETRANGE(ImprestSurrenderHeader2.Status,ImprestSurrenderHeader2.Status::Open);
              IF ImprestSurrenderHeader2.FINDFIRST THEN BEGIN
        
        
                REPEAT
                  ImprestSurrenderDocuments.INIT;
                  ImprestSurrenderDocuments."DocumentNo.":=ImprestSurrenderHeader."No.";
                  ImprestSurrenderDocuments."Document Code":=UPPERCASE('Imprest Receipt');
                  ImprestSurrenderDocuments."Document Description":=UPPERCASE('Imprest Receipt');
                  ImprestSurrenderDocuments."Document Attached":=FALSE;
                  ImprestSurrenderDocuments.INSERT;
                UNTIL ImprestSurrenderDocuments.NEXT=0;
                KLK
                "ImprestSurrenderDocumentNo.":="DocNo.";
            END;
          END;*/
        end;

    end;

    [Scope('Personalization')]
    procedure ModifyImprestSurrenderHeader("ImprestSurrenderNo.": Code[20]; "EmployeeNo.": Code[20]; "ImprestNo.": Code[20]; Description: Text[100]; DocumentName: Text) ReturnValue: Text
    var
        HREmployee: Record Employee;
    begin
        ReturnValue := '';
        ImprestSurrenderHeader.Reset;
        ImprestSurrenderHeader.SetRange(ImprestSurrenderHeader."No.", "ImprestSurrenderNo.");
        if ImprestSurrenderHeader.FindFirst then begin
            ImprestSurrenderHeader."Imprest No." := "ImprestNo.";
            ImprestSurrenderHeader.Validate(ImprestSurrenderHeader."Imprest No.");
            ImprestSurrenderHeader.Description := Description;
            ImprestSurrenderHeader."Document Name" := DocumentName;
            HREmployee.Reset;
            HREmployee.SetRange("No.", "EmployeeNo.");
            if HREmployee.FindFirst then begin
                ImprestSurrenderHeader."Employee Name" := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
                ImprestSurrenderHeader."Global Dimension 1 Code" := HREmployee."Global Dimension 1 Code";
                ImprestSurrenderHeader.Validate(ImprestSurrenderHeader."Global Dimension 1 Code");
            end;
            if ImprestSurrenderHeader.Modify then begin
                ReturnValue := '200: Imprest Surrender No ' + "ImprestSurrenderNo." + ' Successfully Modified';
            end
            else
                ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;
        end;
    end;

    [Scope('Personalization')]
    procedure GetImprestSurrenderAmount("ImprestSurrenderNo.": Code[20]) ImprestSurrenderAmount: Decimal
    begin
        ImprestSurrenderAmount := 0;

        ImprestSurrenderHeader.Reset;
        if ImprestSurrenderHeader.Get("ImprestSurrenderNo.") then begin
            ImprestSurrenderHeader.CalcFields(Amount);
            ImprestSurrenderAmount := ImprestHeader.Amount;
        end;
    end;

    [Scope('Personalization')]
    procedure GetImprestRemainingAmount("ImprestNo.": Code[20]; ActualSpent: Decimal) Difference: Decimal
    begin
        Difference := 0;
        ImprestHeader.Reset;
        ImprestHeader.SetRange(ImprestHeader."No.", "ImprestNo.");
        ImprestHeader.SetRange(ImprestHeader.Status, ImprestHeader.Status::Posted);
        if ImprestHeader.FindFirst then begin
            ImprestHeader.CalcFields(Amount);
            Difference := (ImprestHeader.Amount) - ActualSpent;
        end;
    end;

    [Scope('Personalization')]
    procedure GetImprestSurrenderStatus("ImprestSurrenderNo.": Code[20]) ImprestSurrenderStatus: Text
    begin
        ImprestSurrenderStatus := '';

        ImprestSurrenderHeader.Reset;
        if ImprestSurrenderHeader.Get("ImprestSurrenderNo.") then begin
            ImprestSurrenderStatus := Format(ImprestSurrenderHeader.Status);
        end;

        //Add GetImprestSurrenderGlobalDimension1Code
        /*GlobalDimension1Code:='';
        
        ImprestSurrenderHeader.RESET;
        IF ImprestSurrenderHeader.GET("ImprestSurrenderNo.") THEN BEGIN
          GlobalDimension1Code:=ImprestSurrenderHeader."Global Dimension 1 Code";
        END;*/

    end;

    [Scope('Personalization')]
    procedure CreateImprestSurrenderLine("ImprestSurrenderNo.": Code[20]; ImprestCode: Code[50]; Description: Text; ActualAmountSpent: Decimal; GlobalDimension1Code: Code[20]; GlobalDimension2Code: Code[20]; ShortcutDimension3Code: Code[20]; ShortcutDimension4Code: Code[20]; ShortcutDimension5Code: Code[20]; ShortcutDimension6Code: Code[20]; ShortcutDimension7Code: Code[20]; ShortcutDimension8Code: Code[20]) ImprestSurrenderLineCreated: Boolean
    begin
        ImprestSurrenderLineCreated := false;

        ImprestSurrenderHeader.Reset;
        ImprestSurrenderHeader.Get("ImprestSurrenderNo.");

        ImprestSurrenderLine.Init;
        ImprestSurrenderLine."Line No." := 0;
        ImprestSurrenderLine."Document No." := "ImprestSurrenderNo.";
        ImprestSurrenderLine."Imprest Code" := ImprestCode;
        ImprestSurrenderLine.Validate(ImprestSurrenderLine."Imprest Code");
        ImprestSurrenderLine.Description := Description;
        ImprestSurrenderLine."Actual Spent" := ActualAmountSpent;
        ImprestSurrenderLine.Validate(ImprestSurrenderLine."Actual Spent");
        ImprestSurrenderLine."Global Dimension 1 Code" := GlobalDimension1Code;
        ImprestSurrenderLine."Global Dimension 2 Code" := GlobalDimension2Code;
        ImprestSurrenderLine."Shortcut Dimension 3 Code" := ShortcutDimension3Code;
        ImprestSurrenderLine."Shortcut Dimension 4 Code" := ShortcutDimension4Code;
        ImprestSurrenderLine."Shortcut Dimension 5 Code" := ShortcutDimension5Code;
        ImprestSurrenderLine."Shortcut Dimension 6 Code" := ShortcutDimension6Code;
        ImprestSurrenderLine."Shortcut Dimension 7 Code" := ShortcutDimension7Code;
        ImprestSurrenderLine."Shortcut Dimension 8 Code" := ShortcutDimension8Code;
        if ImprestSurrenderLine.Insert then begin
            ImprestSurrenderLineCreated := true;
        end;
    end;

    [Scope('Personalization')]
    procedure ModifyImprestSurrenderLine("LineNo.": Integer; "ImprestSurrenderNo.": Code[20]; ImprestCode: Code[50]; Description: Text; ActualAmountSpent: Decimal; GlobalDimension1Code: Code[20]; GlobalDimension2Code: Code[20]; ShortcutDimension3Code: Code[20]; ShortcutDimension4Code: Code[20]; ShortcutDimension5Code: Code[20]; ShortcutDimension6Code: Code[20]; ShortcutDimension7Code: Code[20]; ShortcutDimension8Code: Code[20]) ImprestSurrenderLineModified: Boolean
    begin
        ImprestSurrenderLineModified := false;

        ImprestSurrenderLine.Reset;
        ImprestSurrenderLine.SetRange(ImprestSurrenderLine."Line No.", "LineNo.");
        ImprestSurrenderLine.SetRange(ImprestSurrenderLine."Document No.", "ImprestSurrenderNo.");
        if ImprestSurrenderLine.FindFirst then begin
            ImprestSurrenderLine."Imprest Code" := ImprestCode;
            ImprestSurrenderLine.Validate(ImprestSurrenderLine."Imprest Code");
            ImprestSurrenderLine.Description := Description;
            ImprestSurrenderLine."Actual Spent" := ActualAmountSpent;
            ImprestSurrenderLine.Validate(ImprestSurrenderLine."Actual Spent");
            ImprestSurrenderLine."Global Dimension 2 Code" := GlobalDimension2Code;
            ImprestSurrenderLine."Shortcut Dimension 3 Code" := ShortcutDimension3Code;
            ImprestSurrenderLine."Shortcut Dimension 4 Code" := ShortcutDimension4Code;
            ImprestSurrenderLine."Shortcut Dimension 5 Code" := ShortcutDimension5Code;
            ImprestSurrenderLine."Shortcut Dimension 6 Code" := ShortcutDimension6Code;
            ImprestSurrenderLine."Shortcut Dimension 7 Code" := ShortcutDimension7Code;
            ImprestSurrenderLine."Shortcut Dimension 8 Code" := ShortcutDimension8Code;
            if ImprestSurrenderLine.Modify then begin
                ImprestSurrenderLineModified := true;
            end;
        end;
    end;

    [Scope('Personalization')]
    procedure DeleteImprestSurrenderLine("LineNo.": Integer; "ImprestSurrenderNo.": Code[20]) ImprestSurrenderLineDeleted: Boolean
    begin
        ImprestSurrenderLineDeleted := false;

        ImprestSurrenderLine.Reset;
        ImprestSurrenderLine.SetRange(ImprestSurrenderLine."Line No.", "LineNo.");
        ImprestSurrenderLine.SetRange(ImprestSurrenderLine."Document No.", "ImprestSurrenderNo.");
        if ImprestSurrenderLine.FindFirst then begin
            if ImprestSurrenderLine.Delete then begin
                ImprestSurrenderLineDeleted := true;
            end;
        end;
    end;

    [Scope('Personalization')]
    procedure CheckImprestSurrenderLinesExist("ImprestSurrenderNo.": Code[20]) ImprestSurrenderLinesExist: Boolean
    begin
        ImprestSurrenderLinesExist := false;

        ImprestSurrenderLine.Reset;
        ImprestSurrenderLine.SetRange(ImprestSurrenderLine."Document No.", "ImprestSurrenderNo.");
        if ImprestSurrenderLine.FindFirst then begin
            ImprestSurrenderLinesExist := true;
        end;
    end;

    procedure ValidateImprestSurrenderLines("ImprestSurrenderNo.": Code[20]) ImprestSurrenderLinesError: Text
    var
        "ImprestSurrenderLineNo.": Integer;
    begin
        ImprestSurrenderLinesError := '';
        "ImprestSurrenderLineNo." := 0;

        ImprestSurrenderLine.Reset;
        ImprestSurrenderLine.SetRange(ImprestSurrenderLine."Document No.", "ImprestSurrenderNo.");
        if ImprestSurrenderLine.FindSet then begin
            repeat
                "ImprestSurrenderLineNo." := "ImprestSurrenderLineNo." + 1;
                if ImprestSurrenderLine."Imprest Code" = '' then begin
                    ImprestSurrenderLinesError := 'Imprest code missing on imprest surrender line no.' + Format("ImprestSurrenderLineNo.") + ', it cannot be zero or empty';
                    break;
                end;
            /*IF ImprestLine."Global Dimension 1 Code"='' THEN BEGIN
              ImprestLinesError:='Project code missing on imprest line no.'+FORMAT("ImprestLineNo.")+', it cannot be zero or empty';
              BREAK;
            END;*/

            until ImprestSurrenderLine.Next = 0;
        end;

    end;

    procedure CheckImprestSurrenderApprovalWorkflowEnabled("ImprestSurrenderNo.": Code[20]) ApprovalWorkflowEnabled: Boolean
    begin
        ApprovalWorkflowEnabled := false;

        ImprestSurrenderHeader.Reset;
        if ImprestSurrenderHeader.Get("ImprestSurrenderNo.") then
            ApprovalWorkflowEnabled := ApprovalsMgmt.CheckImprestSurrenderApprovalsWorkflowEnabled(ImprestSurrenderHeader);
    end;

    [Scope('Personalization')]
    procedure SendImprestSurrenderApprovalRequest("ImprestSurrenderNo.": Code[20]) ImprestSurrenderApprovalRequestSent: Boolean
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ImprestSurrenderApprovalRequestSent := false;

        ImprestSurrenderHeader.Reset;
        if ImprestSurrenderHeader.Get("ImprestSurrenderNo.") then begin
            ApprovalsMgmt.OnSendImprestSurrenderHeaderForApproval(ImprestSurrenderHeader);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", ImprestSurrenderHeader."No.");
            ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            if ApprovalEntry.FindFirst then
                ImprestSurrenderApprovalRequestSent := true;
        end;
    end;

    [Scope('Personalization')]
    procedure CancelImprestSurrenderApprovalRequest("ImprestSurrenderNo.": Code[20]) ImprestSurrenderApprovalRequestCanceled: Boolean
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ImprestSurrenderApprovalRequestCanceled := false;

        ImprestSurrenderHeader.Reset;
        if ImprestSurrenderHeader.Get("ImprestSurrenderNo.") then begin
            ApprovalsMgmt.OnCancelImprestSurrenderHeaderApprovalRequest(ImprestSurrenderHeader);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", ImprestSurrenderHeader."No.");
            if ApprovalEntry.FindLast then begin
                if ApprovalEntry.Status = ApprovalEntry.Status::Canceled then
                    ImprestSurrenderApprovalRequestCanceled := true;
            end;
        end;
    end;

    procedure ReopenImprestSurrender("ImprestSurrenderNo.": Code[20]) ImprestSurrenderOpened: Boolean
    begin
        ImprestSurrenderOpened := false;
        ImprestSurrenderHeader.Reset;
        ImprestSurrenderHeader.SetRange(ImprestSurrenderHeader."No.", "ImprestSurrenderNo.");
        if ImprestSurrenderHeader.FindFirst then begin
            FundsApprovalManager.ReOpenImprestSurrenderHeader(ImprestSurrenderHeader);
            ImprestSurrenderOpened := true;
        end;
    end;

    procedure CancelImprestSurrenderBudgetCommitment("ImprestSurrenderNo.": Code[20]) ImprestSurrenderBudgetCommitmentCanceled: Boolean
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ImprestSurrenderBudgetCommitmentCanceled := false;

        ImprestSurrenderHeader.Reset;
        if ImprestSurrenderHeader.Get("ImprestSurrenderNo.") then begin
            ImprestSurrenderBudgetCommitmentCanceled := true;
        end;
    end;

    procedure ModifyImprestSurrenderUploadedDocumentLocalURL("DocumentNo.": Code[20]; DocumentCode: Code[50]; LocalURL: Text[250]) RequiredDocumentModified: Boolean
    var
        ImprestSurrenderDocuments: Record "Imprest Surrender Documents";
    begin
        RequiredDocumentModified := false;
        ImprestSurrenderDocuments.Reset;
        ImprestSurrenderDocuments.SetRange(ImprestSurrenderDocuments."DocumentNo.", "DocumentNo.");
        ImprestSurrenderDocuments.SetRange(ImprestSurrenderDocuments."Document Code", DocumentCode);
        if ImprestSurrenderDocuments.FindFirst then begin
            ImprestSurrenderDocuments."Local File URL" := LocalURL;
            ImprestSurrenderDocuments."Document Attached" := true;
            if ImprestSurrenderDocuments.Modify then
                RequiredDocumentModified := true;
        end;
    end;

    procedure CheckImprestSurrenderUploadedDocumentAttached("DocumentNo.": Code[20]) UploadedDocumentAttached: Boolean
    var
        ImprestSurrenderDocuments: Record "Imprest Surrender Documents";
        Error0001: Label '%1 must be attached.';
    begin
        UploadedDocumentAttached := false;
        ImprestSurrenderDocuments.Reset;
        ImprestSurrenderDocuments.SetRange(ImprestSurrenderDocuments."DocumentNo.", "DocumentNo.");
        if ImprestSurrenderDocuments.FindSet then begin
            repeat
                if ImprestSurrenderDocuments."Local File URL" = '' then
                    Error(Error0001, ImprestSurrenderDocuments."Document Description");
            until ImprestSurrenderDocuments.Next = 0;
            UploadedDocumentAttached := true;
        end;
    end;

    procedure DeleteImprestSurrenderUploadedDocument("DocumentNo.": Code[20]) RequiredDocumentsDeleted: Boolean
    var
        ImprestSurrenderDocuments: Record "Imprest Surrender Documents";
    begin
        RequiredDocumentsDeleted := false;
        ImprestSurrenderDocuments.Reset;
        ImprestSurrenderDocuments.SetRange(ImprestSurrenderDocuments."DocumentNo.", "DocumentNo.");
        if ImprestSurrenderDocuments.FindSet then begin
            ImprestSurrenderDocuments.DeleteAll;
            RequiredDocumentsDeleted := true;
        end;
    end;

    [Scope('Personalization')]
    procedure ApproveImprestApplication("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]) Approved: Text
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
            Approved := '200: Imprest Approved Successfully '
        else
            Approved := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure RejectImprestApplication("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]; RejectionComments: Text) Rejected: Text
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
            Rejected := '200: Imprest Rejected Successfully '
        else
            Rejected := '400:' + GetLastErrorCode + '-' + GetLastErrorText;


        //**************************************** HR Leave Reimbursement ********************************************************************************************************************************************************
    end;

    [Scope('Personalization')]
    procedure GetEmployeeImprestApprovalEntries(var ApprovalEntries: XMLport "Approval Entries"; EmployeeNo: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        Employee: Record Employee;
    begin
        ApprovalEntry.Reset;
        //  ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::Imprest);
        if EmployeeNo <> '' then begin
            Employee.Get(EmployeeNo);
            Employee.TestField("User ID");
            ApprovalEntry.SetRange("Approver ID", Employee."User ID");
        end;
        if ApprovalEntry.FindFirst then;
        ApprovalEntries.SetTableView(ApprovalEntry);
    end;

    [Scope('Personalization')]
    procedure GetImprestApprovalEntries(var ApprovalEntries: XMLport "Approval Entries"; LeaveNo: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        Employee: Record Employee;
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SETRANGE("Document Type", ApprovalEntry."Document Type"::Imprest);
        if LeaveNo <> '' then begin
            ApprovalEntry.SetRange("Document No.", LeaveNo);
        end;
        if ApprovalEntry.FindFirst then;
        ApprovalEntries.SetTableView(ApprovalEntry);
    end;

    [Scope('Personalization')]
    procedure ApproveImprestSurrApplication("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]) Approved: Text
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
            Approved := '200: Imprest Surrender Approved Successfully '
        else
            Approved := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure RejectImprestSurrApplication("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]; RejectionComments: Text) Rejected: Text
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
            ApprovalEntry."Rejection Comments" := RejectionComments;
            ApprovalEntry."Web Portal Approval" := true;
            ApprovalEntry.Modify;

            ApprovalsMgmtMain.RejectApprovalRequests(ApprovalEntry);
        end;
        Commit;

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Entry No.", "EntryNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Rejected);
        if ApprovalEntry.FindFirst then
            Rejected := '200: Imprest Surrender Rejected Successfully '
        else
            Rejected := '400:' + GetLastErrorCode + '-' + GetLastErrorText;


        //**************************************** HR Leave Reimbursement ********************************************************************************************************************************************************
    end;

    [Scope('Personalization')]
    procedure GetEmployeeImprestSurrApprovalEntries(var ApprovalEntries: XMLport "Approval Entries"; EmployeeNo: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        Employee: Record Employee;
    begin
        ApprovalEntry.Reset;
        // ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::"Imprest Surrender");
        if EmployeeNo <> '' then begin
            Employee.Get(EmployeeNo);
            Employee.TestField("User ID");
            ApprovalEntry.SetRange("Approver ID", Employee."User ID");
        end;
        if ApprovalEntry.FindFirst then;
        ApprovalEntries.SetTableView(ApprovalEntry);
    end;

    [Scope('Personalization')]
    procedure GetImprestSurrApprovalEntries(var ApprovalEntries: XMLport "Approval Entries"; LeaveNo: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        Employee: Record Employee;
    begin
        ApprovalEntry.Reset;
        //  ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::"Imprest Surrender");
        if LeaveNo <> '' then begin
            ApprovalEntry.SetRange("Document No.", LeaveNo);
        end;
        if ApprovalEntry.FindFirst then;
        ApprovalEntries.SetTableView(ApprovalEntry);
    end;

    [Scope('Personalization')]
    procedure PrintImprest(ImprestNo: Code[20]) ServerPath: Text
    var
        ImprestVoucher: Report "Imprest Voucher";
        Filename: Text;
        PortalSetup: Record "Portal Setup";
        Filepath: Text;
        ImprestHeader: Record "Imprest Header";
    begin
        PortalSetup.Reset;
        PortalSetup.Get;
        PortalSetup.TestField("Server File Path");
        PortalSetup.TestField("Local File Path");
        Filename := ImprestNo + '_' + 'ImprestApplication.pdf';
        Filepath := PortalSetup."Local File Path" + Filename;
        //   if FILE.Exists(Filepath) then
        //   FILE.Erase(Filepath);

        ImprestHeader.Reset;
        ImprestHeader.SetRange("No.", ImprestNo);
        ImprestVoucher.SetTableView(ImprestHeader);
        // ImprestVoucher.SaveAsPdf(Filepath);
        // if FILE.Exists(Filepath) then
        //     ServerPath := PortalSetup."Server File Path" + Filename
        // else
        //     Error('There was an Error. Please Try again');
    end;

    [Scope('Personalization')]
    procedure PrintPettyCash(ImprestNo: Code[20]) ServerPath: Text
    var
        ImprestVoucher: Report "Petty Cash Voucher 1";
        Filename: Text;
        PortalSetup: Record "Portal Setup";
        Filepath: Text;
        ImprestHeader: Record "Imprest Header";
    begin
        PortalSetup.Reset;
        PortalSetup.Get;
        PortalSetup.TestField("Server File Path");
        PortalSetup.TestField("Local File Path");
        Filename := ImprestNo + '_' + 'PettyCashApplication.pdf';
        Filepath := PortalSetup."Local File Path" + Filename;
        // if FILE.Exists(Filepath) then
        //     FILE.Erase(Filepath);

        ImprestHeader.Reset;
        ImprestHeader.SetRange("No.", ImprestNo);
        ImprestVoucher.SetTableView(ImprestHeader);
        // ImprestVoucher.SaveAsPdf(Filepath);
        // if FILE.Exists(Filepath) then
        //     ServerPath := PortalSetup."Server File Path" + Filename
        // else
        //     Error('There was an Error. Please Try again');
    end;

    [Scope('Personalization')]
    procedure GetGlobalDimension1Codes(var DepartmentCodes: XMLport "Department Codes")
    begin
    end;

    [Scope('Personalization')]
    procedure CreateImprestLineII("ImprestNo.": Code[20]; ImprestCode: Code[50]; Description: Text; Amount: Decimal; Quantity: Decimal; BankName: Text; BankBranch: Text; BankAccNo: Code[20]; ActivityDate: Date) ImprestLineCreated: Text
    var
        HREmployee: Record Employee;
    begin
        ImprestLineCreated := '';

        ImprestHeader.Reset;
        ImprestHeader.Get("ImprestNo.");

        ImprestLine.Init;
        ImprestLine."Line No." := 0;
        ImprestLine."Document No." := "ImprestNo.";
        ImprestLine."Imprest Code" := ImprestCode;
        ImprestLine.Validate(ImprestLine."Imprest Code");
        ImprestLine.Quantity := Quantity;
        ImprestLine."Unit Amount" := Amount;
        ImprestLine.Description := Description;
        ImprestLine."Gross Amount" := Amount * ImprestLine.Quantity;
        ImprestLine.Validate(ImprestLine."Gross Amount");
        ImprestLine."Bank Name" := BankName;
        ImprestLine."Bank Branch" := BankBranch;
        ImprestLine."Bank A/C No." := BankAccNo;
        ImprestLine."Activity Date" := ActivityDate;
        /*ImprestLine."Global Dimension 1 Code":=GlobalDimension1Code;
        ImprestLine."Global Dimension 2 Code":=GlobalDimension2Code;
        ImprestLine."Shortcut Dimension 3 Code":=ShortcutDimension3Code;
        ImprestLine."Shortcut Dimension 4 Code":=ShortcutDimension4Code;
        ImprestLine."Shortcut Dimension 5 Code":=ShortcutDimension5Code;
        ImprestLine."Shortcut Dimension 6 Code":=ShortcutDimension6Code;
        ImprestLine."Shortcut Dimension 7 Code":=ShortcutDimension7Code;
        ImprestLine."Shortcut Dimension 8 Code":=ShortcutDimension8Code;*/

        if ImprestLine.Insert then begin
            ImprestLineCreated := '200: Imprest Line Successfully Created';
        end else
            ImprestLineCreated := GetLastErrorCode + '-' + GetLastErrorText;

    end;

    [Scope('Personalization')]
    procedure CreateImprestHeaderII("Employee No.": Code[20]; DateFrom: Date; DateTo: Date; Description: Text[250]; Type: Option " ",Imprest,"Petty Cash","Casual Payment"; Department: Code[20]; ProjectNo: Code[20]; ImprestTypeII: Integer) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
        ImprestType: Option " ",Imprest,"Petty Cash";
    begin

        //Check imprest not surrendered
        //CheckImprestNotSurrendered("Employee No.");

        //Check imprest partially surrendered
        //CheckImprestPartiallySurrendered("Employee No.");
        ReturnValue := '';

        Employee.Reset;
        Employee.Get("Employee No.");

        FundsGeneralSetup.Reset;
        FundsGeneralSetup.Get;

        //ERROR('Type '+ FORMAT(Type));
        //ADDED ON 06/02/2020
        "DocNo." := NoSeriesMgt.GetNextNo(FundsGeneralSetup."Imprest Nos.", 0D, true);

        if Type = Type::Imprest then begin
            "DocNo." := NoSeriesMgt.GetNextNo(FundsGeneralSetup."Imprest Nos.", 0D, true);
            // ImprestHeader.CheckImprestNotSurrendered(Employee."No.");

        end else
            if Type = Type::"Petty Cash" then begin
                "DocNo." := NoSeriesMgt.GetNextNo(FundsGeneralSetup."Petty Cash Nos", 0D, true);
            end else
                if Type = Type::"Casual Payment" then begin
                    "DocNo." := NoSeriesMgt.GetNextNo(FundsGeneralSetup."Casual Payment Nos", 0D, true);
                end;
        ;
        //
        if "DocNo." <> '' then begin
            ImprestHeader.Init;
            ImprestHeader."No." := "DocNo.";
            ImprestHeader.Type := Type;
            ImprestHeader."Document Type" := ImprestHeader."Document Type"::Imprest;
            ImprestHeader."Employee No." := "Employee No.";
            ImprestHeader.Validate(ImprestHeader."Employee No.");
            ImprestHeader."User ID" := Employee."User ID";
            ImprestHeader."Document Date" := Today;
            ImprestHeader."Posting Date" := Today;

            if Department = 'NONE' then
                ImprestHeader."Approving Department" := ImprestHeader."Approving Department"::" "
            else if Department = 'MANAGING DIRECTOR' then
                ImprestHeader."Approving Department" := ImprestHeader."Approving Department"::"Managing Director"
            else if Department = 'COMMERCIAL' then
                ImprestHeader."Approving Department" := ImprestHeader."Approving Department"::Commercial;

            if Type = Type::"Casual Payment" then begin
                ImprestHeader."Document Type" := ImprestHeader."Document Type"::"Casuals Payment";
                ImprestHeader.Type := ImprestHeader.Type::"Casuals Payment";
            end;
            ImprestHeader."Date From" := DateFrom;
            ImprestHeader."Date To" := DateTo;
            ImprestHeader.Description := Description;
            ImprestHeader."Project No" := ProjectNo;
            ImprestHeader.Validate("Project No");

            HREmployee.Reset;
            HREmployee.SetRange("No.", "Employee No.");
            if HREmployee.FindFirst then begin
                ImprestHeader."Global Dimension 1 Code" := HREmployee."Global Dimension 1 Code";
                ImprestHeader.Validate(ImprestHeader."Global Dimension 1 Code");
                ImprestHeader."Global Dimension 2 Code" :=/*Department;"*/HREmployee."Global Dimension 2 Code";
                ImprestHeader."Shortcut Dimension 3 Code" := HREmployee."Shortcut Dimension 3 Code";
                ImprestHeader."Shortcut Dimension 4 Code" := HREmployee."Shortcut Dimension 4 Code";
                ImprestHeader."Shortcut Dimension 5 Code" := HREmployee."Shortcut Dimension 5 Code";
            end;

            /*ImprestHeader."Project No" := ProjectNo;
            ImprestHeader.VALIDATE("Project No");*/
            ImprestHeader."Imprest Type" := ImprestTypeII;
            ImprestHeader.Validate("Imprest Type");

            /* IF (ImprestHeader."Imprest Type" = 0) AND (ImprestHeader."Purchase Requisition No" = '') THEN
                 ERROR ('Kindly create a purchase requision first');*/

            if ImprestHeader.Insert then begin
                ReturnValue := '200: Imprest No ' + "DocNo." + ' Successfully Created';
            end
            else
                ReturnValue := '4000:' + GetLastErrorCode + '-' + GetLastErrorText;
        end
        else
            ReturnValue := '400: Doc No is empty';// +GETLASTERRORCODE+'-'+GETLASTERRORTEXT;

    end;

    [Scope('Personalization')]
    procedure GetImprestcodesII(var ImprestCodes: XMLport "Imprest Codes"; Type: Integer)
    begin
        FundsTransactionCode.Reset;

        //ERROR(FORMAT(Type));
        if Type = 1 then
            FundsTransactionCode.SetRange("Account Type", FundsTransactionCode."Account Type"::"Bank Account");
        if Type = 3 then
            FundsTransactionCode.SetRange("Transaction Type", FundsTransactionCode."Transaction Type"::Allowance);
        if Type = 2 then
            FundsTransactionCode.SetRange("Account Type", FundsTransactionCode."Account Type"::"G/L Account");

        if FundsTransactionCode.FindFirst then;
        ImprestCodes.SetTableView(FundsTransactionCode);
    end;

    [Scope('Personalization')]
    procedure CreateAllowanceHeader("Employee No.": Code[20]; DateFrom: Date; DateTo: Date; Description: Text[250]; Type: Option " ",Imprest,"Petty Cash","Casual Payment"; Department: Code[20]; AttachmentName: Text) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
        ImprestType: Option " ",Imprest,"Petty Cash";
    begin

        ReturnValue := '';

        Employee.Reset;
        Employee.Get("Employee No.");

        FundsGeneralSetup.Reset;
        FundsGeneralSetup.Get;

        "DocNo." := NoSeriesMgt.GetNextNo(FundsGeneralSetup."Allowance Nos", 0D, true);

        /*IF Type = Type::Imprest THEN
        BEGIN
        "DocNo.":=NoSeriesMgt.GetNextNo(FundsGeneralSetup."Imprest Nos.",0D,TRUE);
        
        END ELSE
        IF Type = Type::"Petty Cash" THEN
        BEGIN
        "DocNo.":=NoSeriesMgt.GetNextNo(FundsGeneralSetup."Petty Cash Nos",0D,TRUE);
        END ELSE
        IF Type = Type::"Casual Payment" THEN
        BEGIN
        "DocNo.":=NoSeriesMgt.GetNextNo(FundsGeneralSetup."Casual Payment Nos",0D,TRUE);
        END;;*/
        //
        if "DocNo." <> '' then begin
            AllowanceHeader.Init;
            AllowanceHeader."No." := "DocNo.";
            AllowanceHeader.Type := AllowanceHeader.Type::Allowance;
            AllowanceHeader."Document Type" := AllowanceHeader."Document Type"::Allowance;
            AllowanceHeader."Employee No." := "Employee No.";
            AllowanceHeader.Validate(AllowanceHeader."Employee No.");
            AllowanceHeader."User ID" := Employee."User ID";
            AllowanceHeader."Document Date" := Today;
            AllowanceHeader."Posting Date" := Today;
            AllowanceHeader."Date From" := DateFrom;
            AllowanceHeader."Date To" := DateTo;
            AllowanceHeader.Description := Description;
            AllowanceHeader."Attachment Name" := AttachmentName;
            // AllowanceHeader."Project No" := ProjectNo;
            //AllowanceHeader.VALIDATE("Project No");


            HREmployee.Reset;
            HREmployee.SetRange("No.", "Employee No.");
            if HREmployee.FindFirst then begin
                AllowanceHeader."Global Dimension 1 Code" := HREmployee."Global Dimension 1 Code";
                AllowanceHeader.Validate(AllowanceHeader."Global Dimension 1 Code");
                AllowanceHeader."Global Dimension 2 Code" :=/*Department;"*/HREmployee."Global Dimension 2 Code";
                AllowanceHeader."Shortcut Dimension 3 Code" := HREmployee."Shortcut Dimension 3 Code";
                AllowanceHeader."Shortcut Dimension 4 Code" := HREmployee."Shortcut Dimension 4 Code";
                AllowanceHeader."Shortcut Dimension 5 Code" := HREmployee."Shortcut Dimension 5 Code";
            end;
            if AllowanceHeader.Insert then begin
                ReturnValue := '200: Allowance No ' + "DocNo." + ' Successfully Created';
            end
            else
                ReturnValue := '4000:' + GetLastErrorCode + '-' + GetLastErrorText;
        end
        else
            ReturnValue := '400: Doc No is empty';// +GETLASTERRORCODE+'-'+GETLASTERRORTEXT;

    end;

    [Scope('Personalization')]
    procedure CreateAllowanceLine("ImprestNo.": Code[20]; ImprestCode: Code[50]; Description: Text; Amount: Decimal; Quantity: Decimal; BankName: Text; BankBranch: Text; BankAccNo: Code[20]; ActivityDate: Date) ImprestLineCreated: Text
    var
        HREmployee: Record Employee;
    begin
        ImprestLineCreated := '';

        AllowanceHeader.Reset;
        AllowanceHeader.Get("ImprestNo.");

        AllowanceLine.Init;
        AllowanceLine."Line No." := 0;
        AllowanceLine."Document No." := "ImprestNo.";
        AllowanceLine."Allowance Code" := ImprestCode;
        AllowanceLine.Validate("Employee No", AllowanceHeader."Employee No.");
        AllowanceLine.Validate(AllowanceLine."Allowance Code");
        AllowanceLine.Validate(Quantity, Quantity);
        //AllowanceLine.VALIDATE("Unit Amount",Amount);
        AllowanceLine.Description := Description;
        //AllowanceLine."Gross Amount":=Amount*ImprestLine.Quantity;
        AllowanceLine.Validate(AllowanceLine."Gross Amount");
        /*AllowanceLine."Bank Name":=BankName;
        AllowanceLine."Bank Branch":=BankBranch;
        AllowanceLine."Bank A/C No.":=BankAccNo;
        AllowanceLine."Activity Date" :=ActivityDate;
        ImprestLine."Global Dimension 1 Code":=GlobalDimension1Code;
        ImprestLine."Global Dimension 2 Code":=GlobalDimension2Code;
        ImprestLine."Shortcut Dimension 3 Code":=ShortcutDimension3Code;
        ImprestLine."Shortcut Dimension 4 Code":=ShortcutDimension4Code;
        ImprestLine."Shortcut Dimension 5 Code":=ShortcutDimension5Code;
        ImprestLine."Shortcut Dimension 6 Code":=ShortcutDimension6Code;
        ImprestLine."Shortcut Dimension 7 Code":=ShortcutDimension7Code;
        ImprestLine."Shortcut Dimension 8 Code":=ShortcutDimension8Code;*/

        if AllowanceLine.Insert then begin
            ImprestLineCreated := '200: Imprest Line Successfully Created';
        end else
            ImprestLineCreated := GetLastErrorCode + '-' + GetLastErrorText;

    end;

    [Scope('Personalization')]
    procedure GetAllowanceList(var AllowanceHeaderXml: XMLport "AllowanceHeader Xml"; EmployeeNo: Code[20])
    begin
        if EmployeeNo <> '' then begin
            AllowanceHeader.Reset;
            AllowanceHeader.SetFilter("Employee No.", EmployeeNo);
            if AllowanceHeader.FindFirst then;
            AllowanceHeaderXml.SetTableView(AllowanceHeader);
        end
    end;

    [Scope('Personalization')]
    procedure GetAllowanceLines(var AllowanceLinesXml: XMLport "AllowanceLines Xml"; HeaderNo: Code[20])
    begin
        if HeaderNo <> '' then begin
            AllowanceLine.Reset;
            AllowanceLine.SetFilter("Document No.", HeaderNo);
            if AllowanceLine.FindFirst then;
            AllowanceLinesXml.SetTableView(AllowanceLine);
        end
    end;

    [Scope('Personalization')]
    procedure GetAllowanceApprovalEntries(var ApprovalEntries: XMLport "Approval Entries"; No: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        Employee: Record Employee;
    begin
        ApprovalEntry.Reset;
        /// ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::Allowance);
        if No <> '' then begin
            ApprovalEntry.SetRange("Document No.", No);
        end;
        if ApprovalEntry.FindFirst then;
        ApprovalEntries.SetTableView(ApprovalEntry);
    end;

    [Scope('Personalization')]
    procedure SendAllowanceApprovalRequest(No: Code[20]) ImprestApprovalRequestSent: Text
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ImprestApprovalRequestSent := '';

        AllowanceHeader.Reset;

        if AllowanceHeader.Get(No) then begin

            ApprovalsMgmt.OnSendAllowanceHeaderForApproval(AllowanceHeader);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", AllowanceHeader."No.");
            ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            if ApprovalEntry.FindFirst then
                ImprestApprovalRequestSent := '200: Allowance Approval Request sent Successfully '
            else
                ImprestApprovalRequestSent := '400:' + GetLastErrorCode + '-' + GetLastErrorText;

        end;
    end;

    [Scope('Personalization')]
    procedure CancelAllowanceApprovalRequest(No: Code[20]) ImprestApprovalRequestCanceled: Text
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ImprestApprovalRequestCanceled := '';

        AllowanceHeader.Reset;
        if AllowanceHeader.Get(No) then begin
            ApprovalsMgmt.OnCancelAllowanceApprovalRequest(AllowanceHeader);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", AllowanceHeader."No.");
            if ApprovalEntry.FindLast then begin
                if ApprovalEntry.Status = ApprovalEntry.Status::Canceled then
                    ImprestApprovalRequestCanceled := '200: Allowance Cancelled Successfully '
                else
                    ImprestApprovalRequestCanceled := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
            end;
        end;
    end;

    [Scope('Personalization')]
    procedure DeleteAlowanceLine("LineNo.": Integer; No: Code[20]) ImprestLineDeleted: Boolean
    begin
        ImprestLineDeleted := false;

        AllowanceLine.Reset;
        AllowanceLine.SetRange(AllowanceLine."Line No.", "LineNo.");
        AllowanceLine.SetRange(AllowanceLine."Document No.", No);
        if AllowanceLine.FindFirst then begin
            if AllowanceLine.Delete then begin
                ImprestLineDeleted := true;
            end;
        end;
    end;

    [Scope('Personalization')]
    procedure ModifyAllowanceHeader("ImprestNo.": Code[20]; DateFrom: Date; DateTo: Date; Description: Text[250]; Type: Option " ",Imprest,"Petty Cash","Casual Payment"; AttachmentName: Text) ImprestHeaderModified: Boolean
    var
        HREmployee: Record Employee;
        ImprestType: Option " ",Imprest,"Petty Cash";
    begin
        ImprestHeaderModified := false;
        AllowanceHeader.Reset;
        AllowanceHeader.SetRange(AllowanceHeader."No.", "ImprestNo.");
        if AllowanceHeader.FindFirst then begin
            AllowanceHeader."Date From" := DateFrom;
            AllowanceHeader."Date To" := DateTo;
            AllowanceHeader.Description := Description;
            AllowanceHeader."Attachment Name" := AttachmentName;
            if AllowanceHeader.Modify then
                ImprestHeaderModified := true;
        end;
    end;
}

