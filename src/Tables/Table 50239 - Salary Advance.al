table 50239 "Salary Advance"
{
    DrillDownPageID = "Salary Advance List";
    LookupPageID = "Salary Advance List";
    Permissions = TableData "Payroll Header" = rimd,
                  TableData "Payroll Lines" = rimd,
                  TableData "Payroll Entry" = rimd,
                  TableData "Special Payments" = rimd,
                  TableData "Loan Entry" = rimd;

    fields
    {
        field(1; ID; Code[20])
        {
        }
        field(2; Employee; Code[20])
        {
            Editable = true;
            NotBlank = true;
            TableRelation = Employee;

            trigger OnValidate()
            var
                lvEmployee: Record Employee;
            begin
                //TestStatusOpen(TRUE);

                //"Employee Name":='';
                //"Employee Posting Group":='';
                if UserSetup.Get(Employee) then begin
                    "First Name" := UserSetup."First Name";//+' '+Employee."Middle Name"+' '+Employee."Last Name";
                    "Last Name" := UserSetup."Last Name";
                    "Employee Name" := UserSetup."Full Name";
                    "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                    "Terms of Employement" := UserSetup."Emplymt. Contract Code";
                    "Contract End Date" := UserSetup."Contract Expiry Date";
                    "USER ID" := UserId;
                    HOD := UserSetup.HOD;
                    Supervisor := UserSetup.Supervisor;
                end;
            end;
        }
        field(3; Type; Option)
        {
            OptionMembers = Annuity,Serial,Advance;

            trigger OnValidate()
            begin
                if Type = Type::Advance then "Interest Rate" := 0;
            end;
        }
        field(4; "Loan Types"; Code[20])
        {
            Editable = false;
            NotBlank = true;
            TableRelation = IF (Type = CONST(Advance)) "Loan Types" WHERE(Type = CONST(Advance))
            ELSE IF (Type = FILTER(Annuity | Serial)) "Loan Types" WHERE(Type = FILTER(Annuity | Serial));

            trigger OnValidate()
            begin
                /*LoanTypeRec.GET("Loan Types","Payroll Code");
                Type := LoanTypeRec.Type;
                "Calculate Interest Benefit" := LoanTypeRec."Calculate Interest Benefit";
                Description := LoanTypeRec.Description;
                */

            end;
        }
        field(5; "Interest Rate"; Decimal)
        {
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                if Type = Type::Advance then "Interest Rate" := 0;
                Validate(Installments);
            end;
        }
        field(6; Principal; Decimal)
        {

            trigger OnValidate()
            begin
                gsGetCurrency;
                if "Currency Code" = '' then
                    "Principal (LCY)" := Principal
                else
                    "Principal (LCY)" := Round(gvCurrExchRate.ExchangeAmtFCYToLCY(WorkDate, "Currency Code", Principal, "Currency Factor"));

                Principal := Round(Principal, gvCurrency."Amount Rounding Precision");
                Validate(Installments);
            end;
        }
        field(7; "Remaining Debt"; Decimal)
        {
            // CalcFormula = Sum("Loan Entry".Repayment WHERE("Loan ID" = FIELD(ID),
            //                                                 "Transfered To Payroll" = CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Number of Installments"; Integer)
        {
            // CalcFormula = Count("Loan Entry" WHERE("Loan ID" = FIELD(ID)));
            Editable = false;
            FieldClass = FlowField;
            MinValue = 0;

            trigger OnValidate()
            begin
                //Get Basic Pay
                Lines.Reset;
                Lines.SetRange("Employee No.", Employee);
                Lines.SetRange("Payroll ID", "Start Period");
                Lines.SetRange("Payroll Code", "Payroll Code");
                Lines.SetRange(Lines."ED Code", PayrollSetupRec."Basic Pay E/D Code");
                //Lines.SETRANGE(Lines."ED Code",'BASIC');
                if Lines.Find('-') then begin
                    BasicAmount := Lines.Amount;
                    "Basic Pay" := BasicAmount;
                    "1/3 Basic Pay" := Round(BasicAmount * 1 / 3, 1, '>');
                end;

                //Get Gross Pay
                Lines2.Reset;
                Lines2.SetRange(Lines2."Employee No.", Employee);
                Lines2.SetRange(Lines2."Payroll ID", "Start Period");
                Lines2.SetRange(Lines2."Calculation Group", Lines2."Calculation Group"::Payments);
                if Lines2.Find('-') then begin
                    repeat
                        TotalGrossPay += Lines2.Amount;
                    until Lines2.Next = 0;
                end;

                //Get Total Deduction
                PayrollLines.Reset;
                PayrollLines.SetRange(PayrollLines."Employee No.", Employee);
                PayrollLines.SetRange(PayrollLines."Payroll ID", "Start Period");
                PayrollLines.SetRange(PayrollLines."Calculation Group", PayrollLines."Calculation Group"::Deduction);
                if PayrollLines.Find('-') then begin
                    repeat
                        TotalDeduction += PayrollLines.Amount;
                    until PayrollLines.Next = 0;
                end;
                //Get Netpay
                TotalNetPay := TotalGrossPay - TotalDeduction;
                "Net Pay" := Round(TotalNetPay, 1, '>');
                "Net Pay after Advance" := Round(("Net Pay" - "Installment Amount"), 1, '>');
            end;
        }
        field(9; Repaid; Decimal)
        {
            // CalcFormula = Sum("Loan Entry".Repayment WHERE("Loan ID" = FIELD(ID),
            //                                                 "Transfered To Payroll" = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Start Period"; Code[10])
        {
            TableRelation = Periods."Period ID" WHERE(Status = CONST(Open));

            trigger OnValidate()
            var
                PeriodRec: Record Periods;
                PayrollHeaderrec: Record "Payroll Header";
            begin
                //updated on 2/2/2023 to ensure that if you have a pending salarya dvance one is not able to apply again
                /*LoansAdvanceRec.RESET;
                LoansAdvanceRec.SETRANGE(Employee,Employee);
                LoansAdvanceRec.SETRANGE(Type,LoansAdvanceRec.Type::Advance);
                IF LoansAdvanceRec.FINDSET THEN
                BEGIN
                  //REPEAT
                    LoansAdvanceRec.CALCFIELDS("Remaining Debt");
                    IF LoansAdvanceRec."Remaining Debt" > 0 THEN
                    ERROR('There is an advance number %1 with remaining balance %2 ',LoansAdvanceRec."Salary Advance Request No",LoansAdvanceRec."Remaining Debt");
                  //UNTIL  LoansAdvanceRec.NEXT=0;
                END;
                // end
                */
                PeriodRec.SetRange("Period ID", "Start Period");
                //PeriodRec.SETRANGE("Payroll Code", "Payroll Code");
                PeriodRec.Find('-');
                "Period Month" := PeriodRec."Period Month";
                "Period Year" := PeriodRec."Period Year";
                if PayrollHeaderrec.Get("Start Period", Employee) then begin
                    if PayrollHeaderrec.Calculated = true then begin
                        PayrollHeaderrec.Calculated := false;
                        PayrollHeaderrec.Modify;
                    end;
                end;

                //Get Basic Pay
                Lines.Reset;
                Lines.SetRange("Employee No.", Employee);
                Lines.SetRange("Payroll ID", "Start Period");
                //Lines.SETRANGE("Payroll Code","Payroll Code");
                //Lines.SETRANGE(Lines."ED Code",PayrollSetupRec."Basic Pay E/D Code");
                Lines.SetRange(Lines."ED Code", 'BASIC');
                if Lines.Find('-') then begin
                    BasicAmount := Lines.Amount;
                    "Basic Pay" := BasicAmount;
                    "1/3 Basic Pay" := Round(BasicAmount * 1 / 3, 1, '>');
                end;

                //Get Gross Pay
                Lines2.Reset;
                Lines2.SetRange(Lines2."Employee No.", Employee);
                Lines2.SetRange(Lines2."Payroll ID", "Start Period");
                Lines2.SetRange(Lines2."Calculation Group", Lines2."Calculation Group"::Payments);
                if Lines2.Find('-') then begin
                    repeat
                        TotalGrossPay += Lines2.Amount;
                        "Gross Amount" := TotalGrossPay;
                    until Lines2.Next = 0;
                end;

                //Get Total Deduction
                PayrollLines.Reset;
                PayrollLines.SetRange(PayrollLines."Employee No.", Employee);
                PayrollLines.SetRange(PayrollLines."Payroll ID", "Start Period");
                PayrollLines.SetRange(PayrollLines."Calculation Group", PayrollLines."Calculation Group"::Deduction);
                if PayrollLines.Find('-') then begin
                    repeat
                        TotalDeduction += PayrollLines.Amount;
                        "Total Deductions" := TotalDeduction;
                    until PayrollLines.Next = 0;
                end;
                //Get Netpay
                TotalNetPay := TotalGrossPay - TotalDeduction;
                "Net Pay" := Round(TotalNetPay, 1, '>');
                "Net Pay after Advance" := Round(("Net Pay" - "Installment Amount"), 1, '>');

            end;
        }
        field(11; "Payment Date"; Date)
        {
        }
        field(12; Description; Text[50])
        {
        }
        field(13; "First Name"; Text[30])
        {
            CalcFormula = Lookup(Employee."First Name" WHERE("No." = FIELD(Employee)));
            FieldClass = FlowField;
        }
        field(14; "Last Name"; Text[30])
        {
            CalcFormula = Lookup(Employee."Last Name" WHERE("No." = FIELD(Employee)));
            FieldClass = FlowField;
        }
        field(15; "Type Text"; Text[50])
        {
            CalcFormula = Lookup("Loan Types".Description WHERE(Code = FIELD("Loan Types")));
            FieldClass = FlowField;
        }
        field(16; Created; Boolean)
        {
            InitValue = false;
        }
        field(17; "Period Month"; Integer)
        {
        }
        field(18; "Period Year"; Integer)
        {
        }
        field(19; Changed; Boolean)
        {
            InitValue = false;
        }
        field(20; "Total Interest"; Decimal)
        {
            //CalcFormula = Sum("Loan Entry".Interest WHERE("Loan ID" = FIELD(ID)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "Interest Paid"; Decimal)
        {
            // CalcFormula = Sum("Loan Entry".Interest WHERE("Loan ID" = FIELD(ID),
            //                                                "Transfered To Payroll" = CONST(true)));
            // CalcFormula = Sum("Loan Entry".Interest WHERE("Loan ID" = FIELD(ID),
            //                                                "Transfered To Payroll" = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; Installments; Integer)
        {

            trigger OnValidate()
            begin
                if Installments = 0 then exit;
                if Type = Type::Annuity then begin
                    if "Interest Rate" <= 0 then
                        "Installment Amount" := Round(Principal / Installments, 1, '>')
                    else
                        "Installment Amount" := Round(DebtService(Principal, "Interest Rate", Installments), 1, '>');
                end else if Type = Type::Serial then
                        "Installment Amount" := Round(Principal / Installments, 1, '>')
                else if Type = Type::Advance then
                    "Installment Amount" := Round(Principal / Installments, 1, '>');

                //ELSE
                // Installments := 1;

                gsGetCurrency;
                if "Currency Code" = '' then
                    "Installment Amount (LCY)" := "Installment Amount"
                else
                    "Installment Amount (LCY)" :=
                    Round(gvCurrExchRate.ExchangeAmtFCYToLCY(WorkDate, "Currency Code", "Installment Amount", "Currency Factor"));

                "Installment Amount" := Round("Installment Amount", gvCurrency."Amount Rounding Precision");

                //Get Basic Pay
                Lines.Reset;
                Lines.SetRange("Employee No.", Employee);
                Lines.SetRange("Payroll ID", "Start Period");
                Lines.SetRange("Payroll Code", "Payroll Code");
                //Lines.SETRANGE(Lines."ED Code",PayrollSetupRec."Basic Pay E/D Code");
                Lines.SetRange(Lines."ED Code", 'BASIC');
                if Lines.Find('-') then begin
                    BasicAmount := Lines.Amount;
                    "Basic Pay" := BasicAmount;
                    "1/3 Basic Pay" := Round(BasicAmount * 1 / 3, 1, '>');
                end;

                //Get Gross Pay
                Lines2.Reset;
                Lines2.SetRange(Lines2."Employee No.", Employee);
                Lines2.SetRange(Lines2."Payroll ID", "Start Period");
                Lines2.SetRange(Lines2."Calculation Group", Lines2."Calculation Group"::Payments);
                if Lines2.Find('-') then begin
                    repeat
                        TotalGrossPay += Lines2.Amount;
                    until Lines2.Next = 0;
                end;

                //Get Total Deduction
                PayrollLines.Reset;
                PayrollLines.SetRange(PayrollLines."Employee No.", Employee);
                PayrollLines.SetRange(PayrollLines."Payroll ID", "Start Period");
                PayrollLines.SetRange(PayrollLines."Calculation Group", PayrollLines."Calculation Group"::Deduction);
                if PayrollLines.Find('-') then begin
                    repeat
                        TotalDeduction += PayrollLines.Amount;
                    until PayrollLines.Next = 0;
                end;
                //Get Netpay
                TotalNetPay := TotalGrossPay - TotalDeduction;
                "Net Pay" := Round(TotalNetPay, 1, '>');
                "Net Pay after Advance" := Round(("Net Pay" - "Installment Amount"), 1, '>');
            end;
        }
        field(23; "Installment Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if Type = Type::Annuity then Error('For an annuity enter the number of installments only');
                //IF Type = Type::Advance THEN ERROR('Not valid');
                Installments := Round((Principal / "Installment Amount"), 1, '>');

                gsGetCurrency;
                if "Currency Code" = '' then
                    "Installment Amount (LCY)" := "Installment Amount"
                else
                    "Installment Amount (LCY)" := Round(
                      gvCurrExchRate.ExchangeAmtFCYToLCY(WorkDate, "Currency Code", "Installment Amount", "Currency Factor"));

                "Installment Amount" := Round("Installment Amount", gvCurrency."Amount Rounding Precision");

                //Get Basic Pay
                Lines.Reset;
                Lines.SetRange("Employee No.", Employee);
                Lines.SetRange("Payroll ID", "Start Period");
                Lines.SetRange("Payroll Code", "Payroll Code");
                //Lines.SETRANGE(Lines."ED Code",PayrollSetupRec."Basic Pay E/D Code");
                Lines.SetRange(Lines."ED Code", 'BASIC');
                if Lines.Find('-') then begin
                    BasicAmount := Lines.Amount;
                    "Basic Pay" := BasicAmount;
                    "1/3 Basic Pay" := Round(BasicAmount * 1 / 3, 1, '>');
                end;

                //Get Gross Pay
                Lines2.Reset;
                Lines2.SetRange(Lines2."Employee No.", Employee);
                Lines2.SetRange(Lines2."Payroll ID", "Start Period");
                Lines2.SetRange(Lines2."Calculation Group", Lines2."Calculation Group"::Payments);
                if Lines2.Find('-') then begin
                    repeat
                        TotalGrossPay += Lines2.Amount;
                    until Lines2.Next = 0;
                end;

                //Get Total Deduction
                PayrollLines.Reset;
                PayrollLines.SetRange(PayrollLines."Employee No.", Employee);
                PayrollLines.SetRange(PayrollLines."Payroll ID", "Start Period");
                PayrollLines.SetRange(PayrollLines."Calculation Group", PayrollLines."Calculation Group"::Deduction);
                if PayrollLines.Find('-') then begin
                    repeat
                        TotalDeduction += PayrollLines.Amount;
                    until PayrollLines.Next = 0;
                end;
                //Get Netpay
                TotalNetPay := TotalGrossPay - TotalDeduction;
                "Net Pay" := Round(TotalNetPay, 1, '>');
                "Net Pay after Advance" := Round(("Net Pay" - "Installment Amount"), 1, '>');
            end;
        }
        field(24; "Paid to Employee"; Boolean)
        {
            InitValue = false;
        }
        field(26; "Payments Method"; Code[20])
        {
            TableRelation = "Loan Payments";
        }
        field(27; "Calculate Interest Benefit"; Boolean)
        {
            Editable = false;
        }
        field(28; "Last Suspension Date"; Date)
        {
        }
        field(29; "Last Suspension Duration"; Integer)
        {
            Description = 'In months';
        }
        field(30; Cleared; Boolean)
        {
            Editable = false;
        }
        field(31; "Payroll Code"; Code[10])
        {
            TableRelation = Payroll;

            trigger OnValidate()
            begin
                //ERROR('Manual Edits not allowed.');
            end;
        }
        field(32; Create; Boolean)
        {
            InitValue = true;

            trigger OnValidate()
            begin
                TestField(Created, false);
            end;
        }
        field(33; Pay; Boolean)
        {
            InitValue = true;

            trigger OnValidate()
            begin
                TestField("Paid to Employee", false);
            end;
        }
        field(34; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()
            begin
                if "Currency Code" <> '' then begin
                    gsGetCurrency;
                    if ("Currency Code" <> xRec."Currency Code") or (CurrFieldNo = FieldNo("Currency Code")) or ("Currency Factor" = 0) then
                        "Currency Factor" := gvCurrExchRate.ExchangeRate(WorkDate, "Currency Code");
                end else
                    "Currency Factor" := 0;
                Validate("Currency Factor");
                Validate(Installments);
            end;
        }
        field(35; "Principal (LCY)"; Decimal)
        {
            AutoFormatType = 1;

            trigger OnValidate()
            begin
                if "Currency Code" = '' then begin
                    Principal := "Principal (LCY)";
                    Validate(Principal);
                end else begin
                    TestField("Principal (LCY)");
                    TestField(Principal);
                    "Currency Factor" := Principal / "Principal (LCY)";
                end;
            end;
        }
        field(36; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                if ("Currency Code" = '') and ("Currency Factor" <> 0) then
                    FieldError("Currency Factor", StrSubstNo(Text002, FieldCaption("Currency Code")));
                Validate(Principal);
            end;
        }
        field(37; "Remaining Debt (LCY)"; Decimal)
        {
            // CalcFormula = Sum("Loan Entry"."Repayment (LCY)" WHERE("Loan ID" = FIELD(ID),
            //                                                         "Transfered To Payroll" = CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(38; "Repaid (LCY)"; Decimal)
        {
            // CalcFormula = Sum("Loan Entry"."Repayment (LCY)" WHERE("Loan ID" = FIELD(ID),
            //                                                         "Transfered To Payroll" = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(39; "Total Interest (LCY)"; Decimal)
        {
            // CalcFormula = Sum("Loan Entry"."Interest (LCY)" WHERE("Loan ID" = FIELD(ID)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "Interest Paid (LCY)"; Decimal)
        {
            // CalcFormula = Sum("Loan Entry"."Interest (LCY)" WHERE("Loan ID" = FIELD(ID),
            //                                                        "Transfered To Payroll" = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(41; "Installment Amount (LCY)"; Decimal)
        {

            trigger OnValidate()
            begin
                if Type = Type::Annuity then Error('For an annuity enter the number of installments only');
                if Type = Type::Advance then Error('Not valid');
                "Installment Amount (LCY)" := Round(("Principal (LCY)" / "Installment Amount (LCY)"), 1, '>');

                if "Currency Code" = '' then begin
                    "Installment Amount" := "Installment Amount (LCY)";
                    Validate("Installment Amount");
                end;

                //Get Basic Pay
                /*Lines.RESET;
                Lines.SETRANGE("Employee No.",Employee);
                Lines.SETRANGE("Payroll ID","Start Period");
                Lines.SETRANGE(Lines."ED Code",PayrollSetupRec."Basic Pay E/D Code");
                //Lines.SETRANGE(Lines."ED Code",'BASIC');
                IF Lines.FIND('-') THEN BEGIN
                BasicAmount:=Lines.Amount;
                "Basic Pay":=BasicAmount;
                "1/3 Basic Pay" := ROUND(BasicAmount*1/3,1,'>');
                END;
                
                //Get Gross Pay
                Lines2.RESET;
                Lines2.SETRANGE(Lines2."Employee No.", Employee);
                Lines2.SETRANGE(Lines2."Payroll ID","Start Period");
                Lines2.SETRANGE(Lines2."Calculation Group",Lines2."Calculation Group"::Payments);
                IF Lines2.FIND('-') THEN BEGIN
                  REPEAT
                TotalGrossPay += Lines2.Amount;
                  UNTIL Lines2.NEXT = 0;
                END;
                
                //Get Total Deduction
                PayrollLines.RESET;
                PayrollLines.SETRANGE(PayrollLines."Employee No.", Employee);
                PayrollLines.SETRANGE(PayrollLines."Payroll ID","Start Period");
                PayrollLines.SETRANGE(PayrollLines."Calculation Group",PayrollLines."Calculation Group"::Deduction);
                IF PayrollLines.FIND('-') THEN BEGIN
                  REPEAT
                TotalDeduction += PayrollLines.Amount;
                  UNTIL PayrollLines.NEXT=0;
                END;
                //Get Netpay
                TotalNetPay := TotalGrossPay-TotalDeduction;
                "Net Pay" := ROUND(TotalNetPay,1,'>');
                "Net Pay after Advance" := ROUND(("Net Pay"-"Installment Amount"),1,'>');*/

            end;
        }
        field(42; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(43; "Loan ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "No Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(45; "Purpose of Salary Advance"; Text[250])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Get Basic Pay
                Lines.Reset;
                Lines.SetRange("Employee No.", Employee);
                Lines.SetRange("Payroll ID", "Start Period");
                Lines.SetRange("Payroll Code", "Payroll Code");
                //Lines.SETRANGE(Lines."ED Code",PayrollSetupRec."Basic Pay E/D Code");
                Lines.SetRange(Lines."ED Code", 'BASIC');
                if Lines.Find('-') then begin
                    BasicAmount := Lines.Amount;
                    "Basic Pay" := BasicAmount;
                    "1/3 Basic Pay" := Round(BasicAmount * 1 / 3, 1, '>');
                end;

                //Get Gross Pay
                Lines2.Reset;
                Lines2.SetRange(Lines2."Employee No.", Employee);
                Lines2.SetRange(Lines2."Payroll ID", "Start Period");
                Lines2.SetRange(Lines2."Calculation Group", Lines2."Calculation Group"::Payments);
                if Lines2.Find('-') then begin
                    repeat
                        TotalGrossPay += Lines2.Amount;
                    until Lines2.Next = 0;
                end;

                //Get Total Deduction
                PayrollLines.Reset;
                PayrollLines.SetRange(PayrollLines."Employee No.", Employee);
                PayrollLines.SetRange(PayrollLines."Payroll ID", "Start Period");
                PayrollLines.SetRange(PayrollLines."Calculation Group", PayrollLines."Calculation Group"::Deduction);
                if PayrollLines.Find('-') then begin
                    repeat
                        TotalDeduction += PayrollLines.Amount;
                    until PayrollLines.Next = 0;
                end;
                //Get Netpay
                TotalNetPay := TotalGrossPay - TotalDeduction;
                "Net Pay" := Round(TotalNetPay, 1, '>');
                "Net Pay after Advance" := Round(("Net Pay" - "Installment Amount"), 1, '>');
            end;
        }
        field(46; "Advance Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Salary in Advance,Salary Advance';
            OptionMembers = " ","Salary in Advance","Salary Advance";

            trigger OnValidate()
            begin
                /*IF "Advance Type" = "Advance Type"::"Phone Advance" THEN
                BEGIN
                 Installments := 6;
                END;
                IF "Advance Type" = "Advance Type"::"Laptop Advance" THEN
                BEGIN
                 Installments := 12;
                END;
                IF "Advance Type" = "Advance Type"::"Salary Advance" THEN
                BEGIN
                 Installments := 3;
                END;
                */

                LoanTypes.Reset;
                LoanTypes.SetRange("Advance Type", "Advance Type");
                if LoanTypes.FindSet then begin
                    "Loan Types" := LoanTypes.Code;
                end;

            end;
        }
        field(47; "File Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Basic Pay"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "1/3 Basic Pay" := "Basic Pay" * 1 / 3;
            end;
        }
        field(50; "1/3 Basic Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Net Pay"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Net Pay after Advance" := "Net Pay" - "Installment Amount";
            end;
        }
        field(52; "Net Pay after Advance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Terms of Employement"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employment Contract";
        }
        field(54; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(55; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(56; "Contract End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Gross Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Total Deductions"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(59; "USER ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            begin
                UserSetup.Reset;
                UserSetup.SetRange(UserSetup."User ID", "USER ID");
                if UserSetup.FindFirst then begin
                    "Employee Name" := UserSetup."Full Name";
                    //UserSetup.TESTFIELD(UserSetup."Global Dimension 1 Code");
                    //UserSetup.TESTFIELD(UserSetup."Global Dimension 2 Code");
                    "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                    //"Shortcut Dimension 3 Code":=UserSetup."Shortcut Dimension 3 Code";
                    // "Shortcut Dimension 4 Code":=UserSetup."Shortcut Dimension 4 Code";
                    // "Shortcut Dimension 5 Code":=UserSetup."Shortcut Dimension 5 Code";
                    // "Shortcut Dimension 6 Code":=UserSetup."Shortcut Dimension 6 Code";
                    //  "Shortcut Dimension 7 Code":=UserSetup."Shortcut Dimension 7 Code";
                    //  "Shortcut Dimension 8 Code":=UserSetup."Shortcut Dimension 8 Code";
                    Employee := UserSetup."No.";
                    Validate(Employee);
                end;
            end;
        }
        field(60; HOD; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(61; Supervisor; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(102; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';
            DataClassification = ToBeClassified;
        }
        field(106; "Document Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(500008; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt,Funds Transfer,Imprest,Imprest Surrender,Allowance,Store Req,Purchase Req,Salary Advance';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Surrender",Allowance,"Store Req","Purchase Req","Salary Advance";
        }
        field(500009; "Employee Name"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
    }

    keys
    {
        key(Key1; ID)
        {
        }
        key(Key2; "Loan ID")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; ID, Employee, Description, Principal)
        {
        }
    }

    trigger OnInsert()
    var
        LoanRec: Record "Loans/Advances";
    begin

        if "Payroll Code" = '' then "Payroll Code" := gvPayrollUtilities.gsAssignPayrollCode; //SNG 130611 payroll data segregation
        "Loan ID" := Format(ID);

        if ID = '' then begin
            HumanResourcesSetup.Get;
            HumanResourcesSetup.TestField(HumanResourcesSetup."Salary Advance Nos");
            NoSeriesManagement.InitSeries(HumanResourcesSetup."Salary Advance Nos", xRec."No Series", 0D, ID, "No Series");
        end;

        "Document Date" := Today;
        "USER ID" := UserId;
        ///Update user details
        if UserSetup.Get("USER ID") then begin
            Employee := UserSetup."No.";
            "First Name" := UserSetup."First Name";//+' '+Employee."Middle Name"+' '+Employee."Last Name";
            "Last Name" := UserSetup."Last Name";
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Terms of Employement" := UserSetup."Emplymt. Contract Code";
            "Contract End Date" := UserSetup."Contract Expiry Date";
        end;
        Validate("USER ID");
        "Loan Types" := 'SALARY ADVANCE';
    end;

    trigger OnModify()
    begin
        if not "Paid to Employee" then Created := false;
    end;

    var
        LoanTypeRec: Record "Loan Types";
        GlobalLoanEntryRec: Record "Loan Entry";
        gvPayrollUtilities: Codeunit "Payroll Posting";
        gvCurrencyCode: Code[10];
        gvCurrency: Record Currency;
        gvCurrExchRate: Record "Currency Exchange Rate";
        Text002: Label 'cannot be specified without %1';
        TableCodeTransfer: Codeunit "Table Code Transferred-Payroll";
        HumanResourcesSetup: Record "Human Resources Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        EmployeeRec: Record Employee;
        UserSetup: Record Employee;
        LoanTypes: Record "Loan Types";
        PayrollSetupRec: Record "Payroll Setups";
        Period: Record Periods;
        Lines: Record "Payroll Lines";
        Periods: Record Periods;
        Name: Text[92];
        TitleText: Text[60];
        PeriodCode: Code[10];
        BasicAmount: Decimal;
        TotalNetPay: Decimal;
        SkipZeroAmountEDs: Boolean;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        TotalGrossPay: Decimal;
        TotalDeduction: Decimal;
        Lines2: Record "Payroll Lines";
        PayrollLines: Record "Payroll Lines";
        LoansAdvances: Record "Loans/Advances";
        SalaryAdvanceRc: Record "Salary Advance";
        LoansAdvanceRec: Record "Loans/Advances";

    procedure CreateLoan()
    var
        PeriodRec: Record Periods;
    begin

        //TableCodeTransfer.LoanAdvancesCreateLoan(Rec);
    end;

    procedure CreateAdvance()
    var
        LoanEntryRec: Record "Loan Entry";
    begin
        //TableCodeTransfer.LoanAdvancesCreateAdvance(Rec);
    end;

    procedure CreateSerialLoan()
    var
        LoanEntryRec: Record "Loan Entry";
        Periodrec: Record Periods;
        LoanTypeRec: Record "Loan Types";
        LoopEndBool: Boolean;
        LineNoInt: Integer;
        PeriodCode: Code[10];
        InterestAmountDec: Decimal;
        RemainingPrincipalAmountDec: Decimal;
        RepaymentAmountDec: Decimal;
        RoundPrecisionDec: Decimal;
        RoundDirectionCode: Code[10];
    begin
        //TableCodeTransfer.LoanAdvancesCreateSerialLoan(Rec);
    end;

    procedure CreateAnnuityLoan()
    var
        LoanEntryRec: Record "Loan Entry";
        Periodrec: Record Periods;
        LoanTypeRec: Record "Loan Types";
        LoopEndBool: Boolean;
        LineNoInt: Integer;
        PeriodCode: Code[10];
        InterestAmountDec: Decimal;
        RemainingPrincipalAmountDec: Decimal;
        RepaymentAmountDec: Decimal;
        RoundPrecisionDec: Decimal;
        RoundDirectionCode: Code[10];
    begin
        //TableCodeTransfer.LoanAdvancesCreateAnnuityLoan(Rec);
    end;

    procedure PayLoan()
    var
        GenJnlLine: Record "Gen. Journal Line";
        Loansetup: Record "Payroll Setups";
        LoanTypeRec: Record "Loan Types";
        LoanPaymentRec: Record "Loan Payments";
        EmployeeRec: Record Employee;
        PeriodRec: Record Periods;
        HeaderRec: Record "Payroll Header";
        TemplateName: Code[10];
        BatchName: Code[10];
        LineNo: Integer;
    begin
        //TableCodeTransfer.LoanAdvancesPayLoan(Rec);
    end;

    procedure DebtService(Principal: Decimal; Interest: Decimal; PayPeriods: Integer): Decimal
    var
        PeriodInterest: Decimal;
    begin
        //EXIT(TableCodeTransfer.LoanAdvancesDebtService(Principal,Interest,PayPeriods));
    end;

    procedure CreateLoanfromSchedule()
    var
        PeriodRec: Record Periods;
        lvLoansSchedule: Record "Recurring Loans Schedule";
        lvEmp: Record Employee;
    begin
        //TableCodeTransfer.LoanAdvancesCreateLoanfromSchedule(Rec);
    end;

    local procedure gsGetCurrency()
    begin
        gvCurrencyCode := "Currency Code";

        if gvCurrencyCode = '' then begin
            Clear(gvCurrency);
            gvCurrency.InitRoundingPrecision
        end else if gvCurrencyCode <> gvCurrency.Code then begin
            gvCurrency.Get(gvCurrencyCode);
            gvCurrency.TestField("Amount Rounding Precision");
        end;
    end;
}

