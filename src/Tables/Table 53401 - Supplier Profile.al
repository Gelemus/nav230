table 53401 "Supplier Profile"
{

    fields
    {
        field(1;No;Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Supplier Name";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Supplier Telephone";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Supplier Company Name";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Supplier Physical Address";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Supplier Postal Address";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Supplier Email";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Supplier Website";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Supplier Legal Status";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Supplier Max Bussiness Value";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Supplier Business Nature";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12;"Supplier Kra Pin Cert No";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13;"Supplier Vat Cert No";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14;"Supplier Company Reg Cert No";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(15;"Supplier Bankers Name";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(16;"Supplier Trade Terms";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(17;"Supplier Country";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18;"Supplier County";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(19;"Supplier Date Created";DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(20;"Supplier Date Updated";DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(21;"Supplier Id";Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
        }
    }

    keys
    {
        key(Key1;No)
        {
        }
    }

    fieldgroups
    {
    }
}

