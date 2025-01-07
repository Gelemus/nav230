table 50310 "Work Ticket"
{
    DrillDownPageID = "Work Ticket List";
    LookupPageID = "Work Ticket List";

    fields
    {
        field(1; "Ticket No"; Code[20])
        {
            //TableRelation = 
            //"Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
            //                                            "Dimension Value Type" = CONST(Standard),
            //                                           Blocked = CONST(false));
        }
        field(2; "Vehicle No"; Code[20])
        {
            Caption = 'Vehicle No';
            TableRelation = "Fixed Asset";

            trigger OnValidate()
            begin
                if FixedAsset.Get("Vehicle No") then begin
                    Description := FixedAsset.Description;
                    "Registration No" := FixedAsset."Registration No.";
                    Validate("Driver No", FixedAsset."Responsible Employee");
                    "Vehicle Type" := FixedAsset."Transport Type";
                    Model := FixedAsset.Model;
                end;
            end;
        }
        field(3; Date; Date)
        {
        }
        field(4; "Oil Drawn (Litres)"; Decimal)
        {
        }
        field(5; "Fuel Drawn (Litres)"; Decimal)
        {
        }
        field(6; "Issue Voucher No."; Code[20])
        {
        }
        field(7; "Start Speedometer Reading"; Decimal)
        {

            trigger OnValidate()
            begin
                "Kms Covered" := "Last Mileage Reading" - "Start Speedometer Reading";
            end;
        }
        field(8; "Kms Covered"; Decimal)
        {
        }
        field(9; "No. Series"; Code[10])
        {
        }
        field(10; "Driver No"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Emp.Get("Driver No") then
                    "Driver Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(11; "Driver Name"; Text[90])
        {
        }
        field(12; Description; Code[30])
        {
        }
        field(13; "Registration No"; Code[20])
        {
        }
        field(14; "Cost per Litre"; Decimal)
        {
        }
        field(15; Amount; Decimal)
        {
        }
        field(16; "Last Mileage Reading"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Last Mileage Reading" < "Start Speedometer Reading" then Error('Return Mileage Must be greater than Previous Mileage');
                "Kms Covered" := "Last Mileage Reading" - "Start Speedometer Reading";
            end;
        }
        field(17; "Last Fuel Filled"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Estimated Litres Per Km"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Journery Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Journey Details"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Last Reading Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Super (Litres)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Diesel (Litres)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Other(Litres)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Start Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Return TIme"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(27; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Closed';
            OptionMembers = Open,"Pending Approval",Approved,Closed;
        }
        field(28; "Inspection Remarks"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(29; DefectReport; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(30; Department; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(31; Region; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "External Ticket No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Previous Ticket No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Vehicle Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Motorvehicle,Motorcycle;
        }
        field(35; "Receipt No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(36; Model; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
    }

    keys
    {
        key(Key1; "Ticket No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Ticket No" = '' then begin
            HumanResSetup.Get;
            HumanResSetup.TestField(HumanResSetup."Vehicle Filling Nos");
            NoSeriesMgt.InitSeries(HumanResSetup."Fuel Requisition Nos", xRec."No. Series", 0D, "Ticket No", "No. Series");
        end;
    end;

    var
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Emp: Record Employee;
        FixedAsset: Record "Fixed Asset";
}

