table 56203 "Job Employment History"
{
    Caption = 'Job Employment History';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            Caption = 'Line No';
        }
        field(2; "Job Application No."; Code[30])
        {
            Caption = 'Job Application No.';
        }
        field(3; "Employer Name/Organization"; Text[100])
        {
            Caption = 'Employer Name/Organization';
        }
        field(4; "Address of the Organization"; Text[100])
        {
            Caption = 'Address of the Organization';
        }
        field(5; "Job Designation/Position Held"; Text[100])
        {
            Caption = 'Job Designation/Position Held';
        }
        field(6; "From Date"; Date)
        {
            Caption = 'From Date';
        }
        field(7; "To Date"; Date)
        {
            Caption = 'To Date';
        }
        field(8; "Days/Years of service"; Text[100])
        {
            Caption = 'Days/Years of service';
        }
        field(9; "Gross SalaryGross Salary"; Integer)
        {
            Caption = 'Gross SalaryGross Salary';
        }
        field(10; Benefits; Text[100])
        {
            Caption = 'Benefits';
        }
        field(11; "E-mail"; Text[50])
        {
            Caption = 'E-mail';
        }
        field(12; "Job Held Description"; Text[1000])
        {
            Caption = 'Job Held Description';
        }
        field(13; Current; Text[100])
        {
            Caption = 'Current';
        }
    }
    keys
    {
        key(PK; "Line No")
        {
            Clustered = true;
        }
    }
}
