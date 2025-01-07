table 53000 "Employee - payroll fields"
{
    Caption = 'Employee';
    DataCaptionFields = "No.","First Name","Middle Name","Last Name";
    DrillDownPageID = "Employee List";
    LookupPageID = "Employee List";

    fields
    {
        field(1;"No.";Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                  HumanResSetup.Get;
                  NoSeriesMgt.TestManual(HumanResSetup."Employee Nos.");
                  "No. Series" := '';
                end;
            end;
        }
        field(2;"First Name";Text[30])
        {
            Caption = 'First Name';
        }
        field(3;"Middle Name";Text[30])
        {
            Caption = 'Middle Name';
        }
        field(4;"Last Name";Text[30])
        {
            Caption = 'Last Name';
        }
        field(5;Initials;Text[30])
        {
            Caption = 'Initials';

            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Initials)) or ("Search Name" = '') then
                  "Search Name" := Initials;
            end;
        }
        field(6;"Job Title";Text[30])
        {
            Caption = 'Job Title';
        }
        field(7;"Search Name";Code[250])
        {
            Caption = 'Search Name';

            trigger OnValidate()
            begin
                if "Search Name" = '' then
                  "Search Name" := SetSearchNameToFullnameAndInitials;
            end;
        }
        field(8;Address;Text[50])
        {
            Caption = 'Address';
        }
        field(9;"Address 2";Text[50])
        {
            Caption = 'Address 2';
        }
        field(10;City;Text[30])
        {
            Caption = 'City';
            TableRelation = IF ("Country/Region Code"=CONST('')) "Post Code".City
                            ELSE IF ("Country/Region Code"=FILTER(<>'')) "Post Code".City WHERE ("Country/Region Code"=FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(11;"Post Code";Code[20])
        {
            Caption = 'Post Code';
            TableRelation = IF ("Country/Region Code"=CONST('')) "Post Code"
                            ELSE IF ("Country/Region Code"=FILTER(<>'')) "Post Code" WHERE ("Country/Region Code"=FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(12;County;Text[30])
        {
            CaptionClass = '5,1,' + "Country/Region Code";
            Caption = 'County';
        }
        field(13;"Phone No.";Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(14;"Mobile Phone No.";Text[30])
        {
            Caption = 'Mobile Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(15;"E-Mail";Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("E-Mail");
            end;
        }
        field(16;"Alt. Address Code";Code[10])
        {
            Caption = 'Alt. Address Code';
            TableRelation = "Alternative Address".Code WHERE ("Employee No."=FIELD("No."));
        }
        field(17;"Alt. Address Start Date";Date)
        {
            Caption = 'Alt. Address Start Date';
        }
        field(18;"Alt. Address End Date";Date)
        {
            Caption = 'Alt. Address End Date';
        }
        field(19;Picture;BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(20;"Birth Date";Date)
        {
            Caption = 'Birth Date';
        }
        field(21;"Social Security No.";Text[30])
        {
            Caption = 'Social Security No.';
        }
        field(22;"Union Code";Code[10])
        {
            Caption = 'Union Code';
            TableRelation = Union;
        }
        field(23;"Union Membership No.";Text[30])
        {
            Caption = 'Union Membership No.';
        }
        field(24;Gender;Option)
        {
            Caption = 'Gender';
            OptionCaption = ' ,Female,Male';
            OptionMembers = " ",Female,Male;
        }
        field(25;"Country/Region Code";Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(26;"Manager No.";Code[20])
        {
            Caption = 'Manager No.';
            TableRelation = Employee;
        }
        field(27;"Emplymt. Contract Code";Code[10])
        {
            Caption = 'Emplymt. Contract Code';
            TableRelation = "Employment Contract";
        }
        field(28;"Statistics Group Code";Code[10])
        {
            Caption = 'Statistics Group Code';
            TableRelation = "Employee Statistics Group";
        }
        field(29;"Employment Date";Date)
        {
            Caption = 'Employment Date';
        }
        field(31;Status;Option)
        {
            Caption = 'Status';
            OptionCaption = 'Active,Inactive,Terminated';
            OptionMembers = Active,Inactive,Terminated;

            trigger OnValidate()
            begin
                EmployeeQualification.SetRange("Employee No.","No.");
                EmployeeQualification.ModifyAll("Employee Status",Status);
                Modify;

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
                EmployeeQualification.SetRange("Employee No.","No.");
                EmployeeQualification.ModifyAll("Employee Status",Status);
                Modify;
            end;
        }
        field(32;"Inactive Date";Date)
        {
            Caption = 'Inactive Date';
        }
        field(33;"Cause of Inactivity Code";Code[10])
        {
            Caption = 'Cause of Inactivity Code';
            TableRelation = "Cause of Inactivity";
        }
        field(34;"Termination Date";Date)
        {
            Caption = 'Termination Date';
        }
        field(35;"Grounds for Term. Code";Code[10])
        {
            Caption = 'Grounds for Term. Code';
            TableRelation = "Grounds for Termination";
        }
        field(36;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(37;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(38;"Resource No.";Code[20])
        {
            Caption = 'Resource No.';
            TableRelation = Resource WHERE (Type=CONST(Person));

            // trigger OnValidate()
            // begin
            //     if ("Resource No." <> '') and Res.WritePermission then
            //       //EmployeeResUpdate.ResUpdate(Rec)//justo commented
            // end;
        }
        field(39;Comment;Boolean)
        {
            CalcFormula = Exist("Human Resource Comment Line" WHERE ("Table Name"=CONST(Employee),
                                                                     "No."=FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(40;"Last Date Modified";Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(41;"Date Filter";Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(42;"Global Dimension 1 Filter";Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1));
        }
        field(43;"Global Dimension 2 Filter";Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2));
        }
        field(44;"Cause of Absence Filter";Code[10])
        {
            Caption = 'Cause of Absence Filter';
            FieldClass = FlowFilter;
            TableRelation = "Cause of Absence";
        }
        field(45;"Total Absence (Base)";Decimal)
        {
            CalcFormula = Sum("Employee Absence"."Quantity (Base)" WHERE ("Employee No."=FIELD("No."),
                                                                          "Cause of Absence Code"=FIELD("Cause of Absence Filter"),
                                                                          "From Date"=FIELD("Date Filter")));
            Caption = 'Total Absence (Base)';
            DecimalPlaces = 0:5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(46;Extension;Text[30])
        {
            Caption = 'Extension';
        }
        field(47;"Employee No. Filter";Code[20])
        {
            Caption = 'Employee No. Filter';
            FieldClass = FlowFilter;
            TableRelation = Employee;
        }
        field(48;Pager;Text[30])
        {
            Caption = 'Pager';
        }
        field(49;"Fax No.";Text[30])
        {
            Caption = 'Fax No.';
        }
        field(50;"Company E-Mail";Text[80])
        {
            Caption = 'Company Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("Company E-Mail");
            end;
        }
        field(51;Title;Text[30])
        {
            Caption = 'Title';
        }
        field(52;"Salespers./Purch. Code";Code[20])
        {
            Caption = 'Salespers./Purch. Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(53;"No. Series";Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(54;"Last Modified Date Time";DateTime)
        {
            Caption = 'Last Modified Date Time';
            Editable = false;
        }
        field(55;"Employee Posting Group";Code[20])
        {
            Caption = 'Employee Posting Group';
            TableRelation = "Employee Posting Group";
        }
        field(56;"Bank Branch No.";Text[20])
        {
            Caption = 'Bank Branch No.';
        }
        field(57;"Bank Account No.";Text[30])
        {
            Caption = 'Bank Account No.';
        }
        field(58;IBAN;Code[50])
        {
            Caption = 'IBAN';

            trigger OnValidate()
            var
                CompanyInfo: Record "Company Information";
            begin
                CompanyInfo.CheckIBAN(IBAN);
            end;
        }
        field(59;Balance;Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = -Sum("Detailed Employee Ledger Entry".Amount WHERE ("Employee No."=FIELD("No."),
                                                                              "Initial Entry Global Dim. 1"=FIELD("Global Dimension 1 Filter"),
                                                                              "Initial Entry Global Dim. 2"=FIELD("Global Dimension 2 Filter"),
                                                                              "Posting Date"=FIELD("Date Filter")));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60;"SWIFT Code";Code[20])
        {
            Caption = 'SWIFT Code';
        }
        field(80;"Application Method";Option)
        {
            Caption = 'Application Method';
            OptionCaption = 'Manual,Apply to Oldest';
            OptionMembers = Manual,"Apply to Oldest";
        }
        field(140;Image;Media)
        {
            Caption = 'Image';
            ExtendedDatatype = Person;
        }
        field(150;"Privacy Blocked";Boolean)
        {
            Caption = 'Privacy Blocked';
        }
        field(1100;"Cost Center Code";Code[20])
        {
            Caption = 'Cost Center Code';
            TableRelation = "Cost Center";
        }
        field(1101;"Cost Object Code";Code[20])
        {
            Caption = 'Cost Object Code';
            TableRelation = "Cost Object";
        }
        field(8000;Id;Guid)
        {
            Caption = 'Id';
        }
        field(50001;"Emp Branch Code";Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50002;"Bank Branch Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003;"National ID";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50004;"Customer No.";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(50005;"Name of Old Employer";Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50006;"Address of Old Employer";Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50007;"Name of New Employer";Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50008;"Address of New Employer";Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50009;"Calculation Scheme";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = "Calculation Header";
        }
        field(50010;"Mode of Payment";Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Mode of Payment";
        }
        field(50011;"Bank Code";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employee Bank Account";

            trigger OnValidate()
            var
                rEmpBankAccount: Record "Employee Bank Account";
            begin
                //IGS The code below was commented out.. dont know why, so i uncommented it
                rEmpBankAccount.Get("Bank Code");
                "Bank Branch Code" :=  rEmpBankAccount."Bank Branch Code";
                //IGS END
            end;
        }
        field(50012;"Bank Account No";Code[30])
        {
            DataClassification = ToBeClassified;
            Numeric = true;
        }
        field(50013;"ED Code Filter";Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ED Definitions"."ED Code";
        }
        field(50014;"Period Filter";Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = Periods."Period ID";
        }
        field(50015;Amount;Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE ("Employee No."=FIELD("No."),
                                                            "Payroll ID"=FIELD("Period Filter"),
                                                            "ED Code"=FIELD("ED Code Filter"),
                                                            "Calculation Group"=FIELD("Calculation Group Filter"),
                                                            "Currency Code"=FIELD("Currency Filter"),
                                                            "Posting Date"=FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(50016;"Calculation Group Filter";Option)
        {
            FieldClass = FlowFilter;
            OptionMembers = "None",Payments,"Benefit non Cash",Deduction;
            TableRelation = "ED Definitions"."Calculation Group";
        }
        field(50017;Loans;Decimal)
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(50018;"Posting Group";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Employee Posting Groups";
        }
        field(50019;"Salary Scale";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Scale";
        }
        field(50020;"Scale Step";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Scale Step".Code WHERE (Scale=FIELD("Salary Scale"));
        }
        field(50021;Paystation;Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Paystation;
        }
        field(50022;"Fixed Pay";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50023;"Basic Pay";Option)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            OptionMembers = " ","None","Fixed",Scale;
        }
        field(50024;"Hourly Rate";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50025;"Daily Rate";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50026;"Amount To Date";Decimal)
        {
            CalcFormula = Sum("Payroll Lines".Amount WHERE ("Employee No."=FIELD("No."),
                                                            "ED Code"=FIELD("ED Code Filter"),
                                                            "Calculation Group"=FIELD("Calculation Group Filter"),
                                                            "Posting Date"=FIELD(UPPERLIMIT("Date Filter")),
                                                            "Currency Code"=FIELD("Currency Filter")));
            FieldClass = FlowField;
        }
        field(50027;"Payroll Code";Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = Payroll;

            trigger OnValidate()
            begin
                //ERROR('Manual Edits not allowed.');
            end;
        }
        field(50028;"Membership No.";Code[20])
        {
            CalcFormula = Lookup("Membership Numbers"."Membership Number" WHERE ("Employee No."=FIELD("No."),
                                                                                 "ED Code"=FIELD("ED Code Filter")));
            FieldClass = FlowField;
        }
        field(50029;"Amount (LCY)";Decimal)
        {
            CalcFormula = Sum("Payroll Lines"."Amount (LCY)" WHERE ("Employee No."=FIELD("No."),
                                                                    "Payroll ID"=FIELD("Period Filter"),
                                                                    "ED Code"=FIELD("ED Code Filter"),
                                                                    "Calculation Group"=FIELD("Calculation Group Filter"),
                                                                    "Posting Date"=FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(50030;"Amount To Date (LCY)";Decimal)
        {
            CalcFormula = Sum("Payroll Lines"."Amount (LCY)" WHERE ("Employee No."=FIELD("No."),
                                                                    "ED Code"=FIELD("ED Code Filter"),
                                                                    "Calculation Group"=FIELD("Calculation Group Filter"),
                                                                    "Posting Date"=FIELD(UPPERLIMIT("Date Filter"))));
            FieldClass = FlowField;
        }
        field(50031;"Currency Filter";Code[10])
        {
            FieldClass = FlowFilter;
        }
        field(50032;"Basic Pay Currency";Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;
        }
        field(50033;"Housing For Employee";Option)
        {
            DataClassification = ToBeClassified;
            Description = 'used in PAYE monthly generation';
            OptionCaption = 'Not Housed,Employer Owned,Employer Rented,Agricultural farm';
            OptionMembers = "Not Housed","Employer Owned","Employer Rented","Agricultural farm";
            TableRelation = Currency;
        }
        field(50034;"Value of Quarters";Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'used in PAYE monthly generation';
        }
        field(50035;"Employee Grade";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employee Grades2"."Grade Code";
        }
        field(50036;"Personal ID No.";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50037;PIN;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50038;"Visa No.";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50039;"Visa End Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50040;"Work Permit No.";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50041;"Work Permit End Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50042;"Total Empl. Factor";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50043;"NSSF No.";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50044;"NHIF No.";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50045;"Branch Code";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50046;"Location Code";Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(50047;"Housing Eligibility";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,House,House Allowance,Both';
            OptionMembers = " ",House,"House Allowance",Both;
        }
        field(50048;Service;Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50200;Position;Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HR fields';
            TableRelation = Designations;

            trigger OnValidate()
            var
                Jobs: Record Designations;
            begin

                Jobs.Reset;
                Jobs.SetRange(Jobs."Job ID",Position);
                if Jobs.FindFirst then begin
                  "Job Title":=Jobs."Job Description";
                  "Position Title":=Jobs."Job Description";
                end;
            end;
        }
        field(50201;"Position Title";Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50202;"Marital Status";Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Single,Married,Separated,Divorced,"Widow(er)",Other;
        }
        field(50203;"Physically Challenged";Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = No,Yes;
        }
        field(50204;"Physically Challenged Details";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50205;"Physically Challenged Grade";Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50207;"Physical File No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50208;"Confirmation Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50209;"Full Time/Part Time";Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Full Time","Part Time",Contract,Internship;
        }
        field(50210;Age;Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50211;"Wedding Anniversary";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50212;"Contract End Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50213;"Exit Interview Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50214;"Exit Interview Done By";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(50215;"Allow Re-Employment in Future";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50216;"Probation Expiry Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50217;"No of Days";Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Fixed Pay":="No of Days"*"Daily Rate";
            end;
        }
    }

    keys
    {
        key(Key1;"No.")
        {
        }
        key(Key2;"Search Name")
        {
        }
        key(Key3;Status,"Union Code")
        {
        }
        key(Key4;Status,"Emplymt. Contract Code")
        {
        }
        key(Key5;"Last Name","First Name","Middle Name")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"No.","First Name","Last Name",Initials,"Job Title")
        {
        }
        fieldgroup(Brick;"Last Name","First Name","Job Title",Image)
        {
        }
    }

    trigger OnDelete()
    begin
        AlternativeAddr.SetRange("Employee No.","No.");
        AlternativeAddr.DeleteAll;

        EmployeeQualification.SetRange("Employee No.","No.");
        EmployeeQualification.DeleteAll;

        //Relative.SetRange("Employee No.","No.");//Justo commented
        //Relative.DeleteAll;

        EmployeeAbsence.SetRange("Employee No.","No.");
        EmployeeAbsence.DeleteAll;

        MiscArticleInformation.SetRange("Employee No.","No.");
        MiscArticleInformation.DeleteAll;

        ConfidentialInformation.SetRange("Employee No.","No.");
        ConfidentialInformation.DeleteAll;

        HumanResComment.SetRange("No.","No.");
        HumanResComment.DeleteAll;

        DimMgt.DeleteDefaultDim(DATABASE::Employee,"No.");
    end;

    trigger OnInsert()
    begin
        "Last Modified Date Time" := CurrentDateTime;
        if "No." = '' then begin
          HumanResSetup.Get;
          HumanResSetup.TestField("Employee Nos.");
          NoSeriesMgt.InitSeries(HumanResSetup."Employee Nos.",xRec."No. Series",0D,"No.","No. Series");
        end;

        DimMgt.UpdateDefaultDim(
          DATABASE::Employee,"No.",
          "Global Dimension 1 Code","Global Dimension 2 Code");
        UpdateSearchName;
        "Calculation Scheme":='IGS';
        "Payroll Code":='IGS';
        "Posting Group":='EMPLOYEE';
        "Basic Pay":="Basic Pay"::Fixed;
    end;

    trigger OnModify()
    begin
        "Last Modified Date Time" := CurrentDateTime;
        "Last Date Modified" := Today;
        /*IF Res.READPERMISSION THEN
          EmployeeResUpdate.HumanResToRes(xRec,Rec);
        IF SalespersonPurchaser.READPERMISSION THEN
          EmployeeSalespersonUpdate.HumanResToSalesPerson(xRec,Rec);*/
        UpdateSearchName;

    end;

    trigger OnRename()
    begin
        "Last Modified Date Time" := CurrentDateTime;
        "Last Date Modified" := Today;
        UpdateSearchName;
    end;

    var
        HumanResSetup: Record "Human Resources Setup";
        Res: Record Resource;
        PostCode: Record "Post Code";
        AlternativeAddr: Record "Alternative Address";
        EmployeeQualification: Record "Employee Qualification";
        //Relative: Record pay;//Justo to uncommit
        EmployeeAbsence: Record "Employee Absence";
        MiscArticleInformation: Record "Misc. Article Information";
        ConfidentialInformation: Record "Confidential Information";
        HumanResComment: Record "Human Resource Comment Line";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EmployeeResUpdate: Codeunit "Employee/Resource Update";
        EmployeeSalespersonUpdate: Codeunit "Employee/Salesperson Update";
        DimMgt: Codeunit DimensionManagement;
        Text000: Label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        BlockedEmplForJnrlErr: Label 'You cannot create this document because employee %1 is blocked due to privacy.', Comment='%1 = employee no.';
        BlockedEmplForJnrlPostingErr: Label 'You cannot post this document because employee %1 is blocked due to privacy.', Comment='%1 = employee no.';
        DAge: Text[250];
        DService: Text[250];
        Dates: Codeunit "HR Dates";
        gvResource: Record Resource;
        gvLicensePermission: Record "License Permission";

    [Scope('Personalization')]
    procedure AssistEdit(): Boolean
    begin
        HumanResSetup.Get;
        HumanResSetup.TestField("Employee Nos.");
        if NoSeriesMgt.SelectSeries(HumanResSetup."Employee Nos.",xRec."No. Series","No. Series") then begin
          NoSeriesMgt.SetSeries("No.");
          exit(true);
        end;
    end;

    [Scope('Personalization')]
    procedure FullName(): Text[100]
    var
        NewFullName: Text[100];
        Handled: Boolean;
    begin
        //OnBeforeGetFullName(Rec,NewFullName,Handled);
        if Handled then
          exit(NewFullName);

        if "Middle Name" = '' then
          exit("First Name" + ' ' + "Last Name");

        exit("First Name" + ' ' + "Middle Name" + ' ' + "Last Name");
    end;

    [Scope('Personalization')]
    procedure ValidateShortcutDimCode(FieldNumber: Integer;var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber,ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::Employee,"No.",FieldNumber,ShortcutDimCode);
        Modify;
    end;

    procedure DisplayMap()
    var
        MapPoint: Record "Online Map Setup";
        MapMgt: Codeunit "Online Map Management";
    begin
        if MapPoint.FindFirst then
          MapMgt.MakeSelection(DATABASE::Employee,GetPosition)
        else
          Message(Text000);
    end;

    local procedure UpdateSearchName()
    var
        PrevSearchName: Code[250];
    begin
        PrevSearchName := xRec.FullName + ' ' + xRec.Initials;
        if ((("First Name" <> xRec."First Name") or ("Middle Name" <> xRec."Middle Name") or ("Last Name" <> xRec."Last Name") or
             (Initials <> xRec.Initials)) and ("Search Name" = PrevSearchName))
        then
          "Search Name" := SetSearchNameToFullnameAndInitials;
    end;

    local procedure SetSearchNameToFullnameAndInitials(): Code[250]
    begin
        exit(FullName + ' ' + Initials);
    end;

    [Scope('Personalization')]
    procedure GetBankAccountNo(): Text
    begin
        if IBAN <> '' then
          exit(DelChr(IBAN,'=<>'));

        if "Bank Account No." <> '' then
          exit("Bank Account No.");
    end;

    [Scope('Personalization')]
    procedure CheckBlockedEmployeeOnJnls(IsPosting: Boolean)
    begin
        if "Privacy Blocked" then begin
          if IsPosting then
            Error(BlockedEmplForJnrlPostingErr,"No.");
          Error(BlockedEmplForJnrlErr,"No.")
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetFullName(Employee: Record Employee;var NewFullName: Text[100];var Handled: Boolean)
    begin
    end;

    procedure GetDurations()
    begin
        //Recalculate Important Dates
           if ("Inactive Date" = 0D) then begin
           if Today > "Birth Date" then
            if  ("Birth Date" <> 0D) then Age:= Dates.DetermineAge("Birth Date",Today);
           if Today > "Employment Date" then
            if  ("Employment Date" <> 0D) then  Service:= Dates.DetermineAge("Employment Date",Today);
          end else begin
            if Today > "Birth Date" then
              if  ("Birth Date" <> 0D) then Age:= Dates.DetermineAge("Birth Date",Today);
            if "Inactive Date" > "Employment Date" then
              if  ("Employment Date" <> 0D) then Service:= Dates.DetermineAge("Employment Date","Inactive Date");
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
                    'Are you sure none of the open payroll months for this employee have been paid?')= false then
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
}

