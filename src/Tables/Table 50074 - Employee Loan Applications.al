table 50074 "Employee Loan Applications"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                "Employee Name" := '';
                "Employee Age" := '';
                Description := '';
                "Loan Product Code" := '';
                "Loan Product Description" := '';
                "Repayment Amount" := 0;
                "Repayment End Date" := 0D;
                "Repayment Frequency" := "Repayment Frequency"::" ";
                "Repayment Period" := 0;
                "Repayment Start Date" := Today;
                "Applied Amount" := 0;
                "Entitled Amount" := 0;
                "No. of Installments" := 0;
                "Interest Rate" := 0;

                Employee.Reset;
                if Employee.Get("Employee No.") then begin
                    Employee.TestField(Employee."Birth Date");
                    Employee.TestField("Job Grade-d");
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    Evaluate(RetirementPeriod, '60Y');
                    "Retirement Period" := RetirementPeriod;
                    "Retirement Date" := CalcDate(RetirementPeriod, Employee."Birth Date");
                    "Employee Age" := Dates.DetermineAge(Employee."Birth Date", Today);
                    "Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                    "Shortcut Dimension 3 Code" := Employee."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 4 Code" := Employee."Shortcut Dimension 4 Code";
                end;
            end;
        }
        field(4; "Employee Name"; Text[90])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "HR Branch"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "HR Department"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Employee Age"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Retirement Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Retirement Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Loan Product Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            // TableRelation = Table50363;

            trigger OnValidate()
            begin
                //check if loan of same type is present
                EmployeeLoanApplications.Reset;
                EmployeeLoanApplications.SetRange("Employee No.", "Employee No.");
                EmployeeLoanApplications.SetRange("Loan Product Code", "Loan Product Code");
                if EmployeeLoanApplications.Count > 1 then
                    Error(Text_0003);

                TestField("Employee No.");
                "Loan Product Description" := '';
                "Applied Amount" := 0;
                "Repayment Period" := 0;
                "Repayment Amount" := 0;

                EmployeeLoanProducts.Reset;
                if EmployeeLoanProducts.Get("Loan Product Code") then begin
                    EmployeeLoanProducts.TestField(EmployeeLoanProducts."Product Description");
                    EmployeeLoanProducts.TestField(EmployeeLoanProducts."Repayment Frequency");
                    EmployeeLoanProducts.TestField(EmployeeLoanProducts."Repayment Period");
                    "Loan Product Description" := EmployeeLoanProducts."Product Description";
                    "Repayment Frequency" := EmployeeLoanProducts."Repayment Frequency";
                    "Repayment Period" := EmployeeLoanProducts."Repayment Period";
                    "No. of Installments" := EmployeeLoanProducts."Repayment Period";
                    "Interest Rate" := EmployeeLoanProducts."Interest Rate(%)";
                end;

                //get entitlement amount
                "Entitled Amount" := HRLoanMgt.GetEntitlementAmount(Rec);
                //insert documents
                HRLoanMgt.GetLoanDocuments("Loan Product Code", "No.");
            end;
        }
        field(11; "Loan Product Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Repayment Frequency"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Daily,Monthly,Quarterly,Annually';
            OptionMembers = " ",Daily,Monthly,Quarterly,Annually;
        }
        field(13; "Applied Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Loan Schedule Base Amount" := "Applied Amount";
                Modify;
                TestField(Status, Status::Open);
                TestField("Repayment Period");
                HRLoanMgt.ValidateEmployeeLoanAppliedAmount(Rec);
                "Repayment Amount" := RepaymentAmount;
                Validate("Repayment Period");
            end;
        }
        field(14; "Entitled Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Repayment Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Repayment Period"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                TestField("Loan Product Code");
                //TESTFIELD("Applied Amount");

                EmployeeLoanProducts.Reset;
                if EmployeeLoanProducts.Get("Loan Product Code") then begin
                    if "Repayment Period" > EmployeeLoanProducts."Repayment Period" then
                        Error(Text_0001, Format(EmployeeLoanProducts."Repayment Period"));
                end;

                case "Repayment Frequency" of
                    "Repayment Frequency"::Daily:
                        Evaluate(RepaymentPeriod, '+' + Format("Repayment Period") + 'D');
                    "Repayment Frequency"::Monthly:
                        Evaluate(RepaymentPeriod, '+' + Format("Repayment Period") + 'M');
                    "Repayment Frequency"::Quarterly:
                        Evaluate(RepaymentPeriod, '+' + Format("Repayment Period") + 'Q');
                    "Repayment Frequency"::Annually:
                        Evaluate(RepaymentPeriod, '+' + Format("Repayment Period") + 'Y');
                end;

                //check retirement age
                if EmployeeLoanProducts.Get("Loan Product Code") then begin
                    "Repayment End Date" := 0D;
                    "Repayment End Date" := CalcDate(RepaymentPeriod, "Repayment Start Date");
                    if EmployeeLoanProducts."Check Employee Age" = EmployeeLoanProducts."Check Employee Age"::Yes then begin
                        if "Repayment End Date" > "Retirement Date" then begin
                            Error(Text_0002);
                        end;
                    end else begin
                    end;
                end;

                RepaymentAmount := ("Interest Rate" / 12 / 100) / (1 - Power((1 + ("Interest Rate" / 12 / 100)), -"Repayment Period")) * "Applied Amount";
                "Repayment Amount" := RepaymentAmount;


                "No. of Installments" := "Repayment Period";
                HRLoanMgt.ValidateEmployeeLoanAppliedAmount(Rec);
            end;
        }
        field(17; "Repayment End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "No. of Installments"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "Job Grade"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "HR Job Grades"."Job Grade";
        }
        field(20; "Interest Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Loan Schedule Base Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "Repayment Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(30; Submitted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Account Created"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32; "Loan Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(49; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(50; "Global Dimension 1 Code"; Code[50])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(51; "Global Dimension 2 Code"; Code[50])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(52; "Shortcut Dimension 3 Code"; Code[50])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(53; "Shortcut Dimension 4 Code"; Code[50])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(54; "Shortcut Dimension 5 Code"; Code[50])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(55; "Shortcut Dimension 6 Code"; Code[50])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(56; "Shortcut Dimension 7 Code"; Code[50])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(57; "Shortcut Dimension 8 Code"; Code[50])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(58; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
            //TableRelation = "Supplier Category".Field1;
        }
        field(70; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Submitted,Disbursed';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Submitted,Disbursed;

            trigger OnValidate()
            begin
                if Status = Status::Approved then begin
                    //Notify Legal Department
                    LoansUserSetup.Reset;
                    LoansUserSetup.SetRange("Legal Manager", true);
                    if LoansUserSetup.FindFirst then begin
                        UserSetup.Reset;
                        UserSetup.Get(LoansUserSetup."User ID");
                        //Email to Legal
                        HRLoanMgt.CreateNotificationEmailLegal(Rec, UserSetup."E-Mail");
                    end;
                    //send to employee
                    if Employee.Get("Employee No.") then
                        HRLoanMgt.CreateApprovalNotificationEmailApplicant(Rec, Employee."Company E-Mail");
                end;

                //rejected
                if Status = Status::Rejected then begin
                    if Employee.Get("Employee No.") then
                        //Email to Applicant
                        HRLoanMgt.CreateRejectionNotificationEmailApplicant(Rec, Employee."Company E-Mail");
                end;
            end;
        }
        field(80; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(81; "Time Created"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(99; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            begin
                Employee.Reset;
                Employee.SetRange(Employee."User ID", "User ID");
                if Employee.FindFirst then begin
                    "Employee No." := Employee."No.";
                    "Employee Name" := Employee."Last Name" + ' ' + Employee."Middle Name" + ' ' + Employee."First Name";
                    Evaluate(RetirementPeriod, '60Y');
                    "Retirement Period" := RetirementPeriod;
                    "Retirement Date" := CalcDate(RetirementPeriod, Employee."Birth Date");
                    "Employee Age" := Dates.DetermineAge(Employee."Birth Date", Today);
                    "Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                    "Shortcut Dimension 3 Code" := Employee."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 4 Code" := Employee."Shortcut Dimension 4 Code";
                end;
            end;
        }
        field(100; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(101; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            DataClassification = ToBeClassified;
        }
        field(102; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';
            DataClassification = ToBeClassified;
        }
        field(200; "Approval User ID"; Code[50])
        {
            Caption = 'Approval User ID';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(300; "1-3 yrs"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(301; "3-6 yrs"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(302; "6-8 yrs"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(400; "Documents Verified"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(401; "Loan Officer Remarks"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(402; "Approval Recommendation"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Approve Loan,Reject Loan';
            OptionMembers = " ","Approve Loan","Reject Loan";
        }
        field(500; "Rejection Comment"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            LoansGeneralSetup.Get;
            LoansGeneralSetup.TestField(LoansGeneralSetup."Loan Application No's");
            "NoSeriesMgt.".InitSeries(LoansGeneralSetup."Loan Application No's", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Document Date" := Today;
        "User ID" := UserId;
        "Date Created" := Today;
        "Time Created" := Time;
        "Approval User ID" := UserId;
        "Repayment Start Date" := Today;

        if Employee.Get(UserId) then
            "User ID" := Employee."User ID";
        Validate("User ID");
    end;

    var
        InvestmentGeneralSetup: Record "Funds General Setup";
        "NoSeriesMgt.": Codeunit NoSeriesManagement;
        Employee: Record Employee;
        EmployeeLoanProducts: Record "Employee Loan Products";
        HRLoanMgt: Codeunit "HR Loan Management";
        RetirementPeriod: DateFormula;
        RepaymentPeriod: DateFormula;
        LoanProductGrades: Record "Loan Product Grades";
        EmployeeSalary: Record "Cover Letter";
        RepaymentAmount: Decimal;
        Dates: Codeunit Dates;
        EmployeeSalaryLedger: Record "Employee Salary Ledger1";
        NewNetPay: Decimal;
        LoanProductDocuments: Record "Loan Application Documents";
        LoansGeneralSetup: Record "Employee Loans General Setup";
        Text_0001: Label 'Repayment Period cannot be higher than: %1';
        Text_0002: Label 'The repayment end date cannot be later than your retirement age. Please reduce the repayment period.';
        EmployeeLoanApplications: Record "Employee Loan Applications";
        LoansUserSetup: Record "Employee Loans User Setup";
        UserSetup: Record "User Setup";
        Text_0003: Label 'You cannot apply loan of the same type twice';
        PortalWS: Codeunit "HR Management WS";
}

