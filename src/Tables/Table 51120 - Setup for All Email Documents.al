table 51120 "Setup for All Email Documents"
{
    Permissions = TableData "G/L Entry"=rimd;

    fields
    {
        field(1;"Primary Key";Code[10])
        {
        }
        field(2;"Customer Statement Due After";DateFormula)
        {
        }
        field(3;"Sales Invoices Due After";DateFormula)
        {
        }
        field(4;"Service Invoices Due After";DateFormula)
        {
        }
        field(5;"Remittance Advice Due After";DateFormula)
        {
        }
        field(6;"Payments Advice Due After";DateFormula)
        {
        }
        field(7;"EFT Payments Advice Due After";DateFormula)
        {
        }
        field(8;"Reminders Due After";DateFormula)
        {
        }
        field(9;"Payslips Due After";DateFormula)
        {
        }
        field(10;"Purchase Orders";DateFormula)
        {
        }
    }

    keys
    {
        key(Key1;"Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

