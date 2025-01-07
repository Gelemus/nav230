table 50319 "Rules & Regulations"
{

    fields
    {
        field(1;No;Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Document Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3;Remarks;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4;Description;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Start Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6;"End Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Start Time";Time)
        {
            DataClassification = ToBeClassified;
        }
        field(8;"End Time";Time)
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Venue/Location";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10;Cost;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Company Activities";Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;No)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Document Date" := Today;
    end;
}

