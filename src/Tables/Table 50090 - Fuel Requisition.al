table 50090 "Fuel Requisition"
{

    fields
    {
        field(1;"No.";Code[20])
        {
            Editable = false;
        }
        field(2;Date;Date)
        {
        }
        field(3;"Vehicle No.";Code[20])
        {
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnValidate()
            begin
                /*IF Vehicle.GET("Vehicle No.") THEN BEGIN
                  "Vehicle Registration No.":=Vehicle."Registration No.";
                END ELSE BEGIN
                  "Vehicle Registration No.":='';
                END;*/

            end;
        }
        field(4;"Vehicle Registration No.";Code[20])
        {
            Editable = false;
        }
        field(5;"Fuel Type";Option)
        {
            OptionMembers = ,Petrol,Diesel;
        }
        field(6;"Quantity in Litres";Decimal)
        {
        }
        field(7;"Price Per Litre";Decimal)
        {

            trigger OnValidate()
            begin
                  "Value of Fuel":="Quantity in Litres"*"Price Per Litre";
            end;
        }
        field(8;"Value of Fuel";Decimal)
        {
            Editable = false;
        }
        field(20;"Vendor No.";Code[20])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                Vendor.Reset;
                Vendor.SetRange(Vendor."No.","Vendor No.");
                if Vendor.FindFirst then begin
                 "Vendor Name":=Vendor.Name;
                  end else begin
                    "Vendor Name":='';
                end;
            end;
        }
        field(21;"Vendor Name";Text[100])
        {
            Editable = false;
        }
        field(22;"Vendor Invoice No.";Code[20])
        {
        }
        field(49;Description;Text[100])
        {

            trigger OnValidate()
            begin
                Description:=UpperCase(Description);
            end;
        }
        field(50;"Global Dimension 1 Code";Code[50])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(51;"Global Dimension 2 Code";Code[50])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(52;"Shortcut Dimension 3 Code";Code[50])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(53;"Shortcut Dimension 4 Code";Code[50])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(4),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(54;"Shortcut Dimension 5 Code";Code[50])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(5),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(55;"Shortcut Dimension 6 Code";Code[50])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(6),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(56;"Shortcut Dimension 7 Code";Code[50])
        {
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(7),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(57;"Shortcut Dimension 8 Code";Code[50])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(8),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(58;"Responsibility Center";Code[20])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(70;Status;Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Closed';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Closed;
        }
        field(99;"User ID";Code[50])
        {
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(100;"No. Series";Code[20])
        {
        }
        field(101;"Bank Account No.";Code[20])
        {
            Caption = 'Bank Account No.';
            TableRelation = "Bank Account"."No." WHERE ("Bank Account Type"=CONST("Fuel Card"));

            trigger OnValidate()
            begin
                BankAccount.Reset;
                BankAccount.SetRange(BankAccount."No.","Bank Account No.");
                if BankAccount.FindFirst then begin
                  "Bank Account Name":=BankAccount.Name;
                  end else begin
                    "Bank Account Name":='';
                end;
            end;
        }
        field(102;"Bank Account Name";Text[100])
        {
            Caption = 'Bank Account Name';
            Editable = false;
        }
        field(103;"Bank Account Balance";Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE ("Bank Account No."=FIELD("Bank Account No.")));
            Caption = 'Bank Account Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(104;"Previous Kms";Decimal)
        {
            DataClassification = ToBeClassified;
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

    trigger OnInsert()
    begin
          if "No." = '' then begin
            FleetSetup.Get;
            FleetSetup.TestField("Fuel Requisition Nos.");
            NoSeriesMgt.InitSeries(FleetSetup."Fuel Requisition Nos.",xRec."No. Series",0D,"No.","No. Series");
          end;
          "User ID":=UserId;
    end;

    var
        Vendor: Record Vendor;
        FleetSetup: Record "Human Resource Cue";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        BankAccount: Record "Bank Account";
}

