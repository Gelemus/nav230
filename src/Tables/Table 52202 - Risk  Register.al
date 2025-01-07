table 52202 "Risk  Register"
{

    fields
    {
        field(1;"Ref Id";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Key Process";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3;Probability;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',low,High,Medium';
            OptionMembers = ,low,High,Medium;
        }
        field(4;"Accepted Probability";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Accepted Impact";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(7;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(8;Status;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'open,Submitted';
            OptionMembers = open,Submitted;
        }
        field(9;"Date Submitted";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Time Submitted";Time)
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Document Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12;"Submitted By";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13;"Created By";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14;"No. Series";Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Ref Id")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Ref Id" = '' then begin
            FundsSetup.Get;
            FundsSetup.TestField(FundsSetup."Risk Management Nos");
            NoSeriesMgt.InitSeries(FundsSetup."Risk Management Nos",xRec."No. Series",0D,"Ref Id","No. Series");
          end;
        "Document Date" := Today;
        "Created By" := UserId;
    end;

    var
        FundsSetup: Record "Resource Centre Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

