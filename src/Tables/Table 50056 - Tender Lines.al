table 50056 "Tender Lines"
{

    fields
    {
        field(10; "Line No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Supplier Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Remarks; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Reason for Disqualification"; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; Disqualified; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Disqualification point"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Bid Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Supplier No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Application No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Firm Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(22; Telephone; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(23; Location; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Legal status"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Incorporation Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Business Nature"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Max Business Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Bankers Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(29; Status; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(30; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Date Updated"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Business Registration Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Payment Mode"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(35; Website; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "KRA PIN"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Supplier Profile ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Approval Remarks"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Recommendation Remarks"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(40; Score; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Recommendation By"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Approved By"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Created By"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Updated By"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Recommendation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Recommendation Status"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Approval status"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Registration of Supplier,Open Tender,Request for Proposal';
            OptionMembers = " ","Registration of Supplier","Open Tender","Request for Proposal";
        }
    }

    keys
    {
        key(Key1; "Line No.", "Document No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Supplier: Record Vendor;
}

