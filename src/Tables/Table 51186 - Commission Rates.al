table 51186 "Commission Rates"
{

    fields
    {
        field(1;"Entry No";Integer)
        {
        }
        field(2;"Employee No";Code[20])
        {
            TableRelation = Employee;
        }
        field(3;Base;Option)
        {
            InitValue = "Sales Turnover";
            OptionMembers = "Basic Salary","Sales Turnover","Receipts Collected";

            trigger OnValidate()
            var
                lvEmployee: Record Employee;
            begin
                if Base = Base::"Basic Salary" then begin
                  TestField("Employee No");
                  lvEmployee.Get("Employee No");
                  if lvEmployee."Basic Pay" = lvEmployee."Basic Pay"::" " then Error('Invalid for an employee without a Basic Salary.');
                end
            end;
        }
        field(5;"Valid To Date";Date)
        {
        }
        field(6;"ED Code";Code[20])
        {
            NotBlank = true;
            TableRelation = "ED Definitions"."ED Code" WHERE ("Calculation Group"=CONST(Payments),
                                                              "System Created"=CONST(true));
        }
        field(7;"Threshold Amount LCY";Decimal)
        {
        }
        field(8;"Commission %";Decimal)
        {
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                if "Commission %" <> 0 then "Commission Amount LCY" := 0;
            end;
        }
        field(9;"Commission Amount LCY";Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                if "Commission Amount LCY" <> 0 then "Commission %" := 0;
            end;
        }
        field(10;"Payroll Code";Code[10])
        {
            TableRelation = Payroll;

            trigger OnValidate()
            begin
                Error('Manual Edits not allowed.');
            end;
        }
    }

    keys
    {
        key(Key1;"Entry No")
        {
        }
        key(Key2;"Employee No","Valid To Date",Base)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Payroll Code" = '' then "Payroll Code" := gvPayrollUtilities.gsAssignPayrollCode; //SNG 130611 payroll data segregation
    end;

    var
        gvPayrollUtilities: Codeunit "Payroll Posting";
}

