tableextension 60149 tableextension60149 extends "Reversal Entry"
{

    //Unsupported feature: Property Modification (Attributes) on "ReverseTransaction(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "ReverseRegister(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "CheckEntries(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "SetReverseFilter(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "CopyReverseFilters(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "ShowGLEntries(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "ShowCustLedgEntries(PROCEDURE 26)".


    //Unsupported feature: Property Modification (Attributes) on "ShowVendLedgEntries(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "ShowBankAccLedgEntries(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "ShowFALedgEntries(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "ShowMaintenanceLedgEntries(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "ShowVATEntries(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "Caption(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "TestFieldError(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "AlreadyReversedEntry(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "VerifyReversalEntries(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "Equal(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "ReversalErrorForChangedEntry(PROCEDURE 31)".


    //Unsupported feature: Property Modification (Attributes) on "SetHideDialog(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "SetHideWarningDialogs(PROCEDURE 41)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromCustLedgEntry(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromBankAccLedgEntry(PROCEDURE 53)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromFALedgEntry(PROCEDURE 51)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromGLEntry(PROCEDURE 42)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromMaintenanceEntry(PROCEDURE 49)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromVATEntry(PROCEDURE 47)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromVendLedgEntry(PROCEDURE 55)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromEmployeeLedgerEntry(PROCEDURE 62)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCaption(PROCEDURE 43)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckEntries(PROCEDURE 66)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckBankAcc(PROCEDURE 75)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckGLAcc(PROCEDURE 67)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckCust(PROCEDURE 71)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckVend(PROCEDURE 73)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckEmpl(PROCEDURE 74)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckFA(PROCEDURE 76)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckMaintenance(PROCEDURE 77)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckVAT(PROCEDURE 80)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckDtldCustLedgEntry(PROCEDURE 82)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckDtldVendLedgEntry(PROCEDURE 83)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckDtldEmplLedgEntry(PROCEDURE 84)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromBankAccLedgEntry(PROCEDURE 52)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromCustLedgEntry(PROCEDURE 50)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromFALedgEntry(PROCEDURE 54)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromGLEntry(PROCEDURE 56)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromMaintenanceEntry(PROCEDURE 58)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromVATEntry(PROCEDURE 59)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromVendLedgEntry(PROCEDURE 60)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromEmplLedgEntry(PROCEDURE 65)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInsertReversalEntry(PROCEDURE 63)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetReverseFilter(PROCEDURE 48)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckEntries(PROCEDURE 46)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckRegister(PROCEDURE 87)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeReverseEntries(PROCEDURE 70)".

    local procedure "//Cust"()
    begin
    end;

    [Scope('Personalization')]
    procedure AlreadyReversedDocument(Caption: Text[50]; DocumentNo: Code[20])
    begin
        //Sysre Added
        //  Error(Text011,Caption,DocumentNo);
        //End Sysre Added
    end;
}

