table 56037 "Case Schedule"
{

    fields
    {
        field(1;"Case ID";Code[20])
        {

            trigger OnValidate()
            begin
                if "Case ID"<> xRec."Case ID" then begin
                NoSetup.Get;
                NoSeriesMgt.TestManual(NoSetup."Case Nos");
                "No. Series" := '';
                end;
            end;
        }
        field(2;"Court Date";Date)
        {
        }
        field(3;"Type of Proceedings";Code[10])
        {
            TableRelation = "Case Document Types".Code;

            trigger OnValidate()
            begin
                if proceed.Get("Type of Proceedings") then
                "Proceedings Description":=proceed.Description;
            end;
        }
        field(4;"Proceedings Description";Text[60])
        {
        }
        field(5;"Date Created";Date)
        {
            Editable = false;
        }
        field(6;"Time Created";Date)
        {
            Editable = false;
        }
        field(7;"Created By";Code[20])
        {
            Editable = false;
        }
        field(8;"No. Series";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"Case ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Case ID"= '' then begin
          NoSetup.Get;
          NoSetup.TestField(NoSetup."Case Nos");
          NoSeriesMgt.InitSeries(NoSetup."Case Nos",xRec."No. Series",0D,"Case ID","No. Series");
        end;

        "Date Created":=Today;
        "Created By":=UserId;
        "Time Created":="Time Created";
    end;

    var
        NoSetup: Record "Accreditation/Arbitratio Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        proceed: Record "Case Document Types";
}

