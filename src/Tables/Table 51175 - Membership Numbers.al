table 51175 "Membership Numbers"
{

    fields
    {
        field(1;"Employee No.";Code[20])
        {
            NotBlank = true;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                Rec.Reset;
                Rec.SetRange("Employee No.",Employee."No.");
                if Rec.FindFirst then begin
                  "Member Name":=Employee."Last Name"+' '+Employee."First Name"+' '+Employee."Middle Name";
                  "Payroll Code" := Employee."Payroll Code";
                  end;
            end;
        }
        field(2;"ED Code";Code[20])
        {
            NotBlank = true;
            TableRelation = "ED Definitions";
        }
        field(3;"Number Name";Text[30])
        {
            CalcFormula = Lookup("ED Definitions"."Membership No. Name" WHERE ("ED Code"=FIELD("ED Code")));
            FieldClass = FlowField;
        }
        field(4;"Membership Number";Code[20])
        {
        }
        field(50000;"Member Name";Text[30])
        {
            CalcFormula = Lookup(Employee."Last Name" WHERE ("No."=FIELD("Employee No.")));
            FieldClass = FlowField;
        }
        field(50009;"Payroll Code";Code[10])
        {
            TableRelation = Payroll;

            trigger OnValidate()
            begin
                //ERROR('Manual Edits not allowed.');
            end;
        }
    }

    keys
    {
        key(Key1;"Employee No.","ED Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record Employee;

    procedure gsAssignPayrollCode()
    var
        lvUserSetup: Record "User Setup";
    begin
        /*lvUserSetup.GET(USERID);
        lvUserSetup.TESTFIELD("Give Access to Payroll");
        "Payroll Code" := lvUserSetup."Give Access to Payroll"
        */

    end;
}

