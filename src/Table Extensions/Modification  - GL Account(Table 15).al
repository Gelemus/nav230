tableextension 60106 tableextension60106 extends "G/L Account" 
{
    fields
    {
        modify("Account Category")
        {
            OptionCaption = ' ,Assets,Liabilities,Equity,Revenue,Cost of Sales,Expense';

            //Unsupported feature: Property Modification (OptionString) on ""Account Category"(Field 8)".

        }

        //Unsupported feature: Code Modification on ""Account Category"(Field 8).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "Account Category" = "Account Category"::" " then
              exit;

            if "Account Category" in ["Account Category"::Income,"Account Category"::"Cost of Goods Sold","Account Category"::Expense] then
              "Income/Balance" := "Income/Balance"::"Income Statement"
            else
              "Income/Balance" := "Income/Balance"::"Balance Sheet";
            if "Account Category" <> xRec."Account Category" then
              "Account Subcategory Entry No." := 0;

            UpdateAccountCategoryOfSubAccounts;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
            if "Account Category" in ["Account Category"::Revenue,"Account Category"::"Cost of Sales","Account Category"::Expense] then
            #5..11
            */
        //end;
        field(50000;"Budget Controlled";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001;"Last Modified By";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50002;"Working Capital Ledger";Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }


    //Unsupported feature: Code Modification on "SetLastModifiedDateTime(PROCEDURE 39)".

    //procedure SetLastModifiedDateTime();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Last Modified Date Time" := CurrentDateTime;
        "Last Date Modified" := Today;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        "Last Modified Date Time" := CurrentDateTime;
        "Last Date Modified" := Today;
        "Last Modified By" := UserId;
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "IsTotaling(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckGLAcc(PROCEDURE 9)".

}

