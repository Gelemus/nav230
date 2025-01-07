table 51117 "Document E-Mailing Setup"
{
    DrillDownPageID = "Document E-Mailing List";
    LookupPageID = "Document E-Mailing List";
    Permissions = TableData "G/L Entry"=rimd;

    fields
    {
        field(1;"Document Type";Option)
        {
            OptionCaption = 'Sales Invoice,Service Invoice,Customer Statement,Remittance Advice,Payslips,Payment Receipts,EFT Remittance Advice,Reminder,Purchase Order';
            OptionMembers = "Sales Invoice","Service Invoice","Customer Statement","Remittance Advice",Payslips,"Payment Receipts","EFT Remittance Advice",Reminder,"Purchase Order";
        }
        field(2;"Document Folder";Text[250])
        {
        }
        field(3;"Document Folder No Email";Text[250])
        {
        }
        field(4;"Email Subject";Text[250])
        {
            Description = 'Subject of the debtor statements Emails';
        }
        field(5;"Email Body";Text[250])
        {
            Description = 'Body of the debtor statements Emails';
        }
        field(6;"Email Footer Line 1";Text[100])
        {
            Description = 'e.g Regards,';
        }
        field(7;"Email Footer Line 2";Text[100])
        {
            Description = 'e.g For Company XYZ Ltd.';
        }
        field(8;"Email Footer Line 3";Text[100])
        {
            Description = 'e.g HR Manager';
        }
        field(9;"Email Footer Line 4";Text[100])
        {
        }
        field(10;"Email Footer Line 5";Text[100])
        {
        }
        field(11;"Sender Name";Text[250])
        {
        }
        field(12;"Sender Email";Text[250])
        {
        }
        field(13;Salutation;Text[50])
        {
        }
        field(14;Signature;Text[50])
        {
        }
        field(15;"Report Selection";Integer)
        {
            TableRelation = "Document Report Selections"."Report ID" WHERE ("Document Type"=FIELD("Document Type"));

            trigger OnValidate()
            begin
                if ReportSelectin.Get("Report Selection","Document Type") then   begin
                  "Report Name" := ReportSelectin."Report Name"
                end else
                  "Report Name" := '';
            end;
        }
        field(16;"Report Name";Text[30])
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(17;"Last Date Run";Date)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Document Type")
        {
        }
    }

    fieldgroups
    {
    }

    var
        ReportSelectin: Record "Document Report Selections";
}

