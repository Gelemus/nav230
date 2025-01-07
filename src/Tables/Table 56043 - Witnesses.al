table 56043 Witnesses
{

    fields
    {
        field(1;"Case No";Code[50])
        {
        }
        field(2;"Line No";Integer)
        {
            AutoIncrement = true;
        }
        field(3;"Witnessness Name";Text[250])
        {
        }
        field(4;"Witnessness Address";Text[250])
        {
        }
        field(5;"Witnessness Phone";Text[100])
        {
        }
    }

    keys
    {
        key(Key1;"Case No","Line No")
        {
        }
    }

    fieldgroups
    {
    }
}

