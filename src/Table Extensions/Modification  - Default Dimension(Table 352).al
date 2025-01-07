tableextension 60270 tableextension60270 extends "Default Dimension" 
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""No."(Field 2)".


        //Unsupported feature: Property Modification (Data type) on ""Dimension Code"(Field 3)".


        //Unsupported feature: Property Modification (Data type) on ""Dimension Value Code"(Field 4)".


        //Unsupported feature: Code Modification on ""Table ID"(Field 1).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CalcFields("Table Caption");
            DimMgt.DefaultDimObjectNoList(TempAllObjWithCaption);
            TempAllObjWithCaption."Object Type" := TempAllObjWithCaption."Object Type"::Table;
            TempAllObjWithCaption."Object ID" := "Table ID";
            if not TempAllObjWithCaption.Find then
              FieldError("Table ID");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
            {IF NOT TempAllObjWithCaption.FIND THEN
              FIELDERROR("Table ID");}
            */
        //end;
    }

    //Unsupported feature: Property Modification (Attributes) on "GetCaption(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateGlobalDimCode(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateReferencedIds(PROCEDURE 13)".

}

