table 50133 "Employee Leave Type"
{

    fields
    {
        field(1;"Employee No.";Code[20])
        {
            TableRelation = Employee;
        }
        field(2;"Leave Type";Code[50])
        {
            TableRelation = "HR Leave Types".Code;

            trigger OnValidate()
            begin
                Description:='';
                if HRLeaveType.Get("Leave Type") then
                 Description:=HRLeaveType.Description;

                if "Leave Type"<>'' then begin
                  HRLeavePeriod.Reset;
                  HRLeavePeriod.SetRange(HRLeavePeriod.Closed,false);
                  if HRLeavePeriod.FindLast then begin
                    "Current Period":=HRLeavePeriod.Code;
                  end;
                end else begin
                 Error('Please setup leave period');
                end;
            end;
        }
        field(3;Description;Text[100])
        {
            Editable = false;
        }
        field(4;"Allocation Days";Decimal)
        {
            Editable = true;
        }
        field(5;"Leave Balance";Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries".Days WHERE ("Employee No."=FIELD("Employee No."),
                                                                    "Leave Type"=FIELD("Leave Type"),
                                                                    "Leave Period"=FIELD("Current Period")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(10;"Current Period";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50000;Department;Code[50])
        {
            CalcFormula = Lookup(Employee."Global Dimension 1 Code" WHERE ("No."=FIELD("Employee No.")));
            FieldClass = FlowField;
        }
        field(50001;Section;Code[50])
        {
            CalcFormula = Lookup(Employee."Global Dimension 2 Code" WHERE ("No."=FIELD("Employee No.")));
            FieldClass = FlowField;
        }
        field(50002;"Employee Name";Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Employee No.","Leave Type")
        {
        }
    }

    fieldgroups
    {
    }

    var
        HRLeaveType: Record "HR Leave Types";
        HRLeavePeriod: Record "HR Leave Periods";
}

