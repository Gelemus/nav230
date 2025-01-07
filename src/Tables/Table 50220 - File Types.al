table 50220 "File Types"
{
    DrillDownPageID = "File Types";
    LookupPageID = "File Types";

    fields
    {
        field(1;"Type Code";Code[50])
        {
            NotBlank = false;
        }
        field(2;Description;Text[80])
        {
        }
        field(5;"No. Series";Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(6;Files;Integer)
        {
            CalcFormula = Count("File Detail" WHERE ("File Class"=FIELD("Type Code")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"Type Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "Type Code" = '' then begin
          SalesSetup.Get;
          SalesSetup.TestField(Files);
          NoSeriesMgt.InitSeries(SalesSetup.Files,xRec."No. Series",0D,"Type Code","No. Series");
        end;
    end;

    var
        SalesSetup: Record "Resource Centre Setup";
        CommentLine: Record "Comment Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Users: Record "User Setup";
}

