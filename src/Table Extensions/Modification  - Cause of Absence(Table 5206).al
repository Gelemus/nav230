tableextension 60385 tableextension60385 extends "Cause of Absence" 
{
    fields
    {
        field(50000;"Day/Hour";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Day,Hour';
            OptionMembers = Day,Hour;
        }
        field(50001;"Transfer To Payroll";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002;"Payroll Code";Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Payroll;
        }
        field(50003;"E/D Code";Code[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ED Definitions";
        }
    }
}

