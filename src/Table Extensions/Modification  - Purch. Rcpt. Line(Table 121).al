tableextension 60038 tableextension60038 extends "Purch. Rcpt. Line" 
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on "Description(Field 11)".


        //Unsupported feature: Property Modification (Data type) on ""Description 2"(Field 12)".


        //Unsupported feature: Property Modification (Editable) on ""Unit Cost"(Field 100)".


        //Unsupported feature: Property Deletion (Editable) on ""Posting Group"(Field 8)".

        field(69;"Inv. Discount Amount";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Discount Amount';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                /*UpdateAmounts;
                UpdateUnitCost;
                CalcInvDiscToInvoice;
                */

            end;
        }
        field(105;"Inv. Disc. Amount to Invoice";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Disc. Amount to Invoice';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "GetCurrencyCodeFromHeader(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "ShowItemTrackingLines(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "InsertInvLineFromRcptLine(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "CalcReceivedPurchNotReturned(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "FilterPstdDocLnItemLedgEntries(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "ShowItemPurchInvLines(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "ShowLineComments(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "ShowShortcutDimCode(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "InitFromPurchLine(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "FormatType(PROCEDURE 144)".


    //Unsupported feature: Property Modification (Attributes) on "GetCaptionClass(PROCEDURE 34)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitFromPurchLine(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInsertInvLineFromRcptLine(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInsertInvLineFromRcptLine(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInsertInvLineFromRcptLineBeforeInsertTextLine(PROCEDURE 14)".

}

