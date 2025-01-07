table 50214 "Vehicle Filling"
{
    DrillDownPageID = "Fuel Filling List";
    LookupPageID = "Fuel Filling List";

    fields
    {
        field(1; "Filling No"; Code[20])
        {
        }
        field(2; "No."; Code[20])
        {
            TableRelation = "Fixed Asset"."No." WHERE("Transport Type" = FILTER(<> " "));

            trigger OnValidate()
            begin
                if FixedAsset.Get("No.") then begin
                    Description := FixedAsset.Description;
                    "Registration No" := FixedAsset."Registration No.";
                    Make := FixedAsset."Body Type";
                    "Transport Type" := FixedAsset."Transport Type";
                end;
            end;
        }
        field(3; "Filling Date"; Date)
        {
        }
        field(4; "Oil Drawn (Litres)"; Decimal)
        {

            trigger OnValidate()
            begin


                Amount := Round(("Cost per Litre" * "Fuel Drawn (Litres)"), 1, '>');
                "Total Amount" := Round(("Others Amount" + Amount), 1, '>');
            end;
        }
        field(5; "Fuel Drawn (Litres)"; Decimal)
        {

            trigger OnValidate()
            begin
                Amount := Round(("Cost per Litre" * "Fuel Drawn (Litres)"), 1, '>');
                "Total Amount" := Round(("Others Amount" + Amount), 1, '>');
            end;
        }
        field(6; "Voucher No."; Code[20])
        {
        }
        field(7; "Current Speed"; Decimal)
        {
        }
        field(8; "Kms Covered"; Decimal)
        {
            Caption = 'Kms Covered';
        }
        field(9; "No. Series"; Code[10])
        {
        }
        field(10; "Employee No"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Emp.Get("Employee No") then begin
                    "Employee No" := Emp."No.";
                    "Employee Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                    "Global Dimension 1 Code" := Emp."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := Emp."Global Dimension 2 Code";
                    "Shortcut Dimension 3 Code" := Emp."Shortcut Dimension 3 Code";
                end;
            end;
        }
        field(11; "Employee Name"; Text[90])
        {
            Editable = false;
        }
        field(12; Description; Code[100])
        {
        }
        field(13; "Registration No"; Code[20])
        {
        }
        field(14; "Cost per Litre"; Decimal)
        {

            trigger OnValidate()
            begin
                Amount := "Cost per Litre" * "Fuel Drawn (Litres)";
            end;
        }
        field(15; Amount; Decimal)
        {
        }
        field(16; "Submitted By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Date Submitted"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Time Submitted"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(19; Submitted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(21; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(22; Type; Text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset"."No.";
        }
        field(23; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Card Description"; Code[250])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(25; "Card No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Card Information";

            trigger OnValidate()
            begin
                if CardInfo.Get("Card No") then
                    "Card Description" := CardInfo.Description;
            end;
        }
        field(26; "Balance BF"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Amount Loaded"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Balance CF"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Loading Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(30; Make; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(32; "Paraffin (Litres)"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin


                "Cost per Litre" := Amount / "Paraffin (Litres)";
            end;
        }
        field(33; Details; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Invoice No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Previoust Kms"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Fa Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset"."FA Posting Group";
        }
        field(37; "Transport Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Vehicle,MotorBike,Generator,Water Pump OM,Gas,Water Pump Lorry,Other';
            OptionMembers = " ",Vehicle,MotorBike,Generator,"Water Pump OM",Gas,"Water Pump Lorry",Other;
        }
        field(38; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Released,Cancelled';
            OptionMembers = Open,"Pending Approval",Released,Cancelled;
        }
        field(39; "Fuel Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Petrol,Diesel,Paraffin,6kg Gas,13kg Gas';
            OptionMembers = " ",Petrol,Diesel,Paraffin,"6kg Gas","13kg Gas";

            trigger OnValidate()
            begin
                "Cost per Litre" := 0;
                "Fuel Drawn (Litres)" := 0;

                if "Fuel Type" = "Fuel Type"::Diesel then begin
                    FuelPrices.Reset;
                    FuelPrices.SetRange("Fuel type", FuelPrices."Fuel type"::Diesel);
                    if FuelPrices.FindSet then
                      //IF FuelPrices."Fuel type" = FuelPrices."Fuel type"::Diesel  THEN
                      begin
                        "Cost per Litre" := FuelPrices.Amount;
                    end;
                end else
                    if "Fuel Type" = "Fuel Type"::Petrol then begin
                        FuelPrices.Reset;
                        FuelPrices.SetRange("Fuel type", FuelPrices."Fuel type"::Petrol);
                        if FuelPrices.FindSet then
                          //IF FuelPrices."Fuel type" = FuelPrices."Fuel type"::Petrol  THEN
                          begin
                            "Cost per Litre" := FuelPrices.Amount;
                        end;
                    end else
                        if "Fuel Type" = "Fuel Type"::Paraffin then begin
                            FuelPrices.Reset;
                            FuelPrices.SetRange("Fuel type", FuelPrices."Fuel type"::Paraffin);
                            if FuelPrices.FindSet then
                              //IF FuelPrices."Fuel type" = FuelPrices."Fuel type"::Paraffin  THEN
                              begin
                                "Cost per Litre" := FuelPrices.Amount;
                            end;
                        end else
                            if "Fuel Type" = "Fuel Type"::"6kg Gas" then begin
                                FuelPrices.Reset;
                                FuelPrices.SetRange("Fuel type", FuelPrices."Fuel type"::"13Kg Gas");
                                if FuelPrices.FindSet then
                                  //IF FuelPrices."Fuel type" = FuelPrices."Fuel type"::Gas  THEN
                                  begin
                                    "Cost per Litre" := FuelPrices.Amount;
                                end;
                            end;
                Validate("Cost per Litre");
            end;
        }
        field(40; "Others description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Others Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Amount" := "Others Amount" + Amount;
            end;
        }
        field(42; "Fueling Officer"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "KM/LT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Other Services"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '  ,Car Wash,Punctures,Sprays,Battery Repairs,Engine Oil,Coolant,Brake fluid,2T Oil,Hydraulic Oil,Power Steering Oil';
            OptionMembers = "  ","Car Wash",Punctures,Sprays,"Battery Repairs","Engine Oil",Coolant,"Brake fluid","2T Oil","Hydraulic Oil","Power Steering Oil";
        }
        field(45; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                Vendor.Reset;
                Vendor.SetRange(Vendor."No.", "Vendor No.");
                if Vendor.FindFirst then begin
                    "Vendor Name" := Vendor.Name;
                end else begin
                    "Vendor Name" := '';
                end;
            end;
        }
        field(46; "Vendor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(47; "Reason for Cancellation"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Cancelled By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Date Cancelled"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Time Cancelled"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            begin
                /*UserSetup.RESET;
                UserSetup.SETRANGE(UserSetup."User ID","User ID");
                IF UserSetup.FINDFIRST THEN BEGIN
                  //UserSetup.TESTFIELD(UserSetup."Global Dimension 1 Code");
                  //UserSetup.TESTFIELD(UserSetup."Global Dimension 2 Code");
                  "Global Dimension 1 Code":=UserSetup."Global Dimension 1 Code";
                  "Global Dimension 2 Code":=UserSetup."Global Dimension 2 Code";
                  {"Shortcut Dimension 3 Code":=UserSetup."Shortcut Dimension 3 Code";
                  "Shortcut Dimension 4 Code":=UserSetup."Shortcut Dimension 4 Code";
                  "Shortcut Dimension 5 Code":=UserSetup."Shortcut Dimension 5 Code";
                  "Shortcut Dimension 6 Code":=UserSetup."Shortcut Dimension 6 Code";
                  "Shortcut Dimension 7 Code":=UserSetup."Shortcut Dimension 7 Code";
                  "Shortcut Dimension 8 Code":=UserSetup."Shortcut Dimension 8 Code";}
                  "Employee No":=UserSetup."No.";
                  "Employee Name":= UserSetup."Full Name";
                  VALIDATE("Employee No");
                END;
                */

            end;
        }
        field(52; "Total Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Filling No", "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Filling No" = '' then begin
            HumanResSetup.Get;
            HumanResSetup.TestField(HumanResSetup."Vehicle Filling Nos");
            NoSeriesMgt.InitSeries(HumanResSetup."Vehicle Filling Nos", xRec."No. Series", 0D, "Filling No", "No. Series");
        end;

        "Filling Date" := Today;
        "User ID" := UserId;
        Validate("User ID");
    end;

    var
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Emp: Record Employee;
        FixedAsset: Record "Fixed Asset";
        CardInfo: Record "Card Information";
        Vendor: Record Vendor;
        UserSetup: Record Employee;
        FuelPrices: Record "Fuel Prices";
}

