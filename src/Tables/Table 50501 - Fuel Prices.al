table 50501 "Fuel Prices"
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
        field(3;"Fuel type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Petrol,Diesel,Paraffin,13Kg Gas,6Kg Gas,Oil';
            OptionMembers = " ",Petrol,Diesel,Paraffin,"13Kg Gas","6Kg Gas",Oil;
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

