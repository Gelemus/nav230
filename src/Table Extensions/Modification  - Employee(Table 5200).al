tableextension 60381 tableextension60381 extends Employee
{
    LookupPageID = "Employee List look up";
    DrillDownPageID = "Employee List look up";
    fields
    {
        modify("No.")
        {
            Caption = 'Employee PF No.';
        }

        //Unsupported feature: Property Modification (Data type) on ""Job Title"(Field 6)".

        modify(Status)
        {
            OptionCaption = 'Active,Inactive,Terminated,Retired';

            //Unsupported feature: Property Modification (OptionString) on "Status(Field 31)".

        }
        modify("Global Dimension 1 Code")
        {

            //Unsupported feature: Property Modification (Data type) on ""Global Dimension 1 Code"(Field 36)".

            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
        }
        modify("Global Dimension 2 Code")
        {

            //Unsupported feature: Property Modification (Data type) on ""Global Dimension 2 Code"(Field 37)".

            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
        }

        //Unsupported feature: Property Modification (Data type) on ""Global Dimension 1 Filter"(Field 42)".


        //Unsupported feature: Property Modification (Data type) on ""Global Dimension 2 Filter"(Field 43)".


        //Unsupported feature: Code Insertion on ""Last Name"(Field 4)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        if "Full Name" = '' then
          "Full Name" := SetSearchNameToFullnameAndInitials;
        */
        //end;


        //Unsupported feature: Code Insertion on ""Birth Date"(Field 20)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        GetDurations;
        if ("Calculation Scheme"='CMT') and ("Calculation Scheme"='INTERN')  and ("Calculation Scheme"='GENERAL')then
            exit;
        if "Calculation Scheme"='PERMANENT' then begin
          GetServiceDurations;
          end;
          if "Calculation Scheme"='PWD'then begin
            PWDGetServiceDurations;
            end;

        */
        //end;


        //Unsupported feature: Code Modification on "Status(Field 31).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        EmployeeQualification.SetRange("Employee No.","No.");
        EmployeeQualification.ModifyAll("Employee Status",Status);
        Modify;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //Mesh ke payroll
        if Status = Status::Terminated then begin
          TestField("Termination Date");
          DeletePayrollHeaders;
          //V.6.1.65 >>
          Clear(gvResource);
          gvResource.SetRange(gvResource."Employee No.","No.");
          if gvResource.FindFirst then begin
            gvResource.Blocked := true;
            gvResource.Modify;
          end;
          //V.6.1.65 <<
        end else begin
          //V.6.1.65 >>
          Clear(gvResource);
          gvResource.SetRange(gvResource."Employee No.","No.");
          if gvResource.FindFirst then begin
            gvResource.Blocked := false;
            gvResource.Modify;
          end;
        end;
        //V.6.1.65 <<
        if Status = Status::Inactive then TestField("Inactive Date");

        if Status = Status::Active then begin
          "Termination Date" := 0D;
          "Inactive Date" := 0D
        end;
        //Mesh end
        #1..3
        */
        //end;
        field(50001; "Emp Branch Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50002; "Bank Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "National ID"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(50005; "Name of Old Employer"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Address of Old Employer"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Name of New Employer"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Address of New Employer"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Calculation Scheme"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = "Calculation Header";
        }
        field(50010; "Mode of Payment"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Mode of Payment";
        }
        field(50011; "Bank Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employee Bank Account";

            trigger OnValidate()
            var
                rEmpBankAccount: Record "Employee Bank Account";
            begin
                //IGS The code below was commented out.. dont know why, so i uncommented it
                rEmpBankAccount.Get("Bank Code");
                "Bank Branch Code" := rEmpBankAccount."Bank Branch Code";
                //IGS END
            end;
        }
        field(50012; "Bank Account No"; Code[30])
        {
            DataClassification = ToBeClassified;
            Numeric = true;
        }
        field(50013; "ED Code Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ED Definitions"."ED Code";
        }
        field(50014; "Period Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = Periods."Period ID";
        }
        field(50015; Amount; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("Employee No." = FIELD("No."),
                                                            "Payroll ID" = FIELD("Period Filter"),
                                                            "ED Code" = FIELD("ED Code Filter"),
                                                            "Calculation Group" = FIELD("Calculation Group Filter"),
                                                            "Currency Code" = FIELD("Currency Filter"),
                                                            "Posting Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(50016; "Calculation Group Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionMembers = "None",Payments,"Benefit non Cash",Deduction;
            TableRelation = "ED Definitions"."Calculation Group";
        }
        field(50017; Loans; Decimal)
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(50018; "Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = "Employee Posting Groups";
        }
        field(50019; "Salary Scale"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Scale";
        }
        field(50020; "Scale Step"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Scale Step".Code WHERE(Scale = FIELD("Salary Scale"));
        }
        field(50021; Paystation; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Paystation;
        }
        field(50022; "Fixed Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Basic Pay"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            OptionMembers = " ","None","Fixed",Scale;
        }
        field(50024; "Hourly Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Daily Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Amount To Date"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE("Employee No." = FIELD("No."),
                                                            "ED Code" = FIELD("ED Code Filter"),
                                                            "Calculation Group" = FIELD("Calculation Group Filter"),
                                                            "Posting Date" = FIELD(UPPERLIMIT("Date Filter")),
                                                            "Currency Code" = FIELD("Currency Filter")));
            FieldClass = FlowField;
        }
        field(50027; "Payroll Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = Payroll;

            trigger OnValidate()
            begin
                //ERROR('Manual Edits not allowed.');
            end;
        }
        field(50028; "Membership No."; Code[20])
        {
            CalcFormula = Lookup("Membership Numbers"."Membership Number" WHERE("Employee No." = FIELD("No."),
                                                                                 "ED Code" = FIELD("ED Code Filter")));
            FieldClass = FlowField;
        }
        field(50029; "Amount (LCY)"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines"."Amount (LCY)" WHERE("Employee No." = FIELD("No."),
                                                                    "Payroll ID" = FIELD("Period Filter"),
                                                                    "ED Code" = FIELD("ED Code Filter"),
                                                                    "Calculation Group" = FIELD("Calculation Group Filter"),
                                                                    "Posting Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(50030; "Amount To Date (LCY)"; Decimal)
        {
            CalcFormula = Sum("Payroll Lines"."Amount (LCY)" WHERE("Employee No." = FIELD("No."),
                                                                    "ED Code" = FIELD("ED Code Filter"),
                                                                    "Calculation Group" = FIELD("Calculation Group Filter"),
                                                                    "Posting Date" = FIELD(UPPERLIMIT("Date Filter"))));
            FieldClass = FlowField;
        }
        field(50031; "Currency Filter"; Code[10])
        {
            FieldClass = FlowFilter;
        }
        field(50032; "Basic Pay Currency"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;
        }
        field(50033; "Housing For Employee"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'used in PAYE monthly generation';
            OptionCaption = 'Not Housed,Employer Owned,Employer Rented,Agricultural farm';
            OptionMembers = "Not Housed","Employer Owned","Employer Rented","Agricultural farm";
            TableRelation = Currency;
        }
        field(50034; "Value of Quarters"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'used in PAYE monthly generation';
        }
        field(50035; "Employee Grade"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Jobs"."Job Grade";
        }
        field(50036; "Personal ID No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50037; PIN; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Visa No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50039; "Visa End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50040; "Work Permit No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50041; "Work Permit End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50042; "Total Empl. Factor"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50043; "NSSF No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50044; "NHIF No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50045; "Branch Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50046; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(50047; "Housing Eligibility"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,House,House Allowance,Both';
            OptionMembers = " ",House,"House Allowance",Both;
        }
        field(50048; Service; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50182; Driver; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50200; Position; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Jobs";

            trigger OnValidate()
            var
                Jobs: Record Designations;
            begin

                HRJob.Reset;
                HRJob.SetRange(HRJob."No.", Position);
                if HRJob.FindFirst then begin
                    "Job Title" := HRJob."Job Title";
                    "Position Title" := HRJob."Job Title";
                    "Employee Grade" := HRJob."Job Grade";
                    "Supervisor Job No." := HRJob."Supervisor Job No.";
                    "Supervisor Job Title" := HRJob."Supervisor Job Title";
                    //  Position:=HRJob."Employee Name";
                end;
            end;
        }
        field(50201; "Position Title"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            Enabled = true;
        }
        field(50202; "Marital Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Single,Married,Separated,Divorced,"Widow(er)",Other;
        }
        field(50203; "Physically Challenged"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = No,Yes;
        }
        field(50204; "Physically Challenged Details"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50205; "Physically Challenged Grade"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50207; "Physical File No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50208; "Confirmation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50209; "Full Time/Part Time"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Full Time","Part Time",Contract,Internship;
        }
        field(50210; Age; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50211; "Wedding Anniversary"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50212; "Contract End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50213; "Exit Interview Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50214; "Exit Interview Done By"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(50215; "Allow Re-Employment in Future"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50216; "Probation Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50217; "No of Days"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Fixed Pay" := "No of Days" * "Daily Rate";
            end;
        }
        field(50218; "Employee Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',CMT,General,Apprentices';
            OptionMembers = ,CMT,General,Apprentices;
        }
        field(50219; Sanlam; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50220; Liberty; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50221; HELB; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50222; "Active Service Years"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50223; Ages; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50224; "Laptrust No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50225; HOD; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50226; Supervisor; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50228; "Board Members"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50229; "Medical Limit Inpatient"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50230; "Board Members Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50231; "Board Members End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50232; "Board Members Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Chairperson,Secretary,Staff,Visitor,Member';
            OptionMembers = " ",Chairperson,Secretary,Staff,Visitor,Member;
        }
        field(50233; MD; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50234; CIS; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50235; "Association representing"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50236; "Length of term"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50237; "Current Deisignation"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50238; "New PF No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50239; "Medical Limit Outpatient"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50240; "Medical Limit Dental"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50241; "Medical Limit Optical"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50242; "Medical Limit Maternity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50243; "Driver Allocation Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Available,Allocated,On Safari,Not on Duty';
            OptionMembers = " ",Available,Allocated,"On Safari","Not on Duty";
        }
        field(50244; "Class of Driving License"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50245; "Morgage Limits"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50246; "Car benefits"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50247; "Area Manager"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50248; "Old PF No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50249; Secretary; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50250; "Date of Retirement"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50251; HR; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52137023; "Marital Status-d"; Option)
        {
            DataClassification = ToBeClassified;
            Enabled = false;
            OptionCaption = ' ,Single,Married';
            OptionMembers = " ",Single,Married;
        }
        field(52137024; "Birth Certificate No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(52137025; "National ID No.-d"; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(52137026; "PIN No.-d"; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(52137027; "NSSF No.-d"; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(52137028; "NHIF No.-d"; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(52137029; "Passport No.-d"; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(52137030; "Driving Licence No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(52137031; "Job No.-d"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Jobs"."No." WHERE(Status = CONST(Released));

            trigger OnValidate()
            begin
                //Check if Occupied Positions exceeds Maximum positions created for the Job
                /*
                HRJob.RESET;
                //HRJob.SETRANGE(HRJob."No.","Job No.");
                IF HRJob.FINDFIRST THEN BEGIN
                  HRJob.CALCFIELDS(HRJob."Occupied Positions");
                IF HRJob."Occupied Positions">HRJob."Maximum Positions" THEN BEGIN
                  ERROR(ErrorVaccantPositions);
                  END;
                END;
                
                "Job Title":='';
                "Job Grade":='';
                "Global Dimension 1 Code":='';
                "Global Dimension 2 Code":='';
                
                HRJob.RESET;
                HRJob.SETRANGE(HRJob."No.","Job No.");
                IF HRJob.FINDFIRST THEN BEGIN
                  "Job Title":=HRJob."Job Title";
                  "Job Grade":=HRJob."Job Grade";
                  "Supervisor Job No.":=HRJob."Supervisor Job No.";
                  "Supervisor Job Title":=HRJob."Supervisor Job Title";
                  "Global Dimension 1 Code":=HRJob."Global Dimension 1 Code";
                  "Global Dimension 2 Code":=HRJob."Global Dimension 2 Code";
                
                END;
                */

            end;
        }
        field(52137033; "Job Grade-d"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Enabled = false;
            TableRelation = "HR Job Lookup Value".Code WHERE(Option = CONST("Job Grade"));
        }
        field(52137034; "Age-d"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Enabled = false;
        }
        field(52137035; "Bank Code-d"; Code[20])
        {
            Caption = 'Bank Code';
            DataClassification = ToBeClassified;
            Enabled = false;
            TableRelation = "Bank Code"."Bank Code";

            trigger OnValidate()
            begin
                "Bank Name" := '';
                BankCodes.Reset;
                BankCodes.SetRange(BankCodes."Bank Code", "Bank Code");
                if BankCodes.FindFirst then begin
                    BankCodes.TestField(BankCodes."Bank Name");
                    "Bank Name" := BankCodes."Bank Name";
                end;

            end;
        }
        field(52137036; "Bank Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(52137037; "Bank Branch Code-d"; Code[20])
        {
            Caption = 'Bank Branch Code';
            DataClassification = ToBeClassified;
            Enabled = false;
            TableRelation = "Bank Branch"."Bank Branch Code" WHERE("Bank Code" = FIELD("Bank Code"));

            trigger OnValidate()
            begin
                "Bank Branch Name" := '';
                BankBranches.Reset;
                BankBranches.SetRange(BankBranches."Bank Code", "Bank Code");
                BankBranches.SetRange(BankBranches."Bank Branch Code", "Bank Branch Code");
                if BankBranches.FindFirst then begin
                    BankBranches.TestField(BankBranches."Bank Branch Name");
                    "Bank Branch Name" := BankBranches."Bank Branch Name";
                end;

            end;
        }
        field(52137038; "Bank Branch Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(52137039; "Contract Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(52137040; Citizenship; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Lookup Values".Code WHERE(Option = CONST(Nationality));
        }
        field(52137041; Religion; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Lookup Values".Code WHERE(Option = CONST(Religion));
        }
        field(52137042; "County Code"; Code[50])
        {
            Caption = 'County of Origin Code';
            DataClassification = ToBeClassified;
            TableRelation = County.Code;

            trigger OnValidate()
            begin
                "County Name" := '';
                Counties.Reset;
                Counties.SetRange(Counties.Code, "County Code");
                if Counties.FindFirst then begin
                    "County Name" := Counties.Name;
                end;
            end;
        }
        field(52137043; "County Name"; Text[100])
        {
            Caption = 'County of Orgin Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(52137044; "SubCounty Code"; Code[50])
        {
            Caption = 'SubCounty of Origin Code';
            DataClassification = ToBeClassified;
            TableRelation = "Sub-County"."Sub-County Code" WHERE("County Code" = FIELD("County Code"));

            trigger OnValidate()
            begin
                "SubCounty Name" := '';
                SubCounty.Reset;
                SubCounty.SetRange(SubCounty."Sub-County Code", "SubCounty Code");
                SubCounty.SetRange(SubCounty."County Code", "County Code");
                if SubCounty.FindFirst then begin
                    "SubCounty Name" := SubCounty."Sub-County Name";
                end;
            end;
        }
        field(52137045; "SubCounty Name"; Text[100])
        {
            Caption = 'SubCounty of Origin Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(52137046; "Leave Status"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,On Leave';
            OptionMembers = " ","On Leave";
        }
        field(52137047; "Leave Calendar"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Base Calendar";
        }
        field(52137048; PasswordResetToken; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(52137049; PasswordResetTokenExpiry; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(52137050; "Portal Password"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(52137051; "Default Portal Password"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(52137053; "Contract Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(52137054; "Employee Signature"; Media)
        {
            DataClassification = ToBeClassified;
        }
        field(52137055; "Person Living with Disability"; Option)
        {
            DataClassification = ToBeClassified;
            Enabled = false;
            OptionCaption = 'No,Yes';
            OptionMembers = No,Yes;
        }
        field(52137056; "Ethnic Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Lookup Values".Code WHERE(Option = CONST(Ethnicity));
        }
        field(52137057; "Huduma No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(52137058; "HR Salary Notch"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(52137059; "Supervisor Job Title"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(52137060; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
            //ValidateTableRelation = true;

        }
        field(52137061; "Imprest Posting Group"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employee Posting Group";
        }
        field(52137062; Department; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Department";
        }
        field(52137063; Location; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Location";
        }
        field(52137064; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(52137065; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(52137066; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(52137067; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(52137068; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(52137069; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(52137070; "Driving License Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(52137072; "Practice Cert No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(52137073; "Employement Years of Service"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(52137124; "Date of Leaving"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(52137125; "Supervisor Job No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "HR Jobs"."No.";
        }
        field(52137126; "Termination Grounds"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Resignation,Non-Renewal Of Contract,Dismissal,Retirement,Death,Other';
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Death,Other;
        }
        field(52137127; "Total Leave Taken"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(52137128; "Leave Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "HR Leave Ledger Entries"."Leave Type" WHERE("Leave Type" = CONST('ANNUAL'));
        }
        field(52137129; "Leave Period Filter"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(52137130; "Allocated Leave Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(52137132; "Reason For Leaving"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Deceased,Termination,"Contract Ended",Abscondment,"Appt. Revoked","Contract Termination",Retrenchment,Other;
        }
        field(52137133; "Reason For Leaving (Other)"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(52137134; "On Probation"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50252; "Retirement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(52137140; "Contract Period"; DateFormula)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Format("Contract Period") = '' then begin
                    "Contract Expiry Date" := 0D
                end else begin
                    TestField("Contract Start Date");
                    "Contract Expiry Date" := (CalcDate("Contract Period", "Contract Start Date") - 1);
                end;
            end;
        }
        field(52137141; "Probation Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(52137142; "Probation Period"; DateFormula)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Format("Probation Period") = '' then begin
                    "Probation End date" := 0D
                end else begin
                    TestField("Probation Start Date");
                    "Probation End date" := (CalcDate("Probation Period", "Probation Start Date") - 1);
                end;
            end;
        }
        field(52137143; "Probation End date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(52137144; "Reactivation Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(52137145; "Leave Group"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Leave Groups".Code;
        }
        field(52137146; "Imprest Balance"; Decimal)
        {
            CalcFormula = Sum("Detailed Employee Ledger Entry".Amount WHERE("Employee No." = FIELD("No."),
                                                                             "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                             "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                             "Posting Date" = FIELD("Date Filter"),
                                                                             "Employee Transaction Type" = CONST(Imprest)));
            Caption = 'Imprest Balance';
            FieldClass = FlowField;
        }
        field(52137147; "Full Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(52137171; "Payroll Group Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(52137172; "Non Payroll Receipts"; Decimal)
        {
            CalcFormula = Sum("Non payroll Receipt".Amount WHERE("Employee No" = FIELD("No."),
                                                                  "ED Code" = FIELD("ED Code Filter"),
                                                                  "Posting Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(52137173; Responsibilty; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Head of Section,Head of Department';
            OptionMembers = " ","Head of Section","Head of Department";
        }
        field(52137174; Level; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Director,CMT,Management,Management 1,Key Support,Support,Unionisable,Intern';
            OptionMembers = " ",Director,CMT,Management,"Management 1","Key Support",Support,Unionisable,Intern;
        }
        field(52137175; "Board Members Sequence"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(52137176; "Employee Name"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "AssistEdit(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "FullName(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "DisplayMap(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "GetBankAccountNo(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "CheckBlockedEmployeeOnJnls(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeGetFullName(PROCEDURE 6)".


    procedure GetDurations()
    begin
        //Recalculate Important Dates
        if ("Inactive Date" = 0D) then begin
            if Today > "Birth Date" then
                if ("Birth Date" <> 0D) then Age := Dates.DetermineAge("Birth Date", Today);
            if Today > "Employment Date" then
                if ("Employment Date" <> 0D) then Service := Dates.DetermineAge("Employment Date", Today);
        end else begin
            if Today > "Birth Date" then
                if ("Birth Date" <> 0D) then Age := Dates.DetermineAge("Birth Date", Today);
            if "Inactive Date" > "Employment Date" then
                if ("Employment Date" <> 0D) then Service := Dates.DetermineAge("Employment Date", "Inactive Date");

        end;
    end;

    procedure DeletePayrollHeaders()
    var
        PayrollHeader: Record "Payroll Header";
        PayrollEntry: Record "Payroll Entry";
        PayrollLines: Record "Payroll Lines";
    begin
        //Mesh ke payroll
        if Confirm('You are about to delete all Open (unposted) Payroll Headers for this employee.\ ' +
                    'Are you sure none of the open payroll months for this employee have been paid?') = false then
            Error('Status change cancelled');

        PayrollHeader.SetRange("Employee no.", "No.");
        PayrollHeader.SetRange(Posted, false);
        if PayrollHeader.Find('-') then
            repeat
                PayrollEntry.SetRange("Payroll ID", PayrollHeader."Payroll ID");
                PayrollEntry.SetRange("Employee No.", PayrollHeader."Employee no.");
                PayrollEntry.DeleteAll;

                PayrollLines.SetRange("Payroll ID", PayrollHeader."Payroll ID");
                PayrollLines.SetRange("Employee No.", PayrollHeader."Employee no.");
                PayrollLines.DeleteAll;

                PayrollHeader.Delete;
            until PayrollHeader.Next = 0;
    end;

    procedure GetServiceDurations()
    begin
        //Recalculate Important Dates
        //IF ("Inactive Date" = 0D) THEN BEGIN
        if ("Calculation Scheme" = 'CMT') and ("Calculation Scheme" = 'INTERN') and ("Calculation Scheme" = 'GENERAL') then
            exit;
        if Today > "Birth Date" then begin
            //IF  ("Birth Date" <> 0D) THEN Age:= Dates.DetermineAge_Years("Birth Date",TODAY);
            if Today > "Birth Date" then
                if ("Birth Date" <> 0D) then "Active Service Years" := Dates.DetermineAgeService2("Birth Date", Today);
            /*END ELSE BEGIN
              IF TODAY > "Birth Date" THEN
                IF  ("Birth Date" <> 0D) THEN Age:= Dates.DetermineAge("Birth Date",TODAY);
              IF "Inactive Date" > "Employment Date" THEN
                IF  ("Employment Date" <> 0D) THEN Service:= Dates.DetermineAge("Employment Date","Inactive Date");*/

        end;

    end;

    procedure PWDGetServiceDurations()
    begin
        //Recalculate Important Dates
        //IF ("Inactive Date" = 0D) THEN BEGIN
        if ("Calculation Scheme" = 'CMT') and ("Calculation Scheme" = 'INTERN') and ("Calculation Scheme" = 'GENERAL') then
            exit;
        if Today > "Birth Date" then begin
            //IF  ("Birth Date" <> 0D) THEN Age:= Dates.DetermineAge_Years("Birth Date",TODAY);
            if Today > "Birth Date" then
                if ("Birth Date" <> 0D) then "Active Service Years" := Dates.pwdDetermineAgeService2("Birth Date", Today);
            /*END ELSE BEGIN
              IF TODAY > "Birth Date" THEN
                IF  ("Birth Date" <> 0D) THEN Age:= Dates.DetermineAge("Birth Date",TODAY);
              IF "Inactive Date" > "Employment Date" THEN
                IF  ("Employment Date" <> 0D) THEN Service:= Dates.DetermineAge("Employment Date","Inactive Date");*/

        end;

    end;

    //Unsupported feature: Property Modification (Fields) on "DropDown(FieldGroup 1)".



    //Unsupported feature: Property Modification (Subtype) on "Relative(Variable 1006)".

    //var
    //Relative : pay;
    //Variable type has not been exported.

    var
        //>>>> ORIGINAL VALUE:
        //Relative : "Employee Relative";
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        HRJob: Record "HR Jobs";
        BankCodes: Record "Bank Code";
        BankBranches: Record "Bank Branch";
        Employee: Record Employee;
        UserMgt: Codeunit "User Management";
        Counties: Record County;
        SubCounty: Record "Sub-County";
        Dates: Codeunit Dates;
        ErrorVaccantPositions: Label 'The Vacant Position(s) cannot exceed the Maximum Position(s) to be occupied for this Job.';
        gvResource: Record Resource;
        gvLicensePermission: Record "License Permission";
        DAge: Text[250];
        DService: Text[250];
        PayrollSetup: Record "Payroll Setups";
}

