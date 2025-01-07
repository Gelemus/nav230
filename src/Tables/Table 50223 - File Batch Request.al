table 50223 "File Batch Request"
{

    fields
    {
        field(1;"Request No";Code[100])
        {
        }
        field(2;"File No.";Code[100])
        {
            TableRelation = "File Detail"."File Code";

            trigger OnValidate()
            begin
                   FD.SetCurrentKey(FD."File Code");
                    FD.Get("File No.");
                   "File Name":=FD."File Description";
                   "Folio No.":=FD."Folio No.";
                   "SF No":=FD."Shelf  No.";
                   Modify;

                //IF
            end;
        }
        field(3;"No. Series";Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(4;"File Name";Text[250])
        {
        }
        field(5;"Issued?";Boolean)
        {
        }
        field(6;Volume;Code[10])
        {
        }
        field(7;"SF No";Code[100])
        {
        }
        field(8;"Folio No.";Code[100])
        {
        }
        field(9;"Return Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10;Time;Time)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Request No","File No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*
        IF "Request No"= '' THEN BEGIN
          SalesSetup.GET;
          SalesSetup.TESTFIELD(file);
          NoSeriesMgt.InitSeries(SalesSetup."File Issue No",xRec."Request No",0D,"Request No","No. Series");
          //NoSeriesMgt.InitSeries(SalesSetup."File Movement Numbers",xRec."File Movement Code",0D,"File Movement Code","No. Series");
        END;
        */

    end;

    var
        SalesSetup: Record "Resource Centre Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FD: Record "File Detail";
}

