tableextension 60386 tableextension60386 extends "Employee Absence" 
{
    fields
    {
        field(50000;"Payroll Code";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Payroll;
        }
        field(50001;"Global Dimension 1 Code";Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1));
        }
        field(50002;"Global Dimension 2 Code";Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2));
        }
        field(50003;"Day/Hour";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Day,Hour';
            OptionMembers = Day,Hour;
        }
    }
}

