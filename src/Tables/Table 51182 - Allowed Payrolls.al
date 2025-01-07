table 51182 "Allowed Payrolls"
{

    fields
    {
        field(1; "Payroll Code"; Code[10])
        {
            TableRelation = Payroll;
        }
        field(2; "User ID"; Code[50])
        {

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
                //LoginMgt.LookupUserID("User ID");///Justo to look for this function in the codeunit
            end;

            trigger OnValidate()
            var
                LoginMgt: Codeunit "User Management";
            begin
                //LoginMgt.ValidateUserID("User ID");/////Justo to look for this function in the codeunit
            end;
        }
        field(3; "Valid to Date"; Date)
        {
        }
        field(4; "Last Active Payroll"; Boolean)
        {
            Description = 'Indicates the payroll the user had access to last';
            Editable = false;

            trigger OnValidate()
            begin
                Error('Manual edit not allowed.')
            end;
        }
    }

    keys
    {
        key(Key1; "Payroll Code", "User ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        PayrollEdit;
    end;

    trigger OnInsert()
    begin
        PayrollEdit;
    end;

    trigger OnModify()
    begin
        //PayrollEdit;
    end;

    trigger OnRename()
    begin
        PayrollEdit;
    end;

    local procedure PayrollEdit()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Payroll Admin" then
            Error('You are not allowed to edit this payroll!');
    end;
}

