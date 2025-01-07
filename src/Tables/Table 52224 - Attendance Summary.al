table 52224 "Attendance Summary"
{

    fields
    {
        field(1;"No.";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Employee No.";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                EmployeeRec.Reset;
                EmployeeRec.SetRange("No.", "Employee No.");
                if EmployeeRec.FindFirst then
                  "Employee Name" := EmployeeRec."First Name" +' ' +EmployeeRec."Last Name";
            end;
        }
        field(3;"Employee Name";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4;Date;Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Time In";DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Time Out";DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Agreed Status";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8;Clocked;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Clocked In Late";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Clocket Out Early";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Time In String";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(12;"Time out String";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(13;Id;Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14;"Break Out";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(15;"Break In";Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        EmployeeRec: Record Employee;
}

