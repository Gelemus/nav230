table 50166 "HR Disciplinary Case"
{

    fields
    {
        field(1;"Case Number";Code[20])
        {
            Editable = false;
        }
        field(3;"Document Date";Date)
        {
        }
        field(4;"Type of Disciplinary Case";Text[100])
        {
            NotBlank = true;
        }
        field(5;"Employee No";Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                Employees.Reset;
                Employees.SetRange("No.", "Employee No");
                if Employees.FindFirst then
                  "Employee Name":=Employees."First Name"+' '+Employees."Middle Name"+ ' '+Employees."Last Name";
            end;
        }
        field(6;"Employee Name";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Case Description";Text[250])
        {
        }
        field(8;"Accuser Name";Text[100])
        {
        }
        field(9;"Witness #1";Code[20])
        {
        }
        field(10;"Witness #2";Code[20])
        {
        }
        field(15;"Action Taken";Text[250])
        {
        }
        field(17;"Disciplinary Remarks";Code[250])
        {
        }
        field(18;Comments;Text[250])
        {
        }
        field(19;Recomendations;Text[250])
        {
        }
        field(20;Status;Option)
        {
            Editable = false;
            OptionMembers = Open,Closed;
        }
        field(30;"Closed By";Code[50])
        {
        }
        field(31;"Closed Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50;"No. Series";Code[20])
        {
        }
        field(51;"Employer Accuser";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(52;"Outsider Accuser";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53;"Witness#3";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(54;"Type of Displinary Cases";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '  ,Misconduct ';
            OptionMembers = "  ","Misconduct ";
        }
    }

    keys
    {
        key(Key1;"Case Number")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Case Number" = '' then begin
          HRSetup.Get;
          HRSetup.TestField(HRSetup."Disciplinary Cases Nos.");
          NoSeriesMgt.InitSeries(HRSetup."Disciplinary Cases Nos.",xRec."No. Series",0D,"Case Number","No. Series");
        end;
        "Document Date":=Today;
        "Closed By":=UserId;
    end;

    var
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Employees: Record Employee;
}

