table 50210 "Transport Request"
{
    LookupPageID = "Allocated Vehicle List";

    fields
    {
        field(1; "Request No."; Code[30])
        {
        }
        field(2; "Request Date"; Date)
        {
        }
        field(3; "Request ID"; Code[30])
        {
        }
        field(4; "Employee No."; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Empl.Get("Employee No.") then begin
                    "Employee Name" := Empl."First Name" + ' ' + Empl."Middle Name" + ' ' + Empl."Last Name";
                    "Employee No." := "Employee No.";
                    Designation := Empl."Job Title";
                    "Request ID" := Empl."User ID";
                    "Global Dimension 1 Code" := Empl."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := Empl."Global Dimension 2 Code";
                    "Job No" := Empl."Job Title";
                end;
            end;
        }
        field(5; "Employee Name"; Text[50])
        {
        }
        field(6; "Trip Planned Start Date"; Date)
        {

            trigger OnValidate()
            begin
                //MESSAGE('message here');
            end;
        }
        field(7; "Trip Planned End Date"; Date)
        {
        }
        field(8; Destination; Text[250])
        {
        }
        field(9; "Geographical Terrain"; Text[30])
        {
        }
        field(10; "No. of Personnel"; Integer)
        {
            CalcFormula = Count("Travelling Employee" WHERE("Request No." = FIELD("Request No."),
                                                             "Employee No." = FILTER(<> '')));
            FieldClass = FlowField;
        }
        field(11; "Predicted Weather Conditions"; Text[30])
        {
        }
        field(12; "Vehicle Allocated"; Code[30])
        {
            TableRelation = "Fixed Asset";

            trigger OnValidate()
            begin
                /*IF Status<>Status::Released THEN
                ERROR('You are not allowed to assign a vehicle when the transport request has not been approved');
                  */


                if FA.Get("Vehicle Allocated") then begin
                    "Vehicle Description" := FA.Description;
                    Make := FA.Make;
                    // "Vehicle Allocated":="Vehicle Description";
                    //FA.CALCFIELDS(FA."In Use");
                    //IF FA."In Use" THEN
                    //ERROR('This vehicle is currently un-available');
                end;



            end;
        }
        field(13; "Outsourced Vehicle Reg No."; Code[10])
        {
        }
        field(14; "Vehicle Owner"; Code[20])
        {
            TableRelation = Vendor;
        }
        field(15; "Odometer Reading Before"; Decimal)
        {

            trigger OnValidate()
            begin
                Mantainance.Reset;
                Mantainance.SetRange(Mantainance."Vehicle No.", "Vehicle Allocated");
                if Mantainance.Find('+') then begin
                    if "Odometer Reading Before" >= (Mantainance."Actual Mileage KM" + Mantainance."Service Mileage KM") then begin
                        CompanyInfo.Get();
                        Recipients := CompanyInfo."Fleet Manager Support E-Mail";
                        CompanyInfo.Get();
                        SenderName := CompanyName;
                        SenderAddress := CompanyInfo."E-Mail";
                        Subject := 'Vehicle Mantainace ' + "Vehicle Allocated";
                        Body := StrSubstNo('This is to notify you that the Vehicle No. %1 is due for servicing', "Vehicle Allocated");
                        // SMTPSetup.CreateMessage(SenderName, SenderAddress, Recipients, Subject, Body, true);
                        //SMTPSetup.Send;

                    end;
                end;
            end;
        }
        field(16; "Odometer Reading After"; Decimal)
        {

            trigger OnValidate()
            begin
                Mantainance.Reset;
                Mantainance.SetRange(Mantainance."Vehicle No.", "Vehicle Allocated");
                if Mantainance.Find('+') then begin
                    if "Odometer Reading Before" >= (Mantainance."Actual Mileage KM" + Mantainance."Service Mileage KM") then begin
                        CompanyInfo.Get();
                        Recipients := CompanyInfo."Fleet Manager Support E-Mail";
                        CompanyInfo.Get();
                        SenderName := CompanyName;
                        SenderAddress := CompanyInfo."E-Mail";
                        Subject := 'Vehicle Mantainace ' + "Vehicle Allocated";
                        Body := StrSubstNo('This is to notify you that the Vehicle No. %1 is due for servicing', "Vehicle Allocated");
                        //SMTPSetup.CreateMessage(SenderName, SenderAddress, Recipients, Subject, Body, true);
                        //SMTPSetup.Send;

                    end;
                end
            end;
        }
        field(17; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(18; Country; Code[10])
        {
        }
        field(19; "Town/City"; Code[10])
        {
        }
        field(20; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Rejected,Allocated,Completed;
        }
        field(21; "No. of Approvals"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID" = CONST(50210),
                                                        "Document No." = FIELD("Request No.")));
            FieldClass = FlowField;
        }
        field(22; "Reason for Travel"; Text[250])
        {
        }
        field(23; "Start Date"; Date)
        {
        }
        field(24; "Return Date"; Date)
        {
        }
        field(25; "Start Time"; Time)
        {
        }
        field(26; "Return Time"; Time)
        {
        }
        field(27; "Vehicle Description"; Text[80])
        {
        }
        field(28; "User ID"; Code[30])
        {
        }
        field(29; "Travel Details"; Text[250])
        {
        }
        field(30; Driver; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                /* IF Status<>Status::Released THEN
                 ERROR('You are not allowed to assign a driver when the transport request has not been approved');
                 */
                if Empl.Get(Driver) then
                    // BEGIN
                    "Driver Name" := Empl."First Name" + ' ' + Empl."Middle Name" + ' ' + Empl."Last Name";

                // TESTFIELD("Vehicle Allocated");

                TravellingEmployees.Reset;
                TravellingEmployees.SetRange(TravellingEmployees."Request No.", "Request No.");
                if TravellingEmployees.Find('-') then begin
                    repeat
                        UserSetup.Reset;
                        UserSetup.SetRange(UserSetup."Employee No", TravellingEmployees."Employee No.");
                        if UserSetup.Find('-') then begin
                            UserSetup.TestField(UserSetup."E-Mail");
                            Recipients := UserSetup."E-Mail";

                            CompanyInfo.Get();
                            SenderName := CompanyName;
                            SenderAddress := CompanyInfo."Fleet Manager Support E-Mail";

                            Subject := 'Vehicle Allocation for Transport Request ' + "Request No.";
                            Body := 'This is to inform you that you have been allocated Vehicle No ' + "Vehicle Allocated" + ', ' + "Vehicle Description" + ' and Driver ' + "Driver Name" + ' for the trip to ' + Destination;
                            //SMTPSetup.CreateMessage(SenderName, SenderAddress, Recipients, Subject, Body, true);
                            //SMTPSetup.Send;
                        end;
                    until TravellingEmployees.Next = 0;
                end;

            end;
        }
        field(31; "Driver Name"; Text[50])
        {
        }
        field(32; Taxi; Text[50])
        {

            trigger OnValidate()
            begin
                if Status <> Status::Released then
                    Error('You are not allowed to assign a Taxi when the transport request has not been approved');



                TravellingEmployees.Reset;
                TravellingEmployees.SetRange(TravellingEmployees."Request No.", "Request No.");
                if TravellingEmployees.Find('-') then begin
                    repeat
                        UserSetup.Reset;
                        UserSetup.SetRange(UserSetup."Employee No", TravellingEmployees."Employee No.");
                        if UserSetup.Find('-') then begin
                            UserSetup.TestField(UserSetup."E-Mail");
                            Recipients := UserSetup."E-Mail";

                            CompanyInfo.Get();
                            SenderName := CompanyName;
                            SenderAddress := CompanyInfo."Fleet Manager Support E-Mail";

                            Subject := 'Vehicle Allocation for Transport Request ' + "Request No.";
                            Body := 'This is to inform you that you have been allocated ' + Taxi + ' for the trip to ' + Destination;
                            //SMTPSetup.CreateMessage(SenderName, SenderAddress, Recipients, Subject, Body, true);
                            //SMTPSetup.Send;
                        end;
                    until TravellingEmployees.Next = 0;
                end;
            end;
        }
        field(33; Cancelled; Boolean)
        {
        }
        field(34; "No. of Non Employees"; Integer)
        {
            FieldClass = Normal;
        }
        field(35; Allocated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Type of Request"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Routine,Planned,Emergency';
            OptionMembers = " ",Routine,Planned,Emergency;
        }
        field(37; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
                //Delete the previous dimensions
                //"Global Dimension 2 Code":='';
                //"Shortcut Dimension 3 Code":='';
                /*
                "Shortcut Dimension 4 Code":='';
                "Shortcut Dimension 5 Code":='';
                "Shortcut Dimension 6 Code":='';
                "Shortcut Dimension 7 Code":='';
                "Shortcut Dimension 8 Code":='';
                
                ImprestLine.RESET;
                ImprestLine.SETRANGE(ImprestLine."Document No.","No.");
                IF ImprestLine.FINDSET THEN BEGIN
                  REPEAT
                   // ImprestLine."Global Dimension 2 Code":='';
                    //ImprestLine."Shortcut Dimension 3 Code":='';
                    ImprestLine."Shortcut Dimension 4 Code":='';
                    ImprestLine."Shortcut Dimension 5 Code":='';
                    ImprestLine."Shortcut Dimension 6 Code":='';
                    ImprestLine."Shortcut Dimension 7 Code":='';
                    ImprestLine."Shortcut Dimension 8 Code":='';
                    ImprestLine.MODIFY;
                  UNTIL ImprestLine.NEXT=0;
                END;
                //End delete the previous dimensions
                
                ImprestLine.RESET;
                ImprestLine.SETRANGE(ImprestLine."Document No.","No.");
                IF ImprestLine.FINDSET THEN BEGIN
                  REPEAT
                    ImprestLine."Global Dimension 1 Code":="Global Dimension 1 Code";
                    ImprestLine.MODIFY;
                  UNTIL ImprestLine.NEXT=0;
                END;
                */

            end;
        }
        field(38; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(39; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(40; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(41; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(42; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(43; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(44; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(45; "No. of Non Staff Employees"; Integer)
        {
            FieldClass = Normal;
        }
        field(46; "Created By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Project Request,Feasibility Study,Concept Design,Design Plan,Project Implementation,Proposal,Repair Order,Safari Notice,Handover Notes,Pre-Trip,Post-Trip';
            OptionMembers = " ","Project Request","Feasibility Study","Concept Design","Design Plan","Project Implementation",Proposal,"Repair Order","Safari Notice","Handover Notes","Pre-Trip","Post-Trip";
        }
        field(48; "P.Nature of Request"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Sewer Line Extension,Water Pipeline Extension,Water Supply Project,Sewer Network Project,Contruction Works,Others';
            OptionMembers = " ","Sewer Line Extension","Water Pipeline Extension","Water Supply Project","Sewer Network Project","Contruction Works",Others;
        }
        field(49; "P.Request Reason"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Extend to new customers","Solve Pressure Issues","Replace a dilapidated line","New construction","Repair of existing masonry/concrete chamber/manhole/kiosk",Others;
        }
        field(50; "P.No of Customer to Connect"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "P.Ppe Diameter"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(52; "P.No Of Manholes"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "P.Other Information"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(54; "P.Job No"; Code[20])
        {
            FieldClass = Normal;
            TableRelation = Job."No.";
        }
        field(55; "P.Job Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Proposed Offtake Pressure"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Length of Proposed Line"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Elevation At Required Points"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Description Of Housing"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Verification Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Data Collection Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Data Collected By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(63; "Design Submitted by"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(64; "Project No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transport Request"."Request No." WHERE("Document Type" = CONST("Project Request"),
                                                                     Status = CONST(Released));

            trigger OnValidate()
            begin
                if TransportRequest.Get("Project No") then begin
                    "P.Job No" := TransportRequest."P.Job No";
                    Description := TransportRequest.Description;
                    Validate("Employee No.", TransportRequest."Employee No.");
                    Validate("Supervisor No.", TransportRequest."Supervisor No.");
                    Validate("P.Job No");
                end;
            end;
        }
        field(65; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(66; "Study Submited"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(67; "Design Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(68; "External Designer Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Design External No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Design Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(71; "Implementation Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(72; "Implementation End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(73; "Contructor Notes"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(74; "Supervisor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                Empl.Reset;
                if Empl.Get("Supervisor No.") then
                    "Supervisor Name" := Empl."First Name" + ' ' + Empl."Middle Name" + ' ' + Empl."Last Name";
                "Supervisor No." := "Supervisor No.";
            end;
        }
        field(75; "Supervisor Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(76; "Proposal Document Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(102; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';
            DataClassification = ToBeClassified;
        }
        field(103; "Project Financier"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(104; Contractor; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(105; "Reporting Period - Start"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(106; "Reporting Period - End"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(107; "Construction Start date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(108; "Construction Completion date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(109; "Project Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Ongoing,At Procurement Stage,At Proposal stage,At Implementation Stage,Completed,Cancelled';
            OptionMembers = " ",Ongoing,"At Procurement Stage","At Proposal stage","At Implementation Stage",Completed,Cancelled;
        }
        field(110; "% of works done per bill item"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(111; Location; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(112; "Contract Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(113; "Deriveries on Site"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(114; "Project Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(115; "Project Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(116; "Defects Liability Period"; DateFormula)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Format("Construction Completion date") = '' then begin
                    "Expected End of DLP" := 0D
                end else begin
                    TestField("Construction Start date");
                    "Expected End of DLP" := (CalcDate("Defects Liability Period", "Construction Start date") - 1);
                end;
            end;
        }
        field(117; "Expected End of DLP"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(118; "Action Plan No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transport Request"."Request No." WHERE("Document Type" = CONST("Design Plan"),
                                                                     "Project No" = FIELD("Project No"));

            trigger OnValidate()
            begin
                if TransportRequest.Get("Project No") then begin
                    "P.Job No" := TransportRequest."P.Job No";
                    Description := TransportRequest.Description;
                    Validate("Employee No.", TransportRequest."Employee No.");
                    Validate("Supervisor No.", TransportRequest."Supervisor No.");
                    Validate("P.Job No");
                end;
            end;
        }
        field(119; Comments; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(120; "Allocate a Vehicle"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(121; "Supplier No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if VendorRec.Get("Supplier No") then begin
                    "Supplier Address" := VendorRec.Address;
                    "Supplier Name" := VendorRec.Name;
                end;
            end;
        }
        field(122; "Supplier Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(123; "Supplier Address"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(124; "Vehicle No"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset";

            trigger OnValidate()
            begin
                FA.Reset;
                FA.SetRange("No.", "Vehicle No");
                if FA.FindSet then begin
                    "Vehicle Name" := FA.Description;
                end;
            end;
        }
        field(125; "Vehicle Name"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(126; "Job No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(127; "Motor Vehicle/Motor Cycle"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Motor Vehicle,Motor Cycle';
            OptionMembers = " ","Motor Vehicle","Motor Cycle";
        }
        field(128; "Repair Order"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(129; Designation; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(130; "Where Stationed"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(131; "Number of Night away"; Decimal)
        {
            Caption = 'Number of Night away From Station';
            DataClassification = ToBeClassified;
        }
        field(132; "Safari Notice"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(133; "Financial Year"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Financial Year";
        }
        field(134; "Private/Public/Official Car"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Private,Public,Official Car';
            OptionMembers = " ",Private,Public,"Official Car";
        }
        field(135; "Driver 1 Fixed Asset"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(136; "Driver 1 Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Empl.Get("Employee No.") then begin
                    "Employee Name" := Empl."First Name" + ' ' + Empl."Middle Name" + ' ' + Empl."Last Name";
                    "Employee No." := "Employee No.";
                    Designation := Empl."Job Title";
                end;
            end;
        }
        field(137; "Driver 1 Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(138; "Driver 1 Vehicle Reg No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(139; "Driver 1 Start Miles"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(140; "Driver 2 Fixed Asset"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(141; "Driver 2 Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Empl.Get("Employee No.") then begin
                    "Employee Name" := Empl."First Name" + ' ' + Empl."Middle Name" + ' ' + Empl."Last Name";
                    "Employee No." := "Employee No.";
                    Designation := Empl."Job Title";
                end;
            end;
        }
        field(142; "Driver 2 Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(143; "Driver 2 Vehicle Reg No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(144; "Driver 2 Start Miles"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(145; "Pre-Trip"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(146; "Post-Trip"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(147; Mileage; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(148; "Last Fueling (Lts)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(149; "Issue Voucher"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(150; "Last Service KMS:"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(151; "Next Service at:"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(152; Battery; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(153; "Battery Comment"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(154; Jack; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(155; "Jack Comments"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(156; "Wheel Spanner"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(157; "Wheel Spanner Comments"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(158; "Fire Extinguisher"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(159; "Fire Extinguisher Comments"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(160; "First Aid Kit"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(161; "First Aid Kit Cooments"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(162; "Radio/Cassette"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(163; "Radio/Cassette Comments"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(164; "Fuel Gauge"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(165; "Fuel Gauge Comments"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(166; "Speedo Meter Cable"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(167; "Speedo Meter Cable Comments"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(168; Headlights; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Working, Not Working';
            OptionMembers = " ",Working," Not Working";
        }
        field(169; "Headlights Comments"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(170; Indicator; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Working, Not Working';
            OptionMembers = " ",Working," Not Working";
        }
        field(171; "Indicator Comments"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(172; "Hazard Lights"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Working, Not Working';
            OptionMembers = " ",Working," Not Working";
        }
        field(173; "Hazard Lights Comments"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(174; "Hand Break"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Working, Not Working';
            OptionMembers = " ",Working," Not Working";
        }
        field(175; "Hand Break Comments"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(176; "Tyres Type"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(177; "Front Right"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(178; "Front Left"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(179; "Rear Right"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(180; "Rear Left"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(181; "Spare Wheel Nos"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(182; "Mechanical Problem"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(183; Dents; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(184; "Driving Mirrors"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(185; Scratches; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(186; "Handing Over By No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Empl.Get("Handing Over By No") then begin
                    "Handing Over By" := Empl."First Name" + ' ' + Empl."Middle Name" + ' ' + Empl."Last Name";
                    "Handing Over Designation" := Empl."Job Title";
                    "Handing over Date" := Today;
                    "Handing over Time" := Time;
                end;
            end;
        }
        field(187; "Handing Over By"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(188; "Handing Over Designation"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(189; "Taking Over By No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Empl.Get("Taking Over By No") then begin
                    "Taking Over By" := Empl."First Name" + ' ' + Empl."Middle Name" + ' ' + Empl."Last Name";
                    "Taking Over Designation" := Empl."Job Title";
                    "Taking Over Date" := Today;
                    "Taking Over Time" := Time;
                end;
            end;
        }
        field(190; "Taking Over By"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(191; "Taking Over Designation"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(192; "Witnessed By No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Empl.Get("Witnessed By No") then begin
                    "Witnessed By Name" := Empl."First Name" + ' ' + Empl."Middle Name" + ' ' + Empl."Last Name";
                    "Date Witnessed" := Today;
                    TimeWitnessed := Time;
                end;
            end;
        }
        field(193; "Witnessed By Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'o';
        }
        field(194; "Date Witnessed"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(195; TimeWitnessed; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(196; "Handing over Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(197; "Handing over Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(198; "Taking Over Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(199; "Taking Over Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(200; "Engine Oil"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Fuull,Half,Maximum,Low,Empty';
            OptionMembers = " ",Fuull,Half,Maximum,Low,Empty;
        }
        field(201; Make; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(202; "Classes Of Driving License"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '   ,B1,BC,E(FG)';
            OptionMembers = "   ",B1,BC,"E(FG)";
        }
        field(203; "Driver Allocation Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Available,Allocated,On Safari,Not on Duty';
            OptionMembers = " ",Available,Allocated,"On Safari","Not on Duty";
        }
        field(204; "Total Amount"; Decimal)
        {
            CalcFormula = Sum("Travelling Employee".Amount WHERE("Request No." = FIELD("Request No.")));
            FieldClass = FlowField;
        }
        field(205; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(206; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Request No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Request No.", Destination, "Reason for Travel")
        {
        }
    }

    trigger OnDelete()
    begin
        if Status <> Status::Open then
            Error('You cannot delete a document that is already approved or pending approval');
    end;

    trigger OnInsert()
    begin

        if "Request No." = '' then begin
            HumanResSetup.Get;
            if "Document Type" = "Document Type"::" " then begin
                HumanResSetup.TestField(HumanResSetup."Transport Request Nos");
                NoSeriesMgt.InitSeries(HumanResSetup."Transport Request Nos", xRec."No. Series", 0D, "Request No.", "No. Series");
            end else if "Document Type" = "Document Type"::"Project Request" then begin
                HumanResSetup.TestField(HumanResSetup."Project Request Nos");
                NoSeriesMgt.InitSeries(HumanResSetup."Project Request Nos", xRec."No. Series", 0D, "Request No.", "No. Series");
            end else if "Document Type" = "Document Type"::"Feasibility Study" then begin
                HumanResSetup.TestField(HumanResSetup."Project FeasibilityStudy Nos");
                NoSeriesMgt.InitSeries(HumanResSetup."Project FeasibilityStudy Nos", xRec."No. Series", 0D, "Request No.", "No. Series");
            end else if "Document Type" = "Document Type"::"Design Plan" then begin
                HumanResSetup.TestField(HumanResSetup."Project Implementation Nos");
                NoSeriesMgt.InitSeries(HumanResSetup."Project Implementation Nos", xRec."No. Series", 0D, "Request No.", "No. Series");
            end else if "Document Type" = "Document Type"::"Safari Notice" then begin
                HumanResSetup.TestField(HumanResSetup."Safari Notice Nos");
                NoSeriesMgt.InitSeries(HumanResSetup."Safari Notice Nos", xRec."No. Series", 0D, "Request No.", "No. Series");
            end else if "Document Type" = "Document Type"::"Repair Order" then begin
                HumanResSetup.TestField(HumanResSetup."Repair Order Nos");
                NoSeriesMgt.InitSeries(HumanResSetup."Repair Order Nos", xRec."No. Series", 0D, "Request No.", "No. Series");

                //added on 4/4/2022
            end else if "Document Type" = "Document Type"::"Handover Notes" then begin
                HumanResSetup.TestField(HumanResSetup."Handover Notes Nos");
                NoSeriesMgt.InitSeries(HumanResSetup."Handover Notes Nos", xRec."No. Series", 0D, "Request No.", "No. Series");
            end else if "Document Type" = "Document Type"::"Post-Trip" then begin
                HumanResSetup.TestField(HumanResSetup."Post-Trip Nos");
                NoSeriesMgt.InitSeries(HumanResSetup."Post-Trip Nos", xRec."No. Series", 0D, "Request No.", "No. Series");
            end else if "Document Type" = "Document Type"::"Pre-Trip" then begin
                HumanResSetup.TestField(HumanResSetup."Pre-Trip Nos");
                NoSeriesMgt.InitSeries(HumanResSetup."Pre-Trip Nos", xRec."No. Series", 0D, "Request No.", "No. Series");

            end else begin
                HumanResSetup.TestField(HumanResSetup."Project Nos.");
                NoSeriesMgt.InitSeries(HumanResSetup."Project Nos.", xRec."No. Series", 0D, "Request No.", "No. Series");

            end;
        end;
        "Request Date" := Today;
        "Request ID" := UserId;
        if UserSetup.Get(UserId) then begin
            if Empl.Get(UserSetup."Employee No") then begin
                "Employee Name" := Empl."First Name" + ' ' + Empl."Middle Name" + ' ' + Empl."Last Name";
                "User ID" := UserId;
                Designation := Empl."Job Title";
            end;
            // "Employee No.":=UserSetup."Employee No";
        end;

        "No." := "Request No.";
        "Posting Date" := Today;
    end;

    var
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        Empl: Record Employee;
        FA: Record "Fixed Asset";
        Mail: Codeunit Mail;
        MailSent: Boolean;
        Subject: Text[250];
        Body: Text[250];
        Recipients: Text[50];
        CName: Text[50];
        // SMTPSetup: Codeunit "SMTP Mail";
        CompanyInfo: Record "Company Information";
        TravellingEmployees: Record "Travelling Employee";
        SenderName: Text[50];
        SenderAddress: Text[50];
        ToName: Text[50];
        Mantainance: Record "Maintanance and Repair";
        Job: Record Job;
        TransportRequest: Record "Transport Request";
        VendorRec: Record Vendor;

    local procedure TestStatusOpen(AllowApproverEdit: Boolean)
    var
        ApprovalEntry: Record "Approval Entry";
        TransportRequestRec: Record "Transport Request";
    begin
        if TransportRequestRec.Get("Request No.") then begin
            if AllowApproverEdit then begin
                ApprovalEntry.Reset;
                ApprovalEntry.SetRange(ApprovalEntry."Document No.", TransportRequestRec."Request No.");
                ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
                ApprovalEntry.SetRange(ApprovalEntry."Approver ID", UserId);
                if not ApprovalEntry.FindFirst then begin
                    TransportRequestRec.TestField(Status, TransportRequestRec.Status::Open);
                end;
            end else begin
                TransportRequestRec.TestField(Status, TransportRequestRec.Status::Open);
            end;
        end;
    end;
}

