table 50500 UpdateReceipts
{

    fields
    {
        field(1; ReceiptNo; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Newdate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Modified; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4; NewBank; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                BankAccount.Reset;
                BankAccount.SetRange("No.", NewBank);
                if BankAccount.FindFirst then begin
                    BankPostingGroup.Reset;
                    BankPostingGroup.SetRange(Code, BankAccount."Bank Acc. Posting Group");
                    if BankPostingGroup.FindFirst then
                        NewGl := BankPostingGroup."G/L Account No.";//musya
                end;
            end;
        }
        field(5; NewGl; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; OldGL; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; ReceiptNo)
        {
        }
    }

    fieldgroups
    {
    }

    var
        BankPostingGroup: Record "Bank Account Posting Group";
        BankAccount: Record "Bank Account";
}

