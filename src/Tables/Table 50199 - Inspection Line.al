table 50199 "Inspection Line"
{

    fields
    {
        field(1;"Inspection No";Code[20])
        {
        }
        field(2;"Line No";Integer)
        {
        }
        field(3;Description;Text[250])
        {
        }
        field(4;"Unit of Measure";Code[10])
        {
        }
        field(5;"Quantity Ordered";Decimal)
        {
        }
        field(6;"Quantity Received";Decimal)
        {
        }
        field(7;"Inspection Decision";Option)
        {
            OptionMembers = " ",Accept,Reject;
        }
        field(8;"Reasons for Rejection";Text[250])
        {
        }
        field(9;"Return Reasons";Code[10])
        {
            TableRelation = "Return Reason";
        }
        field(10;"Item No";Code[20])
        {
        }
        field(11;"Quantity Rejected";Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Quantity Accepted":="Quantity Received"-"Quantity Rejected";
            end;
        }
        field(12;"Quantity Accepted";Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(13;"Specification in Brief";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(14;"Score (%)";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15;Remarks;Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Inspection No","Line No")
        {
        }
    }

    fieldgroups
    {
    }
}

