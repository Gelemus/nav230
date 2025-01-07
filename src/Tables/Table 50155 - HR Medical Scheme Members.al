table 50155 "HR Medical Scheme Members"
{

    fields
    {
        field(10;"Line No";Integer)
        {
            Editable = false;
        }
        field(11;"Scheme No";Code[30])
        {
        }
        field(12;"Employee No";Code[30])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employees.Get("Employee No") then
                begin
                 "Employee Name":=Employees."First Name"+' '+Employees."Middle Name"+' '+Employees."Last Name";
                  "Principal No":=Employees."No.";
                end;
            end;
        }
        field(13;"Employee Name";Text[100])
        {
        }
        field(14;"Medical Scheme Description";Text[100])
        {
        }
        field(15;"Family Size";Code[20])
        {
        }
        field(16;"Cover Option";Option)
        {
            OptionCaption = ' ,Principal,Dependant';
            OptionMembers = " ",Principal,Dependant;
        }
        field(17;"In Patient Benfit";Decimal)
        {
        }
        field(18;"Out patient Benefit";Decimal)
        {
        }
        field(19;Status;Option)
        {
            OptionCaption = 'Active,Inactive';
            OptionMembers = Active,Inactive;
        }
        field(20;"Principal No";Code[30])
        {
        }
        field(21;"Dependant Name";Text[100])
        {

            trigger OnValidate()
            begin
                /*HREmployeeRelative.RESET;
                HREmployeeRelative.SETRANGE();*/

            end;
        }
        field(22;"Date of Birth";Date)
        {
        }
        field(23;Age;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(24;Relation;Code[20])
        {
        }
        field(25;Category;Code[10])
        {
            TableRelation = "Medical Cover Setup";

            trigger OnValidate()
            begin

                if MedicalSetup.Get(Relation) then
                begin
                "In Patient Benfit":=MedicalSetup."In-Patient Amount";
                "Out patient Benefit":=MedicalSetup."Out-Patient Amount";
                end;
            end;
        }
    }

    keys
    {
        key(Key1;"Line No","Scheme No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Employees: Record Employee;
        MedicalSetup: Record "Medical Cover Setup";
        HREmployeeRelative: Record "HR Employee Relative";
}

