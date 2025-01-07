tableextension 60219 tableextension60219 extends Item
{
    fields
    {
        field(182; "Customer Name"; Text[100])
        {
            Editable = false;

        }
        field(183; "Returned Status"; Option)
        {
            OptionMembers = " ","Issued","Returned";
            OptionCaption = '" ",Issued,Returned';
            Editable = false;
        }
        field(184; "InventoryI"; Decimal)
        {

        }
        field(185; Returnable; Boolean)
        {

        }
        field(50000; "Is Connection Item"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; TERTIARY; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "CLUSTER CONNECTIONS"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "NEW CONNECTIONS"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Sequence New Connections"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Sequence Cluster Connections"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Sequence Tertiary Connections"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Cluster Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "STOLEN METER"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Sequence Stolen Meter"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Meter Size (Inches)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "New Connection Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(52136923; "Location Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(52136924; "Market Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(52136930; "Item G/L Budget Account"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
    }
    keys
    {
        key(Key1; "Location Code")
        {
        }
        key(Key2; "Sequence New Connections")
        {
        }
        key(Key3; "Sequence Cluster Connections")
        {
        }
        key(Key4; "Sequence Tertiary Connections")
        {
        }

    }
    trigger OnInsert()

    begin


    end;


    var
        TempItemCategory: Record "Item Category";
}

