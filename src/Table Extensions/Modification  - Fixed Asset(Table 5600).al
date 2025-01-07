tableextension 60455 tableextension60455 extends "Fixed Asset" 
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Location Code"(Field 9)".


        //Unsupported feature: Property Modification (Data type) on ""FA Location Code"(Field 10)".

        field(50000;"Registration No.";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50001;"Year of Manufacture";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002;"Logbook No.";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50003;"Body Type";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50004;"Color of  Body";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50005;"Propelled By";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50006;"Chasses No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50007;"Engine No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50008;"Asset Condition";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50009;"Purchase Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50010;"Asset No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50011;"I.D NO.";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50012;Dimension;Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50013;"Nature of Ownership";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50014;Supplier;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50015;"Transport Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Vehicle,MotorBike,Generator,Water Pump OM,Gas, Water Pump Lorry,Other';
            OptionMembers = " ",Vehicle,MotorBike,Generator,"Water Pump OM",Gas," Water Pump Lorry",Other;
        }
        field(50016;"Tyre Size";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50017;Make;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50018;"Specialized use of the vehicle";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50019;"Specialized system";Text[250])
        {
            Caption = 'Specialized system on the system';
            DataClassification = ToBeClassified;
        }
        field(50020;Insurance;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50021;"Booking Status";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Available,Booked,In Use,Under Repair';
            OptionMembers = " ",Available,Booked,"In Use","Under Repair";
        }
        field(50022;"Completion Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50023;"Date of disposal";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50024;Donated;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50025;"Organization that Donated";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50026;Quantity;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50027;Color;Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50028;Brand;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(52136923;"FA Tag No.";Code[50])
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
        }
        field(52136924;"Employee Name";Text[90])
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            Editable = false;
        }
        field(52136925;"Shortcut Dimension 3 Code";Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(52136926;"Shortcut Dimension 4 Code";Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(4),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(52136927;"Shortcut Dimension 5 Code";Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(5),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(52136928;"Shortcut Dimension 6 Code";Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(6),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(52136929;"Shortcut Dimension 7 Code";Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(7),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(52136930;"Shortcut Dimension 8 Code";Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(8),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(52136931;"FA Status";Option)
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            OptionCaption = 'Good,Fair,Faulty,Disposed,Under Maintenance';
            OptionMembers = Good,Fair,Faulty,Disposed,"Under Maintenance";
        }
        field(52136932;"FA Status Comment";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(52137932;"User ID";Code[50])
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon';
            Editable = false;
        }
        field(52137933;Model;Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(52137934;"Model No.";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(52137941;"Fuel Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Petrol,Diesel,Paraffin,Others,Oil,Gas';
            OptionMembers = " ",Petrol,Diesel,Paraffin,Others,Oil,Gas;
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "AssistEdit(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "FieldsForAcquitionInGeneralGroupAreCompleted(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "ShowAcquireWizardNotification(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "GetNotificationID(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "SetNotificationDefaultState(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "DontNotifyCurrentUserAgain(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "RecallNotificationForCurrentUser(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Fields) on "DropDown(FieldGroup 1)".

}

