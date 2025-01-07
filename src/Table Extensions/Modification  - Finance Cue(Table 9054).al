tableextension 60702 tableextension60702 extends "Finance Cue" 
{
    fields
    {
        field(50000;"Imprests Pending Approval";Integer)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header"=R;
            CalcFormula = Count("Imprest Header" WHERE (Type=CONST(Imprest),
                                                        Status=CONST("Pending Approval")));
            Caption = 'Imprests Pending Approval';
            FieldClass = FlowField;
        }
        field(50001;"Payments Pending Approval";Integer)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header"=R;
            CalcFormula = Count("Payment Header" WHERE (Status=FILTER("Pending Approval")));
            Caption = 'Payments Pending Approval';
            FieldClass = FlowField;
        }
        field(50002;"Posted Payments";Integer)
        {
            CalcFormula = Count("Payment Header" WHERE (Posted=CONST(true)));
            FieldClass = FlowField;
        }
        field(50003;"Approved Imprest List";Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
}

