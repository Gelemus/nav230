table 50200 "Commitee Members"
{

    fields
    {
        field(1; "Ref No"; Code[50])
        {
            //TableRelation = Table51511303;
        }
        field(2; Commitee; Code[10])
        {
            NotBlank = false;
            //TableRelation = Table51511302;
        }
        field(3; "Employee No"; Code[20])
        {
            NotBlank = true;
            TableRelation = Employee."No." WHERE(Status = CONST(Active));

            trigger OnValidate()
            begin
                if Empl.Get("Employee No") then begin
                    Name := Empl."First Name" + ' ' + Empl."Last Name";
                end;

            end;
        }
        field(4; Name; Text[250])
        {
        }
        field(5; "Appointment No"; Code[20])
        {

            trigger OnValidate()
            begin
                /*
                  IF Appoitment.GET("Appointment No") THEN
                  BEGIN
                   "Appointment No":=Appoitment."Appointment No";
                    Commitee:=Appoitment."Committee ID";
                  END;
                */

            end;
        }
        field(6; Chair; Boolean)
        {
        }
        field(7; Secretary; Boolean)
        {
        }
        field(8; Comments; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Appointment No", "Employee No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Empl: Record Employee;
}

