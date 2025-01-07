table 50019 "Budget Committment"
{
    Caption = 'Budget Committment';

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
            Editable = false;
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            Editable = false;
        }
        field(4; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'LPO,Requisition,Imprest,Payment Voucher,PettyCash,PurchInvoice,StaffClaim,StaffAdvance,StaffSurrender,Grant Surrender,Cash Purchase,Casuals,Payroll,Journal Voucher';
            OptionMembers = LPO,Requisition,Imprest,"Payment Voucher",PettyCash,PurchInvoice,StaffClaim,StaffAdvance,StaffSurrender,"Grant Surrender","Cash Purchase",Casuals,Payroll,"Journal Voucher";
        }
        field(5; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
        }
        field(7; "Month Budget"; Decimal)
        {
            Caption = 'Month Budget';
            Editable = false;
        }
        field(8; "Month Actual"; Decimal)
        {
            Editable = false;
        }
        field(9; Committed; Boolean)
        {
            Editable = false;
        }
        field(10; "Committed By"; Code[50])
        {
            Editable = false;
        }
        field(11; "Committed Date"; Date)
        {
            Editable = false;
        }
        field(12; "Committed Time"; Time)
        {
            Editable = false;
        }
        field(13; "Committed Machine"; Text[100])
        {
            Editable = false;
        }
        field(14; Cancelled; Boolean)
        {
            Editable = false;
        }
        field(15; "Cancelled By"; Code[50])
        {
            Editable = false;
        }
        field(16; "Cancelled Date"; Date)
        {
            Editable = false;
        }
        field(17; "Cancelled Time"; Time)
        {
            Editable = false;
        }
        field(18; "Cancelled Machine"; Text[100])
        {
            Editable = false;
        }
        field(19; "Shortcut Dimension 1 Code"; Code[50])
        {
        }
        field(20; "Shortcut Dimension 2 Code"; Code[50])
        {
        }
        field(21; "Shortcut Dimension 3 Code"; Code[50])
        {
        }
        field(22; "Shortcut Dimension 4 Code"; Code[50])
        {
        }
        field(23; "G/L Account No."; Code[20])
        {
        }
        field(24; Budget; Code[20])
        {
        }
        field(25; "Vendor/Cust No."; Code[20])
        {
            Caption = 'Vendor/Cust No.';
        }
        field(26; Type; Option)
        {
            Caption = 'Type';
            OptionMembers = " ",Vendor,Customer;
        }
        field(27; "Gl Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Budget Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "G/L Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(30; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Employee Name"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Actual Netchange"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Document No.", "Line No.", Amount)
        {
        }
    }

    fieldgroups
    {
    }
}

