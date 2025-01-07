pageextension 60333 pageextension60333 extends "Employee Qualifications"
{
    layout
    {
        addafter("Qualification Code")
        {
            field(Qualification; Rec.Qualification)
            {
            }
        }
        addafter(Type)
        {
            field("Year of Graduation"; Rec."Year of Graduation")
            {
            }
        }
        moveafter("Qualification Code"; Description)
        moveafter(Description; "Institution/Company")
    }


    //Unsupported feature: Code Insertion on "OnInsertRecord".

    //trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    //begin
    /*
    "Document Type":= "Document Type"::qualification;
    */
    //end;


    //Unsupported feature: Code Insertion on "OnNewRecord".

    //trigger OnNewRecord(BelowxRec: Boolean)
    //begin
    /*
    "Document Type":= "Document Type"::qualification;
    */
    //end;


    //Unsupported feature: Code Insertion on "OnOpenPage".

    //trigger OnOpenPage()
    //begin
    /*
    "Document Type":= "Document Type"::qualification;
    */
    //end;
}

