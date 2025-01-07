tableextension 60476 tableextension60476 extends "G/L Account Category" 
{
    fields
    {
        modify("Account Category")
        {
            OptionCaption = ',Assets,Liabilities,Equity,Revenue,Cost of Sales,Expense';

            //Unsupported feature: Property Modification (OptionString) on ""Account Category"(Field 7)".

        }

        //Unsupported feature: Code Modification on ""Account Category"(Field 7).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "Account Category" in ["Account Category"::Income,"Account Category"::"Cost of Goods Sold","Account Category"::Expense]
            then begin
              "Income/Balance" := "Income/Balance"::"Income Statement";
              "Additional Report Definition" := "Additional Report Definition"::" ";
            end else
              "Income/Balance" := "Income/Balance"::"Balance Sheet";
            if Description = '' then
              Description := Format("Account Category");
            UpdatePresentationOrder;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            if "Account Category" in ["Account Category"::Revenue,"Account Category"::"Cost of Sales","Account Category"::Expense]
            #2..9
            */
        //end;
    }

    //Unsupported feature: Property Modification (Attributes) on "UpdatePresentationOrder(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "UpdatePresentationOrder(PROCEDURE 4)".

    //procedure UpdatePresentationOrder();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        if "Entry No." = 0 then
          exit;
        GLAccountCategory := Rec;
        #4..16
            PresentationOrder := '1' + PresentationOrder;
          "Account Category"::Equity:
            PresentationOrder := '2' + PresentationOrder;
          "Account Category"::Income:
            PresentationOrder := '3' + PresentationOrder;
          "Account Category"::"Cost of Goods Sold":
            PresentationOrder := '4' + PresentationOrder;
          "Account Category"::Expense:
            PresentationOrder := '5' + PresentationOrder;
        end;
        "Presentation Order" := CopyStr(PresentationOrder,1,MaxStrLen("Presentation Order"));
        Modify;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..19
          "Account Category"::Revenue:
            PresentationOrder := '3' + PresentationOrder;
          "Account Category"::"Cost of Sales":
        #23..28
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "InitializeDataSet(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "InsertRow(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "MoveUp(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "MoveDown(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "MakeChildOfPreviousSibling(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "MakeSiblingOfParent(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "DeleteRow(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "MapAccounts(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateTotaling(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "LookupTotaling(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "PositiveNormalBalance(PROCEDURE 19)".



    //Unsupported feature: Code Modification on "PositiveNormalBalance(PROCEDURE 19)".

    //procedure PositiveNormalBalance();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        exit("Account Category" in ["Account Category"::Expense,"Account Category"::Assets,"Account Category"::"Cost of Goods Sold"]);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        exit("Account Category" in ["Account Category"::Expense,"Account Category"::Assets,"Account Category"::"Cost of Sales"]);
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "GetBalance(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "GetTotaling(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "OnGetBalanceOnAfterGetTotaling(PROCEDURE 18)".

}

