table 50059 "Tender Evaluation Line"
{

    fields
    {
        field(10; "Line No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(11; "Document No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Tender No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Requirements; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Marks; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Marks > 100 then Error(NotExceed);
            end;
        }
        field(15; "Marks Assigned"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //IF "Marks Assigned">Marks THEN
                // ERROR(AssignedMarks);
            end;
        }
        field(16; Comments; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Supplier Name"; Text[500])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; Evaluator; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "Evaluator Name"; Text[500])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Evaluator User ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Evaluation Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Mandatory,Supplier Availability,Business Profile Ownership,Financial Capability,Experience: (Evidence of at least 3 fulfilled Orders in the last 2 years,Reliability: Recommendations within the last 2 year,Supply Capacity,Eligibility & Disclosure of litigation history';
            OptionMembers = " ",Mandatory,"Supplier Availability","Business Profile Ownership","Financial Capability","Experience: (Evidence of at least 3 fulfilled Orders in the last 2 years","Reliability: Recommendations within the last 2 year","Supply Capacity","Eligibility & Disclosure of litigation history";
        }
        field(22; "Max Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Conformity Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Yes,No;
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        AssignedMarks: Label 'Marks assigned cannot be higher than the set Maximum marks per question';
        NotExceed: Label 'Marks should not exceed 100%';
}

