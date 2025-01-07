table 51174 "Payslip Lines"
{

    fields
    {
        field(1;"Line No.";Integer)
        {
            NotBlank = true;
        }
        field(2;"Payslip Group";Code[20])
        {
            NotBlank = true;
            TableRelation = "Payslip Group";
        }
        field(3;"Line Type";Option)
        {
            OptionMembers = "E/D code",P9;
        }
        field(4;P9;Option)
        {
            OptionMembers = " ",A,B,C,D,E1,E2,E3,F,G,H,J,K,L,M;
        }
        field(5;"E/D Code";Code[20])
        {
            TableRelation = "ED Definitions";
        }
        field(6;"P9 Text";Text[50])
        {
        }
        field(7;Amount;Decimal)
        {
        }
        field(8;"E/D Description";Text[50])
        {
            CalcFormula = Lookup("ED Definitions".Description WHERE ("ED Code"=FIELD("E/D Code")));
            FieldClass = FlowField;
        }
        field(9;Negative;Boolean)
        {
        }
        field(50009;"Payroll Code";Code[10])
        {
            Editable = true;
            TableRelation = Payroll;

            trigger OnValidate()
            begin
                //ERROR('Manual Edits not allowed.');
            end;
        }
    }

    keys
    {
        key(Key1;"Line No.","Payslip Group","Payroll Code")
        {
        }
    }

    fieldgroups
    {
    }

    procedure SetUpNewLine(LastReg: Record "Payslip Lines";BottomLine: Boolean)
    var
        LastReg2: Record "Payslip Lines";
    begin
        LastReg2.Copy(LastReg);
        LastReg2.SetRange("Payslip Group",LastReg."Payslip Group");

        if BottomLine then
          if LastReg2.Find('-') then
            "Line No." := LastReg."Line No." + 10000
          else
            "Line No." := 10000
        else begin
          if LastReg2.Find('<') then
            "Line No." := (LastReg."Line No." + LastReg2."Line No.") div 2
          else
            "Line No." := LastReg."Line No." div 2
        end;
    end;

    procedure gsAssignPayrollCode()
    var
        lvUserSetup: Record "User Setup";
    begin
        lvUserSetup.Get(UserId);
        lvUserSetup.TestField("Give Access to Payroll");
        "Payroll Code" := lvUserSetup."Give Access to Payroll"
    end;
}
