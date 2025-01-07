table 50254 "Deposit Transaction"
{

    fields
    {
        field(1;"Deposit ID";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Cust. No.";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;

            trigger OnValidate()
            begin
                if CustomerRec.Get("Cust. No.") then
                  "Customer Name":=CustomerRec.Name;
            end;
        }
        field(3;"Customer Name";Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Deposit ID")
        {
        }
    }

    fieldgroups
    {
    }

    var
        CustomerRec: Record Customer;
}

