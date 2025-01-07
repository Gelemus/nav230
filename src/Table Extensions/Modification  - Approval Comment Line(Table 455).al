tableextension 60321 tableextension60321 extends "Approval Comment Line" 
{
    fields
    {

        //Unsupported feature: Property Deletion (Editable) on ""Document No."(Field 4)".

        field(10;"Approved Days";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Approved Start Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12;"Approved Return Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13;Reason;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14;"Leave allowance Granted";Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        Evaluate("Table ID",GetFilter("Table ID"));
        Evaluate("Record ID to Approve",GetFilter("Record ID to Approve"));
        "User ID" := UserId;
        "Date and Time" := CreateDateTime(Today,Time);
        if "Entry No." = 0 then
          "Entry No." := GetNextEntryNo;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        Evaluate("Table ID",GetFilter("Table ID"));
        Evaluate("Record ID to Approve",GetFilter("Record ID to Approve"));
        Evaluate("Document No.", GetFilter("Document No."));
        #3..6
        */
    //end;
}

