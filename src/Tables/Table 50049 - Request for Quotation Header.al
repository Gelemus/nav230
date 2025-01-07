table 50049 "Request for Quotation Header"
{
    Caption = 'Request for Quotation Header';

    fields
    {
        field(1;"No.";Code[20])
        {
            Editable = false;
        }
        field(2;"Document Date";Date)
        {
        }
        field(3;"Closing Date";Date)
        {
        }
        field(4;"Issue Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5;Type;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'RFQ,RFP';
            OptionMembers = RFQ,RFP;
        }
        field(21;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(22;"Currency Factor";Decimal)
        {
            Caption = 'Currency Factor';
        }
        field(23;Amount;Decimal)
        {
            CalcFormula = Sum("Request for Quotation Line"."Total Cost" WHERE ("Document No."=FIELD("No.")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(24;"Amount(LCY)";Decimal)
        {
            CalcFormula = Sum("Request for Quotation Line"."Total Cost(LCY)" WHERE ("Document No."=FIELD("No.")));
            Caption = 'Amount(LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(30;Time;Time)
        {
            DataClassification = ToBeClassified;
        }
        field(49;Description;Text[100])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                Description:=UpperCase(Description);
            end;
        }
        field(50;"Global Dimension 1 Code";Code[50])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(51;"Global Dimension 2 Code";Code[50])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(52;"Shortcut Dimension 3 Code";Code[50])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(53;"Shortcut Dimension 4 Code";Code[50])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(4),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(54;"Shortcut Dimension 5 Code";Code[50])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(5),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(55;"Shortcut Dimension 6 Code";Code[50])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(6),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(56;"Shortcut Dimension 7 Code";Code[50])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(7),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(57;"Shortcut Dimension 8 Code";Code[50])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(8),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(58;"Responsibility Center";Code[20])
        {
            Caption = 'Responsibility Center';
        }
        field(70;Status;Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Released,Rejected,Closed';
            OptionMembers = Open,"Pending Approval",Released,Rejected,Closed;

            trigger OnValidate()
            begin
                RequestforQuotationLine.Reset;
                RequestforQuotationLine.SetRange(RequestforQuotationLine."Document No.","No.");
                if RequestforQuotationLine.FindSet then begin
                  repeat
                    RequestforQuotationLine.Status:=Status;
                    RequestforQuotationLine.Modify;
                  until RequestforQuotationLine.Next=0;
                end;
            end;
        }
        field(99;"User ID";Code[50])
        {
            Caption = 'User ID';
            Editable = false;
            TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            begin
                UserSetup.Reset;
                UserSetup.SetRange(UserSetup."User ID","User ID");
                if UserSetup.FindFirst then begin
                  UserSetup.TestField(UserSetup."Global Dimension 1 Code");
                  UserSetup.TestField(UserSetup."Global Dimension 2 Code");
                  "Global Dimension 1 Code":=UserSetup."Global Dimension 1 Code";
                  "Global Dimension 2 Code":=UserSetup."Global Dimension 2 Code";
                  "Shortcut Dimension 3 Code":=UserSetup."Shortcut Dimension 3 Code";
                  "Shortcut Dimension 4 Code":=UserSetup."Shortcut Dimension 4 Code";
                  "Shortcut Dimension 5 Code":=UserSetup."Shortcut Dimension 5 Code";
                  "Shortcut Dimension 6 Code":=UserSetup."Shortcut Dimension 6 Code";
                  "Shortcut Dimension 7 Code":=UserSetup."Shortcut Dimension 7 Code";
                  "Shortcut Dimension 8 Code":=UserSetup."Shortcut Dimension 8 Code";
                end;
            end;
        }
        field(100;"No. Series";Code[20])
        {
            Caption = 'No. Series';
        }
        field(101;"No. Printed";Integer)
        {
            Caption = 'No. Printed';
        }
        field(102;"Incoming Document Entry No.";Integer)
        {
            Caption = 'Incoming Document Entry No.';
        }
        field(200;"Send RFQ via Email";Boolean)
        {
        }
        field(201;"Email Body";Text[250])
        {
        }
        field(205;"Edit in Outlook Client";Boolean)
        {
        }
        field(206;"AGPO Certificate";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Mandatory,Not Mandatory';
            OptionMembers = Mandatory,"Not Mandatory";
        }
        field(207;"Business Registration Cert.";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Mandatory,Not Mandatory';
            OptionMembers = Mandatory,"Not Mandatory";
        }
        field(208;"Tax Compliance Cert.";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Mandatory,Not Mandatory';
            OptionMembers = Mandatory,"Not Mandatory";
        }
        field(209;"Confidential Bus.Questionnaire";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Mandatory,Not Mandatory';
            OptionMembers = Mandatory,"Not Mandatory";
        }
        field(210;"Request For Quatation Created";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(211;Timeline;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(212;"Request For Quotation Doc No.";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Sysre NextGen Addon';
            TableRelation = "No. Series".Code;
        }
        field(213;"Request For Quotation No";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(215;"Reason for Cancellation";Code[250])
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
        fieldgroup(DropDown;"No.","Document Date",Description,Amount,"Global Dimension 1 Code",Status,"User ID")
        {
        }
    }

    trigger OnDelete()
    begin
        TestField(Status,Status::Open);
        RequestforQuotationLine.Reset;
        RequestforQuotationLine.SetRange(RequestforQuotationLine."Document No.","No.");
        if RequestforQuotationLine.FindSet then
          RequestforQuotationLine.DeleteAll;
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
          "Purchases&PayablesSetup".Get;
          "Purchases&PayablesSetup".TestField("Purchases&PayablesSetup"."Request for Quotation Nos.");
          NoSeriesMgt.InitSeries("Purchases&PayablesSetup"."Request for Quotation Nos.",xRec."No. Series",0D,"No.","No. Series");
        end;

        "Document Date":=Today;
        "User ID":=UserId;
        Validate("User ID");
    end;

    var
        "Purchases&PayablesSetup": Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        RequestforQuotationLine: Record "Request for Quotation Line";
        UserSetup: Record Employee;
}

