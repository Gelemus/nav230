table 50786 "HrJob purpose"
{

    fields
    {
        field(1;"Job No";Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Jobs"."No.";
        }
        field(2;"Purpose Code";Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Job Lookup Value".Code WHERE (Option=FILTER("Job Purpose"));
        }
        field(3;Descrpition;Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Line No";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Line No.";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Job No","Purpose Code","Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

