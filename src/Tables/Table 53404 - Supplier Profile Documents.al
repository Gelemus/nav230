table 53404 "Supplier Profile Documents"
{

    fields
    {
        field(1;"Entry No";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2;"Reference No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"File Name";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Actual File";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5;FilePath;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6;Type;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'SupplierProfile,Prequalification,Tender,RFP,Quote';
            OptionMembers = SupplierProfile,Prequalification,Tender,RFP,Quote;
        }
    }

    keys
    {
        key(Key1;"Entry No")
        {
        }
    }

    fieldgroups
    {
    }
}

