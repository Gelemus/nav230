tableextension 60220 tableextension60220 extends "Bank Account" 
{
    fields
    {
        field(1261;"Bank Account Type";Option)
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre Next Gen Add-on Specifies the bank Account Type';
            OptionCaption = 'Normal,Petty Cash,Fuel Card,Credit Card,Mobile Banking,Fixed Deposit';
            OptionMembers = Normal,"Petty Cash","Fuel Card","Credit Card","Mobile Banking","Fixed Deposit";
        }
        field(50000;"Float Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50001;"Budget Gl";Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." WHERE ("Account Type"=CONST(Posting));
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "AssistEdit(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "ShowContact(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "SetInsertFromContact(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "GetPaymentExportCodeunitID(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "GetPaymentExportXMLPortID(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "GetDDExportCodeunitID(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "GetDDExportXMLPortID(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "GetBankExportImportSetup(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "GetDDExportImportSetup(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "GetCreditTransferMessageNo(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "GetDirectDebitMessageNo(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "DisplayMap(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "GetDataExchDef(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "GetDataExchDefPaymentExport(PROCEDURE 51)".


    //Unsupported feature: Property Modification (Attributes) on "GetBankAccountNoWithCheck(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "GetBankAccountNo(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "IsInLocalCurrency(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "GetPosPayExportCodeunitID(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "IsLinkedToBankStatementServiceProvider(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "StatementProvidersExist(PROCEDURE 37)".


    //Unsupported feature: Property Modification (Attributes) on "LinkStatementProvider(PROCEDURE 32)".


    //Unsupported feature: Property Modification (Attributes) on "SimpleLinkStatementProvider(PROCEDURE 39)".


    //Unsupported feature: Property Modification (Attributes) on "UnlinkStatementProvider(PROCEDURE 31)".


    //Unsupported feature: Property Modification (Attributes) on "RefreshStatementProvider(PROCEDURE 47)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateBankAccountLinking(PROCEDURE 35)".


    //Unsupported feature: Property Modification (Attributes) on "GetUnlinkedBankAccounts(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "GetLinkedBankAccounts(PROCEDURE 33)".


    //Unsupported feature: Property Modification (Attributes) on "IsAutoLogonPossible(PROCEDURE 28)".


    //Unsupported feature: Property Modification (Attributes) on "CreateNewAccount(PROCEDURE 42)".


    //Unsupported feature: Property Modification (Attributes) on "GetOnlineFeedStatementStatus(PROCEDURE 44)".


    //Unsupported feature: Property Modification (Attributes) on "DisableStatementProviders(PROCEDURE 45)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterIsUpdateNeeded(PROCEDURE 50)".


    //Unsupported feature: Property Modification (Attributes) on "OnCheckLinkedToStatementProviderEvent(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "OnCheckAutoLogonPossibleEvent(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "OnUnlinkStatementProviderEvent(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Attributes) on "OnMarkAccountLinkedEvent(PROCEDURE 41)".


    //Unsupported feature: Property Modification (Attributes) on "OnSimpleLinkStatementProviderEvent(PROCEDURE 40)".


    //Unsupported feature: Property Modification (Attributes) on "OnLinkStatementProviderEvent(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "OnRefreshStatementProviderEvent(PROCEDURE 48)".


    //Unsupported feature: Property Modification (Attributes) on "OnGetDataExchangeDefinitionEvent(PROCEDURE 26)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdateBankAccountLinkingEvent(PROCEDURE 34)".


    //Unsupported feature: Property Modification (Attributes) on "OnGetStatementProvidersEvent(PROCEDURE 36)".


    //Unsupported feature: Property Modification (Attributes) on "OnDisableStatementProviderEvent(PROCEDURE 46)".

}

