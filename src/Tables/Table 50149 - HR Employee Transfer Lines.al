table 50149 "HR Employee Transfer Lines"
{

    fields
    {
        field(1;"Request No";Code[50])
        {
        }
        field(2;"Employee No";Code[50])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employees.Get("Employee No") then
                begin
                "Employee Name":=Employees."First Name"+' '+Employees."Middle Name"+' '+Employees."Last Name";
                "Global Dimension 1 Code":=Employees."Global Dimension 1 Code";
                "Global Dimension 2 Code":=Employees."Global Dimension 2 Code";
                "Shortcut Dimension 3 Code":=Employees."Shortcut Dimension 3 Code";
                "Shortcut Dimension 4 Code":=Employees."Shortcut Dimension 4 Code";
                "Shortcut Dimension 5 Code":=Employees."Shortcut Dimension 5 Code";
                "Shortcut Dimension 6 Code":=Employees."Shortcut Dimension 6 Code";
                //"Employement Category":=Employees."Emplymt. Contract Code";
                "Job No.":=Employees."Job No.-d";
                //"Job Grade":=Employees."Job Grade";
                //"Job Title":=Employees."Job Title";
                end;
            end;
        }
        field(3;"Employee Name";Text[100])
        {
        }
        field(4;"Global Dimension 1 Code";Code[50])
        {
            Caption = 'Current Project';
            Description = 'Stores the reference to the first global dimension in the database';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(5;"New Global Dimension 1 Code";Code[50])
        {
            Caption = 'New Project';
            Description = 'Stores the reference to the New first global dimension in the database';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1),
                                                          "Dimension Value Type"=CONST(Standard));

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin
                  Dimn.SetRange(Dimn.Code,"New Global Dimension 1 Code");
                   if Dimn.Find('-') then begin
                      "New Directorate Name":=Dimn.Name;
                       end;
            end;
        }
        field(6;"Global Dimension 2 Code";Code[50])
        {
            Caption = 'Current Cost category';
            Description = 'Stores the reference of the second global dimension in the database';
        }
        field(7;"New Global Dimension 2 Code";Code[50])
        {
            Caption = 'New Cost Category';
            Description = 'Stores the reference of the second global dimension in the database';

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin
                  Dimn.SetRange(Dimn.Code,"New Global Dimension 2 Code");
                   if Dimn.Find('-') then begin
                      "New Region Name":=Dimn.Name;
                       end;
            end;
        }
        field(8;"Shortcut Dimension 3 Code";Code[50])
        {
            Caption = 'Current Program Area';
            Description = 'Stores the reference of the Third global dimension in the database';
        }
        field(9;"New Shortcut Dimension 3 Code";Code[50])
        {
            Caption = 'New Program Area';
            Description = 'Stores the reference of the New Third global dimension in the database';

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin
                  Dimn.SetRange(Dimn.Code,"New Shortcut Dimension 3 Code");
                   if Dimn.Find('-') then begin
                      "New Department Name":=Dimn.Name;
                       end;
            end;
        }
        field(10;"Current Department Name";Text[100])
        {
        }
        field(11;"New Department Name";Text[100])
        {
        }
        field(12;"Current Region Name";Text[100])
        {
        }
        field(13;"Current Directorate Name";Text[100])
        {
        }
        field(14;"New Directorate Name";Text[100])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE ("Global Dimension No."=FILTER(2),
                                                               Code=FIELD("New Global Dimension 2 Code")));
            FieldClass = FlowField;
        }
        field(15;"New Region Name";Text[30])
        {
        }
        field(16;"Line No";Integer)
        {
            AutoIncrement = true;
        }
        field(52136926;"Shortcut Dimension 4 Code";Code[50])
        {
            Caption = 'Current Sub-Program Area';
            Description = '//Sysre NextGen Addon';
        }
        field(52136927;"New Shortcut Dimension 4 Code";Code[50])
        {
            Caption = 'New Sub-Program Area';
            Description = '//Sysre NextGen Addon';

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin
                  Dimn.SetRange(Dimn.Code,"New Global Dimension 1 Code");
                   if Dimn.Find('-') then begin
                      "New Directorate Name":=Dimn.Name;
                       end;
            end;
        }
        field(52136928;"Shortcut Dimension 5 Code";Code[50])
        {
            Caption = 'Current County';
            Description = '//Sysre NextGen Addon';
        }
        field(52136929;"New Shortcut Dimension 5 Code";Code[50])
        {
            Caption = 'New County';
            Description = '//Sysre NextGen Addon';

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin
                  Dimn.SetRange(Dimn.Code,"New Global Dimension 2 Code");
                   if Dimn.Find('-') then begin
                      "New Region Name":=Dimn.Name;
                       end;
            end;
        }
        field(52136930;"Shortcut Dimension 6 Code";Code[50])
        {
            Caption = 'Current Site';
            Description = '//Sysre NextGen Addon';
        }
        field(52136931;"New Shortcut Dimension 6 Code";Code[50])
        {
            Caption = 'New Site';
            Description = '//Sysre NextGen Addon';

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin
                  Dimn.SetRange(Dimn.Code,"New Shortcut Dimension 3 Code");
                   if Dimn.Find('-') then begin
                      "New Department Name":=Dimn.Name;
                       end;
            end;
        }
        field(52137032;"Job No.";Code[20])
        {
            Description = '//Sysre NextGen Addon(Human Capital Management)';
            TableRelation = "HR Jobs"."No." WHERE (Status=CONST(Released));

            trigger OnValidate()
            begin
                "Job Title":='';
                "Job Grade":='';
                
                /*IF HRJob.GET("Job No.") THEN BEGIN
                  "HR Job Title":=HRJob."Job Title";
                  "Job Grade":=HRJob."Job Grade";
                END;
                */
                
                HRJob.Reset;
                HRJob.SetRange(HRJob."No.","Job No.");
                if HRJob.FindFirst then begin
                  "Job Title":=HRJob."Job Title";
                  "Job Grade":=HRJob."Job Grade";
                end;

            end;
        }
        field(52137033;"Employement Category";Option)
        {
            Description = '//Sysre NextGen Addon(Human Capital Management)';
            Editable = false;
            OptionCaption = ' ,Full Time,Short Term,Community workers,Community Mobilizers,Interns';
            OptionMembers = " ","Full Time","Short Term","Community workers","Community Mobilizers",Interns;
        }
        field(52137034;"Job Grade";Code[20])
        {
            Description = '//Sysre NextGen Addon(Human Capital Management)';
            TableRelation = "HR Job Lookup Value".Code WHERE (Option=CONST("Job Grade"));
        }
        field(52137035;"Job Title";Code[50])
        {
            Description = '//Sysre NextGen Addon(Human Capital Management)';
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Request No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        hrsetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Employees: Record Employee;
        HRJob: Record "HR Jobs";
}

