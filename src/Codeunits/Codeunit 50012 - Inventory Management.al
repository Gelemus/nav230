codeunit 50012 "Inventory Management"
{

    trigger OnRun()
    begin
    end;

    var
        Txt001: Label 'Store requisition No.:%1 is already posted.';

    procedure CheckStoreRequisitionMandatoryFields("Store Requisition Header": Record "Store Requisition Header"; Posting: Boolean)
    var
        StoreRequisitionHeader: Record "Store Requisition Header";
        StoreRequisitionLine: Record "Store Requisition Line";
    begin
        StoreRequisitionHeader.TransferFields("Store Requisition Header", true);

        StoreRequisitionHeader.TestField("Document Date");
        StoreRequisitionHeader.TestField("Posting Date");
        StoreRequisitionHeader.TestField("Required Date");
        StoreRequisitionHeader.TestField(Description);
        //StoreRequisitionHeader.TESTFIELD("Global Dimension 1 Code");
        if Posting then begin
            StoreRequisitionHeader.TestField(Status, StoreRequisitionHeader.Status::Approved);
        end;

        StoreRequisitionLine.Reset;
        StoreRequisitionLine.SetRange(StoreRequisitionLine."Document No.", StoreRequisitionHeader."No.");
        if StoreRequisitionLine.FindSet then begin
            StoreRequisitionLine.TestField("Item No.");
            // StoreRequisitionLine.TESTFIELD("Location Code");
            StoreRequisitionLine.TestField(Quantity);
            StoreRequisitionLine.TestField("Unit of Measure Code");
            //StoreRequisitionLine.TESTFIELD(Description);
            StoreRequisitionLine.TestField("Global Dimension 1 Code");
            //StoreRequisitionLine.TESTFIELD("Global Dimension 2 Code");
            //StoreRequisitionLine.TESTFIELD("Shortcut Dimension 3 Code");
            // StoreRequisitionLine.TESTFIELD("Shortcut Dimension 4 Code");
            //StoreRequisitionLine.TESTFIELD("Shortcut Dimension 5 Code");
            // StoreRequisitionLine.TESTFIELD("Shortcut Dimension 6 Code");
        end else begin
            Error('');
        end;
    end;

    procedure PostStoreRequisition("Store Requisition Header": Record "Store Requisition Header"; JTemplate: Code[10]; JBatch: Code[10])
    var
        "LineNo.": Integer;
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemJnlLine: Record "Item Journal Line";
        StoreRequisitionHeader: Record "Store Requisition Header";
        StoreRequisitionLine: Record "Store Requisition Line";
        StoreRequisitionHeader2: Record "Store Requisition Header";
        StoreRequisitionLine2: Record "Store Requisition Line";
        TempRequisition: Record "Purchase Requisitions";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Setups: Record "Purchases & Payables Setup";
        TempRequisitionLines: Record "Purchase Requisition Line";
        PurchaseRequisition: Record "Purchase Requisitions";
        PurchaseRequisitionLines: Record "Purchase Requisition Line";
        ExistInrequisition: Boolean;
        Items: Record Item;
        Text00011: Label 'Reorder point has been reached and  a purchase requisition has been created for your attention for item no: %1';
        InventorySetup: Record "Inventory Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin

        StoreRequisitionHeader.TransferFields("Store Requisition Header", true);

        //Check posted document
        ItemLedgerEntry.Reset;
        ItemLedgerEntry.SetRange(ItemLedgerEntry."Document No.", StoreRequisitionHeader."No.");
        if ItemLedgerEntry.FindFirst then begin
            Error(Txt001, StoreRequisitionHeader."No.");
        end;
        //End Check Posted Document

        //If Item Journal Lines Exist, Delete
        ItemJnlLine.Reset;
        ItemJnlLine.SetRange(ItemJnlLine."Journal Template Name", JTemplate);
        ItemJnlLine.SetRange(ItemJnlLine."Journal Batch Name", JBatch);
        if ItemJnlLine.FindSet then begin
            ItemJnlLine.DeleteAll;
        end;
        //End Delete Item Journal Lines

        "LineNo." := 1000;

        StoreRequisitionLine.Reset;
        StoreRequisitionLine.SetRange(StoreRequisitionLine."Document No.", StoreRequisitionHeader."No.");
        StoreRequisitionLine.SetFilter(StoreRequisitionLine."Quantity to issue", '>%1', 0);
        if StoreRequisitionLine.FindSet then begin
            repeat
                //StoreRequisitionLine.TESTFIELD("Line Amount");
                StoreRequisitionLine.TestField("Quantity to issue");
                // StoreRequisitionLine.TESTFIELD("Location Code");
                // StoreRequisitionLine.TestField("Global Dimension 1 Code");
                // StoreRequisitionLine.TestField("Global Dimension 2 Code");
                "LineNo." := "LineNo." + 1;
                ItemJnlLine.Init;
                ItemJnlLine."Journal Template Name" := JTemplate;
                ItemJnlLine."Journal Batch Name" := JBatch;
                ItemJnlLine."Line No." := "LineNo.";
                ItemJnlLine."Entry Type" := ItemJnlLine
                ."Entry Type"::"Negative Adjmt.";
                ItemJnlLine."Posting Date" := StoreRequisitionHeader."Posting Date";
                ItemJnlLine."Document No." := StoreRequisitionHeader."No.";
                ItemJnlLine."Item No." := StoreRequisitionLine."Item No.";
                ItemJnlLine.Validate("Item No.");
                ItemJnlLine."Unit of Measure Code" := StoreRequisitionLine."Unit of Measure Code";
                ItemJnlLine.Validate("Unit of Measure Code");
                ItemJnlLine."Location Code" := StoreRequisitionLine."Location Code";
                //ItemJnlLine.VALIDATE("Location Code");
                ItemJnlLine."Gen. Prod. Posting Group" := StoreRequisitionLine."Gen. Prod. Posting Group";
                ItemJnlLine.Description := CopyStr(StoreRequisitionLine."Item Description", 1, 50);
                //Frs05072020 for Nanyuki water
                /*
                IF StoreRequisitionLine.Quantity>StoreRequisitionLine.Inventory THEN
                ItemJnlLine.Quantity:=StoreRequisitionLine.Inventory
                ELSE*/

                ItemJnlLine.Quantity := StoreRequisitionLine."Quantity to issue";

                ItemJnlLine.Validate(ItemJnlLine.Quantity);
                ItemJnlLine."Shortcut Dimension 1 Code" := StoreRequisitionLine."Global Dimension 1 Code";
                ItemJnlLine.Validate("Shortcut Dimension 1 Code");
                ItemJnlLine."Shortcut Dimension 2 Code" := StoreRequisitionLine."Global Dimension 2 Code";
                ItemJnlLine.Validate("Shortcut Dimension 2 Code");
                ItemJnlLine.ValidateShortcutDimCode(3, StoreRequisitionLine."Shortcut Dimension 3 Code");
                ItemJnlLine.ValidateShortcutDimCode(4, StoreRequisitionLine."Shortcut Dimension 4 Code");
                ItemJnlLine.ValidateShortcutDimCode(5, StoreRequisitionLine."Shortcut Dimension 5 Code");
                ItemJnlLine.ValidateShortcutDimCode(6, StoreRequisitionLine."Shortcut Dimension 6 Code");
                ItemJnlLine.ValidateShortcutDimCode(7, StoreRequisitionLine."Shortcut Dimension 7 Code");
                ItemJnlLine.ValidateShortcutDimCode(8, StoreRequisitionLine."Shortcut Dimension 8 Code");
                ItemJnlLine.Validate("Gen. Bus. Posting Group", StoreRequisitionLine."Gen. Bus. Posting Group");
                ItemJnlLine.Insert;
            until StoreRequisitionLine.Next = 0;

            Commit;
            //Post Entries
            ItemJnlLine.Reset;
            ItemJnlLine.SetRange(ItemJnlLine."Journal Template Name", JTemplate);
            ItemJnlLine.SetRange(ItemJnlLine."Journal Batch Name", JBatch);
            if ItemJnlLine.FindSet then begin
                CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", ItemJnlLine);
            end;
            Commit;
            //End Post entries

            //Change Document Status
            ItemLedgerEntry.Reset;
            ItemLedgerEntry.SetRange(ItemLedgerEntry."Document No.", StoreRequisitionHeader."No.");
            if ItemLedgerEntry.FindFirst then begin
                StoreRequisitionHeader2.Reset;
                StoreRequisitionHeader2.SetRange(StoreRequisitionHeader2."No.", StoreRequisitionHeader."No.");
                if StoreRequisitionHeader2.FindFirst then begin

                    StoreRequisitionHeader2.Status := StoreRequisitionHeader2.Status::Posted;
                    StoreRequisitionHeader2."Posting Date" := Today;
                    StoreRequisitionHeader2."Posted By" := UserId;
                    StoreRequisitionHeader2."Issued By" := UserId;
                    StoreRequisitionHeader2.Validate(StoreRequisitionHeader2.Status);
                    InventorySetup.Get();
                    StoreRequisitionHeader2."Store Issue Note" := NoSeriesManagement.GetNextNo(InventorySetup."Store Issue Note Nos.", Today, true);
                    StoreRequisitionHeader2."Store Issue Note No Series" := InventorySetup."Store Issue Note Nos.";
                    StoreRequisitionHeader2.Modify;
                end;
            end;
        end;


        //Replenish Purchase Requisition
        /*
        StoreRequisitionLine2.RESET;
        StoreRequisitionLine2.SETRANGE(StoreRequisitionLine2."Document No.","Store Requisition Header"."No.");
        IF StoreRequisitionLine2.FINDSET THEN BEGIN
          REPEAT
            Setups.GET;
            Setups.TESTFIELD(Setups."User to replenish Stock");
            Items.RESET;
            Items.SETRANGE(Items."No.",StoreRequisitionLine2."Item No.");
            Items.SETFILTER(Items."Reorder Point",'<>%1',0);
            IF Items.FINDSET THEN BEGIN
              REPEAT
              Items.CALCFIELDS(Items.Inventory);
        
              IF Items.Inventory<Items."Reorder Point" THEN BEGIN
              TempRequisition.INIT;
              TempRequisition."No.":=NoSeriesMgt.GetNextNo(Setups."Purchase Requisition Nos.",0D,TRUE);
             // ERROR(FORMAT(TempRequisition."No."));
              TempRequisition."Requested Receipt Date":=TODAY;
              TempRequisition."Document Date":=TODAY;
              TempRequisition.Description:='Purchase requisition for Item that need replenishement';
              TempRequisition."User ID":=Setups."User to replenish Stock";
              TempRequisition.VALIDATE(TempRequisition."User ID");
              TempRequisition."Replenishment PR":=TRUE;
              TempRequisition.INSERT;
        
              TempRequisitionLines.INIT;
              TempRequisitionLines."Document No.":=TempRequisition."No.";
              TempRequisitionLines."Requisition Type":=TempRequisitionLines."Requisition Type"::Item;
              TempRequisitionLines.VALIDATE(TempRequisitionLines."Requisition Type");
              TempRequisitionLines."Requisition Code":=Items."No.";
              TempRequisitionLines.VALIDATE(TempRequisitionLines."Requisition Code");
              TempRequisitionLines.Quantity:=Items."Reorder Quantity";
             IF  TempRequisitionLines.INSERT THEN
               MESSAGE(Text00011,TempRequisitionLines."Requisition Code");
              END;
            // MESSAGE(Text00011,TempRequisitionLines."Requisition Code")
              UNTIL Items.NEXT=0;
            END;
        
          UNTIL StoreRequisitionLine2.NEXT=0;
        END;
        */

    end;

    procedure PostStoreRequisitionReturn("Store Requisition Header": Record "Store Requisition Header"; JTemplate: Code[10]; JBatch: Code[10])
    var
        "LineNo.": Integer;
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemJnlLine: Record "Item Journal Line";
        StoreRequisitionHeader: Record "Store Requisition Header";
        StoreRequisitionLine: Record "Store Requisition Line";
        StoreRequisitionHeader2: Record "Store Requisition Header";
        StoreRequisitionLine2: Record "Store Requisition Line";
        TempRequisition: Record "Purchase Requisitions";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Setups: Record "Purchases & Payables Setup";
        TempRequisitionLines: Record "Purchase Requisition Line";
        PurchaseRequisition: Record "Purchase Requisitions";
        PurchaseRequisitionLines: Record "Purchase Requisition Line";
        ExistInrequisition: Boolean;
        Items: Record Item;
        Text00011: Label 'Reorder point has been reached and  a purchase requisition has been created for your attention for item no: %1';
    begin
        StoreRequisitionHeader.TransferFields("Store Requisition Header", true);

        //Check posted document
        ItemLedgerEntry.Reset;
        ItemLedgerEntry.SetRange(ItemLedgerEntry."Document No.", StoreRequisitionHeader."No.");
        if ItemLedgerEntry.FindFirst then begin
            Error(Txt001, StoreRequisitionHeader."No.");
        end;
        //End Check Posted Document

        //If Item Journal Lines Exist, Delete
        ItemJnlLine.Reset;
        ItemJnlLine.SetRange(ItemJnlLine."Journal Template Name", JTemplate);
        ItemJnlLine.SetRange(ItemJnlLine."Journal Batch Name", JBatch);
        if ItemJnlLine.FindSet then begin
            ItemJnlLine.DeleteAll;
        end;
        //End Delete Item Journal Lines

        "LineNo." := 1000;

        StoreRequisitionLine.Reset;
        StoreRequisitionLine.SetRange(StoreRequisitionLine."Document No.", StoreRequisitionHeader."No.");
        StoreRequisitionLine.SetFilter(StoreRequisitionLine.Quantity, '>%1', 0);
        if StoreRequisitionLine.FindSet then begin
            repeat
                "LineNo." := "LineNo." + 1;
                ItemJnlLine.Init;
                ItemJnlLine."Journal Template Name" := JTemplate;
                ItemJnlLine."Journal Batch Name" := JBatch;
                ItemJnlLine."Line No." := "LineNo.";
                ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Positive Adjmt.";
                ItemJnlLine."Posting Date" := StoreRequisitionHeader."Posting Date";
                ItemJnlLine."Document No." := StoreRequisitionHeader."No.";
                ItemJnlLine."Item No." := StoreRequisitionLine."Item No.";
                ItemJnlLine.Validate("Item No.");
                ItemJnlLine."Unit of Measure Code" := StoreRequisitionLine."Unit of Measure Code";
                ItemJnlLine.Validate("Unit of Measure Code");
                ItemJnlLine."Location Code" := StoreRequisitionLine."Location Code";
                //ItemJnlLine.VALIDATE("Location Code");
                ItemJnlLine.Description := CopyStr(StoreRequisitionLine."Item Description", 1, 50);
                //Frs05072020 for Nanyuki water

                ItemJnlLine.Quantity := StoreRequisitionLine.Quantity;
                ItemJnlLine.Validate(ItemJnlLine.Quantity);
                ItemJnlLine."Unit Cost" := StoreRequisitionLine."Unit Cost";
                ItemJnlLine."Unit Amount" := StoreRequisitionLine."Line Amount";
                ItemJnlLine."Shortcut Dimension 1 Code" := StoreRequisitionLine."Global Dimension 1 Code";
                ItemJnlLine.Validate("Shortcut Dimension 1 Code");
                ItemJnlLine."Shortcut Dimension 2 Code" := StoreRequisitionLine."Global Dimension 2 Code";
                ItemJnlLine.Validate("Shortcut Dimension 2 Code");
                ItemJnlLine.ValidateShortcutDimCode(3, StoreRequisitionLine."Shortcut Dimension 3 Code");
                ItemJnlLine.ValidateShortcutDimCode(4, StoreRequisitionLine."Shortcut Dimension 4 Code");
                ItemJnlLine.ValidateShortcutDimCode(5, StoreRequisitionLine."Shortcut Dimension 5 Code");
                ItemJnlLine.ValidateShortcutDimCode(6, StoreRequisitionLine."Shortcut Dimension 6 Code");
                ItemJnlLine.ValidateShortcutDimCode(7, StoreRequisitionLine."Shortcut Dimension 7 Code");
                ItemJnlLine.ValidateShortcutDimCode(8, StoreRequisitionLine."Shortcut Dimension 8 Code");
                ItemJnlLine.Validate("Gen. Bus. Posting Group", StoreRequisitionLine."Gen. Bus. Posting Group");
                ItemJnlLine."Gen. Prod. Posting Group" := StoreRequisitionLine."Gen. Prod. Posting Group";

                ItemJnlLine.Insert;
            until StoreRequisitionLine.Next = 0;

            Commit;
            //Post Entries
            ItemJnlLine.Reset;
            ItemJnlLine.SetRange(ItemJnlLine."Journal Template Name", JTemplate);
            ItemJnlLine.SetRange(ItemJnlLine."Journal Batch Name", JBatch);
            if ItemJnlLine.FindSet then begin
                CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", ItemJnlLine);
            end;
            Commit;
            //End Post entries

            //Change Document Status
            ItemLedgerEntry.Reset;
            ItemLedgerEntry.SetRange(ItemLedgerEntry."Document No.", StoreRequisitionHeader."No.");
            if ItemLedgerEntry.FindFirst then begin
                StoreRequisitionHeader2.Reset;
                StoreRequisitionHeader2.SetRange(StoreRequisitionHeader2."No.", StoreRequisitionHeader."No.");
                if StoreRequisitionHeader2.FindFirst then begin

                    StoreRequisitionHeader2.Status := StoreRequisitionHeader2.Status::Posted;
                    StoreRequisitionHeader2."Posting Date" := Today;
                    StoreRequisitionHeader2."Posted By" := UserId;
                    StoreRequisitionHeader2.Validate(StoreRequisitionHeader2.Status);
                    StoreRequisitionHeader2.Modify;
                end;
            end;
        end;


        //Replenish Purchase Requisition
        /*
        StoreRequisitionLine2.RESET;
        StoreRequisitionLine2.SETRANGE(StoreRequisitionLine2."Document No.","Store Requisition Header"."No.");
        IF StoreRequisitionLine2.FINDSET THEN BEGIN
          REPEAT
            Setups.GET;
            Setups.TESTFIELD(Setups."User to replenish Stock");
            Items.RESET;
            Items.SETRANGE(Items."No.",StoreRequisitionLine2."Item No.");
            Items.SETFILTER(Items."Reorder Point",'<>%1',0);
            IF Items.FINDSET THEN BEGIN
              REPEAT
              Items.CALCFIELDS(Items.Inventory);
        
              IF Items.Inventory<Items."Reorder Point" THEN BEGIN
              TempRequisition.INIT;
              TempRequisition."No.":=NoSeriesMgt.GetNextNo(Setups."Purchase Requisition Nos.",0D,TRUE);
             // ERROR(FORMAT(TempRequisition."No."));
              TempRequisition."Requested Receipt Date":=TODAY;
              TempRequisition."Document Date":=TODAY;
              TempRequisition.Description:='Purchase requisition for Item that need replenishement';
              TempRequisition."User ID":=Setups."User to replenish Stock";
              TempRequisition.VALIDATE(TempRequisition."User ID");
              TempRequisition."Replenishment PR":=TRUE;
              TempRequisition.INSERT;
        
              TempRequisitionLines.INIT;
              TempRequisitionLines."Document No.":=TempRequisition."No.";
              TempRequisitionLines."Requisition Type":=TempRequisitionLines."Requisition Type"::Item;
              TempRequisitionLines.VALIDATE(TempRequisitionLines."Requisition Type");
              TempRequisitionLines."Requisition Code":=Items."No.";
              TempRequisitionLines.VALIDATE(TempRequisitionLines."Requisition Code");
              TempRequisitionLines.Quantity:=Items."Reorder Quantity";
             IF  TempRequisitionLines.INSERT THEN
               MESSAGE(Text00011,TempRequisitionLines."Requisition Code");
              END;
            // MESSAGE(Text00011,TempRequisitionLines."Requisition Code")
              UNTIL Items.NEXT=0;
            END;
        
          UNTIL StoreRequisitionLine2.NEXT=0;
        END;
        */

    end;

    procedure PostStoreRequisitionPortal("Store Requisition Header": Record "Store Requisition Header"; JTemplate: Code[10]; JBatch: Code[10])
    var
        "LineNo.": Integer;
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemJnlLine: Record "Item Journal Line";
        StoreRequisitionHeader: Record "Store Requisition Header";
        StoreRequisitionLine: Record "Store Requisition Line";
        StoreRequisitionHeader2: Record "Store Requisition Header";
        StoreRequisitionLine2: Record "Store Requisition Line";
        TempRequisition: Record "Purchase Requisitions";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Setups: Record "Purchases & Payables Setup";
        TempRequisitionLines: Record "Purchase Requisition Line";
        PurchaseRequisition: Record "Purchase Requisitions";
        PurchaseRequisitionLines: Record "Purchase Requisition Line";
        ExistInrequisition: Boolean;
        Items: Record Item;
        Text00011: Label 'Reorder point has been reached and  a purchase requisition has been created for your attention for item no: %1';
        InventorySetup: Record "Inventory Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin

        StoreRequisitionHeader.TransferFields("Store Requisition Header", true);

        //Check posted document
        ItemLedgerEntry.Reset;
        ItemLedgerEntry.SetRange(ItemLedgerEntry."Document No.", StoreRequisitionHeader."No.");
        if ItemLedgerEntry.FindFirst then begin
            Error(Txt001, StoreRequisitionHeader."No.");
        end;
        //End Check Posted Document

        //If Item Journal Lines Exist, Delete
        ItemJnlLine.Reset;
        ItemJnlLine.SetRange(ItemJnlLine."Journal Template Name", JTemplate);
        ItemJnlLine.SetRange(ItemJnlLine."Journal Batch Name", JBatch);
        if ItemJnlLine.FindSet then begin
            ItemJnlLine.DeleteAll;
        end;
        //End Delete Item Journal Lines

        "LineNo." := 1000;

        StoreRequisitionLine.Reset;
        StoreRequisitionLine.SetRange(StoreRequisitionLine."Document No.", StoreRequisitionHeader."No.");
        StoreRequisitionLine.SetFilter(StoreRequisitionLine.Quantity, '>%1', 0);
        if StoreRequisitionLine.FindSet then begin
            repeat
                //  StoreRequisitionLine.TESTFIELD("Line Amount");
                StoreRequisitionLine.TestField("Quantity to issue");
                //StoreRequisitionLine.TESTFIELD("Location Code");
                //StoreRequisitionLine.TESTFIELD("Global Dimension 1 Code");
                ///StoreRequisitionLine.TESTFIELD("Shortcut Dimension 3 Code");
                "LineNo." := "LineNo." + 1;
                ItemJnlLine.Init;
                ItemJnlLine."Journal Template Name" := JTemplate;
                ItemJnlLine."Journal Batch Name" := JBatch;
                ItemJnlLine."Line No." := "LineNo.";
                ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Negative Adjmt.";
                ItemJnlLine."Posting Date" := StoreRequisitionHeader."Posting Date";
                ItemJnlLine."Document No." := StoreRequisitionHeader."No.";
                ItemJnlLine."Item No." := StoreRequisitionLine."Item No.";
                ItemJnlLine.Validate("Item No.");
                ItemJnlLine."Unit of Measure Code" := StoreRequisitionLine."Unit of Measure Code";
                ItemJnlLine.Validate("Unit of Measure Code");
                ItemJnlLine.HideDialog := true;
                ItemJnlLine."Location Code" := StoreRequisitionLine."Location Code";
                //ItemJnlLine.VALIDATE("Location Code");
                ItemJnlLine.Description := CopyStr(StoreRequisitionLine."Item Description", 1, 50);
                //Frs05072020 for Nanyuki water
                /*
                IF StoreRequisitionLine.Quantity>StoreRequisitionLine.Inventory THEN
                ItemJnlLine.Quantity:=StoreRequisitionLine.Inventory
                ELSE*/

                ItemJnlLine.Quantity := StoreRequisitionLine."Quantity to issue";

                ItemJnlLine.Validate(ItemJnlLine.Quantity);
                ItemJnlLine."Shortcut Dimension 1 Code" := StoreRequisitionLine."Global Dimension 1 Code";
                ItemJnlLine.Validate("Shortcut Dimension 1 Code");
                ItemJnlLine."Shortcut Dimension 2 Code" := StoreRequisitionLine."Global Dimension 2 Code";
                ItemJnlLine.Validate("Shortcut Dimension 2 Code");
                ItemJnlLine.ValidateShortcutDimCode(3, StoreRequisitionLine."Shortcut Dimension 3 Code");
                ItemJnlLine.ValidateShortcutDimCode(4, StoreRequisitionLine."Shortcut Dimension 4 Code");
                ItemJnlLine.ValidateShortcutDimCode(5, StoreRequisitionLine."Shortcut Dimension 5 Code");
                ItemJnlLine.ValidateShortcutDimCode(6, StoreRequisitionLine."Shortcut Dimension 6 Code");
                ItemJnlLine.ValidateShortcutDimCode(7, StoreRequisitionLine."Shortcut Dimension 7 Code");
                ItemJnlLine.ValidateShortcutDimCode(8, StoreRequisitionLine."Shortcut Dimension 8 Code");
                ItemJnlLine.Validate("Gen. Bus. Posting Group", StoreRequisitionLine."Gen. Bus. Posting Group");
                ItemJnlLine.Insert;
            until StoreRequisitionLine.Next = 0;

            Commit;
            //Post Entries
            ItemJnlLine.Reset;
            ItemJnlLine.SetRange(ItemJnlLine."Journal Template Name", JTemplate);
            ItemJnlLine.SetRange(ItemJnlLine."Journal Batch Name", JBatch);
            if ItemJnlLine.FindSet then begin
                CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", ItemJnlLine);
            end;
            Commit;
            //End Post entries

            //Change Document Status
            ItemLedgerEntry.Reset;
            ItemLedgerEntry.SetRange(ItemLedgerEntry."Document No.", StoreRequisitionHeader."No.");
            if ItemLedgerEntry.FindFirst then begin
                StoreRequisitionHeader2.Reset;
                StoreRequisitionHeader2.SetRange(StoreRequisitionHeader2."No.", StoreRequisitionHeader."No.");
                if StoreRequisitionHeader2.FindFirst then begin

                    StoreRequisitionHeader2.Status := StoreRequisitionHeader2.Status::Posted;
                    StoreRequisitionHeader2."Posting Date" := Today;
                    StoreRequisitionHeader2."Posted By" := StoreRequisitionHeader2."Issued By";//USERID;
                    StoreRequisitionHeader2."Issued By" := StoreRequisitionHeader2."Issued By";//USERID;
                    StoreRequisitionHeader2.Validate(StoreRequisitionHeader2.Status);
                    InventorySetup.Get();
                    StoreRequisitionHeader2."Store Issue Note" := NoSeriesManagement.GetNextNo(InventorySetup."Store Issue Note Nos.", Today, true);
                    StoreRequisitionHeader2."Store Issue Note No Series" := InventorySetup."Store Issue Note Nos.";
                    StoreRequisitionHeader2.Modify;
                end;
            end;
        end;


        //Replenish Purchase Requisition
        /*
        StoreRequisitionLine2.RESET;
        StoreRequisitionLine2.SETRANGE(StoreRequisitionLine2."Document No.","Store Requisition Header"."No.");
        IF StoreRequisitionLine2.FINDSET THEN BEGIN
          REPEAT
            Setups.GET;
            Setups.TESTFIELD(Setups."User to replenish Stock");
            Items.RESET;
            Items.SETRANGE(Items."No.",StoreRequisitionLine2."Item No.");
            Items.SETFILTER(Items."Reorder Point",'<>%1',0);
            IF Items.FINDSET THEN BEGIN
              REPEAT
              Items.CALCFIELDS(Items.Inventory);
        
              IF Items.Inventory<Items."Reorder Point" THEN BEGIN
              TempRequisition.INIT;
              TempRequisition."No.":=NoSeriesMgt.GetNextNo(Setups."Purchase Requisition Nos.",0D,TRUE);
             // ERROR(FORMAT(TempRequisition."No."));
              TempRequisition."Requested Receipt Date":=TODAY;
              TempRequisition."Document Date":=TODAY;
              TempRequisition.Description:='Purchase requisition for Item that need replenishement';
              TempRequisition."User ID":=Setups."User to replenish Stock";
              TempRequisition.VALIDATE(TempRequisition."User ID");
              TempRequisition."Replenishment PR":=TRUE;
              TempRequisition.INSERT;
        
              TempRequisitionLines.INIT;
              TempRequisitionLines."Document No.":=TempRequisition."No.";
              TempRequisitionLines."Requisition Type":=TempRequisitionLines."Requisition Type"::Item;
              TempRequisitionLines.VALIDATE(TempRequisitionLines."Requisition Type");
              TempRequisitionLines."Requisition Code":=Items."No.";
              TempRequisitionLines.VALIDATE(TempRequisitionLines."Requisition Code");
              TempRequisitionLines.Quantity:=Items."Reorder Quantity";
             IF  TempRequisitionLines.INSERT THEN
               MESSAGE(Text00011,TempRequisitionLines."Requisition Code");
              END;
            // MESSAGE(Text00011,TempRequisitionLines."Requisition Code")
              UNTIL Items.NEXT=0;
            END;
        
          UNTIL StoreRequisitionLine2.NEXT=0;
        END;
        */

    end;

    procedure PostStoreRequisitionReturnPortal("Store Requisition Header": Record "Store Requisition Header"; JTemplate: Code[10]; JBatch: Code[10])
    var
        "LineNo.": Integer;
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemJnlLine: Record "Item Journal Line";
        StoreRequisitionHeader: Record "Store Requisition Header";
        StoreRequisitionLine: Record "Store Requisition Line";
        StoreRequisitionHeader2: Record "Store Requisition Header";
        StoreRequisitionLine2: Record "Store Requisition Line";
        TempRequisition: Record "Purchase Requisitions";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Setups: Record "Purchases & Payables Setup";
        TempRequisitionLines: Record "Purchase Requisition Line";
        PurchaseRequisition: Record "Purchase Requisitions";
        PurchaseRequisitionLines: Record "Purchase Requisition Line";
        ExistInrequisition: Boolean;
        Items: Record Item;
        Text00011: Label 'Reorder point has been reached and  a purchase requisition has been created for your attention for item no: %1';
    begin
        StoreRequisitionHeader.TransferFields("Store Requisition Header", true);

        //Check posted document
        ItemLedgerEntry.Reset;
        ItemLedgerEntry.SetRange(ItemLedgerEntry."Document No.", StoreRequisitionHeader."No.");
        if ItemLedgerEntry.FindFirst then begin
            Error(Txt001, StoreRequisitionHeader."No.");
        end;
        //End Check Posted Document

        //If Item Journal Lines Exist, Delete
        ItemJnlLine.Reset;
        ItemJnlLine.SetRange(ItemJnlLine."Journal Template Name", JTemplate);
        ItemJnlLine.SetRange(ItemJnlLine."Journal Batch Name", JBatch);
        if ItemJnlLine.FindSet then begin
            ItemJnlLine.DeleteAll;
        end;
        //End Delete Item Journal Lines

        "LineNo." := 1000;

        StoreRequisitionLine.Reset;
        StoreRequisitionLine.SetRange(StoreRequisitionLine."Document No.", StoreRequisitionHeader."No.");
        StoreRequisitionLine.SetFilter(StoreRequisitionLine.Quantity, '>%1', 0);
        if StoreRequisitionLine.FindSet then begin
            repeat
                "LineNo." := "LineNo." + 1;
                ItemJnlLine.Init;
                ItemJnlLine."Journal Template Name" := JTemplate;
                ItemJnlLine."Journal Batch Name" := JBatch;
                ItemJnlLine."Line No." := "LineNo.";
                ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Positive Adjmt.";
                ItemJnlLine."Posting Date" := StoreRequisitionHeader."Posting Date";
                ItemJnlLine."Document No." := StoreRequisitionHeader."No.";
                ItemJnlLine."Item No." := StoreRequisitionLine."Item No.";
                ItemJnlLine.Validate("Item No.");
                ItemJnlLine."Unit of Measure Code" := StoreRequisitionLine."Unit of Measure Code";
                ItemJnlLine.Validate("Unit of Measure Code");
                ItemJnlLine."Location Code" := StoreRequisitionLine."Location Code";
                //ItemJnlLine.VALIDATE("Location Code");
                ItemJnlLine.Description := CopyStr(StoreRequisitionLine."Item Description", 1, 50);
                //Frs05072020 for Nanyuki water

                ItemJnlLine.Quantity := StoreRequisitionLine.Quantity;
                ItemJnlLine.Validate(ItemJnlLine.Quantity);
                ItemJnlLine."Unit Cost" := StoreRequisitionLine."Unit Cost";
                ItemJnlLine."Unit Amount" := StoreRequisitionLine."Line Amount";
                ItemJnlLine."Shortcut Dimension 1 Code" := StoreRequisitionLine."Global Dimension 1 Code";
                ItemJnlLine.Validate("Shortcut Dimension 1 Code");
                ItemJnlLine."Shortcut Dimension 2 Code" := StoreRequisitionLine."Global Dimension 2 Code";
                ItemJnlLine.Validate("Shortcut Dimension 2 Code");
                ItemJnlLine.ValidateShortcutDimCode(3, StoreRequisitionLine."Shortcut Dimension 3 Code");
                ItemJnlLine.ValidateShortcutDimCode(4, StoreRequisitionLine."Shortcut Dimension 4 Code");
                ItemJnlLine.ValidateShortcutDimCode(5, StoreRequisitionLine."Shortcut Dimension 5 Code");
                ItemJnlLine.ValidateShortcutDimCode(6, StoreRequisitionLine."Shortcut Dimension 6 Code");
                ItemJnlLine.ValidateShortcutDimCode(7, StoreRequisitionLine."Shortcut Dimension 7 Code");
                ItemJnlLine.ValidateShortcutDimCode(8, StoreRequisitionLine."Shortcut Dimension 8 Code");
                ItemJnlLine.Validate("Gen. Bus. Posting Group", StoreRequisitionLine."Gen. Bus. Posting Group");
                ItemJnlLine.HideDialog := true;
                ItemJnlLine.Insert;
            until StoreRequisitionLine.Next = 0;

            Commit;
            //Post Entries
            ItemJnlLine.Reset;
            ItemJnlLine.SetRange(ItemJnlLine."Journal Template Name", JTemplate);
            ItemJnlLine.SetRange(ItemJnlLine."Journal Batch Name", JBatch);
            if ItemJnlLine.FindSet then begin
                CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", ItemJnlLine);
            end;
            Commit;
            //End Post entries

            //Change Document Status
            ItemLedgerEntry.Reset;
            ItemLedgerEntry.SetRange(ItemLedgerEntry."Document No.", StoreRequisitionHeader."No.");
            if ItemLedgerEntry.FindFirst then begin
                StoreRequisitionHeader2.Reset;
                StoreRequisitionHeader2.SetRange(StoreRequisitionHeader2."No.", StoreRequisitionHeader."No.");
                if StoreRequisitionHeader2.FindFirst then begin

                    StoreRequisitionHeader2.Status := StoreRequisitionHeader2.Status::Posted;
                    StoreRequisitionHeader2."Posting Date" := Today;
                    StoreRequisitionHeader2."Posted By" := UserId;
                    StoreRequisitionHeader2.Validate(StoreRequisitionHeader2.Status);
                    StoreRequisitionHeader2.Modify;
                end;
            end;
        end;


        //Replenish Purchase Requisition
        /*
        StoreRequisitionLine2.RESET;
        StoreRequisitionLine2.SETRANGE(StoreRequisitionLine2."Document No.","Store Requisition Header"."No.");
        IF StoreRequisitionLine2.FINDSET THEN BEGIN
          REPEAT
            Setups.GET;
            Setups.TESTFIELD(Setups."User to replenish Stock");
            Items.RESET;
            Items.SETRANGE(Items."No.",StoreRequisitionLine2."Item No.");
            Items.SETFILTER(Items."Reorder Point",'<>%1',0);
            IF Items.FINDSET THEN BEGIN
              REPEAT
              Items.CALCFIELDS(Items.Inventory);
        
              IF Items.Inventory<Items."Reorder Point" THEN BEGIN
              TempRequisition.INIT;
              TempRequisition."No.":=NoSeriesMgt.GetNextNo(Setups."Purchase Requisition Nos.",0D,TRUE);
             // ERROR(FORMAT(TempRequisition."No."));
              TempRequisition."Requested Receipt Date":=TODAY;
              TempRequisition."Document Date":=TODAY;
              TempRequisition.Description:='Purchase requisition for Item that need replenishement';
              TempRequisition."User ID":=Setups."User to replenish Stock";
              TempRequisition.VALIDATE(TempRequisition."User ID");
              TempRequisition."Replenishment PR":=TRUE;
              TempRequisition.INSERT;
        
              TempRequisitionLines.INIT;
              TempRequisitionLines."Document No.":=TempRequisition."No.";
              TempRequisitionLines."Requisition Type":=TempRequisitionLines."Requisition Type"::Item;
              TempRequisitionLines.VALIDATE(TempRequisitionLines."Requisition Type");
              TempRequisitionLines."Requisition Code":=Items."No.";
              TempRequisitionLines.VALIDATE(TempRequisitionLines."Requisition Code");
              TempRequisitionLines.Quantity:=Items."Reorder Quantity";
             IF  TempRequisitionLines.INSERT THEN
               MESSAGE(Text00011,TempRequisitionLines."Requisition Code");
              END;
            // MESSAGE(Text00011,TempRequisitionLines."Requisition Code")
              UNTIL Items.NEXT=0;
            END;
        
          UNTIL StoreRequisitionLine2.NEXT=0;
        END;
        */

    end;

    procedure PostLooseTools("Store Requisition Header": Record "Store Requisition Header"; JTemplate: Code[10]; JBatch: Code[10])
    var
        "LineNo.": Integer;
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemJnlLine: Record "Item Journal Line";
        StoreRequisitionHeader: Record "Store Requisition Header";
        StoreRequisitionLine: Record "Store Requisition Line";
        StoreRequisitionHeader2: Record "Store Requisition Header";
        StoreRequisitionLine2: Record "Store Requisition Line";
        TempRequisition: Record "Purchase Requisitions";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Setups: Record "Purchases & Payables Setup";
        TempRequisitionLines: Record "Purchase Requisition Line";
        PurchaseRequisition: Record "Purchase Requisitions";
        PurchaseRequisitionLines: Record "Purchase Requisition Line";
        ExistInrequisition: Boolean;
        Items: Record Item;
        Text00011: Label 'Reorder point has been reached and  a purchase requisition has been created for your attention for item no: %1';
        InventorySetup: Record "Inventory Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin

        StoreRequisitionHeader.TransferFields("Store Requisition Header", true);

        //Check posted document
        ItemLedgerEntry.Reset;
        ItemLedgerEntry.SetRange(ItemLedgerEntry."Document No.", StoreRequisitionHeader."No.");
        if ItemLedgerEntry.FindFirst then begin
            Error(Txt001, StoreRequisitionHeader."No.");
        end;
        //End Check Posted Document

        //If Item Journal Lines Exist, Delete
        ItemJnlLine.Reset;
        ItemJnlLine.SetRange(ItemJnlLine."Journal Template Name", JTemplate);
        ItemJnlLine.SetRange(ItemJnlLine."Journal Batch Name", JBatch);
        if ItemJnlLine.FindSet then begin
            ItemJnlLine.DeleteAll;
        end;
        //End Delete Item Journal Lines

        "LineNo." := 1000;

        StoreRequisitionLine.Reset;
        StoreRequisitionLine.SetRange(StoreRequisitionLine."Document No.", StoreRequisitionHeader."No.");
        StoreRequisitionLine.SetFilter(StoreRequisitionLine.Quantity, '>%1', 0);
        if StoreRequisitionLine.FindSet then begin
            repeat
                StoreRequisitionLine.TestField("Line Amount");
                StoreRequisitionLine.TestField("Quantity to issue");
                StoreRequisitionLine.TestField("Location Code");
                StoreRequisitionLine.TestField("Global Dimension 1 Code");
                StoreRequisitionLine.TestField("Global Dimension 2 Code");
                "LineNo." := "LineNo." + 1;
                ItemJnlLine.Init;
                ItemJnlLine."Journal Template Name" := JTemplate;
                ItemJnlLine."Journal Batch Name" := JBatch;
                ItemJnlLine."Line No." := "LineNo.";
                ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Negative Adjmt.";
                ItemJnlLine."Posting Date" := StoreRequisitionHeader."Posting Date";
                ItemJnlLine."Document No." := StoreRequisitionHeader."No.";
                ItemJnlLine."Item No." := StoreRequisitionLine."Item No.";
                ItemJnlLine.Validate("Item No.");
                ItemJnlLine."Unit of Measure Code" := StoreRequisitionLine."Unit of Measure Code";
                ItemJnlLine.Validate("Unit of Measure Code");
                ItemJnlLine."Location Code" := StoreRequisitionLine."Location Code";
                //ItemJnlLine.VALIDATE("Location Code");
                ItemJnlLine.Description := CopyStr(StoreRequisitionLine."Item Description", 1, 50);
                //Frs05072020 for Nanyuki water
                /*
                IF StoreRequisitionLine.Quantity>StoreRequisitionLine.Inventory THEN
                ItemJnlLine.Quantity:=StoreRequisitionLine.Inventory
                ELSE*/

                ItemJnlLine.Quantity := StoreRequisitionLine."Quantity to issue";

                ItemJnlLine.Validate(ItemJnlLine.Quantity);
                ItemJnlLine."Shortcut Dimension 1 Code" := StoreRequisitionLine."Global Dimension 1 Code";
                ItemJnlLine.Validate("Shortcut Dimension 1 Code");
                ItemJnlLine."Shortcut Dimension 2 Code" := StoreRequisitionLine."Global Dimension 2 Code";
                ItemJnlLine.Validate("Shortcut Dimension 2 Code");
                ItemJnlLine.ValidateShortcutDimCode(3, StoreRequisitionLine."Shortcut Dimension 3 Code");
                ItemJnlLine.ValidateShortcutDimCode(4, StoreRequisitionLine."Shortcut Dimension 4 Code");
                ItemJnlLine.ValidateShortcutDimCode(5, StoreRequisitionLine."Shortcut Dimension 5 Code");
                ItemJnlLine.ValidateShortcutDimCode(6, StoreRequisitionLine."Shortcut Dimension 6 Code");
                ItemJnlLine.ValidateShortcutDimCode(7, StoreRequisitionLine."Shortcut Dimension 7 Code");
                ItemJnlLine.ValidateShortcutDimCode(8, StoreRequisitionLine."Shortcut Dimension 8 Code");
                ItemJnlLine.Validate("Gen. Bus. Posting Group", StoreRequisitionLine."Gen. Bus. Posting Group");
                ItemJnlLine.Insert;
            until StoreRequisitionLine.Next = 0;

            Commit;
            //Post Entries
            ItemJnlLine.Reset;
            ItemJnlLine.SetRange(ItemJnlLine."Journal Template Name", JTemplate);
            ItemJnlLine.SetRange(ItemJnlLine."Journal Batch Name", JBatch);
            if ItemJnlLine.FindSet then begin
                CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", ItemJnlLine);
            end;
            Commit;
            //End Post entries

            //Change Document Status
            ItemLedgerEntry.Reset;
            ItemLedgerEntry.SetRange(ItemLedgerEntry."Document No.", StoreRequisitionHeader."No.");
            if ItemLedgerEntry.FindFirst then begin
                StoreRequisitionHeader2.Reset;
                StoreRequisitionHeader2.SetRange(StoreRequisitionHeader2."No.", StoreRequisitionHeader."No.");
                if StoreRequisitionHeader2.FindFirst then begin

                    StoreRequisitionHeader2.Status := StoreRequisitionHeader2.Status::Posted;
                    StoreRequisitionHeader2."Posting Date" := Today;
                    StoreRequisitionHeader2."Posted By" := UserId;
                    StoreRequisitionHeader2."Issued By" := UserId;
                    StoreRequisitionHeader2.Validate(StoreRequisitionHeader2.Status);
                    InventorySetup.Get();
                    StoreRequisitionHeader2."Store Issue Note" := NoSeriesManagement.GetNextNo(InventorySetup."Store Issue Note Nos.", Today, true);
                    StoreRequisitionHeader2."Store Issue Note No Series" := InventorySetup."Store Issue Note Nos.";
                    StoreRequisitionHeader2.Modify;
                end;
            end;
        end;


        //Replenish Purchase Requisition
        /*
        StoreRequisitionLine2.RESET;
        StoreRequisitionLine2.SETRANGE(StoreRequisitionLine2."Document No.","Store Requisition Header"."No.");
        IF StoreRequisitionLine2.FINDSET THEN BEGIN
          REPEAT
            Setups.GET;
            Setups.TESTFIELD(Setups."User to replenish Stock");
            Items.RESET;
            Items.SETRANGE(Items."No.",StoreRequisitionLine2."Item No.");
            Items.SETFILTER(Items."Reorder Point",'<>%1',0);
            IF Items.FINDSET THEN BEGIN
              REPEAT
              Items.CALCFIELDS(Items.Inventory);
        
              IF Items.Inventory<Items."Reorder Point" THEN BEGIN
              TempRequisition.INIT;
              TempRequisition."No.":=NoSeriesMgt.GetNextNo(Setups."Purchase Requisition Nos.",0D,TRUE);
             // ERROR(FORMAT(TempRequisition."No."));
              TempRequisition."Requested Receipt Date":=TODAY;
              TempRequisition."Document Date":=TODAY;
              TempRequisition.Description:='Purchase requisition for Item that need replenishement';
              TempRequisition."User ID":=Setups."User to replenish Stock";
              TempRequisition.VALIDATE(TempRequisition."User ID");
              TempRequisition."Replenishment PR":=TRUE;
              TempRequisition.INSERT;
        
              TempRequisitionLines.INIT;
              TempRequisitionLines."Document No.":=TempRequisition."No.";
              TempRequisitionLines."Requisition Type":=TempRequisitionLines."Requisition Type"::Item;
              TempRequisitionLines.VALIDATE(TempRequisitionLines."Requisition Type");
              TempRequisitionLines."Requisition Code":=Items."No.";
              TempRequisitionLines.VALIDATE(TempRequisitionLines."Requisition Code");
              TempRequisitionLines.Quantity:=Items."Reorder Quantity";
             IF  TempRequisitionLines.INSERT THEN
               MESSAGE(Text00011,TempRequisitionLines."Requisition Code");
              END;
            // MESSAGE(Text00011,TempRequisitionLines."Requisition Code")
              UNTIL Items.NEXT=0;
            END;
        
          UNTIL StoreRequisitionLine2.NEXT=0;
        END;
        */

    end;
}

