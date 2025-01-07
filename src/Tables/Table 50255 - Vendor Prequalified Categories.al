table 50255 "Vendor Prequalified Categories"
{

    fields
    {
        field(1;"Vendor No";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Line No";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(3;"Prequalification Code";Code[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Supplier Category";

            trigger OnValidate()
            begin
                SupplierCategory.Reset;
                SupplierCategory.SetRange(SupplierCategory."Document Number","Prequalification Code");
                if SupplierCategory.FindSet then begin
                  "Prequalification Name" := SupplierCategory.Decription;
                end;
            end;
        }
        field(4;"Prequalification Name";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Financial Year";Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Vendor No","Line No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        SupplierCategory: Record "Supplier Category";
}

