tableextension 60487 tableextension60487 extends "Transfer Shipment Header" 
{
    fields
    {
        field(50000;"Shipped By";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50001;"Date Shipped";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50002;"Time Shipped";Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50003;"Assigned User ID";Code[50])
        {
            Caption = 'Assigned User ID';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "Navigate(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "PrintRecords(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromTransferHeader(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromTransferHeader(PROCEDURE 5)".

}

