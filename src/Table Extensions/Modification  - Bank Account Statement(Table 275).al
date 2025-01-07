tableextension 60225 tableextension60225 extends "Bank Account Statement"
{
    fields
    {
        field(50000; "Bank Account name1"; Text[250])
        {
            CalcFormula = Lookup("Bank Acc. Reconciliation"."Bank Account name" WHERE("Bank Account No." = FIELD("Bank Account No.")));
            FieldClass = FlowField;
        }
    }
}

