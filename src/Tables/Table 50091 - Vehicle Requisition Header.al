table 50091 "Vehicle Requisition Header"
{

    fields
    {
        field(1;"No.";Code[20])
        {
            Editable = false;
        }
        field(2;"Document Date";Date)
        {
            Editable = false;
        }
        field(3;"Employee No.";Code[20])
        {
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                "Employee Name":='';

                Employee.Reset;
                if Employee.Get("Employee No.") then begin
                  "Employee Name":=Employee."Last Name"+' '+Employee."First Name"+' '+Employee."Middle Name";
                end;
            end;
        }
        field(4;"Employee Name";Text[150])
        {
            Editable = false;
        }
        field(5;"Departure Location";Code[50])
        {
            TableRelation = Location WHERE ("Use As In-Transit"=CONST(false));
        }
        field(6;"Arrival Location";Code[50])
        {
        }
        field(7;"Start Date";Date)
        {
        }
        field(8;"Days Applied";Integer)
        {

            trigger OnValidate()
            begin
                TestField("Start Date");
                "Return Date":=0D;
                //"Return Date":=FleetManagement.CalculateReturnDate("Start Date","Days Applied");
            end;
        }
        field(9;"Return Date";Date)
        {
            Caption = 'Return Date';
            Editable = false;
        }
        field(20;"Assigned Vehicle No.";Code[30])
        {

            trigger OnValidate()
            begin
                "Vehicle Registration":='';
                /*
                Vehicle.RESET;
                IF Vehicle.GET("Assigned Vehicle No.") THEN BEGIN
                  "Vehicle Registration":=Vehicle."Registration No.";
                END;
                */

            end;
        }
        field(21;"Vehicle Registration";Code[30])
        {
            Editable = false;
        }
        field(22;"Assigned Driver No.";Code[20])
        {
            TableRelation = Employee WHERE ("Job Title"=FILTER('DRIVER'|'HEAD DRIVER'));

            trigger OnValidate()
            begin
                "Driver Name":='';
                Employee.Reset;
                if Employee.Get("Assigned Driver No.") then begin
                  "Driver Name":=Employee."First Name"+' '+Employee."Last Name"+' '+Employee."Middle Name";
                end;
            end;
        }
        field(23;"Driver Name";Text[80])
        {
            Editable = false;
        }
        field(49;Description;Text[250])
        {
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
            TableRelation = "Responsibility Centers".Code;
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
          FleetSetup.TestField("Transport Request Nos");
          NoSeriesMgt.InitSeries(FleetSetup."Transport Request Nos",xRec."No. Series",0D,"No.","No. Series");
        end;
        "Document Date":=Today;
        "User ID":=UserId;
    end;

    var
        FleetSetup: Record "Human Resources Setup";
        Employee: Record Employee;
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

