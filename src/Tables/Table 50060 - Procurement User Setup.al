table 50060 "Procurement User Setup"
{

    fields
    {
        field(10; UserID; Code[50])
        {
            Caption = 'UserID';
            NotBlank = true;

            // trigger OnLookup()
            // begin
            //     UserManager.LookupUserID(UserID);
            // end;

            // trigger OnValidate()
            // begin
            //     UserManager.ValidateUserID(UserID);
            // end;
        }
        field(11; "Procurement Journal Template"; Code[10])
        {
            Caption = 'Receipt Journal Template';
            TableRelation = "Gen. Journal Template".Name WHERE(Type = CONST("Cash Receipts"));
        }
        field(12; "Procurement Journal Batch"; Code[10])
        {
            Caption = 'Receipt Journal Batch';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Procurement Journal Template"));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another user*/
                TempFundsUserSetup.Reset;
                TempFundsUserSetup.SetRange(TempFundsUserSetup."Procurement Journal Template", "Procurement Journal Template");
                TempFundsUserSetup.SetRange(TempFundsUserSetup."Procurement Journal Batch", "Procurement Journal Batch");
                if TempFundsUserSetup.FindFirst then begin
                    repeat
                        if (TempFundsUserSetup.UserID <> UserID) and ("Procurement Journal Batch" <> '') then begin
                            Error(SameBatch, "Procurement Journal Batch");
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
        SameBatch: Label 'Another User has been assign to the batch:%1';
}

