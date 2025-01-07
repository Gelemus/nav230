table 50788 "Litigation Question Setup."
{

    fields
    {
        field(1;"Line No";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(2;Question;Text[300])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Is Attached Required";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Answer type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Yes/No,Description,Yes,No';
            OptionMembers = "Yes/No",Description,Yes,No;
        }
        field(5;"Preq No";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6;LitigationDocNo;Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Line No")
        {
        }
    }

    fieldgroups
    {
    }
}

