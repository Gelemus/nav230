table 50502 "Casual l Rates"
{

    fields
    {
        field(1;"Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Amount;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Casual Rates";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Skilled,Unskilled,Others,Masonry';
            OptionMembers = ,Skilled,Unskilled,Others,Masonry;
        }
        field(4;Comments;Text[250])
        {
            DataClassification = ToBeClassified;
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
}

