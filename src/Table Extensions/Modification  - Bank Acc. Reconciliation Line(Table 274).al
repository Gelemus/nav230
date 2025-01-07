tableextension 60224 tableextension60224 extends "Bank Acc. Reconciliation Line" 
{
    fields
    {
        field(481;Reconciled;Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                BankAccStatementLine: Record "Bank Code";
            begin
                /*
                IF xRec.Reconciled = FALSE THEN ERROR('Please use the match manually function');
                //IF "Bank Ledger Entry Line No" = TRUE THEN ERROR('Please remove match for this entry from the bank statement');
                IF NOT CONFIRM('Are you sure you want to un-reconcile this entry') THEN ERROR('You have chosen to leave entry reconciled');
                RemoveApplication(Type);
                
                //**changes
                BankAccStatementLine.RESET;
                BankAccStatementLine.SETRANGE("Bank Account No.","Bank Account No.");
                BankAccStatementLine.SETRANGE("Statement No.","Statement No.");
                BankAccStatementLine.SETRANGE("Statement Line No.","Bank Statement Entry Line No");
                IF BankAccStatementLine.FINDFIRST THEN
                BEGIN
                
                  BankAccStatementLine."Applied Amount" -= "Statement Amount";
                  BankAccStatementLine."Applied Entries" := BankAccStatementLine."Applied Entries" - 1;
                
                  BankAccStatementLine.VALIDATE("Statement Amount");
                  BankAccStatementLine.MODIFY;
                END
                */

            end;
        }
        field(50000;Reconciled1;Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                BankAccStatementLine: Record "Bank Code";
            begin
                /*
                IF xRec.Reconciled = FALSE THEN ERROR('Please use the match manually function');
                //IF "Bank Ledger Entry Line No" = TRUE THEN ERROR('Please remove match for this entry from the bank statement');
                IF NOT CONFIRM('Are you sure you want to un-reconcile this entry') THEN ERROR('You have chosen to leave entry reconciled');
                RemoveApplication(Type);
                
                //**changes
                BankAccStatementLine.RESET;
                BankAccStatementLine.SETRANGE("Bank Account No.","Bank Account No.");
                BankAccStatementLine.SETRANGE("Statement No.","Statement No.");
                BankAccStatementLine.SETRANGE("Statement Line No.","Bank Statement Entry Line No");
                IF BankAccStatementLine.FINDFIRST THEN
                BEGIN
                
                  BankAccStatementLine."Applied Amount" -= "Statement Amount";
                  BankAccStatementLine."Applied Entries" := BankAccStatementLine."Applied Entries" - 1;
                
                  BankAccStatementLine.VALIDATE("Statement Amount");
                  BankAccStatementLine.MODIFY;
                END
                */

            end;
        }
        field(50001;Applied;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004;"Open Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Unpresented Cheques List,Uncredited Cheques List';
            OptionMembers = " ",Unpresented,Uncredited;
        }
        field(50005;"Bank Ledger Entry Line No";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50006;"Bank Statement Entry Line No";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50007;Reversed;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50008;"Reconciling Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50009;Payee;Text[250])
        {
            CalcFormula = Lookup("Payment Header"."Payee Name" WHERE ("Reference No."=FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(50010;"Payee Details";Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "DisplayApplication(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "GetCurrencyCode(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "GetStyle(PROCEDURE 35)".


    //Unsupported feature: Property Modification (Attributes) on "ClearDataExchEntries(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "CreateDim(PROCEDURE 26)".


    //Unsupported feature: Property Modification (Attributes) on "SetUpNewLine(PROCEDURE 34)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "ShowShortcutDimCode(PROCEDURE 50)".


    //Unsupported feature: Property Modification (Attributes) on "AcceptAppliedPaymentEntriesSelectedLines(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "RejectAppliedPaymentEntriesSelectedLines(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "RejectAppliedPayment(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "AcceptApplication(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "SetManualApplication(PROCEDURE 33)".


    //Unsupported feature: Property Modification (Attributes) on "GetAppliedEntryAccountName(PROCEDURE 47)".


    //Unsupported feature: Property Modification (Attributes) on "GetAppliedToName(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "GetAppliedEntryAccountType(PROCEDURE 43)".


    //Unsupported feature: Property Modification (Attributes) on "GetAppliedToAccountType(PROCEDURE 36)".


    //Unsupported feature: Property Modification (Attributes) on "GetAppliedEntryAccountNo(PROCEDURE 39)".


    //Unsupported feature: Property Modification (Attributes) on "GetAppliedToAccountNo(PROCEDURE 37)".


    //Unsupported feature: Property Modification (Attributes) on "AppliedEntryAccountDrillDown(PROCEDURE 46)".


    //Unsupported feature: Property Modification (Attributes) on "AppliedToDrillDown(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "DrillDownOnNoOfLedgerEntriesWithinAmountTolerance(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "DrillDownOnNoOfLedgerEntriesOutsideOfAmountTolerance(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "FilterBankRecLines(PROCEDURE 20)".


    //Unsupported feature: Property Modification (Attributes) on "LinesExist(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "GetAppliedToDocumentNo(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "GetAppliedToEntryNo(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "TransferRemainingAmountToAccount(PROCEDURE 31)".


    //Unsupported feature: Property Modification (Attributes) on "GetAmountRangeForTolerance(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "GetAppliedPmtData(PROCEDURE 52)".


    //Unsupported feature: Property Modification (Attributes) on "IsTransactionPostedAndReconciled(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "CanImport(PROCEDURE 44)".


    //Unsupported feature: Property Modification (Attributes) on "GetAppliesToID(PROCEDURE 62)".


    //Unsupported feature: Property Modification (Attributes) on "GetDescription(PROCEDURE 53)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateDimTableIDs(PROCEDURE 164)".

}

