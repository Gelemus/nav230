table 50163 "HR Training Group Participants"
{

    fields
    {
        field(1; "Training Group No."; Code[10])
        {
        }
        field(2; "Line No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(3; "Employee No."; Code[20])
        {
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                "Employee Name" := '';
                "E-mail Address" := '';
                "Job Tittle" := '';

                Employees.Reset;
                Employees.SetRange("No.", "Employee No.");
                if Employees.FindFirst then begin
                    "Employee Name" := Employees."First Name" + ' ' + Employees."Middle Name" + ' ' + Employees."Last Name";
                    "Job Tittle" := Employees."Job Title";
                    "E-mail Address" := Employees."Company E-Mail";
                end;
            end;
        }
        field(4; "Employee Name"; Text[90])
        {
            Editable = false;
        }
        field(5; "E-mail Address"; Text[60])
        {
            Editable = false;
            ExtendedDatatype = None;
        }
        field(6; "Phone Number"; Text[50])
        {
            Editable = false;
            ExtendedDatatype = None;
        }
        field(7; "Job Tittle"; Text[50])
        {
            Editable = false;
        }
        field(20; "Estimated Cost"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Training Group No.", "Line No", "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        TrainingApplications: Record "HR Training Applications";
        Employees: Record Employee;
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        TrainingNeeds: Record "HR Training Needs Line";
}

