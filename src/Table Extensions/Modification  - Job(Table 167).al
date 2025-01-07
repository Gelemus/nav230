tableextension 60136 tableextension60136 extends Job 
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Search Description"(Field 2)".


        //Unsupported feature: Property Modification (Data type) on "Description(Field 3)".

        field(50001;Location;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50002;Contractor;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50003;"Contractor Phone No";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50004;"Contractor Location";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50005;"Budget G/L";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50006;"Budget G/L Name";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50007;"Project Status";Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "AssistEdit(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "InitWIPFields(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "TestBlocked(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "CurrencyUpdatePlanningLines(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "DisplayMap(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "GetQuantityAvailable(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "CalcAccWIPCostsAmount(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "CalcAccWIPSalesAmount(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "CalcRecognizedProfitAmount(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "CalcRecognizedProfitPercentage(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "CalcRecognizedProfitGLAmount(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "CalcRecognProfitGLPercentage(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "CopyDefaultDimensionsFromCustomer(PROCEDURE 37)".


    //Unsupported feature: Property Modification (Attributes) on "PercentCompleted(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "PercentInvoiced(PROCEDURE 20)".


    //Unsupported feature: Property Modification (Attributes) on "PercentOverdue(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateOverBudgetValue(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "IsJobSimplificationAvailable(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Attributes) on "SendRecords(PROCEDURE 34)".


    //Unsupported feature: Property Modification (Attributes) on "SendProfile(PROCEDURE 33)".


    //Unsupported feature: Property Modification (Attributes) on "PrintRecords(PROCEDURE 32)".


    //Unsupported feature: Property Modification (Attributes) on "EmailRecords(PROCEDURE 31)".


    //Unsupported feature: Property Modification (Attributes) on "RecalculateJobWIP(PROCEDURE 48)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateBillToCust(PROCEDURE 1001)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterChangeJobCompletionStatus(PROCEDURE 1002)".

}

