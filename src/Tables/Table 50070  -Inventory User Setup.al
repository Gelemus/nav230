table 50070 "Inventory User Setup"
{
    Caption = 'Inventory User Setup';

    fields
    {
        field(1; UserID; Code[50])
        {
            Caption = 'User ID';
            Enabled = true;
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";

        }
        field(2; "Item Journal Template"; Code[10])
        {
            Caption = 'Item Journal Template';
            TableRelation = "Item Journal Template".Name;
        }
        field(3; "Item Journal Batch"; Code[10])
        {
            Caption = 'Item Journal Batch';
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Item Journal Template"));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another user*/
                TempFundsUserSetup.Reset;
                TempFundsUserSetup.SetRange(TempFundsUserSetup."Procurement Journal Template", "Item Journal Template");
                TempFundsUserSetup.SetRange(TempFundsUserSetup."Procurement Journal Batch", "Item Journal Batch");
                if TempFundsUserSetup.FindFirst then begin
                    repeat
                        if (TempFundsUserSetup.UserID <> UserID) and ("Item Journal Batch" <> '') then begin
                            Error(SameBatch, "Item Journal Batch");
                        end;
                    until TempFundsUserSetup.Next = 0;
                end;

            end;
        }
    }

    keys
    {
        key(Key1; UserID)
        {
        }
    }

    fieldgroups
    {
    }

    var
        TempFundsUserSetup: Record "Procurement User Setup";
        UserManager: Codeunit "User Management";
        // OldUser: Record User;
        // NewUser: Record User;
        SameBatch: Label 'Another User has been assign to the batch:%1';
}
