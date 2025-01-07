table 50205 "Returnable Items"
{
    Caption = 'Returnable Items';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[30])
        {
            Caption = 'No.';
        }
        field(2; "Item Description "; Text[50])
        {
            Caption = 'Item Description ';
        }
        field(3; "Base unit of Measure"; Code[30])
        {
            Caption = 'Base unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(4; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
        }
        field(5; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = " ","Issued","Returned";
            OptionCaption = '" ",Issued,Returned';
            Editable = false;
        }
        field(6; "Inventory "; Decimal)
        {
            Caption = 'Inventory ';
        }
        field(7; "No. Series"; code[40])
        {

        }
        field(8; "Document Date"; Date)
        {

        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        InventorySetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    begin
        if "No." = '' then begin
            InventorySetup.Get;
            InventorySetup.TestField(InventorySetup.Returnable);
            NoSeriesMgt.InitSeries(InventorySetup.Returnable, xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Document Date" := Today;
        //"User ID" := UserId;
    end;
}
