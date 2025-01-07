tableextension 60709 tableextension60709 extends "User Setup"
{
    fields
    {


        //Unsupported feature: Code Modification on ""Approver ID"(Field 11).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UserSetup.SetFilter("User ID",'<>%1',"User ID");
        if PAGE.RunModal(PAGE::"Approval User Setup",UserSetup) = ACTION::LookupOK then
          Validate("Approver ID",UserSetup."User ID");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //UserSetup.SETFILTER("User ID",'<>%1',"User ID"); //Frs161119 to be uncommented later
        if PAGE.RunModal(PAGE::"Approval User Setup",UserSetup) = ACTION::LookupOK then
          Validate("Approver ID",UserSetup."User ID");
        */
        //end;


        //Unsupported feature: Code Modification on ""Approver ID"(Field 11).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Approver ID" = "User ID" then
          FieldError("Approver ID");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //IF "Approver ID" = "User ID" THEN
        //  FIELDERROR("Approver ID");
        */
        //end;
        field(50000; "Employee No"; Code[20])

        {


            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(50001; "Vendor Creation"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Vendor Creation" then begin
                    Rec.SetRange("Vendor Creation", true);
                    if not Rec.IsEmpty then
                        FieldError("Vendor Creation");
                end;
            end;
        }
        field(50002; "Chart of Account Creation"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Chart of Account Creation" then begin
                    Rec.SetRange("Chart of Account Creation", true);
                    if not Rec.IsEmpty then
                        FieldError("Chart of Account Creation");
                end;
            end;
        }
        field(50003; "Bank Account  Creation"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Bank Account  Creation" then begin
                    Rec.SetRange("Bank Account  Creation", true);
                    if not Rec.IsEmpty then
                        FieldError("Bank Account  Creation");
                end;
            end;
        }
        field(50004; "Fixed Asset  Creation"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Fixed Asset  Creation" then begin
                    Rec.SetRange("Fixed Asset  Creation", true);
                    if not Rec.IsEmpty then
                        FieldError("Fixed Asset  Creation");
                end;
            end;
        }
        field(50005; "Employee Creation"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Employee Creation" then begin
                    Rec.SetRange("Employee Creation", true);
                    if not Rec.IsEmpty then
                        FieldError("Employee Creation");
                end;
            end;
        }

        field(52136923; "Re-Open Imprest Surrender"; Boolean)
        {

        }
        field(50006; "CreateLpo"; Boolean)

        {
            Caption = 'Lpo Creation';

        }


        field(52136924; "Post Leave Application"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136925; "ReOpen Purchase Requisition"; Boolean)

        {
            DataClassification = ToBeClassified;
        }
        field(52136950; "Reopen Documents"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136951; "Reversal Right"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136952; "Item Creation"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Item Creation" then begin
                    Rec.SetRange("Item Creation", true);
                    if not Rec.IsEmpty then
                        FieldError("Item Creation");
                end;
            end;
        }
        field(52136953; "Payroll Admin"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136980; "Receive Legal Notifications"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136981; "Receive ICT Notifications"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136982; "Give Access to Payroll"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Payroll;
        }
        field(52136983; "Payroll Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch" WHERE("Journal Template Name" = CONST('GENERAL'));
        }
        field(52136984; HOD; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(52136985; "View Imprest"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136986; "View Petty Cash"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136987; Signature; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(52136988; "Allow Multiple Imprest Request"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136989; CommitBudget; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52136990; ChangeProfile; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }

    //Unsupported feature: Property Modification (Attributes) on "CreateApprovalUserSetup(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "GetDefaultSalesAmountApprovalLimit(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "GetDefaultPurchaseAmountApprovalLimit(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "HideExternalUsers(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "CheckAllowedPostingDates(PROCEDURE 6)".

}

