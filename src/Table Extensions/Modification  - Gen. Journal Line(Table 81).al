tableextension 60658 tableextension60658 extends "Gen. Journal Line" 
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""External Document No."(Field 77)".

        field(50000;Payee;Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50500;"Reference No";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(52136923;Description2;Text[250])
        {
            Caption = 'Description2';
            DataClassification = ToBeClassified;
        }
        field(52136924;"Document Source";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(52136925;Document_Type;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(52136930;"Shortcut Dimension 3 Code";Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
            end;
        }
        field(52136931;"Shortcut Dimension 4 Code";Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(4),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
            end;
        }
        field(52136932;"Shortcut Dimension 5 Code";Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(5),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(5,"Shortcut Dimension 5 Code");
            end;
        }
        field(52136933;"Shortcut Dimension 6 Code";Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(6),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(6,"Shortcut Dimension 6 Code");
            end;
        }
        field(52136934;"Shortcut Dimension 7 Code";Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(7),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(7,"Shortcut Dimension 7 Code");
            end;
        }
        field(52136935;"Shortcut Dimension 8 Code";Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(8),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(8,"Shortcut Dimension 8 Code");
            end;
        }
        field(52137023;"Employee Transaction Type";Option)
        {
            Caption = 'Employee Transaction Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Salary,Imprest,Advance,Transfer Allowance';
            OptionMembers = " ",Salary,Imprest,Advance,"Transfer Allowance";
        }
        field(52137063;"Customer No.";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(52137064;"Customer Name";Text[100])
        {
            CalcFormula = Lookup(Customer.Name WHERE ("No."=FIELD("Customer No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(52137123;"Payroll Period";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(52137124;"Payroll Group Code";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(52137125;"Cheque No.";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(52137150;"Property No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(52137151;"Block Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(52137152;"Floor Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(52137153;"Unit Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(52137630;"Investment Application No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(52137650;"Investment Account No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(52137651;"Investment Transaction Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Loan Disbursement,Principal Receivable,Principal Payment,Interest Receivable,Interest Payment,Penalty Interest Receivable,Penalty Interest Payment,Loan Fee Receivable,Loan Fee Payment,Equity Fair Value';
            OptionMembers = " ","Loan Disbursement","Principal Receivable","Principal Payment","Interest Receivable","Interest Payment","Penalty Interest Receivable","Penalty Interest Payment","Loan Fee Receivable","Loan Fee Payment","Equity Fair Value";
        }
        field(52137652;"Recovery Priority";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(52137703;"Investment Product Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(52137719;"Industry Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(52137720;"Sector Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(52137721;"Payroll Calculated";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52137722;HideDialog;Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "EmptyLine(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateLineBalance(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "SetUpNewLine(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "InitNewLine(PROCEDURE 94)".


    //Unsupported feature: Property Modification (Attributes) on "CheckDocNoOnLines(PROCEDURE 78)".


    //Unsupported feature: Property Modification (Attributes) on "CheckDocNoBasedOnNoSeries(PROCEDURE 74)".


    //Unsupported feature: Property Modification (Attributes) on "RenumberDocumentNo(PROCEDURE 68)".


    //Unsupported feature: Property Modification (Attributes) on "SetCurrencyFactor(PROCEDURE 130)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateSource(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "GetFAAddCurrExchRate(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "GetShowCurrencyCode(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "ClearCustVendApplnEntry(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "CheckFixedCurrency(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "CreateDim(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "LookupShortcutDimCode(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "ShowShortcutDimCode(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 26)".


    //Unsupported feature: Property Modification (Attributes) on "GetFAVATSetup(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "GetTemplate(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "LookUpAppliesToDocCust(PROCEDURE 35)".


    //Unsupported feature: Property Modification (Attributes) on "LookUpAppliesToDocVend(PROCEDURE 36)".


    //Unsupported feature: Property Modification (Attributes) on "LookUpAppliesToDocEmpl(PROCEDURE 171)".


    //Unsupported feature: Property Modification (Attributes) on "SetApplyToAmount(PROCEDURE 20)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateApplyRequirements(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "JobTaskIsSet(PROCEDURE 28)".


    //Unsupported feature: Property Modification (Attributes) on "CreateTempJobJnlLine(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePricesFromJobJnlLine(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "SetHideValidation(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "IsApplied(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "DataCaption(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustLedgerEntry(PROCEDURE 33)".


    //Unsupported feature: Property Modification (Attributes) on "GetVendLedgerEntry(PROCEDURE 37)".


    //Unsupported feature: Property Modification (Attributes) on "GetEmplLedgerEntry(PROCEDURE 183)".


    //Unsupported feature: Property Modification (Attributes) on "IncludeVATAmount(PROCEDURE 38)".


    //Unsupported feature: Property Modification (Attributes) on "ConvertAmtFCYToLCYForSourceCurrency(PROCEDURE 39)".


    //Unsupported feature: Property Modification (Attributes) on "MatchSingleLedgerEntry(PROCEDURE 40)".


    //Unsupported feature: Property Modification (Attributes) on "GetStyle(PROCEDURE 41)".


    //Unsupported feature: Property Modification (Attributes) on "GetOverdueDateInteractions(PROCEDURE 75)".


    //Unsupported feature: Property Modification (Attributes) on "ClearDataExchangeEntries(PROCEDURE 42)".


    //Unsupported feature: Property Modification (Attributes) on "ClearAppliedGenJnlLine(PROCEDURE 49)".


    //Unsupported feature: Property Modification (Attributes) on "GetIncomingDocumentURL(PROCEDURE 50)".


    //Unsupported feature: Property Modification (Attributes) on "InsertPaymentFileError(PROCEDURE 64)".


    //Unsupported feature: Property Modification (Attributes) on "InsertPaymentFileErrorWithDetails(PROCEDURE 83)".


    //Unsupported feature: Property Modification (Attributes) on "DeletePaymentFileBatchErrors(PROCEDURE 67)".


    //Unsupported feature: Property Modification (Attributes) on "DeletePaymentFileErrors(PROCEDURE 61)".


    //Unsupported feature: Property Modification (Attributes) on "HasPaymentFileErrors(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Attributes) on "HasPaymentFileErrorsInBatch(PROCEDURE 65)".


    //Unsupported feature: Property Modification (Attributes) on "GetAppliesToDocEntryNo(PROCEDURE 63)".


    //Unsupported feature: Property Modification (Attributes) on "GetAppliesToDocDueDate(PROCEDURE 62)".


    //Unsupported feature: Property Modification (Attributes) on "IsCustVendICAdded(PROCEDURE 209)".


    //Unsupported feature: Property Modification (Attributes) on "IsExportedToPaymentFile(PROCEDURE 1020)".


    //Unsupported feature: Property Modification (Attributes) on "IsPaymentJournallLineExported(PROCEDURE 80)".


    //Unsupported feature: Property Modification (Attributes) on "IsAppliedToVendorLedgerEntryExported(PROCEDURE 79)".


    //Unsupported feature: Property Modification (Attributes) on "SetPostingDateAsDueDate(PROCEDURE 77)".


    //Unsupported feature: Property Modification (Attributes) on "CalculatePostingDate(PROCEDURE 76)".


    //Unsupported feature: Property Modification (Attributes) on "ImportBankStatement(PROCEDURE 73)".


    //Unsupported feature: Property Modification (Attributes) on "ExportPaymentFile(PROCEDURE 81)".


    //Unsupported feature: Property Modification (Attributes) on "TotalExportedAmount(PROCEDURE 85)".


    //Unsupported feature: Property Modification (Attributes) on "DrillDownExportedAmount(PROCEDURE 95)".


    //Unsupported feature: Property Modification (Attributes) on "CopyDocumentFields(PROCEDURE 129)".


    //Unsupported feature: Property Modification (Attributes) on "CopyCustLedgEntry(PROCEDURE 134)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromGenJnlAllocation(PROCEDURE 113)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromInvoicePostBuffer(PROCEDURE 112)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromInvoicePostBufferFA(PROCEDURE 111)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPrepmtInvoiceBuffer(PROCEDURE 110)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPurchHeader(PROCEDURE 109)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPurchHeaderPrepmt(PROCEDURE 127)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPurchHeaderPrepmtPost(PROCEDURE 137)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPurchHeaderApplyTo(PROCEDURE 107)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPurchHeaderPayment(PROCEDURE 104)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromSalesHeader(PROCEDURE 103)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromSalesHeaderPrepmt(PROCEDURE 119)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromSalesHeaderPrepmtPost(PROCEDURE 138)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromSalesHeaderApplyTo(PROCEDURE 100)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromSalesHeaderPayment(PROCEDURE 99)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromServiceHeader(PROCEDURE 98)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromServiceHeaderApplyTo(PROCEDURE 97)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromServiceHeaderPayment(PROCEDURE 96)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPaymentCustLedgEntry(PROCEDURE 205)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPaymentVendLedgEntry(PROCEDURE 202)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPaymentEmpLedgEntry(PROCEDURE 1250)".


    //Unsupported feature: Property Modification (Attributes) on "CheckModifyCurrencyCode(PROCEDURE 105)".


    //Unsupported feature: Property Modification (Attributes) on "IsOpenedFromBatch(PROCEDURE 87)".


    //Unsupported feature: Property Modification (Attributes) on "GetDeferralAmount(PROCEDURE 88)".


    //Unsupported feature: Property Modification (Attributes) on "GetDeferralDocType(PROCEDURE 106)".


    //Unsupported feature: Property Modification (Attributes) on "IsForPurchase(PROCEDURE 86)".


    //Unsupported feature: Property Modification (Attributes) on "IsForSales(PROCEDURE 89)".


    //Unsupported feature: Property Modification (Attributes) on "OnCheckGenJournalLinePostRestrictions(PROCEDURE 90)".


    //Unsupported feature: Property Modification (Attributes) on "OnCheckGenJournalLinePrintCheckRestrictions(PROCEDURE 92)".


    //Unsupported feature: Property Modification (Attributes) on "OnMoveGenJournalLine(PROCEDURE 93)".


    //Unsupported feature: Property Modification (Attributes) on "IncrementDocumentNo(PROCEDURE 120)".


    //Unsupported feature: Property Modification (Attributes) on "NeedCheckZeroAmount(PROCEDURE 196)".


    //Unsupported feature: Property Modification (Attributes) on "IsRecurring(PROCEDURE 199)".


    //Unsupported feature: Property Modification (Attributes) on "CreateFAAcquisitionLines(PROCEDURE 131)".


    //Unsupported feature: Property Modification (Attributes) on "SetAccountNoFromFilter(PROCEDURE 135)".


    //Unsupported feature: Property Modification (Attributes) on "GetNewLineNo(PROCEDURE 136)".


    //Unsupported feature: Property Modification (Attributes) on "VoidPaymentFile(PROCEDURE 139)".


    //Unsupported feature: Property Modification (Attributes) on "TransmitPaymentFile(PROCEDURE 142)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateSalesPersonPurchaserCode(PROCEDURE 298)".


    //Unsupported feature: Property Modification (Attributes) on "CheckIfPrivacyBlocked(PROCEDURE 208)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetupNewLine(PROCEDURE 161)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterClearCustApplnEntryFields(PROCEDURE 212)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterClearEmplApplnEntryFields(PROCEDURE 218)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterClearVendApplnEntryFields(PROCEDURE 213)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromCustLedgEntry(PROCEDURE 181)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromGenJnlAllocation(PROCEDURE 182)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromSalesHeader(PROCEDURE 160)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromSalesHeaderPrepmt(PROCEDURE 195)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromSalesHeaderPrepmtPost(PROCEDURE 197)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromSalesHeaderApplyTo(PROCEDURE 200)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromSalesHeaderPayment(PROCEDURE 201)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromPurchHeader(PROCEDURE 141)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromPurchHeaderPrepmt(PROCEDURE 186)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromPurchHeaderPrepmtPost(PROCEDURE 187)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromPurchHeaderApplyTo(PROCEDURE 192)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromPurchHeaderPayment(PROCEDURE 194)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromServHeader(PROCEDURE 163)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromServHeaderApplyTo(PROCEDURE 203)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromServHeaderPayment(PROCEDURE 204)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromInvPostBuffer(PROCEDURE 144)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromInvPostBufferFA(PROCEDURE 184)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromPrepmtInvBuffer(PROCEDURE 148)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetGLAccount(PROCEDURE 145)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetGLBalAccount(PROCEDURE 147)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetCustomerAccount(PROCEDURE 149)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetCustomerBalAccount(PROCEDURE 152)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetVendorAccount(PROCEDURE 150)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetVendorBalAccount(PROCEDURE 153)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetEmployeeAccount(PROCEDURE 189)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetEmployeeBalAccount(PROCEDURE 179)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetBankAccount(PROCEDURE 155)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetBankBalAccount(PROCEDURE 154)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetFAAccount(PROCEDURE 157)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetFABalAccount(PROCEDURE 156)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetICPartnerAccount(PROCEDURE 159)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetICPartnerBalAccount(PROCEDURE 158)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateTempJobJnlLine(PROCEDURE 151)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCreateTempJobJnlLine(PROCEDURE 162)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdatePricesFromJobJnlLine(PROCEDURE 166)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateDimTableIDs(PROCEDURE 164)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateFAAcquisitionLines(PROCEDURE 245)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterClearPostingGroups(PROCEDURE 168)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterClearBalPostingGroups(PROCEDURE 169)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetCustLedgerEntry(PROCEDURE 234)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetEmplLedgerEntry(PROCEDURE 237)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetVendLedgerEntry(PROCEDURE 236)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterValidateApplyRequirements(PROCEDURE 207)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckDirectPosting(PROCEDURE 220)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetAmountWithRemaining(PROCEDURE 233)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetJournalLineFieldsFromApplication(PROCEDURE 231)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateDocumentTypeAndAppliesToFields(PROCEDURE 221)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckDirectPosting(PROCEDURE 219)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeLookUpAppliesToDocCust(PROCEDURE 214)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeLookUpAppliesToDocEmpl(PROCEDURE 216)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeLookUpAppliesToDocVend(PROCEDURE 215)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeSetAmountWithCustLedgEntry(PROCEDURE 232)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeSetAmountWithVendLedgEntry(PROCEDURE 230)".


    //Unsupported feature: Property Modification (Attributes) on "OnLookUpAppliesToDocCustOnAfterSetFilters(PROCEDURE 235)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateBalGenBusPostingGroup(PROCEDURE 248)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateBalGenPostingType(PROCEDURE 246)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateBalGenProdPostingGroup(PROCEDURE 249)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateGenBusPostingGroup(PROCEDURE 240)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateGenPostingType(PROCEDURE 244)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateGenProdPostingGroup(PROCEDURE 241)".


    //Unsupported feature: Property Modification (Attributes) on "OnGetFAVATSetupOnBeforeCheckGLAcc(PROCEDURE 247)".


    //Unsupported feature: Property Modification (Attributes) on "OnGetCustLedgerEntryOnAfterAssignCustomerNo(PROCEDURE 242)".


    //Unsupported feature: Property Modification (Attributes) on "OnGetVendLedgerEntryOnAfterAssignVendorNo(PROCEDURE 243)".


    //Unsupported feature: Property Modification (Attributes) on "OnLookUpAppliesToDocCustOnAfterUpdateDocumentTypeAndAppliesTo(PROCEDURE 225)".


    //Unsupported feature: Property Modification (Attributes) on "OnLookUpAppliesToDocEmplOnAfterSetFilters(PROCEDURE 239)".


    //Unsupported feature: Property Modification (Attributes) on "OnLookUpAppliesToDocEmplOnAfterUpdateDocumentTypeAndAppliesTo(PROCEDURE 229)".


    //Unsupported feature: Property Modification (Attributes) on "OnLookUpAppliesToDocVendOnAfterSetFilters(PROCEDURE 238)".


    //Unsupported feature: Property Modification (Attributes) on "OnLookUpAppliesToDocVendOnAfterUpdateDocumentTypeAndAppliesTo(PROCEDURE 227)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdateLineBalanceOnAfterAssignBalanceLCY(PROCEDURE 226)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateAmountOnAfterAssignAmountLCY(PROCEDURE 222)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateBalVATPctOnAfterAssignBalVATAmountLCY(PROCEDURE 224)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateAccountID(PROCEDURE 1166)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateCustomerID(PROCEDURE 175)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateAppliesToInvoiceID(PROCEDURE 167)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateGraphContactId(PROCEDURE 170)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateJournalBatchID(PROCEDURE 173)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePaymentMethodId(PROCEDURE 198)".


    //Unsupported feature: Property Modification (Attributes) on "OnGenJnlLineGetVendorAccount(PROCEDURE 1217)".

}

