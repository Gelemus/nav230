table 50221 "File Detail"
{
    DataCaptionFields = "File Code", "File Description";
    DrillDownPageID = "File List";
    LookupPageID = "File List";

    fields
    {
        field(1; "File Code"; Code[60])
        {
            NotBlank = false;

            trigger OnValidate()
            begin
                /* IF "File Code" <> "File Code" THEN BEGIN
                   SalesSetup.GET;
                   NoSeriesMgt.TestManual(SalesSetup."Registry File Numbers");
                   "No. Series" := '';
                 END;*/


            end;
        }
        field(2; "File Description"; Text[100])
        {
        }
        field(3; "Max Size Recommended"; Decimal)
        {
        }
        field(4; "Measure type for size"; Option)
        {
            OptionMembers = ,CM,MM;
        }
        field(6; "File Status"; Option)
        {
            OptionCaption = ' ,Open,Semi-Current,Closed,Archived,Disposed';
            OptionMembers = " ",Open,Closed,Archived,Disposed;

            trigger OnValidate()
            begin
                if "Disposal Action" = "Disposal Action"::Archive then begin
                    if "Disposal Date" <= Today then
                        "File Status" := "File Status"::Archived
                end;
            end;
        }
        field(7; "First Category"; Code[30])
        {
        }
        field(8; "Second Category"; Code[30])
        {
        }
        field(9; "Current Size"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Current Size" = "Max Size Recommended" then begin


                    "File Status" := "File Status"::Open;
                end else if "Current Size" > "Max Size Recommended" then begin


                    Error('The File has exceeded the recommended maximum size!');
                end;
            end;
        }
        field(10; "Measure type"; Option)
        {
            OptionMembers = ,CM,MM;
        }
        field(11; "Retention Period(Yrs)"; DateFormula)
        {
        }
        field(12; "Date Closed"; Date)
        {
        }
        field(13; "Disposal Action"; Option)
        {
            OptionMembers = Destroy,Archive;
        }
        field(14; "Disposal Date"; Date)
        {
        }
        field(15; "Third Category"; Code[30])
        {
        }
        field(16; "Fourth Category"; Code[30])
        {
        }
        field(17; Pensioner; Code[20])
        {
        }
        field(18; Contributer; Code[20])
        {

            trigger OnValidate()
            begin
                //Pensioners.GET( Contributer);

                //Contributer:=Pensioners.SurName;
            end;
        }
        field(19; "Pensioner Name"; Text[20])
        {
        }
        field(20; "Contributer Name"; Text[20])
        {
        }
        field(21; "Attached Documents"; Integer)
        {
            FieldClass = Normal;
        }
        field(22; "Employee File?"; Boolean)
        {

            trigger OnValidate()
            begin
                if "Employee File?" = true then
                    TestField("Employee ID");
            end;
        }
        field(23; "Employee ID"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin

                Emp.Get("Employee ID");
                "Employee Name" := Emp."Last Name" + ' ' + Emp."First Name";
            end;
        }
        field(24; "Employee Name"; Text[40])
        {
        }
        field(25; Status; Option)
        {
            OptionCaption = 'Available,Not Available';
            OptionMembers = Available,"Not Available";
        }
        field(26; Volume; Code[30])
        {
        }
        field(27; "Member Status"; Option)
        {
            OptionCaption = ',Active,Retired,Cleared';
            OptionMembers = ,Active,Retired,Cleared;
        }
        field(28; "Shelf  No."; Code[20])
        {
        }
        field(29; "Integer SF No"; Integer)
        {
        }
        field(30; "Creation Date"; Date)
        {
        }
        field(31; FirstC; Integer)
        {
        }
        field(32; SecondC; Integer)
        {
        }
        field(33; ThirdC; Integer)
        {
        }
        field(34; FourthC; Integer)
        {
        }
        field(35; "File Position"; Integer)
        {
        }
        field(36; "File Class"; Code[10])
        {
            TableRelation = "File Types";
        }
        field(37; "Reason for Closure"; Text[50])
        {
        }
        field(38; "Disposed?"; Boolean)
        {
        }
        field(39; "Start Date"; Date)
        {
            Caption = 'Created Date';
        }
        field(40; "End Date"; Date)
        {
        }
        field(41; Archived; Boolean)
        {
        }
        field(42; "Folio No."; Code[10])
        {
        }
        field(43; "Creation Time"; Time)
        {
        }
        field(44; "Closure Serial Nos."; Code[20])
        {
        }
        field(45; "Covering Date From"; Date)
        {
        }
        field(46; "Covering Date To"; Date)
        {
        }
        field(50; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(51; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(52; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(53; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(54; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(55; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(56; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(57; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));
        }
        field(58; "File Reference"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(59; Author; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "File Code", "First Category", "Second Category", "Third Category", "Fourth Category", Volume)
        {
        }
        key(Key2; "Shelf  No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        GLAcc: Record "G/L Account";
        Cust: Record Customer;
        Vend: Record Vendor;
        FA: Record "Fixed Asset";
        BankAcc: Record "Bank Account";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenLedgerSetup: Record "General Ledger Setup";
        CurrExchRate: Record "Currency Exchange Rate";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        CurrencyExchange: Record "Currency Exchange Rate";
        SalesInvoiceHeadr: Record "Sales Cr.Memo Header";
        AccNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        CustLedgEntry: Record "Cust. Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        PurchInv: Record "Purch. Inv. Header";
        SalesSetup: Record "Sales & Receivables Setup";
        CommentLine: Record "Comment Line";
        FileCode: Code[50];
        LastNumber: Code[30];
        First: Code[30];
        LastCharacter: Integer;
        OriginalCode: Code[30];
        FileCode2: Text[30];
        MaxLength: Integer;
        Emp: Record Employee;
        FileNo: Code[30];
        SFNumber: Code[30];
}

