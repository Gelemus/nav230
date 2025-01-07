table 50400 "None"
{

    fields
    {
        field(1; "Request No."; Code[20])
        {
        }
        field(2; "Employee No."; Code[10])
        {
            NotBlank = true;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Emp.Get("Employee No.") then
                    "Employee Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(3; "Employee Name"; Text[50])
        {
        }
        field(4; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Price per Unit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Line No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Request No.", "Line No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TranReq.Reset;
        TranReq.SetRange(TranReq."Request No.", "Request No.");
        TranReq.SetRange(TranReq.Status, TranReq.Status::Released);
        if TranReq.Find('-') then
            ERROR('You cannot Delete details from documents that have already been released');
    end;

    trigger OnInsert()
    begin
        TranReq.Reset;
        TranReq.SetRange(TranReq."Request No.", "Request No.");
        TranReq.SetRange(TranReq.Status, TranReq.Status::Released);
        if TranReq.Find('-') then
            ERROR('You cannot edit documents that have already been released');
    end;

    trigger OnModify()
    begin
        TranReq.Reset;
        TranReq.SetRange(TranReq."Request No.", "Request No.");
        TranReq.SetRange(TranReq.Status, TranReq.Status::Released);
        if TranReq.Find('-') then
            ERROR('You cannot edit documents that have already been released');
    end;

    var
        Emp: Record Employee;
        TranReq: Record "Transport Request";
}

