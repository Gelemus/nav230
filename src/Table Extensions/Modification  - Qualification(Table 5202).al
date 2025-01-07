tableextension 60382 tableextension60382 extends Qualification
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on "Description(Field 2)".

        field(4; "Line No"; Integer)
        {
            //AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on "Code(Key)".

        // key(Key1;"Code","Line No")
        // {
        // }
    }
}

