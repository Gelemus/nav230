table 50042 "Fixed Deposit Bids"
{

    fields
    {
        field(10;"Document No";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Bank Account";Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                "Bank Account Name":='';

                if BankAccount.Get("Bank Account") then
                  "Bank Account Name":=BankAccount.Name;
            end;
        }
        field(12;"Bank Account Name";Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13;Amount;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14;"Desired Rate";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15;"FD Duration";DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(16;Rate;Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Document No","Bank Account")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        FDProcessing.Reset;
        FDProcessing.SetRange(FDProcessing."Document No.","Document No");
        if FDProcessing.FindFirst then begin
          if FDProcessing."FD Amount"=0 then Error(FDAmountError);
          //IF FDProcessing."Fixed Duration"=0D THEN ERROR(FDAmountError);
          //IF FDProcessing."Interest rate"=0 THEN ERROR(FDAmountError);
          Amount:=FDProcessing."FD Amount";
          "FD Duration":=FDProcessing."Fixed Duration";
        end;
    end;

    var
        BankAccount: Record "Bank Account";
        FDProcessing: Record "FD Processing";
        FDAmountError: Label 'Fixed Deposit Amount Must Be specified before receiving the bids';
}

