table 52223 "Attendance Break"
{

    fields
    {
        field(1;No;Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Start Time";Time)
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(3;"End Time";Time)
        {
            DataClassification = ToBeClassified;
        }
        field(4;Name;Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Auto deduct";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Break Advance";Time)
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Break Delay";Time)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Attendance Punches";
        }
        field(8;"Break Valid Worktime";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9;Overcount;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Over Count minutes";Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;No)
        {
        }
    }

    fieldgroups
    {
    }
}

