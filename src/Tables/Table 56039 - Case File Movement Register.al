table 56039 "Case File Movement Register"
{

    fields
    {
        field(1;"Code";Code[20])
        {

            trigger OnValidate()
            begin
                if Code<> xRec.Code then begin
                NoSetup.Get;
                NoSeriesMgt.TestManual(NoSetup."Case File Movement Nos");
                "No. Series" := '';
                end;
            end;
        }
        field(2;"Movement Reason Code";Code[20])
        {
            TableRelation = "Movement Reasons set-ups".Code;

            trigger OnValidate()
            begin
                if Movmnt.Get("Movement Reason Code") then
                "Movement Reason":=Movmnt.Description;
            end;
        }
        field(3;"Movement Reason";Code[20])
        {
            Editable = false;
        }
        field(4;"Case ID";Code[20])
        {
            TableRelation = "Case File"."Case ID";
        }
        field(5;"Source Type";Option)
        {
            OptionCaption = 'registry,legal,enforcement';
            OptionMembers = registry,legal,enforcement;
        }
        field(6;"Source No";Code[20])
        {
            TableRelation = Employee;
        }
        field(7;"Destination Type";Option)
        {
            OptionCaption = 'registry,legal,enforcement';
            OptionMembers = registry,legal,enforcement;
        }
        field(8;"Destination No";Code[20])
        {
            TableRelation = Employee;
        }
        field(9;"Transaction Date";Date)
        {
        }
        field(10;"Date Created";Date)
        {
            Editable = false;
        }
        field(11;"Time Created";Date)
        {
            Editable = false;
        }
        field(12;"Created By";Code[30])
        {
            Editable = false;
        }
        field(13;"No. Series";Code[20])
        {
        }
        field(14;"Requested By";Code[60])
        {
        }
        field(15;"Issued by";Code[60])
        {
        }
        field(16;"Current Location";Code[20])
        {
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
        if Code= '' then begin
          NoSetup.Get;
          NoSetup.TestField(NoSetup."Case File Movement Nos");
          NoSeriesMgt.InitSeries(NoSetup."Case File Movement Nos",xRec."No. Series",0D,Code,"No. Series");
        end;

        "Date Created":=Today;
        "Created By":=UserId;
        "Time Created":="Time Created";
    end;

    var
        NoSetup: Record "Accreditation/Arbitratio Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Movmnt: Record "Movement Reasons set-ups";
}

