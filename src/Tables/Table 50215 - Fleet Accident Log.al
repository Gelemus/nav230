table 50215 "Fleet Accident Log"
{

    fields
    {
        field(1;"Accident No.";Code[20])
        {

            trigger OnValidate()
            begin
                if FixedAsset.Get("Fixed Asset No.") then begin
                "Fixed Asset Name":=FixedAsset.Description;
                "Item Class Code":=FixedAsset."FA Class Code";
                end;
            end;
        }
        field(2;"Accident Description";Text[80])
        {
        }
        field(3;"Fixed Asset No.";Code[20])
        {
            TableRelation = "Fixed Asset";

            trigger OnValidate()
            begin
                if FixedAsset.Get("Fixed Asset No.") then begin
                "Fixed Asset Name":=FixedAsset.Description;
                "Item Class Code":=FixedAsset."FA Class Code";
                end;
            end;
        }
        field(4;"Fixed Asset Name";Text[80])
        {
        }
        field(5;"Date of Accident";Date)
        {
        }
        field(6;"Cause of Accident";Text[100])
        {
        }
        field(7;"Damage Description";Text[100])
        {
        }
        field(8;"Total Occupants";Integer)
        {
        }
        field(9;"Occupants Injured";Integer)
        {
        }
        field(10;"Occupants Killed";Integer)
        {
        }
        field(11;"Item Class Code";Code[20])
        {
        }
        field(12;"No. Series";Code[20])
        {
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1;"Accident No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Accident No." = '' then begin
          HRSetup.Get;
          HRSetup.TestField("Fleet Accident Nos");
          NoSeriesMgt.InitSeries(HRSetup."Fleet Accident Nos",xRec."No. Series",0D,"Accident No.","No. Series");
        end;
    end;

    var
        VendorRec: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

