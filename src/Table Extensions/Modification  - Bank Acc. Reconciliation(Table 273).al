tableextension 60223 tableextension60223 extends "Bank Acc. Reconciliation"
{
    fields
    {

        //Unsupported feature: Code Modification on ""Bank Account No."(Field 1).OnValidate".

        //trigger "(Field 1)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Statement No." = '' then begin
          BankAcc.Get("Bank Account No.");

        #4..9
          end;

          "Balance Last Statement" := BankAcc."Balance Last Statement";
        end;

        CreateDim(DATABASE::"Bank Account",BankAcc."No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..12
          // Added on 21/10/2021
          "Bank Account name" := BankAcc.Name;
        #13..15
        */
        //end;
        // field(50000;"Bank Account name";Text[250])
        // {
        //     DataClassification = ToBeClassified;
        // }
    }

    //Unsupported feature: Property Modification (Attributes) on "CreateDim(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "MatchSingle(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "ImportBankStatement(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDocDim(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "OpenNewWorksheet(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "ImportAndProcessToNewStatement(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "ImportStatement(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "ProcessStatement(PROCEDURE 20)".


    //Unsupported feature: Property Modification (Attributes) on "CreateNewBankPaymentAppBatch(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "SelectBankAccountToUse(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "OpenWorksheet(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "OpenList(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "SetFiltersOnBankAccReconLineTable(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "DrillDownOnBalanceOnBankAccount(PROCEDURE 38)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateDimTableIDs(PROCEDURE 164)".

}

