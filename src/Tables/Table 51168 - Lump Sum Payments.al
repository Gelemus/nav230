table 51168 "Lump Sum Payments"
{
   //DrillDownPageID = 52021083;
    //LookupPageID = 52021083;

    fields
    {
        field(1;"Line No";BigInteger)
        {
            Editable = false;
        }
        field(2;"Employee No";Code[20])
        {
            NotBlank = true;
            TableRelation = Employee;

            trigger OnValidate()
            var
                LoanRec: Record "Salary Scale";
            begin
                EmployeeRec.Get("Employee No");
                "Employee Name" := EmployeeRec."First Name"+' '+EmployeeRec."Middle Name"+' '+EmployeeRec."Last Name";
            end;
        }
        field(3;"Employee Name";Text[30])
        {
            Editable = false;
        }
        field(4;"ED Code";Code[20])
        {
            TableRelation = "ED Definitions"."ED Code" WHERE ("Calculation Group"=CONST(Payments),
                                                              "System Created"=CONST(true));
        }
        field(5;"ED Description";Text[30])
        {
            CalcFormula = Lookup("ED Definitions"."Payroll Text" WHERE ("ED Code"=FIELD("ED Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6;"Amount (LCY)";Decimal)
        {
        }
        field(8;"Assessment Year";Integer)
        {
            Description = 'Determines the PAYE tax table and Relief table to use.';
        }
        field(9;"Annual Tax Table";Code[20])
        {
            Description = 'Annual PAYE Table to Lookup to';
            TableRelation = "Lookup Table Header"."Table ID" WHERE ("Calendar Year"=FIELD("Assessment Year"));
        }
        field(11;"Linked Payroll Entry No";Integer)
        {
            Description = 'The Payroll Entry the lump sum payment has been processed to';
            Editable = false;
        }
        field(12;"Linked Payroll Line No";Integer)
        {
            Description = 'The Payroll Line the lump sum payment has been processed to';
            Editable = false;
        }
        field(13;"Payroll Code";Code[10])
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
        key(Key1;"Line No")
        {
        }
        key(Key2;"Employee No","Assessment Year","ED Code")
        {
            SumIndexFields = "Amount (LCY)";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lvPayrollEntry: Record "Payroll Entry";
        lvPayrollLine: Record "Payroll Lines";
        lvPayrollHdr: Record "Payroll Header";
    begin
        if ("Linked Payroll Entry No" <> 0) and (lvPayrollEntry.Get("Linked Payroll Entry No")) then begin
          lvPayrollHdr.Get(lvPayrollEntry."Payroll ID", lvPayrollEntry."Employee No.");
          lvPayrollHdr.Calculated := false;
          lvPayrollHdr.Modify;
          lvPayrollEntry.Delete;
        end;

        if ("Linked Payroll Line No" <> 0) and (lvPayrollLine.Get("Linked Payroll Line No")) then lvPayrollLine.Delete;
    end;

    trigger OnInsert()
    begin
        if "Payroll Code" = '' then "Payroll Code" := gvPayrollUtilities.gsAssignPayrollCode; //SNG 130611 payroll data segregation
    end;

    var
        EmployeeRec: Record Employee;
        gvPayrollUtilities: Codeunit "Payroll Posting";
}

