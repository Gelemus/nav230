table 50001 "Bank Branch"
{
    Caption = 'Bank Branch';
    DataPerCompany = false;
    //DrillDownPageID = 52136924;
    //LookupPageID = 52136924;

    

    fields
    {
        field(1; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
            TableRelation = "Bank Code"."Bank Code";

            trigger OnValidate()
            begin
                "Bank Name" := '';
                if BankCodes.Get("Bank Code") then
                    "Bank Name" := BankCodes."Bank Name";
                Validate("Bank Name");
            end;
        }
        field(2; "Bank Name"; Text[100])
        {
            Caption = 'Bank Name';
            Editable = false;

            trigger OnValidate()
            begin
                "Bank Name" := UpperCase("Bank Name");
            end;
        }
        field(3; "Bank Branch Code"; Code[20])
        {
            Caption = 'Bank Branch Code';
        }
        field(4; "Bank Branch Name"; Text[100])
        {
            Caption = 'Bank Branch Name';

            trigger OnValidate()
            begin
                "Bank Branch Name" := UpperCase("Bank Branch Name");
            end;
        }
        field(5; "Branch Physical Location"; Text[100])
        {
            Caption = 'Branch Physical Location';
        }
        field(6; "Branch Postal Code"; Code[20])
        {
            Caption = 'Branch Postal Code';
        }
        field(7; "Branch Address"; Text[50])
        {
            Caption = 'Branch Address';
        }
        field(8; "Branch Phone No."; Code[50])
        {
            Caption = 'Branch Phone No.';
        }
        field(9; "Branch Mobile No."; Code[50])
        {
            Caption = 'Branch Mobile No.';
        }
        field(10; "Branch Email Address"; Text[100])
        {
            Caption = 'Branch Email Address';
        }
    }

    keys
    {
        key(Key1; "Bank Branch Code", "Bank Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Bank Branch Code", "Bank Branch Name")
        {
        }
    }

    var
        BankCodes: Record "Bank Code";
}

