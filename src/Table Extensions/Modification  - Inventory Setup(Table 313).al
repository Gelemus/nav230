tableextension 60252 tableextension60252 extends "Inventory Setup"
{
    fields
    {
        field(182; "Returnable"; Code[50])
        {
            AccessByPermission = TableData "Whse. Internal Put-away Header" = R;
            Caption = 'Returnable  Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";

        }
        field(7307; "Bottled Water Nos."; Code[20])
        {
            AccessByPermission = TableData "Whse. Internal Put-away Header" = R;
            Caption = 'Bottled Water Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(7308; "Store Issue Note Nos."; Code[20])
        {
            AccessByPermission = TableData "Whse. Internal Put-away Header" = R;
            Caption = 'Store Issue Note Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(7309; "Donation Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50000; "Location Code for templates"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(50001; "Loose Tools"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(52136925; "Stores Requisition Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Sysre NextGen Addon - Specifies the Stores Requisition No. Series';
            TableRelation = "No. Series";
        }
        field(52136983; "Item Journal Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            TableRelation = "Item Journal Template".Name;
        }
        field(52136984; "Item Journal Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Item Journal Template"));
        }
        field(52136985; "Return Store Requisition Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Sysre NextGen Addon - Specifies the Return Store  Requisition No. Series';
            TableRelation = "No. Series";
        }
    }
}

