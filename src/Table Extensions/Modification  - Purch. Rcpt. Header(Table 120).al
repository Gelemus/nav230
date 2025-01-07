tableextension 60033 tableextension60033 extends "Purch. Rcpt. Header" 
{
    fields
    {
        field(50000;"Reference No";Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50001;"Vendor Invoice No.2";Code[35])
        {
            DataClassification = ToBeClassified;
        }
        field(50002;"Position Title";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50003;"Delivery Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50004;"Vendor Email";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50005;"Vendor Phone Number";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50006;"Required on";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50010;"Inspection No";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50011;"Vendor Account No";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(52137003;"Delivery Note No.";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(52137004;"Purchase Requisition";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Requisitions";
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "PrintRecords(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "Navigate(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "SetSecurityFilterOnRespCenter(PROCEDURE 4)".

}

