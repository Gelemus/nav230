table 50230 "HR Appraisal Header"
{

    fields
    {
        field(1;"No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Employee No.";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if EmployeeRec.Get("Employee No.") then
                  begin
                  "Employee Name":=EmployeeRec.FullName;
                  "Salary Scale":=EmployeeRec."Salary Scale";
                  Department:=EmployeeRec."Global Dimension 2 Code";
                  Position:=EmployeeRec.Position;
                  "Date of Appointment":=EmployeeRec."Employment Date";
                  "Employment Terms":=EmployeeRec."Emplymt. Contract Code";
                    end;


            end;
        }
        field(3;"Employee Name";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Appraisal Period";Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Calendar Period";
        }
        field(5;"Immediate Supervisor";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if EmployeeRec.Get("Immediate Supervisor") then
                  "Immediate Supervisor Name":=EmployeeRec.FullName;
            end;
        }
        field(6;"Immediate Supervisor Name";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Salary Scale";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8;Department;Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9;Position;Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Jobs";
        }
        field(10;"Date of Appointment";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Date Assigned Current Position";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12;"Employment Terms";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13;"Date of Last Appraisal";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14;"Comments by Appraisee";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(15;"Appraisee Date";Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(16;"Comments by Appraiser";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(17;"Appraiser Date";Date)
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

