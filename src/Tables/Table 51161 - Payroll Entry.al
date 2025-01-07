table 51161 "Payroll Entry"
{
    Permissions = TableData "Payroll Header"=rimd,
                  TableData "Payroll Lines"=rimd;

    fields
    {
        field(1;"Entry No.";Integer)
        {
        }
        field(2;"Payroll ID";Code[10])
        {
            TableRelation = Periods."Period ID";
        }
        field(3;"Employee No.";Code[20])
        {
            TableRelation = Employee;
        }
        field(4;"ED Code";Code[20])
        {
            NotBlank = true;
            TableRelation = "ED Definitions";

            trigger OnLookup()
            var
                EDCodeRec: Record "ED Definitions";
                Employee: Record Employee;
                CalcSchemes: Record "Calculation Scheme";
                lvPayrollHdr: Record "Payroll Header";
                lvRoundDirection: Text[1];
            begin


                EDCodeRec.SetRange("System Created",false);
                  if ACTION::LookupOK = PAGE.RunModal(PAGE::"ED Definitions List",EDCodeRec) then begin

                    if Employee.Get("Employee No.") then begin
                      CalcSchemes.SetRange("Scheme ID",Employee."Calculation Scheme");
                      CalcSchemes.SetCurrentKey("Payroll Entry");
                      CalcSchemes.SetRange("Payroll Entry",EDCodeRec."ED Code");

                      if not CalcSchemes.Find('-') then
                        Error('The ED Code does not exits in the Calculation Scheme')
                      else begin
                        "Calculation Group":=EDCodeRec."Calculation Group";
                        "ED Code" := EDCodeRec."ED Code";
                        Text := EDCodeRec.Description;
                        "Copy to next" := EDCodeRec."Copy to next";
                        "Reset Amount" := EDCodeRec."Reset Amount";
                      end;
                    end;
                  end;

                //Direct Overtime Entry
                if EDCodeRec.Get("ED Code") then
                    if EDCodeRec."Overtime ED" then begin
                       PayrollSetupRec.Get("Payroll Code");
                       case PayrollSetupRec."Hourly Rate Rounding" of
                         PayrollSetupRec."Hourly Rate Rounding"::None: lvRoundDirection := '=';
                         PayrollSetupRec."Hourly Rate Rounding"::Up: lvRoundDirection := '>';
                         PayrollSetupRec."Hourly Rate Rounding"::Down: lvRoundDirection := '<';
                         PayrollSetupRec."Hourly Rate Rounding"::Nearest: lvRoundDirection := '=';
                       end;

                       lvPayrollHdr.Get("Payroll ID", "Employee No.");
                       lvPayrollHdr.TestField("Hour Rate");
                       LineRate :=Round(EDCodeRec."Overtime ED Weight" *  lvPayrollHdr."Hour Rate",
                         PayrollSetupRec."Hourly Rounding Precision", lvRoundDirection);
                       Validate(Rate, LineRate);
                       //MODIFY;
                     end;
                   //Direct Overtime Entry
                //pension
                Validate("ED Code");
            end;

            trigger OnValidate()
            var
                EDCodeRec: Record "ED Definitions";
                Employee: Record Employee;
                CalcSchemes: Record "Calculation Scheme";
                lvPayrollHdr: Record "Payroll Header";
                lvRoundDirection: Text[1];
            begin
                TableCodeTransfer.PayrollEntryEDCodeValidate(Rec,xRec);
                /*TableCodeTransfer.PayrollEntryEDCodeValidate(Rec,xRec);
                //Frs
                //Pension
                //PayrollSetupRec.GET("Payroll Code");
                PayrollSetupRec.GET('PERMANENT');
                IF EDCodeRec.GET("ED Code") THEN
                  BEGIN
                 // IF EDCodeRec."Pension ED" THEN
                      IF(EDCodeRec."Pension ED") AND NOT (EDCodeRec."Gratuity ED") AND NOT (EDCodeRec."OT1 ED") AND NOT (EDCodeRec."OT2 ED") THEN
                      BEGIN
                        EDCodeRec.TESTFIELD("Employee Rate");
                        EDCodeRec.TESTFIELD("Employer Rate");
                        //Get House allowance
                      EmployeeRec1.GET("Employee No.");
                         EmployeeRec1.SETFILTER("Period Filter","Payroll ID");
                      EmployeeRec1.SETRANGE("ED Code Filter",PayrollSetupRec."House Allowances ED");
                      EmployeeRec1.CALCFIELDS("Amount (LCY)");
                      HouseAllowanceAmt:=EmployeeRec1."Amount (LCY)";
                
                     //Get Basic Pay
                      EmployeeRec.GET("Employee No.");
                      EmployeeRec.SETFILTER("Period Filter", "Payroll ID");
                      EmployeeRec.SETRANGE("ED Code Filter",PayrollSetupRec."Basic Pay E/D Code");
                      EmployeeRec.CALCFIELDS("Amount (LCY)");
                      BasicPayAmt:=EmployeeRec."Amount (LCY)";
                
                
                     // MESSAGE(FORMAT(BasicPayAmt));
                      GrossAmt:=BasicPayAmt+HouseAllowanceAmt;
                      PensionAmt:=(GrossAmt*EDCodeRec."Employee Rate"/100);//-200;
                      Amount:=ROUND(PensionAmt,1,'<');
                      Amount:=PensionAmt;
                      VALIDATE(Amount);
                
                     {GratitudeAmt := BasicPayAmt*31/100;
                     Amount := GratitudeAmt;
                     VALIDATE(Amount);}
                
                END ELSE
                  IF (EDCodeRec."OT1 ED") AND (EDCodeRec."Pension ED") THEN
                     BEGIN
                    //Get Basic Pay
                      EmployeeRec.GET("Employee No.");
                      EmployeeRec.SETFILTER("Period Filter", "Payroll ID");
                      EmployeeRec.SETRANGE("ED Code Filter",PayrollSetupRec."Basic Pay E/D Code");
                      EmployeeRec.CALCFIELDS("Amount (LCY)");
                      BasicPayAmt:=EmployeeRec."Amount (LCY)";
                     //OT1
                     DailyRate := ((BasicPayAmt/22)/8)*1.5260351402;
                     Rate := DailyRate;
                     VALIDATE(Rate);
                
                   END ELSE
                        IF (EDCodeRec."OT2 ED") AND (EDCodeRec."Pension ED") THEN
                        BEGIN
                      //Get Basic Pay
                      EmployeeRec.GET("Employee No.");
                      EmployeeRec.SETFILTER("Period Filter", "Payroll ID");
                      EmployeeRec.SETRANGE("ED Code Filter",PayrollSetupRec."Basic Pay E/D Code");
                      EmployeeRec.CALCFIELDS("Amount (LCY)");
                      BasicPayAmt:=EmployeeRec."Amount (LCY)";
                      // OT2
                     DailyRate := ((BasicPayAmt/22)/8)*2.0346915888;
                     Rate := DailyRate;
                     VALIDATE(Rate);
                    END ELSE
                       IF (EDCodeRec."Gratuity ED")AND(EDCodeRec."Pension ED") THEN
                       BEGIN
                      //Get Basic Pay
                      EmployeeRec.GET("Employee No.");
                      EmployeeRec.SETFILTER("Period Filter", "Payroll ID");
                      EmployeeRec.SETRANGE("ED Code Filter",PayrollSetupRec."Basic Pay E/D Code");
                      EmployeeRec.CALCFIELDS("Amount (LCY)");
                      BasicPayAmt:=EmployeeRec."Amount (LCY)";
                     GratitudeAmt := BasicPayAmt*31/100;
                     Amount := GratitudeAmt;
                     VALIDATE(Amount);
                    END;
                END;
                */

            end;
        }
        field(5;Quantity;Decimal)
        {

            trigger OnValidate()
            begin
                CalcAmount();
            end;
        }
        field(6;Rate;Decimal)
        {

            trigger OnValidate()
            begin
                gsGetCurrency;
                if "Currency Code" = '' then
                  "Rate (LCY)" := Rate
                else
                  "Rate (LCY)" := Round(gvCurrExchRate.ExchangeAmtFCYToLCY(WorkDate, "Currency Code", Rate, "Currency Factor"));

                Rate := Round(Rate, gvCurrency."Amount Rounding Precision");
                CalcAmount();
            end;
        }
        field(7;Amount;Decimal)
        {

            trigger OnValidate()
            var
                lvAllowedPayrolls: Record "Allowed Payrolls";
                lvPayrollSetupRec: Record "Payroll Setups";
            begin
                lvAllowedPayrolls.SetRange("User ID", UserId);
                lvAllowedPayrolls.SetRange("Last Active Payroll", true);
                if lvAllowedPayrolls.FindFirst then
                  lvPayrollSetupRec.Get(lvAllowedPayrolls."Payroll Code")
                else
                  Error('You are not allowed access to any payroll');

                if Editable = false then
                  if "ED Code" = lvPayrollSetupRec."Mid Month ED Code" then
                    Error('Mid Month has been closed and cannot be modified');

                gsGetCurrency;
                if "Currency Code" = '' then
                  "Amount (LCY)" := Amount
                else begin
                  TestField(Date);
                  "Amount (LCY)" := Round(gvCurrExchRate.ExchangeAmtFCYToLCY(Date, "Currency Code", Amount, "Currency Factor"));
                end;
                Amount := Round(Amount, gvCurrency."Amount Rounding Precision");
                if "Rate (LCY)" <> 0 then
                  Quantity := Amount/"Rate (LCY)";
            end;
        }
        field(8;"Copy to next";Boolean)
        {
        }
        field(9;"Reset Amount";Boolean)
        {
        }
        field(10;Text;Text[50])
        {
            CalcFormula = Lookup("ED Definitions".Description WHERE ("ED Code"=FIELD("ED Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11;Date;Date)
        {
        }
        field(12;Editable;Boolean)
        {
            InitValue = true;
        }
        field(13;"Loan ID";BigInteger)
        {
            TableRelation = "Loans/Advances";
        }
        field(14;Interest;Decimal)
        {

            trigger OnValidate()
            begin
                gsGetCurrency;
                if "Currency Code" = '' then
                  "Interest (LCY)" := Interest
                else
                  "Interest (LCY)" := Round(gvCurrExchRate.ExchangeAmtFCYToLCY(WorkDate, "Currency Code", Interest, "Currency Factor"));

                Interest := Round(Interest, gvCurrency."Amount Rounding Precision");
            end;
        }
        field(15;Repayment;Decimal)
        {

            trigger OnValidate()
            begin
                gsGetCurrency;
                if "Currency Code" = '' then
                  "Repayment (LCY)" := Repayment
                else
                  "Repayment (LCY)" := Round(gvCurrExchRate.ExchangeAmtFCYToLCY(WorkDate, "Currency Code", Repayment,"Currency Factor"));

                Repayment := Round(Repayment, gvCurrency."Amount Rounding Precision");
            end;
        }
        field(16;"Remaining Debt";Decimal)
        {

            trigger OnValidate()
            begin
                gsGetCurrency;
                if "Currency Code" = '' then
                  "Remaining Debt (LCY)" := "Remaining Debt"
                else
                  "Remaining Debt (LCY)" := Round(gvCurrExchRate.ExchangeAmtFCYToLCY(WorkDate, "Currency Code", "Remaining Debt",
                    "Currency Factor"));

                "Remaining Debt" := Round("Remaining Debt", gvCurrency."Amount Rounding Precision");
            end;
        }
        field(17;Paid;Decimal)
        {

            trigger OnValidate()
            begin
                gsGetCurrency;
                if "Currency Code" = '' then
                  "Paid (LCY)" := Paid
                else
                  "Paid (LCY)" := Round(gvCurrExchRate.ExchangeAmtFCYToLCY(WorkDate, "Currency Code", Paid, "Currency Factor"));

                Paid := Round(Paid, gvCurrency."Amount Rounding Precision");
            end;
        }
        field(18;"Loan Text";Text[50])
        {
        }
        field(19;"Loan Entry";Boolean)
        {
            InitValue = false;
        }
        field(20;"Basic Pay Entry";Boolean)
        {
            InitValue = false;
        }
        field(21;"Time Entry";Boolean)
        {
            InitValue = false;
        }
        field(22;"Loan Entry No";Integer)
        {
        }
        field(23;"Payroll Code";Code[10])
        {
            TableRelation = Payroll;

            trigger OnValidate()
            begin
                //ERROR('Manual Edits not allowed.');
            end;
        }
        field(24;"ED Expiry Date";Date)
        {
        }
        field(25;"Currency Code";Code[10])
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
            end;
        }
        field(26;"Currency Factor";Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0:15;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                if ("Currency Code" = '') and ("Currency Factor" <> 0) then
                  FieldError("Currency Factor", StrSubstNo(Text002, FieldCaption("Currency Code")));
                if (Quantity <> 0) and (Rate <> 0) then
                  Validate(Rate)
                else
                  Validate(Amount);
            end;
        }
        field(27;"Rate (LCY)";Decimal)
        {

            trigger OnValidate()
            begin
                if "Currency Code" = '' then
                  Rate := "Rate (LCY)"
                else begin
                  TestField("Rate (LCY)");
                  TestField(Rate);
                  "Currency Factor" := Rate / "Rate (LCY)";
                end;
                CalcAmount;
            end;
        }
        field(28;"Amount (LCY)";Decimal)
        {

            trigger OnValidate()
            var
                lvAllowedPayrolls: Record "Allowed Payrolls";
                lvPayrollSetupRec: Record "Payroll Setups";
            begin
                lvAllowedPayrolls.SetRange("User ID", UserId);
                lvAllowedPayrolls.SetRange("Last Active Payroll", true);
                if lvAllowedPayrolls.FindFirst then
                  lvPayrollSetupRec.Get(lvAllowedPayrolls."Payroll Code")
                else
                  Error('You are not allowed access to any payroll');

                if Editable = false then
                  if "ED Code" = lvPayrollSetupRec."Mid Month ED Code" then
                    Error('Mid Month has been closed and cannot be modified');

                if "Currency Code" = '' then
                  Amount := "Amount (LCY)"
                else begin
                  TestField("Amount (LCY)");
                  TestField(Amount);
                  "Currency Factor" := Amount / "Amount (LCY)";
                end;
            end;
        }
        field(29;"Interest (LCY)";Decimal)
        {
        }
        field(30;"Repayment (LCY)";Decimal)
        {
        }
        field(31;"Remaining Debt (LCY)";Decimal)
        {
        }
        field(32;"Paid (LCY)";Decimal)
        {

            trigger OnValidate()
            begin
                gsGetCurrency;
                if "Currency Code" = '' then
                  "Paid (LCY)" := Paid
                else
                  "Paid (LCY)" := Round(gvCurrExchRate.ExchangeAmtFCYToLCY(WorkDate, "Currency Code", Paid, "Currency Factor"));

                Paid := Round(Paid, gvCurrency."Amount Rounding Precision");
            end;
        }
        field(50002;"Created From";Option)
        {
            OptionCaption = ' ,Leave Encash,Recovered Lost Day,Leave Allowance,Leave Advance';
            OptionMembers = " ","Leave Encash","Recovered Lost Day","Leave Allowance","Leave Advance";
        }
        field(50003;"Leave Request No.";Code[20])
        {
        }
        field(50004;"Staff Vendor Entry";Code[20])
        {
            TableRelation = Vendor;
        }
        field(50005;"Calculation Group";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'None,Earning,Benefit non cash,Deduction';
            OptionMembers = "None",Payments,"Benefit non cash",Deduction;
        }
    }

    keys
    {
        key(Key1;"Entry No.","ED Code","Employee No.")
        {
        }
        key(Key2;"Payroll ID","Employee No.","ED Code")
        {
        }
        key(Key3;Rate)
        {
        }
        key(Key4;"Payroll ID","Employee No.","ED Code","Loan Entry","Basic Pay Entry","Time Entry")
        {
        }
        key(Key5;"Employee No.","Payroll ID","ED Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        SetHeaderFalse;
        PayrollUtilities.sDeleteDefaultEDDims(Rec);
    end;

    trigger OnInsert()
    begin
        if "Payroll Code" = '' then "Payroll Code" := PayrollUtilities.gsAssignPayrollCode; //SNG 130611 payroll data segregation
        SetHeaderFalse;
    end;

    trigger OnModify()
    begin
        SetHeaderFalse;
    end;

    trigger OnRename()
    begin
        SetHeaderFalse;
    end;

    var
        EmploreeRec: Record Employee;
        EDDef: Record "ED Definitions";
        PayrollSetupRec: Record "Payroll Setups";
        LineRate: Decimal;
        PayrollUtilities: Codeunit "Payroll Posting";
        gvCurrencyCode: Code[10];
        gvCurrency: Record Currency;
        gvCurrExchRate: Record "Currency Exchange Rate";
        Text002: Label 'cannot be specified without %1';
        TableCodeTransfer: Codeunit "Table Code Transferred-Payroll";
        PayrollEntryRec: Record "Payroll Entry";
        EmployeeRec: Record Employee;
        HouseAllowanceAmt: Decimal;
        BasicPayAmt: Decimal;
        GrossAmt: Decimal;
        PensionAmt: Decimal;
        EmployeeRec1: Record Employee;
        GratitudeAmt: Decimal;
        DailyRate: Decimal;

    procedure CalcAmount()
    begin
        TableCodeTransfer.PayrollEntryCalcAmount(Rec);
    end;

    procedure SetHeaderFalse()
    var
        Header: Record "Payroll Header";
    begin
        TableCodeTransfer.PayrollEntrySetHeaderFalse(Rec);
    end;

    procedure ShowDimensions()
    var
        PayrollDim: Record "Payroll Dimension";
        PayrollDimensions: Page "Payroll Dimensions";
    begin
        TableCodeTransfer.PayrollEntryShowDimensions(Rec);
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

