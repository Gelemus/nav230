table 56050 "ICT Helpdesk"
{

    fields
    {
        field(1; "Job No."; Code[10])
        {

            trigger OnValidate()
            begin
                /*
                Employee.RESET;
                Employee.SETFILTER(Employee."Emp UserID","Requesting Officer");
                
                IF Employee.FIND('-') THEN
                BEGIN
                  "Requesting Officer Name":=Employee."First Name" +' ' +Employee."Last Name";
                  Department:=Employee."Department Code";
                  Email:=Employee."Company E-Mail";
                  Phone:=Employee."Work Phone Number";
                  EXT :=Employee."Ext."
                END;
                
                DimValue.RESET;
                DimValue.SETFILTER(DimValue.Code,Department);
                DimValue.SETFILTER(DimValue."Global Dimension No.",'2');
                IF DimValue.FIND('-') THEN
                BEGIN
                  "Department Name":=DimValue.Name
                END;
                */

            end;
        }
        field(2; "Assigned To"; Code[50])
        {
            TableRelation = User."User Name";

            trigger OnLookup()
            begin
                //UserMngt.LookupUserID("Assigned To");
            end;

            trigger OnValidate()
            begin
                // UserMngt.ValidateUserID("Assigned To");
            end;
        }
        field(3; "Assigned Date"; Date)
        {
        }
        field(4; "Assigned Time"; Time)
        {
        }
        field(5; Department; Code[30])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(6; "Department Name"; Text[50])
        {
        }
        field(7; "Physical Station"; Text[30])
        {
        }
        field(8; "Nature of Service"; Text[50])
        {
        }
        field(9; EXT; Code[10])
        {
        }
        field(10; "Requesting Officer"; Code[50])
        {
        }
        field(11; "Requesting Officer Name"; Text[50])
        {
        }
        field(12; Phone; Code[30])
        {
        }
        field(13; Email; Text[30])
        {
        }
        field(14; "Request Date"; Date)
        {
        }
        field(15; "Request Time"; Time)
        {
        }
        field(16; "Computer not Starting up"; Boolean)
        {
        }
        field(17; "Keyboard, Mouse Failure"; Boolean)
        {
        }
        field(18; "Printer Failure"; Boolean)
        {
        }
        field(19; "UPS Failure"; Boolean)
        {
        }
        field(20; "LCD /Monitor Failure"; Boolean)
        {
        }
        field(21; "Storage Device Failure"; Boolean)
        {
        }
        field(22; "Hardware Installation"; Boolean)
        {
        }
        field(23; "Others, specify HW"; Text[200])
        {
        }
        field(24; "Computer Running /Loading Slow"; Boolean)
        {
        }
        field(25; "Network Access Problems"; Boolean)
        {
        }
        field(26; "Antivirus Inefficiency"; Boolean)
        {
        }
        field(27; Applications; Boolean)
        {
        }
        field(28; "Software Installation"; Boolean)
        {
        }
        field(29; "Others, specify SW"; Text[200])
        {
        }
        field(30; Diagnosis; Text[250])
        {
        }
        field(31; "Action Taken"; Text[250])
        {
        }
        field(32; "Attended By"; Code[50])
        {
        }
        field(33; "Attended Date"; Date)
        {
        }
        field(34; "Attended Time"; Time)
        {
        }
        field(35; "Technical Staff Remarks"; Text[200])
        {
        }
        field(36; "Requesting Officer Remarks"; Text[200])
        {
        }
        field(37; "Attended by Name"; Text[50])
        {
        }
        field(38; Status; Option)
        {
            OptionCaption = ' ,Pending,Assigned,Attended,Tech Commented,User Commented,Closed';
            OptionMembers = " ",Pending,Assigned,Attended,"Tech Commented","User Commented",Closed;
        }
        field(39; "No. Series"; Code[20])
        {
        }
        field(40; "ERP Issue"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Job No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert() 
    begin
        if "Job No." = '' then begin
            // SalesSetup.GET;
            //  SalesSetup.TESTFIELD(SalesSetup."ICT Helpdesk Nos.");
            //NoSeriesMgt.InitSeries(SalesSetup."ICT Helpdesk Nos.",xRec."No. Series",0D, "Job No.","No. Series");
        end;

        //"Requesting Officer":=UPPERCASE(USERID);

        /*UserSetup.RESET;
        UserSetup.SETFILTER(UserSetup."User ID",UPPERCASE(USERID));
        IF UserSetup.FIND('-') THEN
        BEGIN
          Employee.RESET;
          Employee.SETRANGE(Employee."No.",UserSetup."Employee No.");
          IF Employee.FIND('-')THEN
          BEGIN
            "Requesting Officer":=UPPERCASE(USERID);
            "Requesting Officer Name":=Employee."First Name"+' '+Employee."Middle Name"+' '+Employee."Last Name";
            Department:=Employee."Global Dimension 1 Code";
            Email:=Employee."Company E-Mail";
            Phone:=Employee."Work Phone Number";
            EXT :=Employee."Ext.";
            //"Physical Station":=Employee.Station;
            "Request Date":=TODAY;
            "Request Time":=TIME;
          END;
        END;*/


        DimValue.Reset;
        DimValue.SetFilter(DimValue.Code, Department);
        DimValue.SetFilter(DimValue."Global Dimension No.", '1');
        if DimValue.Find('-') then begin
            "Department Name" := DimValue.Name
        end;

    end;

    var
        Employee: Record Employee;
        DimValue: Record "Dimension Value";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalesSetup: Record "Sales & Receivables Setup";
        "user id": Record User;
        UserMngt: Codeunit "User Management";
        UserSetup: Record "User Setup";
}

