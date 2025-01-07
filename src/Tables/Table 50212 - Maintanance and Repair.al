table 50212 "Maintanance and Repair"
{

    fields
    {
        field(1;"Vehicle No.";Code[20])
        {
            TableRelation = "Fixed Asset"."No." WHERE ("Transport Type"=FILTER(Vehicle));

            trigger OnValidate()
            begin
                if FixedAsset.Get("Vehicle No.") then begin
                "Vehicle Description":=FixedAsset.Description;
                "Item Class Code":=FixedAsset."FA Class Code";
                end;
            end;
        }
        field(2;"Vehicle Description";Text[80])
        {
        }
        field(3;"Service Provider";Code[10])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if VendorRec.Get("Service Provider") then
                 "Service Provider Name" :=VendorRec.Name;
            end;
        }
        field(4;"Service Provider Name";Text[30])
        {
        }
        field(5;"Service Intervals";Code[10])
        {
            TableRelation = "Service Interval" WHERE ("Service Interval Type"=FIELD("Service Interval Type"));

            trigger OnValidate()
            begin
                ServiceIntervals.Reset;
                //ServiceIntervals.SETRANGE(ServiceIntervals."Service Interval Code","Service Intervals");
                if ServiceIntervals.Find('-') then begin
                  "Service Period":=ServiceIntervals."Service Period";
                  "Service Mileage KM":=ServiceIntervals."Service Mileage";
                end;
            end;
        }
        field(6;"Date of Service";Date)
        {
        }
        field(7;"Next Service";Text[30])
        {
        }
        field(8;Amount;Decimal)
        {
        }
        field(9;"Remarks/service done";Text[250])
        {
        }
        field(10;"Invoice No.";Code[20])
        {
        }
        field(11;"Service LSO/LPO No.";Code[20])
        {
        }
        field(12;"Item Class Code";Code[10])
        {
            Caption = 'FA Class Code';
            TableRelation = "FA Class";
        }
        field(13;"Actual Mileage KM";Decimal)
        {
        }
        field(14;"Service Interval Type";Option)
        {
            OptionCaption = ' ,Mileage,Periodical';
            OptionMembers = " ",Mileage,Periodical;
        }
        field(15;"Service Period";DateFormula)
        {
        }
        field(16;"Service Mileage KM";Decimal)
        {
        }
        field(17;"Next Service Mileage KM";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18;"Type of Service Carried A,B,C,";Text[250])
        {
            Caption = 'Type of Service Carried A,B,C,D';
            DataClassification = ToBeClassified;
        }
        field(19;"Driver No";Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if EmploreyeeRec.Get("Driver No") then
                begin
                  "Driver Name" := EmploreyeeRec."First Name" + ' ' + EmploreyeeRec."Middle Name" + ' ' + EmploreyeeRec."Last Name";
                end;
            end;
        }
        field(20;"Driver Name";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(21;"Line No";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(22;Submit;Boolean)
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

    var
        VendorRec: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        ServiceIntervals: Record "Service Interval";
        EmploreyeeRec: Record Employee;
}

