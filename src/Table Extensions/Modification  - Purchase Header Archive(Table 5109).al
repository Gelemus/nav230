tableextension 60370 tableextension60370 extends "Purchase Header Archive" 
{
    fields
    {
        field(50000;"Reference No";Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50011;"Vendor Account No";Code[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "SetSecurityFilterOnRespCenter(PROCEDURE 5)".

}

