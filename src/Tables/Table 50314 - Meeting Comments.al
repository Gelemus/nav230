table 50314 "Meeting Comments"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Meeting No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Comment; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Member No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Time Created"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No", "Meeting No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*IF "Entry No" = '' THEN BEGIN
          HumanResSetup.GET;
          HumanResSetup.TESTFIELD(HumanResSetup."Board Comments Nos");
          NoSeriesMgt.InitSeries(HumanResSetup."Board Comments Nos",xRec."No. Series",0D,"Entry No","No. Series");
        END;*/

    end;

    var
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

