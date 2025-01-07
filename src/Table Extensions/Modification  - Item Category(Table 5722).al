tableextension 60483 tableextension60483 extends "Item Category" 
{
    fields
    {
        field(8001;"Item Budget G/L";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(8002;"Inventory Posting Group";Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Inventory Posting Group";
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "HasChildren(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "GetStyleText(PROCEDURE 3)".

}

