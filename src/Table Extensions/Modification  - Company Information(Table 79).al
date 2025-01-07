tableextension 60655 tableextension60655 extends "Company Information"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Address 2"(Field 5)".


        //Unsupported feature: Property Modification (Data type) on ""Phone No."(Field 7)".

        field(50000; "Fleet Manager Support E-Mail"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "PWD Age"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Permanet Age"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(52136720; "Managing Agent"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(52136923; "Company Data Directory Path"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'Sysre';
        }
        field(52136924; "NSSF No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Sysre';
        }
        field(52136925; "NHIF No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Sysre';
        }
        field(52136926; "Telephone No."; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Sysre';
            ExtendedDatatype = PhoneNo;
        }
        field(52136927; "Company PIN"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(52136928; "E-Mail 2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(52136929; "Picture 2"; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;

            trigger OnValidate()
            begin
                //  PictureUpdated := true;
            end;
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "CheckIBAN(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "DisplayMap(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "GetRegistrationNumber(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "GetRegistrationNumberLbl(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "GetVATRegistrationNumber(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "GetVATRegistrationNumberLbl(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "GetLegalOffice(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "GetLegalOfficeLbl(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustomGiro(PROCEDURE 20)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustomGiroLbl(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "VerifyAndSetPaymentInfo(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "GetSystemIndicator(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "GetCountryRegionCode(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "GetCompanyCountryRegionCode(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "GetDevBetaModeTxt(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "GetContactUsText(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "IsSyncEnabledForOtherCompany(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetSystemIndicator(PROCEDURE 24)".

}

