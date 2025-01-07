tableextension 60726 tableextension60726 extends "G/L Budget Name" 
{
    fields
    {

        //Unsupported feature: Code Insertion on "Name(Field 1)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            "Procurement Plan No.":=Name;
            */
        //end;
        field(52136925;"Procurement Plan No.";Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }
}

