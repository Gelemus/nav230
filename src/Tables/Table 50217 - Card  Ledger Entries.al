table 50217 "Card  Ledger Entries"
{

    fields
    {
        field(1;"Card no";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Card Information";

            trigger OnValidate()
            begin
                if CardInfo.Get("Card no") then
                   "Card Description" := CardInfo.Description;
            end;
        }
        field(2;"Card Description";Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Card Information";
        }
        field(3;"Balance BF";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Amount Loaded";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Loading Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Date Filter";Date)
        {
            FieldClass = FlowFilter;
        }
        field(7;"Loaded By";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Code";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9;"No. Series";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Amount Spent";Decimal)
        {
            CalcFormula = Sum("Vehicle Filling".Amount WHERE ("Card No"=FIELD("Card no"),
                                                              "Filling Date"=FIELD("Date Filter")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if Code = '' then begin
          HumanResSetup.Get;
          HumanResSetup.TestField(HumanResSetup."Card Nos");
          NoSeriesMgt.InitSeries(HumanResSetup."Card Nos",xRec."No. Series",0D,Code,"No. Series");
        end;

        "Loading Date" := Today;
        "Loaded By" := UserId;
    end;

    var
        CardInfo: Record "Card Information";
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

