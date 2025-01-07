codeunit 50045 "Budget Commitment"
{

    trigger OnRun()
    begin
    end;

    var
        ReqLines: Record "Purchase Line";
        ItemLedgeEntries: Record "Item Ledger Entry";
        "LineNo.": Integer;
        RHeader: Record "Purchase Header";
        // SMTPMailSetup: Record "SMTP Mail Setup";
        // SMTPMail: Codeunit "SMTP Mail";
        RequestforQuotationVendor: Record "Request for Quotation Vendors";
        BCSetup: Record "Budget Control Setup";
        BudgetGL: Code[20];
       // SMTP: Record "SMTP Mail Setup";
        RequestforQuotationHeader: Record "Request for Quotation Header";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        FASubclassRec: Record "FA Subclass";
        Txt_001: Label 'Empty Purchase Requisition Line';
        Txt_002: Label 'Empty Request for Quotation Line';
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
        EdDefinition: Record "ED Definitions";
        PostingSetup: Record "Payroll Posting Setup";
        GLAccount: Record "G/L Account";
        BudgetAmount: Decimal;
        Budget: Record "G/L Budget Entry";
        Commitments: Record "Budget Committment";
        JvLines: Record "Journal Voucher Lines";
        GlName: Text;
        imprestLine1: Record "Imprest Line";
        GLEntry: Record "G/L Entry";
        FundsSetup: Record "Funds General Setup";
        ImprestHeader: Record "Imprest Header";
        FundsTransactionCode: Record "Funds Transaction Code";
        LoansAdvancesRec: Record "Loans/Advances";
        SalaryAdvanceRec: Record "Salary Advance";

    procedure CheckBudgetPurchaseRequisition(var PurchHeader: Record "Purchase Requisitions")
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
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
    begin
        BCSetup.Get;
        //check if the dates are within the specified range
        if (PurchHeader."Document Date"< BCSetup."Current Budget Start Date") or (PurchHeader."Document Date"> BCSetup."Current Budget End Date") then begin
          Error(Text0004,PurchHeader."Document Date",
          BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        end;

        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");

        //get the lines related to the purchase requisition header
        PurchLine.Reset;
        PurchLine.SetRange(PurchLine."Document No.",PurchHeader."No.");
        if PurchLine.FindSet then begin
          repeat
            //Items
            if PurchLine.Type=PurchLine.Type::Item then begin
              Items.Reset;
              if not Items.Get(PurchLine."No.") then
              Error(Text0007);
              Items.TestField("Item G/L Budget Account");
              BudgetGL:=Items."Item G/L Budget Account";
            end;

            //Fixed Asset
            if PurchLine.Type=PurchLine.Type::"Fixed Asset" then begin
              FixedAssets.Reset;
              FixedAssets.SetRange(FixedAssets."No.",PurchLine."No.");
              if FixedAssets.FindFirst then begin
                FAPostingGroup.Reset;
                FAPostingGroup.SetRange(FAPostingGroup.Code,FixedAssets."FA Posting Group");
                if FAPostingGroup.FindFirst then
                if PurchLine."FA Posting Type"=PurchLine."FA Posting Type"::Maintenance then begin
                  BudgetGL:=FAPostingGroup."Maintenance Expense Account";
                  if BudgetGL ='' then
                  Error(Text0008,PurchLine."No.");
                end else begin
                  BudgetGL:=FAPostingGroup."Acquisition Cost Account";
                  if BudgetGL ='' then
                  Error(Text0009,PurchLine."No.");
                end;
              end;
            end;

           //G/L Account
            if PurchLine.Type=PurchLine.Type::"G/L Account" then begin
              BudgetGL:=PurchLine."No.";
              if GLAccount.Get(PurchLine."No.") then
              GLAccount.TestField(GLAccount."Budget Controlled",true);
            end;

            //check the votebook now
            FirstDay:=DMY2Date(1,Date2DMY(PurchHeader."Document Date",2),Date2DMY(PurchHeader."Document Date",3));
            CurrMonth:=Date2DMY(PurchHeader."Document Date",2);
            if CurrMonth=12 then begin
              LastDay:=DMY2Date(1,1,Date2DMY(PurchHeader."Document Date",3) +1);
              LastDay:=CalcDate('-1D',LastDay);
            end else begin
              CurrMonth:=CurrMonth +1;
              LastDay:=DMY2Date(1,CurrMonth,Date2DMY(PurchHeader."Document Date",3));
              LastDay:=CalcDate('-1D',LastDay);
            end;

            //check the summation of the budget
            BudgetAmount:=0;
            ActualsAmount:=0;
            Budget.Reset;
            Budget.SetRange(Budget."Budget Name",BCSetup."Current Budget Code");
            Budget.SetFilter(Budget.Date,'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
            Budget.SetRange(Budget."G/L Account No.",BudgetGL);
             //Budget.SETRANGE(Budget."Global Dimension 1 Code",PurchLine."Global Dimension 1 Code");
            Budget.SetRange(Budget."Global Dimension 2 Code",PurchLine."Global Dimension 2 Code");
            if PurchLine."Shortcut Dimension 3 Code" <> '' then
             Budget.SetRange(Budget."Budget Dimension 3 Code",PurchLine."Shortcut Dimension 3 Code");
            if PurchLine."Shortcut Dimension 4 Code" <> '' then
             Budget.SetRange(Budget."Budget Dimension 4 Code",PurchLine."Shortcut Dimension 4 Code");
            if Budget.FindSet then begin
             Budget.CalcSums(Amount);
             BudgetAmount:=Budget.Amount;
            end;

            //get the committments
            CommitmentAmount:=0;
            Commitments.Reset;
            Commitments.SetRange(Commitments.Budget,BCSetup."Current Budget Code");
            Commitments.SetRange(Commitments."G/L Account No.",BudgetGL);
            Commitments.SetRange(Commitments."Posting Date",BCSetup."Current Budget Start Date",LastDay);
           // Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code",PurchLine."Global Dimension 1 Code");
            Commitments.SetRange(Commitments."Shortcut Dimension 2 Code",PurchLine."Global Dimension 2 Code");
            if PurchLine."Shortcut Dimension 3 Code" <> '' then
             Commitments.SetRange(Commitments."Shortcut Dimension 3 Code",PurchLine."Shortcut Dimension 3 Code");
            if PurchLine."Shortcut Dimension 4 Code" <> '' then
             Commitments.SetRange(Commitments."Shortcut Dimension 4 Code",PurchLine."Shortcut Dimension 4 Code");
            Commitments.CalcSums(Commitments.Amount);
            CommitmentAmount:= Commitments.Amount;

            //check if there is any budget
            if (BudgetAmount<=0) then
             Error(Text0010);

            //check if the actuals plus the amount is greater then the budget amount
            if ((CommitmentAmount + PurchLine."Total Cost(LCY)") > BudgetAmount) and (BCSetup."Allow OverExpenditure"=false) then begin
              Error(Text0011,
              PurchLine."Document No.",PurchLine.Type ,PurchLine."No.",
              Format(Abs(BudgetAmount-(CommitmentAmount + ActualsAmount+PurchLine."Total Cost"))));
            end else begin
            //commit Amounts
            Commitments.Init;
            Commitments."Line No.":=0;
            Commitments.Date:=Today;
            Commitments."Posting Date":=PurchHeader."Document Date";
            Commitments."Document Type":=Commitments."Document Type"::Requisition;
            Commitments."Document No.":=PurchHeader."No.";
            Commitments.Amount:=PurchLine."Total Cost(LCY)";
            Commitments."Month Budget":=BudgetAmount;
            Commitments."Month Actual":=CommitmentAmount+ActualsAmount+PurchLine."Total Cost(LCY)";
            Commitments.Committed:=true;
            Commitments."Committed By":=UserId;
            Commitments."Committed Date":=PurchHeader."Document Date";
            Commitments."G/L Account No.":=BudgetGL;
            Commitments."Committed Time":=Time;
            Commitments."Shortcut Dimension 1 Code":=PurchLine."Global Dimension 1 Code";
            Commitments."Shortcut Dimension 2 Code":=PurchLine."Global Dimension 2 Code";
            Commitments."Shortcut Dimension 3 Code":=PurchLine."Shortcut Dimension 3 Code";
            Commitments."Shortcut Dimension 4 Code":=PurchLine."Shortcut Dimension 4 Code";
            Commitments.Budget:=BCSetup."Current Budget Code";
            Commitments.Type:=Commitments.Type::Vendor;
            Commitments.Committed:=true;
            if Commitments.Insert then begin
              PurchLine.Committed:=true;
              PurchLine.Modify;
             end;
            end;
          until PurchLine.Next=0;
        end;
    end;

    procedure CancelBudgetCommitmentPurchaseRequisition(PurchHeader: Record "Purchase Requisitions")
    var
        Commitments: Record "Budget Committment";
        EntryNo: Integer;
        PurchLine: Record "Purchase Requisition Line";
        BudgetAmount: Decimal;
        Items: Record Item;
        FixedAsset: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
    begin
        Clear(BudgetAmount);
        BudgetGL:='';
        BCSetup.Get();
        PurchLine.Reset;
        PurchLine.SetRange("Document No.",PurchHeader."No.");
        PurchLine.SetRange(Committed,true);
        if PurchLine.FindSet then begin
          if PurchLine.Type = PurchLine.Type::Item then
            if Items.Get(PurchLine."No.") then
              BudgetGL:=Items."Item G/L Budget Account"
          else if PurchLine.Type = PurchLine.Type::"Fixed Asset" then
            if FixedAsset.Get(PurchLine."No.") then
              FAPostingGroup.Reset;
              FAPostingGroup.SetRange(Code,FixedAsset."FA Posting Group");
              if FAPostingGroup.FindFirst then
                BudgetGL:=FAPostingGroup."Acquisition Cost Account"
          else if PurchLine.Type = PurchLine.Type::"G/L Account" then
                  BudgetGL:=PurchLine."No.";

          repeat
            BudgetAmount:=PurchLine.Quantity*PurchLine."Unit Cost";
            Commitments.Reset;
            Commitments.Init;
            Commitments."Line No.":=0;
            Commitments.Date:=Today;
            Commitments."Posting Date":=PurchHeader."Document Date";
            Commitments."Document Type":=Commitments."Document Type"::Requisition;
            Commitments."Document No.":=PurchHeader."No.";
            Commitments.Amount:=-BudgetAmount;
            Commitments.Committed:=false;
            Commitments."Committed By":=UserId;
            Commitments."Committed Date":=PurchHeader."Document Date";
            Commitments."G/L Account No.":=BudgetGL;
            Commitments."Committed Time":=Time;
            Commitments.Cancelled:=true;
            Commitments."Cancelled By":=UserId;
            Commitments."Cancelled Date":=Today;
            Commitments."Shortcut Dimension 1 Code":=PurchLine."Global Dimension 1 Code";
            Commitments."Shortcut Dimension 2 Code":=PurchLine."Global Dimension 2 Code";
            Commitments."Shortcut Dimension 3 Code":=PurchLine."Shortcut Dimension 3 Code";
            Commitments."Shortcut Dimension 4 Code":=PurchLine."Shortcut Dimension 4 Code";
            Commitments.Committed:=true;
            Commitments.Budget:=BCSetup."Current Budget Code";
            if Commitments.Insert then begin
              PurchLine.Committed:=false;
              PurchLine.Modify;
            end;
          until PurchLine.Next=0;
        end;
    end;

    procedure CheckIfGLAccountBlocked(BudgetName: Code[20])
    var
        GLBudgetName: Record "G/L Budget Name";
    begin
        GLBudgetName.Get(BudgetName);
        GLBudgetName.TestField(Blocked,false);
    end;

    procedure CheckBudgetPurchaseOrder(var PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        Items: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
    begin
        BCSetup.Get;
        //check if the dates are within the specified range
        if (PurchHeader."Document Date"< BCSetup."Current Budget Start Date") or (PurchHeader."Document Date"> BCSetup."Current Budget End Date") then begin
          Error(Text0004,PurchHeader."Document Date",
          BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        end;
        
        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");
        //get line no
        Commitments.Reset;
        if Commitments.FindLast then
          EntryNo+=Commitments."Line No."
        else
        EntryNo:=1;
        //get the lines related to the purchase requisition header
        PurchLine.Reset;
        PurchLine.SetRange(PurchLine."Document No.",PurchHeader."No.");
        if PurchLine.FindSet then begin
          repeat
            //Items
            if PurchLine.Type=PurchLine.Type::Item then begin
              Items.Reset;
              if not Items.Get(PurchLine."No.") then
              Error(Text0007);
              Items.TestField("Item G/L Budget Account");
              BudgetGL:=Items."Item G/L Budget Account";
            end;
        
            //Fixed Asset
            if PurchLine.Type=PurchLine.Type::"Fixed Asset" then begin
              FixedAssets.Reset;
              FixedAssets.SetRange(FixedAssets."No.",PurchLine."No.");
              if FixedAssets.FindFirst then begin
                //fixed asset sub class
                FixedAssets.TestField("FA Subclass Code");
                FASubclassRec.Get(FixedAssets."FA Subclass Code");
                FASubclassRec.TestField("Default FA Posting Group");
                FAPostingGroup.Reset;
                FAPostingGroup.SetRange(FAPostingGroup.Code,FASubclassRec."Default FA Posting Group");
                if FAPostingGroup.FindFirst then
                if PurchLine."FA Posting Type"=PurchLine."FA Posting Type"::Maintenance then begin
                  BudgetGL:=FAPostingGroup."Maintenance Expense Account";
                  if BudgetGL ='' then
                  Error(Text0008,PurchLine."No.");
                end else begin
                  BudgetGL:=FAPostingGroup."Acquisition Cost Account";
                  if BudgetGL ='' then
                  Error(Text0009,PurchLine."No.");
                end;
              end;
            end;
        
           //G/L Account
            if PurchLine.Type=PurchLine.Type::"G/L Account" then begin
              BudgetGL:=PurchLine."No.";
        
            end;
        
            //check the votebook now
        
            FirstDay:=DMY2Date(1,Date2DMY(PurchHeader."Document Date",2),Date2DMY(PurchHeader."Document Date",3));
            CurrMonth:=Date2DMY(PurchHeader."Document Date",2);
            if CurrMonth=12 then begin
              LastDay:=DMY2Date(1,1,Date2DMY(PurchHeader."Document Date",3) +1);
              LastDay:=CalcDate('-1D',LastDay);
            end else begin
              CurrMonth:=CurrMonth +1;
              LastDay:=DMY2Date(1,CurrMonth,Date2DMY(PurchHeader."Document Date",3));
              LastDay:=CalcDate('-1D',LastDay);
            end;
        
            //Get actuals
            GLAccount.Reset;;
            GLAccount.SetRange("No.",BudgetGL);
            //GLAccount.SETRANGE("Date Filter",BCSetup."Current Budget Start Date",LastDay);
            GLAccount.SetRange("Date Filter",BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
            GLAccount.CalcFields("Net Change");
            ActualsAmount:=GLAccount."Net Change";
        
            //check the summation of the budget
            BudgetAmount:=0;
            Budget.Reset;
            Budget.SetRange(Budget."Budget Name",BCSetup."Current Budget Code");
            //Budget.SETFILTER(Budget.Date,'%1..%2',BCSetup."Current Budget Start Date",LastDay);
            Budget.SetFilter(Budget.Date,'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
            Budget.SetRange(Budget."G/L Account No.",BudgetGL);
            /*Budget.SETRANGE(Budget."Global Dimension 1 Code",PurchLine."Global Dimension 1 Code");
            Budget.SETRANGE(Budget."Global Dimension 2 Code",PurchLine."Global Dimension 2 Code");
            IF PurchLine."Shortcut Dimension 3 Code" <> '' THEN
             Budget.SETRANGE(Budget."Budget Dimension 3 Code",PurchLine."Shortcut Dimension 3 Code");
            IF PurchLine."Shortcut Dimension 4 Code" <> '' THEN
             Budget.SETRANGE(Budget."Budget Dimension 4 Code",PurchLine."Shortcut Dimension 4 Code");*/
            if Budget.FindSet then begin
             Budget.CalcSums(Amount);
             BudgetAmount:=Budget.Amount;
            end;
        
            //get the committments
            CommitmentAmount:=0;
            Commitments.Reset;
            Commitments.SetRange(Commitments.Budget,BCSetup."Current Budget Code");
            Commitments.SetRange(Commitments."G/L Account No.",BudgetGL);
            //Commitments.SETRANGE(Commitments."Posting Date",BCSetup."Current Budget Start Date",LastDay);
            Commitments.SetRange(Commitments."Posting Date",BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
           /* Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code",PurchLine."Shortcut Dimension 1 Code");
            Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code",PurchLine."Shortcut Dimension 2 Code");
            IF PurchLine."Shortcut Dimension 3 Code" <> '' THEN
             Commitments.SETRANGE(Commitments."Shortcut Dimension 3 Code",PurchLine."Shortcut Dimension 3 Code");
            IF PurchLine."Shortcut Dimension 4 Code" <> '' THEN
             Commitments.SETRANGE(Commitments."Shortcut Dimension 4 Code",PurchLine."Shortcut Dimension 4 Code");*/
            Commitments.CalcSums(Commitments.Amount);
            CommitmentAmount:= Commitments.Amount;
        
            //check if there is any budget
            if (BudgetAmount<=0) then
             Error(Text0010);
        
            //check if the actuals plus the amount is greater then the budget amount
            if ((CommitmentAmount + PurchLine."Amount Including VAT"+ActualsAmount) > BudgetAmount) and (BCSetup."Allow OverExpenditure"=false) then begin
              Error(Text0011,
              PurchLine."Document No.",PurchLine.Type ,PurchLine."No.",
              Format(Abs(BudgetAmount-(CommitmentAmount + ActualsAmount+PurchLine."Amount Including VAT"))));
            end else begin
            //commit Amounts
            EntryNo := EntryNo +1;
            Commitments.Init;
            Commitments."Line No.":=EntryNo;
            Commitments.Date:=Today;
            Commitments."Posting Date":=PurchHeader."Document Date";
            Commitments."Document Type":=Commitments."Document Type"::LPO;
            Commitments."Document No.":=PurchHeader."No.";
            Commitments.Amount:=PurchLine."Amount Including VAT";
            Commitments."Month Budget":=BudgetAmount;
            Commitments.Committed:=true;
            Commitments."Committed By":=UserId;
            Commitments."Committed Date":=PurchHeader."Document Date";
            Commitments."G/L Account No.":=BudgetGL;
            Commitments."Committed Time":=Time;
            Commitments."Shortcut Dimension 1 Code":=PurchLine."Shortcut Dimension 1 Code";
            Commitments."Shortcut Dimension 2 Code":=PurchLine."Shortcut Dimension 2 Code";
            Commitments."Shortcut Dimension 3 Code":=PurchLine."Shortcut Dimension 3 Code";
            Commitments."Shortcut Dimension 4 Code":=PurchLine."Shortcut Dimension 4 Code";
            Commitments.Budget:=BCSetup."Current Budget Code";
            Commitments.Type:=Commitments.Type::" ";
            Commitments.Committed:=true;
            Commitments.Insert(true);
            //(TRUE) THEN BEGIN
              PurchLine.Committed:=true;
              PurchLine.Modify;
            // END
            // ELSE
            // ERROR(GETLASTERRORTEXT);
            end;
          until PurchLine.Next=0;
        end;

    end;

    procedure CancelBudgetCommitmentPurchaseOrder(PurchHeader: Record "Purchase Header")
    var
        Commitments: Record "Budget Committment";
        EntryNo: Integer;
        PurchLine: Record "Purchase Line";
        BudgetAmount: Decimal;
        Items: Record Item;
        FixedAsset: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
    begin
        Clear(BudgetAmount);
        BudgetGL:='';
        BCSetup.Get();
        PurchLine.Reset;
        PurchLine.SetRange("Document No.",PurchHeader."No.");
        PurchLine.SetRange(Committed,true);
        if PurchLine.FindSet then begin
          if PurchLine.Type = PurchLine.Type::Item then
            if Items.Get(PurchLine."No.") then
              BudgetGL:=Items."Item G/L Budget Account"
          else if PurchLine.Type = PurchLine.Type::"Fixed Asset" then begin
              FixedAsset.Get(PurchLine."No.");
              FixedAsset.TestField("FA Subclass Code");
              FASubclassRec.Get(FixedAsset."FA Subclass Code");
              FASubclassRec.TestField("Default FA Posting Group");
              FAPostingGroup.Reset;
              FAPostingGroup.SetRange(Code,FASubclassRec."Default FA Posting Group");
              if FAPostingGroup.FindFirst then
                BudgetGL:=FAPostingGroup."Acquisition Cost Account"
         end
          else if PurchLine.Type = PurchLine.Type::"G/L Account" then
                  BudgetGL:=PurchLine."No.";
          //Find entry no
            Commitments.Reset;
            if Commitments.FindLast then
              EntryNo+=Commitments."Line No."
            else
            EntryNo:=1;
          repeat
           // BudgetAmount:=PurchLine.Quantity*PurchLine."Unit Cost";
            Commitments.Reset;
            Commitments.Init;
            Commitments."Line No.":=EntryNo+1;
            Commitments.Date:=Today;
            Commitments."Posting Date":=PurchHeader."Document Date";
            Commitments."Document Type":=Commitments."Document Type"::LPO;
            Commitments."Document No.":=PurchHeader."No.";
            Commitments.Amount:=-PurchLine."Amount Including VAT";
            Commitments.Committed:=false;
            Commitments."Committed By":=UserId;
            Commitments."Committed Date":=PurchHeader."Document Date";
            Commitments."G/L Account No.":=BudgetGL;
            Commitments."Committed Time":=Time;
            Commitments.Cancelled:=true;
            Commitments."Cancelled By":=UserId;
            Commitments."Cancelled Date":=Today;
            Commitments."Shortcut Dimension 1 Code":=PurchLine."Shortcut Dimension 1 Code";
            Commitments."Shortcut Dimension 2 Code":=PurchLine."Shortcut Dimension 2 Code";
            Commitments."Shortcut Dimension 3 Code":=PurchLine."Shortcut Dimension 3 Code";
            Commitments."Shortcut Dimension 4 Code":=PurchLine."Shortcut Dimension 4 Code";
            Commitments.Committed:=true;
            Commitments.Budget:=BCSetup."Current Budget Code";
            if Commitments.Insert then begin
              PurchLine.Committed:=false;
              PurchLine.Modify;
            end;
            //ELSE
            //ERROR(GETLASTERRORTEXT);
          until PurchLine.Next=0;
        end;
    end;

    procedure CalcBudgetAvailableAmt(Type: Option " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";"No.": Code[50];"Document Date": Date) BudgetAmt: Decimal
    var
        Items: Record Item;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
    begin
           BCSetup.Get;
            //Items
            if Type=Type::Item then begin
              Items.Reset;
              if not Items.Get("No.") then
              Error(Text0007);
              Items.TestField("Item G/L Budget Account");
              BudgetGL:=Items."Item G/L Budget Account";
            end;
        
            //Fixed Asset
            if Type=Type::"Fixed Asset" then begin
              FixedAssets.Reset;
              FixedAssets.SetRange(FixedAssets."No.","No.");
              if FixedAssets.FindFirst then begin
               FixedAssets.TestField("FA Subclass Code");
               FASubclassRec.Get(FixedAssets."FA Subclass Code");
                FASubclassRec.TestField("Default FA Posting Group");
                FAPostingGroup.Reset;
                FAPostingGroup.SetRange(FAPostingGroup.Code,FASubclassRec."Default FA Posting Group");
                if FAPostingGroup.FindFirst then
                if FAPostingGroup.FindFirst then
                begin
                  BudgetGL:=FAPostingGroup."Acquisition Cost Account";
                  if BudgetGL ='' then
                  Error(Text0009,"No.");
                end;
              end;
            end;
        
           //G/L Account
            if Type=Type::"G/L Account" then begin
              BudgetGL:="No.";
        
            end;
        
            //check the votebook now
        
            FirstDay:=DMY2Date(1,Date2DMY("Document Date",2),Date2DMY("Document Date",3));
            CurrMonth:=Date2DMY("Document Date",2);
            if CurrMonth=12 then begin
              LastDay:=DMY2Date(1,1,Date2DMY("Document Date",3) +1);
              LastDay:=CalcDate('-1D',LastDay);
            end else begin
              CurrMonth:=CurrMonth +1;
              LastDay:=DMY2Date(1,CurrMonth,Date2DMY("Document Date",3));
              LastDay:=CalcDate('-1D',LastDay);
            end;
        
            //Get actuals
            GLAccount.Reset;;
            GLAccount.SetRange("No.",BudgetGL);
            GLAccount.SetRange("Date Filter",BCSetup."Current Budget Start Date",LastDay);
            GLAccount.CalcFields("Net Change");
            ActualsAmount:=GLAccount."Net Change";
        
            //check the summation of the budget
            BudgetAmount:=0;
            Budget.Reset;
            Budget.SetRange(Budget."Budget Name",BCSetup."Current Budget Code");
            Budget.SetFilter(Budget.Date,'%1..%2',BCSetup."Current Budget Start Date",LastDay);
            Budget.SetRange(Budget."G/L Account No.",BudgetGL);
            /*Budget.SETRANGE(Budget."Global Dimension 1 Code","Global Dimension 1 Code");
            Budget.SETRANGE(Budget."Global Dimension 2 Code","Global Dimension 2 Code");
            IF "Shortcut Dimension 3 Code" <> '' THEN
             Budget.SETRANGE(Budget."Budget Dimension 3 Code","Shortcut Dimension 3 Code");
            IF "Shortcut Dimension 4 Code" <> '' THEN
             Budget.SETRANGE(Budget."Budget Dimension 4 Code","Shortcut Dimension 4 Code");*/
            if Budget.FindSet then begin
             Budget.CalcSums(Amount);
             BudgetAmount:=Budget.Amount;
            end;
        
            //get the committments
            CommitmentAmount:=0;
            Commitments.Reset;
            Commitments.SetRange(Commitments.Budget,BCSetup."Current Budget Code");
            Commitments.SetRange(Commitments."G/L Account No.",BudgetGL);
            Commitments.SetRange(Commitments."Posting Date",BCSetup."Current Budget Start Date",LastDay);
            /*
            Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code",PurchLine."Global Dimension 1 Code");
            Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code",PurchLine."Global Dimension 2 Code");
            IF PurchLine."Shortcut Dimension 3 Code" <> '' THEN
             Commitments.SETRANGE(Commitments."Shortcut Dimension 3 Code",PurchLine."Shortcut Dimension 3 Code");
            IF PurchLine."Shortcut Dimension 4 Code" <> '' THEN
             Commitments.SETRANGE(Commitments."Shortcut Dimension 4 Code",PurchLine."Shortcut Dimension 4 Code");
             */
            Commitments.CalcSums(Commitments.Amount);
            CommitmentAmount:= Commitments.Amount;
        
            //available budget amount
            BudgetAmt:=BudgetAmount-(ActualsAmount+CommitmentAmount);
            exit(BudgetAmt);

    end;

    procedure CheckGLBudget(var Imprestheader: Record "Imprest Header")
    var
        ImprestLine: Record "Imprest Line";
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        Items: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
    begin
        BCSetup.Get;
        //check if the dates are within the specified range
        if (Imprestheader."Date From"< BCSetup."Current Budget Start Date") or (Imprestheader."Date To"> BCSetup."Current Budget End Date") then begin
          Error(Text0004,Imprestheader."Date From",
          BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        end;
        
        
        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");
        
        //get the lines related to the Imprest/Petty cash requisition header
        ImprestLine.Reset;
        ImprestLine.SetRange(ImprestLine."Document No.",Imprestheader."No.");
        if ImprestLine.FindSet then begin
          repeat
            /*
            //Items
            IF PurchLine.Type=PurchLine.Type::Item THEN BEGIN
              Items.RESET;
              IF NOT Items.GET(PurchLine."No.") THEN
              ERROR(Text0007);
              Items.TESTFIELD("Item G/L Budget Account");
              BudgetGL:=Items."Item G/L Budget Account";
            END;
            */
            //Fixed Asset
            /*
            IF PurchLine.Type=PurchLine.Type::"Fixed Asset" THEN BEGIN
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
            */
        
           //G/L Account i
            if ImprestLine."Account Type"=ImprestLine."Account Type"::"G/L Account" then
            begin
              BudgetGL:=ImprestLine."Account No.";
              if GLAccount.Get(ImprestLine."Account No.") then
              GLAccount.TestField(GLAccount."Budget Controlled",true);
            end;
            //check the votebook now
            FirstDay:=DMY2Date(1,Date2DMY(Imprestheader."Document Date",2),Date2DMY(Imprestheader."Document Date",3));
            CurrMonth:=Date2DMY(Imprestheader."Document Date",2);
            if CurrMonth=12 then begin
              LastDay:=DMY2Date(1,1,Date2DMY(Imprestheader."Document Date",3) +1);
              LastDay:=CalcDate('-1D',LastDay);
            end else begin
              CurrMonth:=CurrMonth +1;
              LastDay:=DMY2Date(1,CurrMonth,Date2DMY(Imprestheader."Document Date",3));
              LastDay:=CalcDate('-1D',LastDay);
            end;
           /* GLAccount.RESET;
            GLAccount.SETRANGE("No.",BudgetGL);
            GLAccount.SETFILTER("Date Filter",'%1..%2',FirstDay,LastDay);
            IF GLAccount.FINDSET THEN
            GLAccount.CALCFIELDS("Net Change");
        
            ActualsAmount:=GLAccount."Net Change";*/
        
            //check the summation of the budget
            BudgetAmount:=0;
            ActualsAmount:=0;
            Budget.Reset;
            Budget.SetRange(Budget."Budget Name",BCSetup."Current Budget Code");
            Budget.SetFilter(Budget.Date,'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
            Budget.SetRange(Budget."G/L Account No.",BudgetGL);//Budget.SETFILTER(Budget.Date,'%1..%2',FirstDay,LastDay);
        
        
        
            /*IF ImprestLine."Global Dimension 1 Code"<>'' THEN
            Budget.SETRANGE(Budget."Global Dimension 1 Code",ImprestLine."Global Dimension 1 Code");
        
            IF ImprestLine."Global Dimension 2 Code"<>'' THEN
            Budget.SETRANGE(Budget."Global Dimension 2 Code",ImprestLine."Global Dimension 2 Code");
        
            IF PurchLine."Shortcut Dimension 3 Code" <> '' THEN
             Budget.SETRANGE(Budget."Budget Dimension 3 Code",PurchLine."Shortcut Dimension 3 Code");
            IF PurchLine."Shortcut Dimension 4 Code" <> '' THEN
             Budget.SETRANGE(Budget."Budget Dimension 4 Code",PurchLine."Shortcut Dimension 4 Code");*/
        
            if Budget.FindSet then begin
             Budget.CalcSums(Amount);
             BudgetAmount:=Budget.Amount;
            end;
        
            //get the committments
        
            CommitmentAmount:=0;
            Commitments.Reset;
            Commitments.SetRange(Commitments.Budget,BCSetup."Current Budget Code");
            Commitments.SetRange(Commitments."G/L Account No.",BudgetGL);
            Commitments.SetRange(Commitments."Posting Date",BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
            /*Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code",ImprestLine."Global Dimension 1 Code");
            Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code",ImprestLine."Global Dimension 2 Code");
            IF ImprestLine."Shortcut Dimension 3 Code" <> '' THEN
             Commitments.SETRANGE(Commitments."Shortcut Dimension 3 Code",ImprestLine."Shortcut Dimension 3 Code");
            IF ImprestLine."Shortcut Dimension 4 Code" <> '' THEN
             Commitments.SETRANGE(Commitments."Shortcut Dimension 4 Code",ImprestLine."Shortcut Dimension 4 Code");*/
            Commitments.CalcSums(Commitments.Amount);
            CommitmentAmount:= Commitments.Amount;
        
            //check if there is any budget
            if (BudgetAmount<=0) then
             Error(Text0010);
        
            //check if the actuals plus the amount plus the commitments is greater then the budget amount
            if ((ImprestLine."Net Amount"+CommitmentAmount) > BudgetAmount) and (BCSetup."Allow OverExpenditure"=false) then begin
              Error(Text0011,
              ImprestLine."Document No.",ImprestLine."Account Type" ,ImprestLine."Account No.",
              Format(Abs(BudgetAmount-(CommitmentAmount+ImprestLine."Net Amount"))));
            end else begin
            Message('Budget test passed %1,%2',CommitmentAmount,BudgetAmount);
        
            //commit Amounts
        
            Commitments.Init;
            Commitments."Line No.":=0;
            Commitments.Date:=Today;
            Commitments."Posting Date":=Imprestheader."Document Date";
            Commitments."Document Type":=Imprestheader."Document Type";
            Commitments."Document No.":=Imprestheader."No.";
            Commitments.Amount:=ImprestLine."Net Amount";
            Commitments."Month Budget":=BudgetAmount;
            Commitments.Committed:=true;
            Commitments."Committed By":=UserId;
            Commitments."Committed Date":=Today;//Imprestheader."Document Date";
            Commitments."G/L Account No.":=BudgetGL;
            Commitments."Committed Time":=Time;
            Commitments."Shortcut Dimension 1 Code":=ImprestLine."Global Dimension 1 Code";
            Commitments."Shortcut Dimension 2 Code":=ImprestLine."Global Dimension 2 Code";
            Commitments."Shortcut Dimension 3 Code":=ImprestLine."Shortcut Dimension 3 Code";
            Commitments."Shortcut Dimension 4 Code":=ImprestLine."Shortcut Dimension 4 Code";
            Commitments.Budget:=BCSetup."Current Budget Code";
            Commitments.Type:=Commitments.Type::" ";
            Commitments."Budget Balance" := BudgetAmount-(CommitmentAmount +ImprestLine."Net Amount");
            Commitments.Committed:=true;
            if Commitments.Insert then begin
              ImprestLine."Budget Committed":=true;
             // ImprestLine."Budget Balance" := BudgetAmount-(CommitmentAmount +ImprestLine."Net Amount");
              //ImprestLine."Amount Committed" := ImprestLine."Net Amount";
              //ImprestLine."Total Commitment Before" := CommitmentAmount;
              ImprestLine.Modify;
             end;
            end;
          until ImprestLine.Next=0;
          Imprestheader.Voted:=true;
          Imprestheader.Modify;
        end;

    end;

    procedure DecommitGLBudget(var Imprestheader: Record "Imprest Header")
    var
        ImprestLine: Record "Imprest Line";
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        Items: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
        CommitmentsCopy: Record "Budget Committment";
        lineno: Integer;
    begin
        BCSetup.Get;
        //check if the dates are within the specified range
        /*
        IF (Imprestheader."Date From"< BCSetup."Current Budget Start Date") OR (Imprestheader."Date To"> BCSetup."Current Budget End Date") THEN BEGIN
          ERROR(Text0004,Imprestheader."Date From",
          BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        END;
        */
        
        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");
         if Commitments.FindLast then
         lineno:=Commitments."Line No."
         else
         lineno:=0;
        //get the lines related to the Imprest/Petty cash requisition header
        ImprestLine.Reset;
        ImprestLine.SetRange(ImprestLine."Document No.",Imprestheader."No.");
        if ImprestLine.FindSet then begin
          repeat
            /*
            //Items
            IF PurchLine.Type=PurchLine.Type::Item THEN BEGIN
              Items.RESET;
              IF NOT Items.GET(PurchLine."No.") THEN
              ERROR(Text0007);
              Items.TESTFIELD("Item G/L Budget Account");
              BudgetGL:=Items."Item G/L Budget Account";
            END;
            */
            //Fixed Asset
            /*
          IF PurchLine.Type=PurchLine.Type::"Fixed Asset" THEN BEGIN
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
            */
        
           //G/L Account i
            if ImprestLine."Account Type"=ImprestLine."Account Type"::"G/L Account" then
            begin
              BudgetGL:=ImprestLine."Account No.";
              if GLAccount.Get(ImprestLine."Account No.") then
              GLAccount.TestField(GLAccount."Budget Controlled",true);
            end;
            //check the votebook now
            /*
            FirstDay:=DMY2DATE(1,DATE2DMY(Imprestheader."Document Date",2),DATE2DMY(Imprestheader."Document Date",3));
            CurrMonth:=DATE2DMY(Imprestheader."Document Date",2);
            IF CurrMonth=12 THEN BEGIN
              LastDay:=DMY2DATE(1,1,DATE2DMY(Imprestheader."Document Date",3) +1);
              LastDay:=CALCDATE('-1D',LastDay);
            END ELSE BEGIN
              CurrMonth:=CurrMonth +1;
              LastDay:=DMY2DATE(1,CurrMonth,DATE2DMY(Imprestheader."Document Date",3));
              LastDay:=CALCDATE('-1D',LastDay);
            END;
            GLAccount.RESET;
            GLAccount.SETRANGE("No.",BudgetGL);
            GLAccount.SETFILTER("Date Filter",'%1..%2',FirstDay,LastDay);
            IF GLAccount.FINDSET THEN
            GLAccount.CALCFIELDS("Net Change");
        
            ActualsAmount:=GLAccount."Net Change";
        
            //check the summation of the budget
            BudgetAmount:=0;
            Budget.RESET;
            Budget.SETRANGE(Budget."Budget Name",BCSetup."Current Budget Code");
            Budget.SETFILTER(Budget.Date,'%1',BCSetup."Current Budget Start Date",FirstDay);
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
            {
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
            }
            //check if there is any budget
            IF (BudgetAmount<=0) THEN
             ERROR(Text0010);
        
            //check if the actuals plus the amount is greater then the budget amount
            IF ((ImprestLine."Net Amount") > BudgetAmount) AND (BCSetup."Allow OverExpenditure"=FALSE) THEN BEGIN
              ERROR(Text0011,
              ImprestLine."Document No.",ImprestLine."Account Type" ,ImprestLine."Account No.",
              FORMAT(ABS(BudgetAmount-(ActualsAmount+ImprestLine."Net Amount"))));
            END ELSE BEGIN
            MESSAGE('Budget test passed');
            */
            //Decommit Amounts
            lineno:= lineno+1;
            Commitments.Reset;
            Commitments.SetRange("Document No.",Imprestheader."No.");
            Commitments.SetRange("Document Type",Imprestheader."Document Type");
            CommitmentsCopy.SetRange("Line No.",ImprestLine."Line No.");
            if CommitmentsCopy.FindFirst then
            begin
            Commitments.Init;
            Commitments."Line No.":=lineno;
            Commitments.Date:=Today;
            Commitments."Posting Date":=Imprestheader."Document Date";
            Commitments."Document Type":=Imprestheader."Document Type";
            Commitments."Document No.":=Imprestheader."No.";
            Commitments.Amount:=-ImprestLine."Net Amount";
            Commitments."Month Budget":=BudgetAmount;
            Commitments.Committed:=true;
            Commitments."Committed By":=UserId;
            Commitments."Committed Date":=Imprestheader."Document Date";
            Commitments."G/L Account No.":=BudgetGL;
            Commitments."Committed Time":=Time;
            Commitments."Shortcut Dimension 1 Code":=ImprestLine."Global Dimension 1 Code";
            Commitments."Shortcut Dimension 2 Code":=ImprestLine."Global Dimension 2 Code";
            Commitments."Shortcut Dimension 3 Code":=ImprestLine."Shortcut Dimension 3 Code";
            Commitments."Shortcut Dimension 4 Code":=ImprestLine."Shortcut Dimension 4 Code";
            Commitments.Budget:=BCSetup."Current Budget Code";
            Commitments.Type:=Commitments.Type::" ";
            Commitments.Committed:=true;
            Commitments.Insert
             end;
        
          until ImprestLine.Next=0;
        end;

    end;

    procedure commitGLBudget(var Imprestheader: Record "Imprest Header") Ok: Boolean
    var
        ImprestLine: Record "Imprest Line";
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        Items: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
        CommitmentsCopy: Record "Budget Committment";
    begin
        BCSetup.Get;
        //check if the dates are within the specified range
        if (Imprestheader."Date From"< BCSetup."Current Budget Start Date") or (Imprestheader."Date To"> BCSetup."Current Budget End Date") then begin
          Error(Text0004,Imprestheader."Date From",
          BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        end;
        
        
        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");
        
        //get the lines related to the Imprest/Petty cash requisition header
        ImprestLine.Reset;
        ImprestLine.SetRange(ImprestLine."Document No.",Imprestheader."No.");
        if ImprestLine.FindSet then begin
          repeat
            /*
            //Items
            IF PurchLine.Type=PurchLine.Type::Item THEN BEGIN
              Items.RESET;
              IF NOT Items.GET(PurchLine."No.") THEN
              ERROR(Text0007);
              Items.TESTFIELD("Item G/L Budget Account");
              BudgetGL:=Items."Item G/L Budget Account";
            END;
            */
            //Fixed Asset
            /*
          IF PurchLine.Type=PurchLine.Type::"Fixed Asset" THEN BEGIN
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
            */
        
           //G/L Account i
            if ImprestLine."Account Type"=ImprestLine."Account Type"::"G/L Account" then
            begin
              BudgetGL:=ImprestLine."Account No.";
              if GLAccount.Get(ImprestLine."Account No.") then
              GLAccount.TestField(GLAccount."Budget Controlled",true);
            end;
            //check the votebook now
            /*
            FirstDay:=DMY2DATE(1,DATE2DMY(Imprestheader."Document Date",2),DATE2DMY(Imprestheader."Document Date",3));
            CurrMonth:=DATE2DMY(Imprestheader."Document Date",2);
            IF CurrMonth=12 THEN BEGIN
              LastDay:=DMY2DATE(1,1,DATE2DMY(Imprestheader."Document Date",3) +1);
              LastDay:=CALCDATE('-1D',LastDay);
            END ELSE BEGIN
              CurrMonth:=CurrMonth +1;
              LastDay:=DMY2DATE(1,CurrMonth,DATE2DMY(Imprestheader."Document Date",3));
              LastDay:=CALCDATE('-1D',LastDay);
            END;
            GLAccount.RESET;
            GLAccount.SETRANGE("No.",BudgetGL);
            GLAccount.SETFILTER("Date Filter",'%1..%2',FirstDay,LastDay);
            IF GLAccount.FINDSET THEN
            GLAccount.CALCFIELDS("Net Change");
        
            ActualsAmount:=GLAccount."Net Change";
        
            //check the summation of the budget
            BudgetAmount:=0;
            Budget.RESET;
            Budget.SETRANGE(Budget."Budget Name",BCSetup."Current Budget Code");
            Budget.SETFILTER(Budget.Date,'%1',BCSetup."Current Budget Start Date",FirstDay);
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
            {
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
            }
            //check if there is any budget
            IF (BudgetAmount<=0) THEN
             ERROR(Text0010);
        
            //check if the actuals plus the amount is greater then the budget amount
            IF ((ImprestLine."Net Amount") > BudgetAmount) AND (BCSetup."Allow OverExpenditure"=FALSE) THEN BEGIN
              ERROR(Text0011,
              ImprestLine."Document No.",ImprestLine."Account Type" ,ImprestLine."Account No.",
              FORMAT(ABS(BudgetAmount-(ActualsAmount+ImprestLine."Net Amount"))));
            END ELSE BEGIN
            MESSAGE('Budget test passed');
            */
            //Commit Amounts
        
            Commitments.Init;
            Commitments.Date:=Today;
            Commitments."Posting Date":=Imprestheader."Posting Date";
            Commitments."Document Type":=Imprestheader."Document Type"::Imprest;;
            Commitments."Document No.":=Imprestheader."No.";
            Commitments.Amount:=ImprestLine."Net Amount";
            Commitments."Month Budget":=BudgetAmount;
            Commitments.Committed:=true;
            Commitments."Committed By":=UserId;
            Commitments."Committed Date":=Imprestheader."Posting Date";
            Commitments."G/L Account No.":=BudgetGL;
            Commitments."Committed Time":=Time;
            Commitments."Shortcut Dimension 1 Code":=ImprestLine."Global Dimension 1 Code";
            Commitments."Shortcut Dimension 2 Code":=ImprestLine."Global Dimension 2 Code";
            Commitments."Shortcut Dimension 3 Code":=ImprestLine."Shortcut Dimension 3 Code";
            Commitments."Shortcut Dimension 4 Code":=ImprestLine."Shortcut Dimension 4 Code";
            Commitments.Budget:=BCSetup."Current Budget Code";
            Commitments.Type:=Commitments.Type::" ";
            Commitments.Committed:=true;
           if  Commitments.Insert(true) then
           begin
           ImprestLine."Budget Committed":=true;
           ImprestLine.Modify;
           end;
          until ImprestLine.Next=0;
        end;

    end;

    procedure CalcBudgetGLBudgetAvailAmt(var Imprestheader: Record "Imprest Header")
    var
        ImprestLine: Record "Imprest Line";
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        Items: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
    begin
        BCSetup.Get;
        //check if the dates are within the specified range
        if (Imprestheader."Date From"< BCSetup."Current Budget Start Date") or (Imprestheader."Date To"> BCSetup."Current Budget End Date") then begin
          Error(Text0004,Imprestheader."Date From",
          BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        end;
        
        
        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");
        
        //get the lines related to the Imprest/Petty cash requisition header
        ImprestLine.Reset;
        ImprestLine.SetRange(ImprestLine."Document No.",Imprestheader."No.");
        if ImprestLine.FindSet then begin
          repeat
            /*
            //Items
            IF PurchLine.Type=PurchLine.Type::Item THEN BEGIN
              Items.RESET;
              IF NOT Items.GET(PurchLine."No.") THEN
              ERROR(Text0007);
              Items.TESTFIELD("Item G/L Budget Account");
              BudgetGL:=Items."Item G/L Budget Account";
            END;
            */
            //Fixed Asset
            /*
            IF PurchLine.Type=PurchLine.Type::"Fixed Asset" THEN BEGIN
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
            */
        
           //G/L Account i
            if ImprestLine."Account Type"=ImprestLine."Account Type"::"G/L Account" then
            begin
              BudgetGL:=ImprestLine."Account No.";
              if GLAccount.Get(ImprestLine."Account No.") then
              GLAccount.TestField(GLAccount."Budget Controlled",true);
            end;
            //check the votebook now
            FirstDay:=DMY2Date(1,Date2DMY(Imprestheader."Document Date",2),Date2DMY(Imprestheader."Document Date",3));
            CurrMonth:=Date2DMY(Imprestheader."Document Date",2);
            if CurrMonth=12 then begin
              LastDay:=DMY2Date(1,1,Date2DMY(Imprestheader."Document Date",3) +1);
              LastDay:=CalcDate('-1D',LastDay);
            end else begin
              CurrMonth:=CurrMonth +1;
              LastDay:=DMY2Date(1,CurrMonth,Date2DMY(Imprestheader."Document Date",3));
              LastDay:=CalcDate('-1D',LastDay);
            end;
            GLAccount.Reset;
            GLAccount.SetRange("No.",BudgetGL);
            GLAccount.SetFilter("Date Filter",'%1..%2',FirstDay,LastDay);
            if GLAccount.FindSet then
            GLAccount.CalcFields("Net Change");
        
            ActualsAmount:=GLAccount."Net Change";
        
            //check the summation of the budget
            BudgetAmount:=0;
            Budget.Reset;
            Budget.SetRange(Budget."Budget Name",BCSetup."Current Budget Code");
           // Budget.SETFILTER(Budget.Date,'%1',BCSetup."Current Budget Start Date",FirstDay);
                Budget.SetFilter(Budget.Date,'%1',FirstDay,LastDay);
        
            Budget.SetRange(Budget."G/L Account No.",BudgetGL);
            /*Budget.SETRANGE(Budget."Global Dimension 1 Code",PurchLine."Global Dimension 1 Code");
            Budget.SETRANGE(Budget."Global Dimension 2 Code",PurchLine."Global Dimension 2 Code");
            IF PurchLine."Shortcut Dimension 3 Code" <> '' THEN
             Budget.SETRANGE(Budget."Budget Dimension 3 Code",PurchLine."Shortcut Dimension 3 Code");
            IF PurchLine."Shortcut Dimension 4 Code" <> '' THEN
             Budget.SETRANGE(Budget."Budget Dimension 4 Code",PurchLine."Shortcut Dimension 4 Code");*/
            if Budget.FindSet then begin
             Budget.CalcSums(Amount);
             BudgetAmount:=Budget.Amount;
            end;
        
            //get the committments
        
            CommitmentAmount:=0;
            Commitments.Reset;
            Commitments.SetRange(Commitments.Budget,BCSetup."Current Budget Code");
            Commitments.SetRange(Commitments."G/L Account No.",BudgetGL);
            Commitments.SetRange(Commitments."Posting Date",BCSetup."Current Budget Start Date",LastDay);
            Commitments.SetRange(Commitments."Shortcut Dimension 1 Code",ImprestLine."Global Dimension 1 Code");
            Commitments.SetRange(Commitments."Shortcut Dimension 2 Code",ImprestLine."Global Dimension 2 Code");
            if ImprestLine."Shortcut Dimension 3 Code" <> '' then
             Commitments.SetRange(Commitments."Shortcut Dimension 3 Code",ImprestLine."Shortcut Dimension 3 Code");
            if ImprestLine."Shortcut Dimension 4 Code" <> '' then
             Commitments.SetRange(Commitments."Shortcut Dimension 4 Code",ImprestLine."Shortcut Dimension 4 Code");
            Commitments.CalcSums(Commitments.Amount);
            CommitmentAmount:= Commitments.Amount;
        
            //check if there is any budget
            if (BudgetAmount<=0) then
             Error(Text0010);
        
            //check if the actuals plus the amount plus the commitments is greater then the budget amount
            if ((ImprestLine."Net Amount"+ActualsAmount+CommitmentAmount) > BudgetAmount) and (BCSetup."Allow OverExpenditure"=false) then begin
              Error(Text0011,
              ImprestLine."Document No.",ImprestLine."Account Type" ,ImprestLine."Account No.",
              Format(Abs(BudgetAmount-(CommitmentAmount+ActualsAmount+ImprestLine."Net Amount"))));
            end else begin
            Message('Budget test passed');
        
            //commit Amounts
            /*
            Commitments.INIT;
            Commitments."Line No.":=0;
            Commitments.Date:=TODAY;
            Commitments."Posting Date":=Imprestheader."Document Date";
            Commitments."Document Type":=Imprestheader."Document Type";
            Commitments."Document No.":=Imprestheader."No.";
            Commitments.Amount:=ImprestLine."Net Amount";
            Commitments."Month Budget":=BudgetAmount;
            Commitments.Committed:=TRUE;
            Commitments."Committed By":=USERID;
            Commitments."Committed Date":=Imprestheader."Document Date";
            Commitments."G/L Account No.":=BudgetGL;
            Commitments."Committed Time":=TIME;
            Commitments."Shortcut Dimension 1 Code":=ImprestLine."Global Dimension 1 Code";
            Commitments."Shortcut Dimension 2 Code":=ImprestLine."Global Dimension 2 Code";
            Commitments."Shortcut Dimension 3 Code":=ImprestLine."Shortcut Dimension 3 Code";
            Commitments."Shortcut Dimension 4 Code":=ImprestLine."Shortcut Dimension 4 Code";
            Commitments.Budget:=BCSetup."Current Budget Code";
            Commitments.Type:=Commitments.Type::" ";
            Commitments.Committed:=TRUE;
            IF Commitments.INSERT THEN BEGIN
              ImprestLine."Budget Committed":=TRUE;
              ImprestLine.MODIFY;
             END;
             */
        
            end;
          until ImprestLine.Next=0;
        end;

    end;

    procedure commitImprestGLBudget(var Imprestheader: Record "Imprest Header") Ok: Boolean
    var
        ImprestLine: Record "Imprest Line";
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        Items: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
        CommitmentsCopy: Record "Budget Committment";
    begin
        BCSetup.Get;
        //check if the dates are within the specified range
        if (Imprestheader."Date From"< BCSetup."Current Budget Start Date") or (Imprestheader."Date To"> BCSetup."Current Budget End Date") then begin
          Error(Text0004,Imprestheader."Date From",
          BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        end;
        
        
        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");
        Imprestheader.TestField(Voted,false);
        /*Imprestheader.RESET;
        Imprestheader.SETRANGE(Type,Imprestheader.Type::Imprest);
        Imprestheader.SETRANGE(Voted,TRUE);
        IF Imprestheader.FINDFIRST THEN BEGIN
          ERROR (Text0005);*/
        //END ELSE
        //IF Imprestheader.Type = Imprestheader.Type::Imprest, AND Imprestheader.Type = Imprestheader.Type::"Petty Cash",AND Imprestheader.Voted,TRUE  THEN
        //ERROR (Text0007);
        /*Imprestheader.RESET;
        Imprestheader.SETRANGE(Type,Imprestheader.Type::"Petty Cash");
        Imprestheader.SETRANGE(Voted,TRUE);
        IF Imprestheader.FINDFIRST THEN BEGIN
          ERROR (Text0005);
          END;*/
        //get the lines related to the Imprest/Petty cash requisition header
        ImprestLine.Reset;
        ImprestLine.SetRange(ImprestLine."Document No.",Imprestheader."No.");
        ImprestLine.SetRange(ImprestLine.Committed,false);
        if ImprestLine.FindSet then begin
          repeat
            /*
            //Items
            IF PurchLine.Type=PurchLine.Type::Item THEN BEGIN
              Items.RESET;
              IF NOT Items.GET(PurchLine."No.") THEN
              ERROR(Text0007);
              Items.TESTFIELD("Item G/L Budget Account");
              BudgetGL:=Items."Item G/L Budget Account";
            END;
            */
            //Fixed Asset
            /*
          IF PurchLine.Type=PurchLine.Type::"Fixed Asset" THEN BEGIN
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
            */
            //BudgetGL:=ImprestLine."Budget Gl";
           //G/L Account i
            if ImprestLine."Account Type"=ImprestLine."Account Type"::"G/L Account" then
            begin
              //BudgetGL:=ImprestLine."Account No.";
              if GLAccount.Get(ImprestLine."Account No.") then
              GLAccount.TestField(GLAccount."Budget Controlled",true);
            end;
            //check the votebook now
        
            FirstDay:=DMY2Date(1,Date2DMY(Imprestheader."Document Date",2),Date2DMY(Imprestheader."Document Date",3));
            CurrMonth:=Date2DMY(Imprestheader."Document Date",2);
            if CurrMonth=12 then begin
              LastDay:=DMY2Date(1,1,Date2DMY(Imprestheader."Document Date",3) +1);
              LastDay:=CalcDate('-1D',LastDay);
            end else begin
              CurrMonth:=CurrMonth +1;
              LastDay:=DMY2Date(1,CurrMonth,Date2DMY(Imprestheader."Document Date",3));
              LastDay:=CalcDate('-1D',LastDay);
            end;
            /*GLAccount.RESET;
            GLAccount.SETRANGE("No.",BudgetGL);
            GLAccount.SETFILTER("Date Filter",'%1..%2',FirstDay,LastDay);
            IF GLAccount.FINDSET THEN
            GLAccount.CALCFIELDS("Net Change");
        
            ActualsAmount:=GLAccount."Net Change";*/
        
            //check the summation of the budget
            BudgetAmount:=0;
            Budget.Reset;
            Budget.SetRange(Budget."Budget Name",BCSetup."Current Budget Code");
            Budget.SetFilter(Budget.Date,'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
            Budget.SetRange(Budget."G/L Account No.",BudgetGL);
            /*Budget.SETRANGE(Budget."Global Dimension 1 Code",PurchLine."Global Dimension 1 Code");
            Budget.SETRANGE(Budget."Global Dimension 2 Code",PurchLine."Global Dimension 2 Code");
            IF PurchLine."Shortcut Dimension 3 Code" <> '' THEN
             Budget.SETRANGE(Budget."Budget Dimension 3 Code",PurchLine."Shortcut Dimension 3 Code");
            IF PurchLine."Shortcut Dimension 4 Code" <> '' THEN
             Budget.SETRANGE(Budget."Budget Dimension 4 Code",PurchLine."Shortcut Dimension 4 Code");*/
            if Budget.FindSet then begin
             Budget.CalcSums(Amount);
             BudgetAmount:=Budget.Amount;
            end;
        
            //get the committments
        
            CommitmentAmount:=0;
            Commitments.Reset;
            Commitments.SetRange(Commitments.Budget,BCSetup."Current Budget Code");
            Commitments.SetRange(Commitments."G/L Account No.",BudgetGL);
            Commitments.SetFilter(Commitments."Posting Date",'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        
            /*Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code",PurchLine."Global Dimension 1 Code");
            Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code",PurchLine."Global Dimension 2 Code");
            IF PurchLine."Shortcut Dimension 3 Code" <> '' THEN
             Commitments.SETRANGE(Commitments."Shortcut Dimension 3 Code",PurchLine."Shortcut Dimension 3 Code");
            IF PurchLine."Shortcut Dimension 4 Code" <> '' THEN
             Commitments.SETRANGE(Commitments."Shortcut Dimension 4 Code",PurchLine."Shortcut Dimension 4 Code");*/
        
            Commitments.CalcSums(Commitments.Amount);
            CommitmentAmount:= Commitments.Amount;
        
            //check if there is any budget
            if (BudgetAmount<=0) then
             Error(Text0010);
        
            //check if the actuals plus the amount is greater then the budget amount
           /* IF ((ImprestLine."Net Amount") > BudgetAmount) AND (BCSetup."Allow OverExpenditure"=FALSE) THEN BEGIN
              ERROR(Text0011,
              ImprestLine."Document No.",ImprestLine."Account Type" ,ImprestLine."Account No.",
              FORMAT(ABS(BudgetAmount-(ActualsAmount+ImprestLine."Net Amount"))));
            END ELSE BEGIN
            MESSAGE('Budget test passed');*/
            //check if the actuals plus the amount is greater than the budget amount
            if ((CommitmentAmount + ImprestLine."Net Amount") > BudgetAmount) and (BCSetup."Allow OverExpenditure"=false) then begin
              Error(Text0011,
              ImprestLine."Document No.",ImprestLine."Account Type" ,ImprestLine."Account No.",
              Format(Abs(BudgetAmount-(CommitmentAmount +ImprestLine."Net Amount"))));
            end else begin
        
            //Commit Amounts
        
            Commitments.Init;
            Commitments.Date:=Imprestheader."Posting Date";
            Commitments."Posting Date":=Imprestheader."Posting Date";
            //Commitments."Document Type":=Imprestheader."Document Type"::Imprest;;
            Commitments."Document Type":=Commitments."Document Type"::Imprest;//jm
            Commitments."Document No.":=Imprestheader."No.";
            Commitments.Amount:=ImprestLine."Net Amount";
            Commitments."Month Budget":=BudgetAmount;
            Commitments.Committed:=true;
            Commitments."Committed By":=UserId;
            Commitments."Committed Date":=Imprestheader."Posting Date";
            Commitments."G/L Account No.":=BudgetGL;
            Commitments."Committed Time":=Time;
            Commitments."Shortcut Dimension 1 Code":=ImprestLine."Global Dimension 1 Code";
            Commitments."Shortcut Dimension 2 Code":=ImprestLine."Global Dimension 2 Code";
            Commitments."Shortcut Dimension 3 Code":=ImprestLine."Shortcut Dimension 3 Code";
            Commitments."Shortcut Dimension 4 Code":=ImprestLine."Shortcut Dimension 4 Code";
            Commitments.Budget:=BCSetup."Current Budget Code";
            Commitments.Description:=ImprestLine.Description;
            Commitments.Type:=Commitments.Type::" ";
            Commitments."Budget Balance":=BudgetAmount-(CommitmentAmount +ImprestLine."Net Amount");
            Commitments.Committed:=true;
           if  Commitments.Insert(true) then begin
           ImprestLine."Budget Committed":=true;
           //ImprestLine."Budget Balance" := BudgetAmount-(CommitmentAmount +ImprestLine."Net Amount");
           //ImprestLine."Amount Committed" := ImprestLine."Net Amount";
           //ImprestLine."Total Commitment Before" := CommitmentAmount;
           ImprestLine.Committed:=true;//
           ImprestLine.Modify;
           end;
        
        end;
          until ImprestLine.Next=0;
        
        Imprestheader.Voted:=true;
        Imprestheader.Modify;
        
        end;

    end;

    procedure commitPaymentsGLBudget(var PaymentHeader: Record "Payment Header") Ok: Boolean
    var
        PayemntLIne: Record "Payment Line";
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        Items: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
        CommitmentsCopy: Record "Budget Committment";
    begin
        BCSetup.Get;
        //check if the dates are within the specified range
        if (PaymentHeader."Document Date"< BCSetup."Current Budget Start Date") or (PaymentHeader."Document Date"> BCSetup."Current Budget End Date") then begin
          Error(Text0004,ImprestHeader."Date From",
          BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        end;
        
        
        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");
        PaymentHeader.TestField(Voted,false);
        /*Imprestheader.RESET;
        Imprestheader.SETRANGE(Type,Imprestheader.Type::Imprest);
        Imprestheader.SETRANGE(Voted,TRUE);
        IF Imprestheader.FINDFIRST THEN BEGIN
          ERROR (Text0005);*/
        //END ELSE
        //IF Imprestheader.Type = Imprestheader.Type::Imprest, AND Imprestheader.Type = Imprestheader.Type::"Petty Cash",AND Imprestheader.Voted,TRUE  THEN
        //ERROR (Text0007);
        /*Imprestheader.RESET;
        Imprestheader.SETRANGE(Type,Imprestheader.Type::"Petty Cash");
        Imprestheader.SETRANGE(Voted,TRUE);
        IF Imprestheader.FINDFIRST THEN BEGIN
          ERROR (Text0005);
          END;*/
        //get the lines related to the Imprest/Petty cash requisition header
        PayemntLIne.Reset;
        PayemntLIne.SetRange(PayemntLIne."Document No.",PaymentHeader."No.");
        PayemntLIne.SetRange(PayemntLIne.Committed,false);
        if PayemntLIne.FindSet then begin
          repeat
             BudgetGL:=PayemntLIne."Budget Gl";
           //G/L Account i
            if PayemntLIne."Account Type"=PayemntLIne."Account Type"::"G/L Account" then
            begin
              //BudgetGL:=ImprestLine."Account No.";
              if GLAccount.Get(PayemntLIne."Account No.") then
              GLAccount.TestField(GLAccount."Budget Controlled",true);
            end;
            //check the votebook now
        
            FirstDay:=DMY2Date(1,Date2DMY(PaymentHeader."Document Date",2),Date2DMY(PaymentHeader."Document Date",3));
            CurrMonth:=Date2DMY(PaymentHeader."Document Date",2);
            if CurrMonth=12 then begin
              LastDay:=DMY2Date(1,1,Date2DMY(PaymentHeader."Document Date",3) +1);
              LastDay:=CalcDate('-1D',LastDay);
            end else begin
              CurrMonth:=CurrMonth +1;
              LastDay:=DMY2Date(1,CurrMonth,Date2DMY(PaymentHeader."Document Date",3));
              LastDay:=CalcDate('-1D',LastDay);
            end;
               //check the summation of the budget
            BudgetAmount:=0;
            Budget.Reset;
            Budget.SetRange(Budget."Budget Name",BCSetup."Current Budget Code");
            Budget.SetFilter(Budget.Date,'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
            Budget.SetRange(Budget."G/L Account No.",BudgetGL);
            if Budget.FindSet then begin
             Budget.CalcSums(Amount);
             BudgetAmount:=Budget.Amount;
            end;
        
            //get the committments
        
            CommitmentAmount:=0;
            Commitments.Reset;
            Commitments.SetRange(Commitments.Budget,BCSetup."Current Budget Code");
            Commitments.SetRange(Commitments."G/L Account No.",BudgetGL);
            Commitments.SetFilter(Commitments."Posting Date",'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
            Commitments.CalcSums(Commitments.Amount);
            CommitmentAmount:= Commitments.Amount;
        
            //check if there is any budget
            if (BudgetAmount<=0) then
             Error(Text0010);
        
            //check if the actuals plus the amount is greater than the budget amount
            if ((CommitmentAmount + PayemntLIne."Net Amount") > BudgetAmount) and (BCSetup."Allow OverExpenditure"=false) then begin
              Error(Text0011,
              PayemntLIne."Document No.",PayemntLIne."Account Type" ,PayemntLIne."Account No.",
              Format(Abs(BudgetAmount-(CommitmentAmount +PayemntLIne."Net Amount"))));
            end else begin
        
            //Commit Amounts
        
            Commitments.Init;
            Commitments.Date:=PaymentHeader."Posting Date";
            Commitments."Posting Date":=PaymentHeader."Posting Date";
            //Commitments."Document Type":=Imprestheader."Document Type"::Imprest;;
            Commitments."Document Type":=Commitments."Document Type"::"Payment Voucher";//jm
            Commitments."Document No.":=PaymentHeader."No.";
            Commitments.Amount:=PayemntLIne."Net Amount";
            Commitments."Month Budget":=BudgetAmount;
            Commitments.Committed:=true;
            Commitments."Committed By":=UserId;
            Commitments."Committed Date":=PaymentHeader."Posting Date";
            Commitments."G/L Account No.":=BudgetGL;
            Commitments."Committed Time":=Time;
            Commitments."Shortcut Dimension 1 Code":=PayemntLIne."Global Dimension 1 Code";
            Commitments."Shortcut Dimension 2 Code":=PayemntLIne."Global Dimension 2 Code";
            Commitments."Shortcut Dimension 3 Code":=PayemntLIne."Shortcut Dimension 3 Code";
            Commitments."Shortcut Dimension 4 Code":=PayemntLIne."Shortcut Dimension 4 Code";
            Commitments.Budget:=BCSetup."Current Budget Code";
            Commitments.Description:=PayemntLIne.Description;
            Commitments.Type:=Commitments.Type::" ";
            Commitments."G/L Account No.":=BudgetGL;
            Commitments."Budget Balance":=BudgetAmount-(CommitmentAmount +PayemntLIne."Net Amount");
            Commitments.Committed:=true;
           if  Commitments.Insert(true) then begin
           //PayemntLIne."Budget Committed":=TRUE;
          // PayemntLIne."Budget Balance" := BudgetAmount-(CommitmentAmount +PayemntLIne."Net Amount");
          // PayemntLIne."Amount Committed" := PayemntLIne."Net Amount";
          // PayemntLIne."Total Commitment Before" := CommitmentAmount;
           PayemntLIne.Committed:=true;//
           PayemntLIne.Modify;
           end;
        
        end;
          until PayemntLIne.Next=0;
        
        PaymentHeader.Voted:=true;
        PaymentHeader.Modify;
        
        end;

    end;

    procedure CancelBudgetCommitmentimprest(ImprestHeader: Record "Imprest Header")
    var
        Commitments: Record "Budget Committment";
        EntryNo: Integer;
        ImprestLine: Record "Imprest Line";
        BudgetAmount: Decimal;
        Items: Record Item;
        FixedAsset: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        CommitmentsCopy: Record "Budget Committment";
        GLAccount: Record "G/L Account";
        CommitmentAmount: Decimal;
    begin
        BCSetup.Get;
        //check if the dates are within the specified range
        if (ImprestHeader."Document Date"< BCSetup."Current Budget Start Date") or (ImprestHeader."Document Date"> BCSetup."Current Budget End Date") then begin
          Error(Text0004,ImprestHeader."Document Date",
          BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        end;
        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");
        //ImprestHeader.TESTFIELD(Voted,TRUE);
        //get the lines related to the purchase requisition header
        ImprestLine.Reset;
        ImprestLine.SetRange(ImprestLine."Document No.",ImprestHeader."No.");
        if ImprestLine.FindSet then begin
          repeat

              //BudgetGL:=ImprestLine."Budget Gl";
            //END;
           //G/L Account
           if ImprestLine."Account Type"= ImprestLine."Account Type"::"G/L Account" then begin
            //IF ImprestLine."Account Type"
              //BudgetGL:=ImprestLine."Budget Gl";
              if GLAccount.Get(ImprestLine."Account No.") then
              GLAccount.TestField(GLAccount."Budget Controlled",true);
            end;
            BudgetGL:=BudgetGL;

            Commitments.Reset;
            Commitments.SetRange(Commitments.Budget,BCSetup."Current Budget Code");
            Commitments.SetRange(Commitments."G/L Account No.",BudgetGL);
            Commitments.SetRange(Commitments."Posting Date",BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
            Commitments.CalcSums(Commitments.Amount);
            CommitmentAmount:= Commitments.Amount;
                //decommit Amounts
            Commitments.Init;
            Commitments."Line No.":=0;
            Commitments.Date:=ImprestHeader."Document Date";
            Commitments."Posting Date":=Today;
            Commitments."Document Type":=Commitments."Document Type"::Requisition;
            Commitments."Document No.":=ImprestHeader."No.";
            Commitments.Amount:=-ImprestLine."Net Amount";
            Commitments."Month Budget":=BudgetAmount;
            Commitments."Month Actual":=CommitmentAmount+ImprestLine."Net Amount";
            Commitments.Committed:=true;
            Commitments."Committed By":=UserId;
            Commitments."Committed Date":=Today;
            Commitments."G/L Account No.":=BudgetGL;
            Commitments."Committed Time":=Time;
            Commitments."Shortcut Dimension 1 Code":=ImprestLine."Global Dimension 1 Code";
            Commitments."Shortcut Dimension 2 Code":=ImprestLine."Global Dimension 2 Code";
            Commitments."Shortcut Dimension 3 Code":=ImprestLine."Shortcut Dimension 3 Code";
            Commitments."Shortcut Dimension 4 Code":=ImprestLine."Shortcut Dimension 4 Code";
            Commitments.Budget:=BCSetup."Current Budget Code";
            Commitments.Cancelled:=true;
            Commitments."Cancelled By":=UserId;
            Commitments."Cancelled Date":=Today;
            Commitments."Cancelled Time":=Time;
            Commitments."G/L Account No.":=BudgetGL;
            if GLAccount.Get(Commitments."G/L Account No.") then
              Commitments."G/L Name":=GLAccount.Name;
            Commitments.Description:=ImprestLine.Description;
            Commitments."G/L Account No.":=BudgetGL;
            Commitments.Type:=Commitments.Type::Vendor;
            Commitments."Budget Balance" := BudgetAmount-(CommitmentAmount +ImprestLine."Net Amount");
            Commitments.Committed:=true;
            if Commitments.Insert then begin
              ImprestLine.Committed:=false;
            // ImprestLine."Budget Gl":=BudgetGL;
             //ImprestLine."Budget Balance" := BudgetAmount-(CommitmentAmount +ImprestLine."Net Amount");
             /// ImprestLine."Amount Committed" := ImprestLine."Net Amount";
              if ImprestHeader.Status = ImprestHeader.Status::Cancelled then
                ImprestLine.Status:=ImprestLine.Status::Open;
              end else
              ImprestLine.Status:=ImprestLine.Status::Released;
              //ImprestLine."Total Commitment Before" := CommitmentAmount;
              ImprestLine.Modify;
             //END;
            //END;
          until ImprestLine.Next=0;
          ImprestHeader.Voted:=false;
          ImprestHeader.Modify;
        end;
    end;

    procedure CommitBudgetPayroll(Periods: Record Periods)
    var
        PayrollLines: Record "Payroll Lines";
    begin
        BCSetup.Get;
        //check if the dates are within the specified range
        if (Periods."Start Date"< BCSetup."Current Budget Start Date") or (Periods."End Date"> BCSetup."Current Budget End Date") then begin
               Error(Text0004,Periods."Start Date",
               BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
           end;
        //Check mandatory fields in periods;
        //Periods.TESTFIELD(Voted,FALSE);
            Periods.TestField("Approval Status",Periods."Approval Status"::Approved);
         Periods.TestField(Status,Periods.Status::Open);
        //get the lines related to the Period
        PayrollLines.Reset;
          PayrollLines.SetRange("Payroll ID",Periods."Period ID");
          PayrollLines.SetRange("Payroll Code",Periods."Payroll Code");
        if PayrollLines.FindSet then begin
          repeat
        
           EdDefinition.Reset;
           EdDefinition.SetRange("ED Code",PayrollLines."ED Code");
           //EdDefinition.SETRANGE("Voting Required",TRUE);
           if EdDefinition.FindFirst then begin
                   PostingSetup.Reset;
                   PostingSetup.SetRange("ED Posting Group",EdDefinition."ED Posting Group");
                   //PostingSetup.SETRANGE("Vote Required",TRUE);
                   PostingSetup.SetRange("Payroll Code",Periods."Payroll Code");
                     if BudgetGL<> '' then
                     Error('The Debit Account No is empty');
                    if PostingSetup.FindFirst then
                     BudgetGL:=PostingSetup."Debit Account";
        
        
            if GLAccount.Get(PostingSetup."ED Posting Group") then
              GLAccount.TestField(GLAccount."Budget Controlled",true);
        
            BudgetAmount:=0;
            Budget.Reset;
            Budget.SetRange(Budget."Budget Name",BCSetup."Current Budget Code");
            //Budget.SETFILTER(Budget.Date,'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
            Budget.SetRange(Budget."G/L Account No.",BudgetGL);
               if Budget.FindSet then begin
             Budget.CalcSums(Amount);
             BudgetAmount:=Budget.Amount;
            end;
        
        
                   Commitments.Amount:=0;
                   Commitments.Reset;
                   //Commitments.SETRANGE("Document No.",Periods."Period ID");
                   //Commitments.SETRANGE("G/L Account No.",BudgetGL);
                   if Commitments.FindFirst then begin
                   //Commitments.Amount:=Commitments.Amount +PayrollLines."Amount (LCY)";
                   //Commitments.MODIFY;
                 //  ERROR('Justo Debugging');
                end else begin
                    Commitments.Init;
                    Commitments."Line No.":=0;
                    Commitments.Date:=Today;
                    Commitments."Posting Date":=Periods."Posting Date";
                    //Commitments."Document Type":=Commitments."Document Type"::Requisition;
                    Commitments."Document No.":=Periods."Period ID";
                    Commitments.Amount:=PayrollLines."Amount (LCY)";
                    Commitments."Month Budget":=BudgetAmount;
                    //Commitments."Month Actual":=CommitmentAmount+PurchLine."Total Cost(LCY)";
                    Commitments.Committed:=true;
                    Commitments."Committed By":=UserId;
                    Commitments."Committed Date":=Today;
                    Commitments."G/L Account No.":=BudgetGL;
                    Commitments."Committed Time":=Time;
                    Commitments.Description:=Periods."Period ID";
                    Commitments.Budget:=BCSetup."Current Budget Code";
                    Commitments.Type:=Commitments.Type::Vendor;
                    Commitments.Committed:=true;
                    Commitments.Insert;
                   // IF Commitments.INSERT THEN BEGIN
        end;
        end;
        until PayrollLines.Next=0;
        end;
        
        
        
        
        
        /*BCSetup.GET;
        //check if the dates are within the specified range
        IF (PurchHeader."Document Date"< BCSetup."Current Budget Start Date") OR (PurchHeader."Document Date"> BCSetup."Current Budget End Date") THEN BEGIN
          ERROR(Text0004,PurchHeader."Document Date",
          BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        END;
        
        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");
        
        PurchHeader.TESTFIELD(PurchHeader.Voted,FALSE);
        //get the lines related to the purchase requisition header
        PurchLine.RESET;
        PurchLine.SETRANGE(PurchLine."Document No.",PurchHeader."No.");
        IF PurchLine.FINDSET THEN BEGIN
          REPEAT
            //Items
           { IF PurchLine.Type=PurchLine.Type::Item THEN BEGIN
              Items.RESET;
              IF NOT Items.GET(PurchLine."No.") THEN
              ERROR(Text0007);
              Items.TESTFIELD("Item G/L Budget Account");
              BudgetGL:=Items."Item G/L Budget Account";
            END;
        
            //Fixed Asset
            IF PurchLine.Type=PurchLine.Type::"Charge (Item)" THEN BEGIN
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
            END;}
        
           //G/L Account
            IF PurchLine.Type=PurchLine.Type::"G/L Account" THEN BEGIN
              BudgetGL:=PurchLine."No.";
              IF GLAccount.GET(PurchLine."No.") THEN
              GLAccount.TESTFIELD(GLAccount."Budget Controlled",TRUE);
            END;
        
            BudgetGL:=PurchLine."Budget GL";
        
            //check the votebook now
            FirstDay:=DMY2DATE(1,DATE2DMY(PurchHeader."Document Date",2),DATE2DMY(PurchHeader."Document Date",3));
            CurrMonth:=DATE2DMY(PurchHeader."Document Date",2);
            IF CurrMonth=12 THEN BEGIN
              LastDay:=DMY2DATE(1,1,DATE2DMY(PurchHeader."Document Date",3) +1);
              LastDay:=CALCDATE('-1D',LastDay);
            END ELSE BEGIN
              CurrMonth:=CurrMonth +1;
              LastDay:=DMY2DATE(1,CurrMonth,DATE2DMY(PurchHeader."Document Date",3));
              LastDay:=CALCDATE('-1D',LastDay);
            END;
        
            //check the summation of the budget
            BudgetAmount:=0;
            ActualsAmount:=0;
            Budget.RESET;
            Budget.SETRANGE(Budget."Budget Name",BCSetup."Current Budget Code");
            Budget.SETFILTER(Budget.Date,'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
            Budget.SETRANGE(Budget."G/L Account No.",BudgetGL);
             //Budget.SETRANGE(Budget."Global Dimension 1 Code",PurchLine."Global Dimension 1 Code");
            {Budget.SETRANGE(Budget."Global Dimension 2 Code",PurchLine."Global Dimension 2 Code");
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
            Commitments.SETRANGE(Commitments."Posting Date",BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
           // Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code",PurchLine."Global Dimension 1 Code");
           { Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code",PurchLine."Global Dimension 2 Code");
            IF PurchLine."Shortcut Dimension 3 Code" <> '' THEN
             Commitments.SETRANGE(Commitments."Shortcut Dimension 3 Code",PurchLine."Shortcut Dimension 3 Code");
            IF PurchLine."Shortcut Dimension 4 Code" <> '' THEN
             Commitments.SETRANGE(Commitments."Shortcut Dimension 4 Code",PurchLine."Shortcut Dimension 4 Code");}
            Commitments.CALCSUMS(Commitments.Amount);
            CommitmentAmount:= Commitments.Amount;
        
            //check if there is any budget
            IF (BudgetAmount<=0) THEN
             ERROR(Text0010);
        
            //check if the actuals plus the amount is greater than the budget amount
            IF ((CommitmentAmount + PurchLine."Total Cost(LCY)") > BudgetAmount) AND (BCSetup."Allow OverExpenditure"=FALSE) THEN BEGIN
              ERROR(Text0011,
              PurchLine."Document No.",PurchLine.Type ,PurchLine."No.",
              FORMAT(ABS(BudgetAmount-(CommitmentAmount +PurchLine."Total Cost"))));
            END ELSE BEGIN
            //commit Amounts
        
            Commitments.INIT;
            Commitments."Line No.":=0;
            Commitments.Date:=PurchHeader."Document Date";
            Commitments."Posting Date":=PurchHeader."Document Date";
            Commitments."Document Type":=Commitments."Document Type"::Requisition;
            Commitments."Document No.":=PurchHeader."No.";
            Commitments.Amount:=PurchLine."Total Cost";
            Commitments."Month Budget":=BudgetAmount;
            Commitments."Month Actual":=CommitmentAmount+PurchLine."Total Cost(LCY)";
            Commitments.Committed:=TRUE;
            Commitments."Committed By":=USERID;
            Commitments."Committed Date":=PurchHeader."Document Date";
            Commitments."G/L Account No.":=BudgetGL;
            //Commitments."G/L Name":=b
            Commitments."Committed Time":=TIME;
            Commitments."Shortcut Dimension 1 Code":=PurchLine."Global Dimension 1 Code";
            Commitments."Shortcut Dimension 2 Code":=PurchLine."Global Dimension 2 Code";
            Commitments."Shortcut Dimension 3 Code":=PurchLine."Shortcut Dimension 3 Code";
            Commitments."Shortcut Dimension 4 Code":=PurchLine."Shortcut Dimension 4 Code";
        
            IF PurchLine.Name<>PurchLine.Description THEN
            Commitments.Description:=PurchLine.Name +'-'+PurchLine.Description
            ELSE
            Commitments.Description:=PurchLine.Name;
        
            Commitments.Budget:=BCSetup."Current Budget Code";
            Commitments.Type:=Commitments.Type::Vendor;
            Commitments."Vendor/Cust No.":= PurchLine."Vendor No";
            Commitments."Budget Balance" := BudgetAmount-(CommitmentAmount +PurchLine."Total Cost");
        
            Commitments.Committed:=TRUE;
            IF Commitments.INSERT THEN BEGIN
              PurchLine.Committed:=TRUE;
              PurchLine."Budget Balance" := BudgetAmount-(CommitmentAmount +PurchLine."Total Cost");
              PurchLine."Amount Committed" := PurchLine."Total Cost";
              PurchLine."Total Commitment Before" := CommitmentAmount;
              PurchLine.MODIFY;
             END;
            END;
          UNTIL PurchLine.NEXT=0;
        
        PurchHeader.Voted := TRUE;
        PurchHeader.MODIFY;
        END;*/

    end;

    procedure CommitjounalVoucher(var JournalVoucher: Record "Journal Voucher Header")
    var
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
        CommitmentsCopy: Record "Budget Committment";
    begin
        BCSetup.Get;
        //check if the dates are within the specified range
        if (JournalVoucher."Document date"< BCSetup."Current Budget Start Date") or (JournalVoucher."Document date"> BCSetup."Current Budget End Date") then begin
          Error(Text0004,JournalVoucher."Document date",
          BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        end;
        
        JournalVoucher.TestField(Voted,false);
        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");
        
        /*Imprestheader.RESET;
        Imprestheader.SETRANGE(Imprestheader."No.");
        IF Imprestheader.FINDSET THEN BEGIN
          REPEAT*/
        
            BudgetGL:=JournalVoucher."Budget GL";
        
        
            FirstDay:=DMY2Date(1,Date2DMY(JournalVoucher."Document date",2),Date2DMY(JournalVoucher."Document date",3));
            CurrMonth:=Date2DMY(JournalVoucher."Document date",2);
            if CurrMonth=12 then begin
              LastDay:=DMY2Date(1,1,Date2DMY(JournalVoucher."Document date",3) +1);
              LastDay:=CalcDate('-1D',LastDay);
            end else begin
              CurrMonth:=CurrMonth +1;
              LastDay:=DMY2Date(1,CurrMonth,Date2DMY(JournalVoucher."Document date",3));
              LastDay:=CalcDate('-1D',LastDay);
            end;
        
            BudgetAmount:=0;
            Budget.Reset;
            Budget.SetRange(Budget."Budget Name",BCSetup."Current Budget Code");
            Budget.SetFilter(Budget.Date,'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
            Budget.SetRange(Budget."G/L Account No.",BudgetGL);
            /*Budget.SETRANGE(Budget."Global Dimension 1 Code",PurchLine."Global Dimension 1 Code");
            Budget.SETRANGE(Budget."Global Dimension 2 Code",PurchLine."Global Dimension 2 Code");
            IF PurchLine."Shortcut Dimension 3 Code" <> '' THEN
             Budget.SETRANGE(Budget."Budget Dimension 3 Code",PurchLine."Shortcut Dimension 3 Code");
            IF PurchLine."Shortcut Dimension 4 Code" <> '' THEN
             Budget.SETRANGE(Budget."Budget Dimension 4 Code",PurchLine."Shortcut Dimension 4 Code");*/
            if Budget.FindSet then begin
             Budget.CalcSums(Amount);
             BudgetAmount:=Budget.Amount;
            end;
        
            //get the committments
        
            CommitmentAmount:=0;
            Commitments.Reset;
            Commitments.SetRange(Commitments.Budget,BCSetup."Current Budget Code");
            Commitments.SetRange(Commitments."G/L Account No.",BudgetGL);
            Commitments.SetFilter(Commitments."Posting Date",'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        
            /*Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code",PurchLine."Global Dimension 1 Code");
            Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code",PurchLine."Global Dimension 2 Code");
            IF PurchLine."Shortcut Dimension 3 Code" <> '' THEN
             Commitments.SETRANGE(Commitments."Shortcut Dimension 3 Code",PurchLine."Shortcut Dimension 3 Code");
            IF PurchLine."Shortcut Dimension 4 Code" <> '' THEN
             Commitments.SETRANGE(Commitments."Shortcut Dimension 4 Code",PurchLine."Shortcut Dimension 4 Code");*/
        
            Commitments.CalcSums(Commitments.Amount);
            CommitmentAmount:= Commitments.Amount;
        
            //check if there is any budget
            if (BudgetAmount<=0) then
             Error(Text0010);
        
            //check if the actuals plus the amount is greater then the budget amount
           /* IF ((ImprestLine."Net Amount") > BudgetAmount) AND (BCSetup."Allow OverExpenditure"=FALSE) THEN BEGIN
              ERROR(Text0011,
              ImprestLine."Document No.",ImprestLine."Account Type" ,ImprestLine."Account No.",
              FORMAT(ABS(BudgetAmount-(ActualsAmount+ImprestLine."Net Amount"))));
            END ELSE BEGIN
            MESSAGE('Budget test passed');*/
            //check if the actuals plus the amount is greater than the budget amount
            if ((CommitmentAmount + JournalVoucher."Total Debit") > BudgetAmount) and (BCSetup."Allow OverExpenditure"=false) then begin
              Error(Text0011,
              JournalVoucher."JV No.",JournalVoucher."Document date" ,JournalVoucher."Budget GL",
              Format(Abs(BudgetAmount-(CommitmentAmount +JournalVoucher."Total Debit"))));
            end else begin
        
            //Commit Amounts
        
            Commitments.Init;
            Commitments.Date:=JournalVoucher."Date Created";
            Commitments."Posting Date":=Today;
            Commitments."Document Type":=Commitments."Document Type"::"Journal Voucher";
            Commitments."Document No.":=JournalVoucher."JV No.";
            Commitments.Amount:=JournalVoucher."Total Debit";
            Commitments."Month Budget":=BudgetAmount;
            Commitments."Month Actual":=CommitmentAmount +JournalVoucher."Total Debit";
            Commitments.Committed:=true;
            Commitments."Committed By":=UserId;
            Commitments."Committed Date":=Today;
            Commitments."G/L Account No.":=BudgetGL;
            Commitments."Committed Time":=Time;
           /* Commitments."Shortcut Dimension 1 Code":=EmployeeRequisition."Global Dimension 1 Code";
            Commitments."Shortcut Dimension 2 Code":=EmployeeRequisition."Global Dimension 2 Code";
            Commitments."Shortcut Dimension 3 Code":=EmployeeRequisition."Shortcut Dimension 3 Code";
            Commitments."Shortcut Dimension 4 Code":=EmployeeRequisition."Shortcut Dimension 4 Code";*/
            Commitments.Budget:=BCSetup."Current Budget Code";
            Commitments.Type:=Commitments.Type::" ";
            Commitments."Employee Name":=JournalVoucher."User ID";
            Commitments.Description:=JournalVoucher.Description;
            Commitments."Budget Balance":=BudgetAmount-(CommitmentAmount +JournalVoucher."Total Debit");
            Commitments.Committed:=true;
            if GLAccount.Get(Commitments."G/L Account No.") then
            Commitments."G/L Name":=GLAccount.Name;
           if  Commitments.Insert(true) then begin
          // EmployeeRequisition."Committed Budget":=TRUE;
           //JournalVoucher."Budget Balance" := BudgetAmount-(CommitmentAmount +JournalVoucher."Total Debit");
           //JournalVoucher."Amount Committed" := JournalVoucher."Total Debit";
           //JournalVoucher."Total Commitment Before" := CommitmentAmount;
           JournalVoucher.Modify;
           end;
        
        //END;
          //UNTIL ImprestLine.NEXT=0;
        
        JournalVoucher.Voted:=true;
        JournalVoucher.Modify;
        
        end;

    end;

    procedure ReverseJournalVoucherBudget(JournalVoucher: Record "Journal Voucher Header")
    var
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
        CommitmentsCopy: Record "Budget Committment";
    begin
        BCSetup.Get;
        //check if the dates are within the specified range
        if (JournalVoucher."Document date"< BCSetup."Current Budget Start Date") or (JournalVoucher."Document date"> BCSetup."Current Budget End Date") then begin
          Error(Text0004,JournalVoucher."Document date",
          BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        end;

        JournalVoucher.TestField(Voted,true);
        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");



            BudgetGL:=JournalVoucher."Budget GL";


            FirstDay:=DMY2Date(1,Date2DMY(JournalVoucher."Document date",2),Date2DMY(JournalVoucher."Document date",3));
            CurrMonth:=Date2DMY(JournalVoucher."Document date",2);
            if CurrMonth=12 then begin
              LastDay:=DMY2Date(1,1,Date2DMY(JournalVoucher."Document date",3) +1);
              LastDay:=CalcDate('-1D',LastDay);
            end else begin
              CurrMonth:=CurrMonth +1;
              LastDay:=DMY2Date(1,CurrMonth,Date2DMY(JournalVoucher."Document date",3));
              LastDay:=CalcDate('-1D',LastDay);
            end;

            BudgetAmount:=0;
            Budget.Reset;
            Budget.SetRange(Budget."Budget Name",BCSetup."Current Budget Code");
            Budget.SetFilter(Budget.Date,'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
            Budget.SetRange(Budget."G/L Account No.",BudgetGL);
            if Budget.FindSet then begin
             Budget.CalcSums(Amount);
             BudgetAmount:=Budget.Amount;
            end;

            //get the committments

            CommitmentAmount:=0;
            Commitments.Reset;
            Commitments.SetRange(Commitments.Budget,BCSetup."Current Budget Code");
            Commitments.SetRange(Commitments."G/L Account No.",BudgetGL);
            Commitments.SetFilter(Commitments."Posting Date",'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");

              Commitments.CalcSums(Commitments.Amount);
            CommitmentAmount:= Commitments.Amount;

            //check if there is any budget
            if (BudgetAmount<=0) then
             Error(Text0010);

              //check if the actuals plus the amount is greater than the budget amount
            if ((CommitmentAmount + JournalVoucher."Total Debit") > BudgetAmount) and (BCSetup."Allow OverExpenditure"=false) then begin
              Error(Text0011,
              JournalVoucher."JV No.",JournalVoucher."Posting Date" ,JournalVoucher."Budget GL",
              Format(Abs(BudgetAmount-(CommitmentAmount +JournalVoucher."Total Debit"))));
            end else begin

            //Commit Amounts

            Commitments.Init;
            Commitments.Date:=JournalVoucher."Document date";
            Commitments."Posting Date":=Today;
            Commitments."Document Type":=Commitments."Document Type"::"Journal Voucher";
            Commitments."Document No.":=JournalVoucher."JV No.";
            Commitments.Amount:=-JournalVoucher."Total Debit";
            Commitments."Month Budget":=BudgetAmount;
            Commitments.Committed:=true;
            Commitments."Committed By":=UserId;
            Commitments."Committed Date":=Today;
            Commitments."G/L Account No.":=BudgetGL;
            Commitments."Committed Time":=Time;
            Commitments.Budget:=BCSetup."Current Budget Code";
            Commitments.Type:=Commitments.Type::" ";
            Commitments."Employee Name":=JournalVoucher."User ID";
            Commitments.Description:=JournalVoucher.Description;
            Commitments."Budget Balance":=BudgetAmount-(CommitmentAmount +JournalVoucher."Total Debit");
            Commitments.Committed:=true;
            if GLAccount.Get(Commitments."G/L Account No.") then
              Commitments."G/L Name":=GLAccount.Name;
           if  Commitments.Insert(true) then begin
          // EmployeeRequisition."Committed Budget":=TRUE;
           //JournalVoucher."Budget Balance" := BudgetAmount-(CommitmentAmount +JournalVoucher."Total Debit");
           //JournalVoucher."Amount Committed" := JournalVoucher."Total Debit";
           //JournalVoucher."Total Commitment Before" := CommitmentAmount;
           JournalVoucher.Modify;
           end;

        JournalVoucher.Voted:=false;
        JournalVoucher.Modify;

        end;
    end;
}

