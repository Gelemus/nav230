tableextension 60151 tableextension60151 extends Customer 
{
    fields
    {
        field(52137048;PasswordResetToken;Text[250])
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Human Capital Management)';
        }
        field(52137049;PasswordResetTokenExpiry;DateTime)
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Human Capital Management)';
        }
        field(52137050;"Portal Password";Text[250])
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Human Capital Management)';
            Editable = true;
        }
        field(52137051;"Default Portal Password";Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Human Capital Management)';
            Editable = false;
        }
        field(52137052;"Old Account No.";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(52137063;"Account Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Employee,Investment,Tenant';
            OptionMembers = " ",Employee,Investment,Tenant;
        }
        field(52137064;"Application No.";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(52137623;"Customer Registration No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(52137624;"Account No.";Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "AssistEdit(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "ShowContact(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "SetInsertFromContact(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "CheckBlockedCustOnDocs(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "CheckBlockedCustOnJnls(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "CustBlockedErrorMessage(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "CustPrivacyBlockedErrorMessage(PROCEDURE 72)".


    //Unsupported feature: Property Modification (Attributes) on "GetPrivacyBlockedGenericErrorText(PROCEDURE 73)".


    //Unsupported feature: Property Modification (Attributes) on "DisplayMap(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "GetTotalAmountLCY(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "GetTotalAmountLCYUI(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "GetSalesLCY(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "CalcAvailableCredit(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "CalcAvailableCreditUI(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "CalcOverdueBalance(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "GetLegalEntityType(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "GetLegalEntityTypeLbl(PROCEDURE 26)".


    //Unsupported feature: Property Modification (Attributes) on "SetStyle(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "HasValidDDMandate(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "GetReturnRcdNotInvAmountLCY(PROCEDURE 53)".


    //Unsupported feature: Property Modification (Attributes) on "GetInvoicedPrepmtAmountLCY(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "CalcCreditLimitLCYExpendedPct(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "CreateAndShowNewInvoice(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "CreateAndShowNewOrder(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "CreateAndShowNewCreditMemo(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "CreateAndShowNewQuote(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Attributes) on "GetBillToCustomerNo(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "HasAddressIgnoreCountryCode(PROCEDURE 37)".


    //Unsupported feature: Property Modification (Attributes) on "HasAddress(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "HasDifferentAddress(PROCEDURE 49)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustNo(PROCEDURE 44)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustNoOpenCard(PROCEDURE 36)".


    //Unsupported feature: Property Modification (Attributes) on "CreateNewCustomer(PROCEDURE 28)".


    //Unsupported feature: Property Modification (Attributes) on "OpenCustomerLedgerEntries(PROCEDURE 31)".


    //Unsupported feature: Property Modification (Attributes) on "SetInsertFromTemplate(PROCEDURE 32)".


    //Unsupported feature: Property Modification (Attributes) on "IsLookupRequested(PROCEDURE 34)".


    //Unsupported feature: Property Modification (Attributes) on "IsBlocked(PROCEDURE 52)".


    //Unsupported feature: Property Modification (Attributes) on "HasAnyOpenOrPostedDocuments(PROCEDURE 60)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromCustomerTemplate(PROCEDURE 63)".


    //Unsupported feature: Property Modification (Attributes) on "SetAddress(PROCEDURE 40)".


    //Unsupported feature: Property Modification (Attributes) on "FindByEmail(PROCEDURE 41)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateReferencedIds(PROCEDURE 61)".


    //Unsupported feature: Property Modification (Attributes) on "GetReferencedIds(PROCEDURE 46)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateCurrencyId(PROCEDURE 55)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePaymentTermsId(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateShipmentMethodId(PROCEDURE 59)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePaymentMethodId(PROCEDURE 45)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateTaxAreaId(PROCEDURE 1166)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeIsContactUpdateNeeded(PROCEDURE 50)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromCustomerTemplate(PROCEDURE 64)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterHasAnyOpenOrPostedDocuments(PROCEDURE 62)".


    //Unsupported feature: Property Modification (Fields) on "DropDown(FieldGroup 1)".

}

