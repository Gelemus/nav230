table 50109 "Interview Attendance Line"
{

    fields
    {
        field(10;"Line No";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(11;"Interview No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12;"Employee No.";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                Employee.Reset;
                Employee.SetRange(Employee."No.","Employee No.");
                if Employee.FindFirst then begin
                  "Employee Name":=Employee."Last Name"+''+Employee."Middle Name"+''+Employee."First Name";
                  "Employee Email":=Employee."Company E-Mail";
                end;
            end;
        }
        field(13;"Employee Name";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14;"Employee Email";Text[100])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
        field(15;Comments;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(18;Closed;Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Interview No.","Employee No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record Employee;
}
