tableextension 60214 tableextension60214 extends "General Posting Setup" 
{
    fields
    {

        //Unsupported feature: Code Modification on ""Sales Account"(Field 10).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Sales Account")
            else
              GLAccountCategoryMgt.LookupGLAccount(
                "Sales Account",GLAccountCategory."Account Category"::Income,
                StrSubstNo('%1|%2',GLAccountCategoryMgt.GetIncomeProdSales,GLAccountCategoryMgt.GetIncomeService));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
                "Sales Account",GLAccountCategory."Account Category"::Revenue,
                StrSubstNo('%1|%2',GLAccountCategoryMgt.GetIncomeProdSales,GLAccountCategoryMgt.GetIncomeService));
            */
        //end;


        //Unsupported feature: Code Modification on ""Sales Line Disc. Account"(Field 11).OnLookup".

        //trigger  Account"(Field 11)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Sales Line Disc. Account")
            else
              GLAccountCategoryMgt.LookupGLAccount(
                "Sales Line Disc. Account",GLAccountCategory."Account Category"::Income,
                GLAccountCategoryMgt.GetIncomeSalesDiscounts);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
                "Sales Line Disc. Account",GLAccountCategory."Account Category"::Revenue,
                GLAccountCategoryMgt.GetIncomeSalesDiscounts);
            */
        //end;


        //Unsupported feature: Code Modification on ""Sales Inv. Disc. Account"(Field 12).OnLookup".

        //trigger  Disc()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Sales Inv. Disc. Account")
            else
              GLAccountCategoryMgt.LookupGLAccount(
                "Sales Inv. Disc. Account",GLAccountCategory."Account Category"::Income,
                GLAccountCategoryMgt.GetIncomeSalesDiscounts);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
                "Sales Inv. Disc. Account",GLAccountCategory."Account Category"::Revenue,
                GLAccountCategoryMgt.GetIncomeSalesDiscounts);
            */
        //end;


        //Unsupported feature: Code Modification on ""Purch. Account"(Field 14).OnLookup".

        //trigger  Account"(Field 14)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Purch. Account")
            else
              GLAccountCategoryMgt.LookupGLAccount(
                "Purch. Account",GLAccountCategory."Account Category"::"Cost of Goods Sold",
                StrSubstNo('%1|%2',GLAccountCategoryMgt.GetCOGSMaterials,GLAccountCategoryMgt.GetCOGSLabor));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
                "Purch. Account",GLAccountCategory."Account Category"::"Cost of Sales",
                StrSubstNo('%1|%2',GLAccountCategoryMgt.GetCOGSMaterials,GLAccountCategoryMgt.GetCOGSLabor));
            */
        //end;


        //Unsupported feature: Code Modification on ""Purch. Line Disc. Account"(Field 15).OnLookup".

        //trigger  Line Disc()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Purch. Line Disc. Account")
            else
              GLAccountCategoryMgt.LookupGLAccount(
                "Purch. Line Disc. Account",GLAccountCategory."Account Category"::"Cost of Goods Sold",
                GLAccountCategoryMgt.GetCOGSDiscountsGranted);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
                "Purch. Line Disc. Account",GLAccountCategory."Account Category"::"Cost of Sales",
                GLAccountCategoryMgt.GetCOGSDiscountsGranted);
            */
        //end;


        //Unsupported feature: Code Modification on ""Purch. Inv. Disc. Account"(Field 16).OnLookup".

        //trigger  Inv()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Purch. Inv. Disc. Account")
            else
              GLAccountCategoryMgt.LookupGLAccount(
                "Purch. Inv. Disc. Account",GLAccountCategory."Account Category"::"Cost of Goods Sold",
                GLAccountCategoryMgt.GetCOGSDiscountsGranted);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
                "Purch. Inv. Disc. Account",GLAccountCategory."Account Category"::"Cost of Sales",
                GLAccountCategoryMgt.GetCOGSDiscountsGranted);
            */
        //end;


        //Unsupported feature: Code Modification on ""COGS Account"(Field 18).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.LookupGLAccountWithoutCategory("COGS Account")
            else
              GLAccountCategoryMgt.LookupGLAccount(
                "COGS Account",GLAccountCategory."Account Category"::"Cost of Goods Sold",
                StrSubstNo('%1|%2',GLAccountCategoryMgt.GetCOGSMaterials,GLAccountCategoryMgt.GetCOGSLabor));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
                "COGS Account",GLAccountCategory."Account Category"::"Cost of Sales",
                StrSubstNo('%1|%2',GLAccountCategoryMgt.GetCOGSMaterials,GLAccountCategoryMgt.GetCOGSLabor));
            */
        //end;


        //Unsupported feature: Code Modification on ""Inventory Adjmt. Account"(Field 19).OnLookup".

        //trigger  Account"(Field 19)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Inventory Adjmt. Account")
            else
              GLAccountCategoryMgt.LookupGLAccount(
                "Inventory Adjmt. Account",GLAccountCategory."Account Category"::"Cost of Goods Sold",
                StrSubstNo('%1|%2',GLAccountCategoryMgt.GetCOGSMaterials,GLAccountCategoryMgt.GetCOGSLabor));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
                "Inventory Adjmt. Account",GLAccountCategory."Account Category"::"Cost of Sales",
                StrSubstNo('%1|%2',GLAccountCategoryMgt.GetCOGSMaterials,GLAccountCategoryMgt.GetCOGSLabor));
            */
        //end;


        //Unsupported feature: Code Modification on ""Invt. Accrual Acc. (Interim)"(Field 5801).OnLookup".

        //trigger  Accrual Acc()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Inventory Adjmt. Account")
            else
              GLAccountCategoryMgt.LookupGLAccount(
                "Inventory Adjmt. Account",GLAccountCategory."Account Category"::"Cost of Goods Sold",
                StrSubstNo('%1|%2',GLAccountCategoryMgt.GetCOGSMaterials,GLAccountCategoryMgt.GetCOGSLabor));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
                "Inventory Adjmt. Account",GLAccountCategory."Account Category"::"Cost of Sales",
                StrSubstNo('%1|%2',GLAccountCategoryMgt.GetCOGSMaterials,GLAccountCategoryMgt.GetCOGSLabor));
            */
        //end;


        //Unsupported feature: Code Modification on ""COGS Account (Interim)"(Field 5803).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.LookupGLAccountWithoutCategory("COGS Account (Interim)")
            else
              GLAccountCategoryMgt.LookupGLAccount(
                "COGS Account (Interim)",GLAccountCategory."Account Category"::"Cost of Goods Sold",
                StrSubstNo('%1|%2',GLAccountCategoryMgt.GetCOGSMaterials,GLAccountCategoryMgt.GetCOGSLabor));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
                "COGS Account (Interim)",GLAccountCategory."Account Category"::"Cost of Sales",
                StrSubstNo('%1|%2',GLAccountCategoryMgt.GetCOGSMaterials,GLAccountCategoryMgt.GetCOGSLabor));
            */
        //end;
    }

    //Unsupported feature: Property Modification (Attributes) on "GetCOGSAccount(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "GetCOGSInterimAccount(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "GetInventoryAdjmtAccount(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "GetInventoryAccrualAccount(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "GetSalesAccount(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "GetSalesCrMemoAccount(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "GetSalesInvDiscAccount(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "GetSalesLineDiscAccount(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "GetSalesPmtDiscountAccount(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "GetSalesPmtToleranceAccount(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "GetSalesPrepmtAccount(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "GetPurchAccount(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "GetPurchCrMemoAccount(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "GetPurchInvDiscAccount(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "GetPurchLineDiscAccount(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "GetPurchPmtDiscountAccount(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "GetPurchPmtToleranceAccount(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "GetPurchPrepmtAccount(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "GetPurchFADiscAccount(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "GetDirectCostAppliedAccount(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "GetOverheadAppliedAccount(PROCEDURE 20)".


    //Unsupported feature: Property Modification (Attributes) on "GetPurchaseVarianceAccount(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "SetAccountsVisibility(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "SuggestSetupAccounts(PROCEDURE 26)".

}

