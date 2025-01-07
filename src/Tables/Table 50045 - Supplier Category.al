table 50045 "Supplier Category"
{
    DrillDownPageID = "Vendor Categories";
    LookupPageID = "Vendor Categories";

    fields
    {
        field(11;"Document Number";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(14;Decription;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(15;"Supplier Category";Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Document Number")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Document Number",Decription)
        {
        }
    }

    var
        ItemCategory: Record "Item Category";
}

