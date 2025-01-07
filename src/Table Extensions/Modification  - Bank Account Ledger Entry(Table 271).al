tableextension 60221 tableextension60221 extends "Bank Account Ledger Entry" 
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""External Document No."(Field 63)".


        //Unsupported feature: Property Deletion (TestTableRelation) on ""Statement No."(Field 56)".

        field(50000;"Reference No.";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50001;Applied;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002;Payee;Text[250])
        {
            CalcFormula = Lookup("Payment Header"."Payee Name" WHERE ("No."=FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(50003;"Statement Date";Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromGenJnlLine(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateDebitCredit(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "IsApplied(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "SetStyle(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "SetFilterBankAccNoOpen(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromGenJnlLine(PROCEDURE 7)".

}

