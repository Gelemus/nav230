table 52201 Registry
{

    fields
    {
        field(1; No; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Cheque No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Account No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Bank to Deposit"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Name of Person Picking"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Incoming Mails"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Content of Letter"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Letter sent via Posta"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Cheque to deposit,Cheque to Collect,Incoming Letters,Oil Requistion,Released Letter,Sent Letter';
            OptionMembers = " ","Cheque to deposit","Cheque to Collect","Incoming Letters","Oil Requistion","Released Letter","Sent Letter";
        }
        field(12; "USER ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Date Submitted"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Time Submitted"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Submitted By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Employee No"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                Emp.Reset;
                Emp.SetRange(Emp."No.", "Employee No");
                if Emp.FindFirst then begin
                    "Employee Name" := Emp."Full Name";
                end else begin
                    "Employee Name" := '';
                end;
            end;
        }
        field(17; "Employee Name"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Motor Cycle No"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset"."No.";

            trigger OnValidate()
            begin
                FA.Reset;
                FA.SetRange(FA."No.", "Motor Cycle No");
                if FA.FindFirst then begin
                    "Motor Cycle Description" := FA.Description;
                    //"Motor Registration No" := FA."Registration No.";
                end else begin
                    "Motor Cycle Description" := '';
                    "Motor Registration No" := '';
                end;
            end;
        }
        field(19; "Motor Cycle Description"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Marked To"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ', MD,CM,TM,PO,ACCOUNTS,STORES,ICT,HRM';
            OptionMembers = ," MD",CM,TM,PO,ACCOUNTS,STORES,ICT,HRM;
        }
        field(21; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Submitted';
            OptionMembers = Open,Submitted;
        }
        field(23; "Name of Person Receiving"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "File No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(25; Submitted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(28; "Cheque Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Motor Registration No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Date the cheque was picked"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Mode of Delivery"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Hand Delivery,Email,Postal Office,Courier Services';
            OptionMembers = " ","Hand Delivery",Email,"Postal Office","Courier Services";
        }
        field(32; "Courier Services Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "PF No"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                Emp.Reset;
                Emp.SetRange(Emp."No.", "PF No");
                if Emp.FindFirst then begin
                    "Marked To Name" := Emp."Full Name";
                end else begin
                    "Employee Name" := '';
                end;
            end;
        }
        field(34; "Marked To Name"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "File Reference"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "File Detail";
        }
    }

    keys
    {
        key(Key1; No)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if No = '' then begin
            if "Document Type" = "Document Type"::"Cheque to Collect" then begin
                FundsSetup.Get;
                FundsSetup.TestField(FundsSetup."Cheque Released No");
                NoSeriesMgt.InitSeries(FundsSetup."Cheque Released No", xRec."No. Series", 0D, No, "No. Series");
            end;
            if "Document Type" = "Document Type"::"Cheque to deposit" then begin
                FundsSetup.Get;
                FundsSetup.TestField(FundsSetup."Cheque Deposit No");
                NoSeriesMgt.InitSeries(FundsSetup."Cheque Deposit No", xRec."No. Series", 0D, No, "No. Series");
            end;
            if "Document Type" = "Document Type"::"Incoming Letters" then begin
                FundsSetup.Get;
                FundsSetup.TestField(FundsSetup."Incoming Mails No");
                NoSeriesMgt.InitSeries(FundsSetup."Incoming Mails No", xRec."No. Series", 0D, No, "No. Series");
            end;
            if "Document Type" = "Document Type"::"Oil Requistion" then begin
                FundsSetup.Get;
                FundsSetup.TestField(FundsSetup."Oil Requistion No");
                NoSeriesMgt.InitSeries(FundsSetup."Oil Requistion No", xRec."No. Series", 0D, No, "No. Series");
            end;
            if "Document Type" = "Document Type"::"Released Letter" then begin
                FundsSetup.Get;
                FundsSetup.TestField(FundsSetup."Released Letters  No");
                NoSeriesMgt.InitSeries(FundsSetup."Released Letters  No", xRec."No. Series", 0D, No, "No. Series");
            end;
            if "Document Type" = "Document Type"::"Sent Letter" then begin
                FundsSetup.Get;
                FundsSetup.TestField(FundsSetup."Sent Letters Nos");
                NoSeriesMgt.InitSeries(FundsSetup."Sent Letters Nos", xRec."No. Series", 0D, No, "No. Series");
            end;
        end;

        "Document Date" := Today;
        "USER ID" := UserId;
        "Posting Date" := Today;
    end;

    var
        FundsSetup: Record "Resource Centre Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Emp: Record Employee;
        FA: Record "Fixed Asset";
}

