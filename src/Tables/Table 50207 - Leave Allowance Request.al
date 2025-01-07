table 50207 "Leave Allowance Request"
{

    fields
    {
        field(1;"No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Document Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Employe No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Employee Name";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Payroll Period";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10;Status;Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = Open,"Pending Approval",Approved;

            trigger OnValidate()
            begin
                if Status=Status::Approved then begin
                //  PayrollManagement.CreatePayrollLeaveAllowance(Rec);
                  Message(LeaveAllowanceMessage,"Payroll Period");
                end;
            end;
        }
    }

    keys
    {
        key(Key1;"No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        LeaveAllowanceMessage: Label 'Leave allownce has sucessfully been Appoved and will be factored in for the payroll period %1';
}

