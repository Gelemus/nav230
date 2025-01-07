tableextension 60724 tableextension60724 extends "Inventory Posting Group" 
{
    fields
    {
        field(52137000;"Budget G/L Account";Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                if GLAccount.Get("Budget G/L Account") then
                  "Budget G/L Account Name":=GLAccount.Name;
            end;
        }
        field(52137001;"Budget G/L Account Name";Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    var
        GLAccount: Record "G/L Account";
}

