table 50048 "Purchase Requisition Codes"
{

    fields
    {
        field(1;"Requisition Type";Option)
        {
            Caption = 'Requisition Type';
            OptionCaption = 'Service,Item,Fixed Asset';
            OptionMembers = Service,Item,"Fixed Asset";
        }
        field(2;"Requisition Code";Code[20])
        {
        }
        field(3;Type;Option)
        {
            Caption = 'Account Type';
            OptionCaption = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";
        }
        field(4;"No.";Code[20])
        {
            TableRelation = IF (Type=CONST("G/L Account")) "G/L Account"."No." WHERE ("Direct Posting"=CONST(true));

            trigger OnValidate()
            begin
                Name:='';
                if Type=Type::"G/L Account" then begin
                  "G/LAccount".Reset;
                  if "G/LAccount".Get("No.") then begin
                    Name:="G/LAccount".Name;
                  end;
                end;
            end;
        }
        field(5;Name;Text[50])
        {
            Caption = 'Account Name';
            Editable = false;
        }
        field(6;Description;Text[100])
        {
        }
    }

    keys
    {
        key(Key1;"Requisition Type","Requisition Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        "G/LAccount": Record "G/L Account";
}

