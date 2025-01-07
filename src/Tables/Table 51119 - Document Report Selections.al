table 51119 "Document Report Selections"
{
    //LookupPageID = 51149;
    Permissions = TableData "G/L Entry" = rimd;

    fields
    {
        field(1; "Report ID"; Integer)
        {
            // TableRelation = Object.ID WHERE (Type=CONST(Report));

            trigger OnValidate()
            begin
                // Objects.Reset;
                // Objects.SetRange(Type,Objects.Type::Report);
                // Objects.SetRange(ID,"Report ID");
                // if Objects.FindFirst then
                //   "Report Name" := Objects.Name
                // else
                "Report Name" := '';
            end;
        }
        field(2; "Document Type"; Option)
        {
            OptionCaption = 'Sales Invoice,Service Invoice,Customer Statement,Remittance Advice,Payslips,Payment Receipts,EFT Remittance Advice,Reminder,Purchase Order';
            OptionMembers = "Sales Invoice","Service Invoice","Customer Statement","Remittance Advice",Payslips,"Payment Receipts","EFT Remittance Advice",Reminder,"Purchase Order";
        }
        field(3; "Report Name"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Report ID", "Document Type")
        {
        }
    }

    fieldgroups
    {
    }

    var
    // Objects: Record "Object";musya
}

