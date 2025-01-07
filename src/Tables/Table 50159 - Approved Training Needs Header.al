table 50159 "Approved Training Needs Header"
{

    fields
    {
        field(1;"No.";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2;Description;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Calendar Year";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Calendar Period".Code;
        }
        field(4;"Document Date";Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10;"User ID";Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14;"No. Series";Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //GENERATE NEW NUMBER FOR THE DOCUMENT
        if "No."= '' then begin
          HRSetup.Get;
          HRSetup.TestField(HRSetup."Approved Training Nos");
          NoSeriesMgt.InitSeries(HRSetup."Approved Training Nos",xRec."No. Series",0D,"No.","No. Series");
        end;

        "Document Date":=Today;
        "User ID":=UserId;
    end;

    var
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

