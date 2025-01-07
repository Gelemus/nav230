table 51151 Periods
{
    DrillDownPageID = "Period Look Up";
    LookupPageID = "Period Look Up";

    fields
    {
        field(1; "Period ID"; Code[10])
        {
            NotBlank = true;
            TableRelation = Periods;
        }
        field(2; "Period Month"; Integer)
        {
            MaxValue = 12;
            MinValue = 1;
            NotBlank = true;

            trigger OnValidate()
            begin
                "Period ID" := Format("Period Month") + '-' + Format("Period Year");
            end;
        }
        field(3; "Period Year"; Integer)
        {
            NotBlank = true;
            TableRelation = Year;
        }
        field(4; "Start Date"; Date)
        {
        }
        field(5; "End Date"; Date)
        {
        }
        field(6; Description; Text[30])
        {
        }
        field(7; "Posting Date"; Date)
        {
        }
        field(8; Status; Option)
        {
            OptionMembers = " ",Open,Posted;
        }
        field(9; Hours; Decimal)
        {
        }
        field(10; Days; Decimal)
        {
        }
        field(11; "Tax Penalties"; Decimal)
        {
        }
        field(12; "Low Interest Benefit %"; Decimal)
        {
            MaxValue = 100;
            MinValue = 0;
        }
        field(13; "NHIF Period Start"; Boolean)
        {
        }
        field(14; "Payroll Code"; Code[10])
        {
            TableRelation = Payroll;

            trigger OnValidate()
            begin
                //ERROR('Manual Edits not allowed.');
            end;
        }
        field(15; "Annualize TAX"; Boolean)
        {
            Description = 'V.6.1.65_08SEP10 For Annualize TAX';
        }
        field(16; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(17; "Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Period Description"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Enable Payslip"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';
            DataClassification = ToBeClassified;
            TableRelation = "Incoming Document";

            trigger OnValidate()
            var
                IncomingDocument: Record "Incoming Document";
            begin
                if "Incoming Document Entry No." = xRec."Incoming Document Entry No." then
                    exit;
                if "Incoming Document Entry No." = 0 then
                    IncomingDocument.RemoveReferenceToWorkingDocument(xRec."Incoming Document Entry No.")
                // else
                // IncomingDocument.SetPurchDoc(Rec);
            end;

        }


    }

    keys
    {
        key(Key1; "Period ID", "Period Month", "Period Year", "Payroll Code")
        {
        }
        key(Key2; "Start Date")
        {
        }
        key(Key3; "Period Year", "Period Month")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Payroll Code" = '' then "Payroll Code" := gvPayrollUtilites.gsAssignPayrollCode; //payroll data segregation
        "Document No" := "Period ID" + '-' + "Payroll Code";
    end;

    trigger OnModify()
    begin
        //IF Status = Status::Posted THEN ERROR('Can''t edit details for a posted period.');
    end;

    var
        gvPayrollUtilites: Codeunit "Payroll Posting";
}
