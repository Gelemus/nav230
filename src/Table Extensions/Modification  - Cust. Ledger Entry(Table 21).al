tableextension 60177 tableextension60177 extends "Cust. Ledger Entry" 
{
    fields
    {
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
        field(52137150;"Property No.";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
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
    }

    //Unsupported feature: Property Modification (Attributes) on "ShowDoc(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "ShowPostedDocAttachment(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "HasPostedDocAttachment(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "DrillDownOnEntries(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "DrillDownOnOverdueEntries(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "GetOriginalCurrencyFactor(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "GetAdjustedCurrencyFactor(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "SetStyle(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "SetApplyToFilters(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "SetAmountToApply(PROCEDURE 35)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromGenJnlLine(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromCVLedgEntryBuffer(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "RecalculateAmounts(PROCEDURE 26)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyCustLedgerEntryFromGenJnlLine(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyCustLedgerEntryFromCVLedgEntryBuffer(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterShowDoc(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeDrillDownEntries(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeDrillDownOnOverdueEntries(PROCEDURE 13)".

}

