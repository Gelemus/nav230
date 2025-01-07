tableextension 60723 tableextension60723 extends "Vendor Posting Group" 
{
    fields
    {

        //Unsupported feature: Code Modification on ""Payment Disc. Debit Acc."(Field 8).OnLookup".

        //trigger  Debit Acc()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Payment Disc. Debit Acc.")
            else
              GLAccountCategoryMgt.LookupGLAccount("Payment Disc. Debit Acc.",GLAccountCategory."Account Category"::Income,'');

            Validate("Payment Disc. Debit Acc.");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
              GLAccountCategoryMgt.LookupGLAccount("Payment Disc. Debit Acc.",GLAccountCategory."Account Category"::Revenue,'');

            Validate("Payment Disc. Debit Acc.");
            */
        //end;


        //Unsupported feature: Code Modification on ""Payment Disc. Debit Acc."(Field 8).OnValidate".

        //trigger  Debit Acc()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Payment Disc. Debit Acc.",false,false)
            else
              GLAccountCategoryMgt.CheckGLAccount("Payment Disc. Debit Acc.",false,false,GLAccountCategory."Account Category"::Income,'');
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
              GLAccountCategoryMgt.CheckGLAccount("Payment Disc. Debit Acc.",false,false,GLAccountCategory."Account Category"::Revenue,'');
            */
        //end;


        //Unsupported feature: Code Modification on ""Debit Curr. Appln. Rndg. Acc."(Field 10).OnLookup".

        //trigger  Appln()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Debit Curr. Appln. Rndg. Acc.")
            else
              GLAccountCategoryMgt.LookupGLAccount("Debit Curr. Appln. Rndg. Acc.",GLAccountCategory."Account Category"::Income,'');

            Validate("Debit Curr. Appln. Rndg. Acc.");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
              GLAccountCategoryMgt.LookupGLAccount("Debit Curr. Appln. Rndg. Acc.",GLAccountCategory."Account Category"::Revenue,'');

            Validate("Debit Curr. Appln. Rndg. Acc.");
            */
        //end;


        //Unsupported feature: Code Modification on ""Debit Curr. Appln. Rndg. Acc."(Field 10).OnValidate".

        //trigger  Appln()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Debit Curr. Appln. Rndg. Acc.",false,false)
            else
              GLAccountCategoryMgt.CheckGLAccount(
                "Debit Curr. Appln. Rndg. Acc.",false,false,GLAccountCategory."Account Category"::Income,'');
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
                "Debit Curr. Appln. Rndg. Acc.",false,false,GLAccountCategory."Account Category"::Revenue,'');
            */
        //end;


        //Unsupported feature: Code Modification on ""Credit Curr. Appln. Rndg. Acc."(Field 11).OnLookup".

        //trigger  Appln()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Credit Curr. Appln. Rndg. Acc.")
            else
              GLAccountCategoryMgt.LookupGLAccount("Credit Curr. Appln. Rndg. Acc.",GLAccountCategory."Account Category"::Income,'');

            Validate("Credit Curr. Appln. Rndg. Acc.");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
              GLAccountCategoryMgt.LookupGLAccount("Credit Curr. Appln. Rndg. Acc.",GLAccountCategory."Account Category"::Revenue,'');

            Validate("Credit Curr. Appln. Rndg. Acc.");
            */
        //end;


        //Unsupported feature: Code Modification on ""Credit Curr. Appln. Rndg. Acc."(Field 11).OnValidate".

        //trigger  Appln()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Credit Curr. Appln. Rndg. Acc.",false,false)
            else
              GLAccountCategoryMgt.CheckGLAccount(
                "Credit Curr. Appln. Rndg. Acc.",false,false,GLAccountCategory."Account Category"::Income,'');
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
                "Credit Curr. Appln. Rndg. Acc.",false,false,GLAccountCategory."Account Category"::Revenue,'');
            */
        //end;


        //Unsupported feature: Code Modification on ""Payment Disc. Credit Acc."(Field 16).OnLookup".

        //trigger  Credit Acc()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Payment Disc. Credit Acc.")
            else
              GLAccountCategoryMgt.LookupGLAccount("Payment Disc. Credit Acc.",GLAccountCategory."Account Category"::Income,'');

            Validate("Payment Disc. Credit Acc.");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
              GLAccountCategoryMgt.LookupGLAccount("Payment Disc. Credit Acc.",GLAccountCategory."Account Category"::Revenue,'');

            Validate("Payment Disc. Credit Acc.");
            */
        //end;


        //Unsupported feature: Code Modification on ""Payment Disc. Credit Acc."(Field 16).OnValidate".

        //trigger  Credit Acc()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Payment Disc. Credit Acc.",false,false)
            else
              GLAccountCategoryMgt.CheckGLAccount("Payment Disc. Credit Acc.",false,false,GLAccountCategory."Account Category"::Income,'');
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
              GLAccountCategoryMgt.CheckGLAccount("Payment Disc. Credit Acc.",false,false,GLAccountCategory."Account Category"::Revenue,'');
            */
        //end;


        //Unsupported feature: Code Modification on ""Payment Tolerance Debit Acc."(Field 17).OnLookup".

        //trigger "(Field 17)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Payment Tolerance Debit Acc.")
            else
              GLAccountCategoryMgt.LookupGLAccount(
                "Payment Tolerance Debit Acc.",GLAccountCategory."Account Category"::Income,GLAccountCategoryMgt.GetIncomeInterest);

            Validate("Payment Tolerance Debit Acc.");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
                "Payment Tolerance Debit Acc.",GLAccountCategory."Account Category"::Revenue,GLAccountCategoryMgt.GetIncomeInterest);

            Validate("Payment Tolerance Debit Acc.");
            */
        //end;


        //Unsupported feature: Code Modification on ""Payment Tolerance Debit Acc."(Field 17).OnValidate".

        //trigger "(Field 17)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Payment Tolerance Debit Acc.",false,false)
            else
              GLAccountCategoryMgt.CheckGLAccount(
                "Payment Tolerance Debit Acc.",false,false,
                GLAccountCategory."Account Category"::Income,GLAccountCategoryMgt.GetIncomeInterest);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..5
                GLAccountCategory."Account Category"::Revenue,GLAccountCategoryMgt.GetIncomeInterest);
            */
        //end;


        //Unsupported feature: Code Modification on ""Payment Tolerance Credit Acc."(Field 18).OnLookup".

        //trigger "(Field 18)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Payment Tolerance Credit Acc.")
            else
              GLAccountCategoryMgt.LookupGLAccount(
                "Payment Tolerance Credit Acc.",GLAccountCategory."Account Category"::Income,GLAccountCategoryMgt.GetIncomeInterest);

            Validate("Payment Tolerance Credit Acc.");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
                "Payment Tolerance Credit Acc.",GLAccountCategory."Account Category"::Revenue,GLAccountCategoryMgt.GetIncomeInterest);

            Validate("Payment Tolerance Credit Acc.");
            */
        //end;


        //Unsupported feature: Code Modification on ""Payment Tolerance Credit Acc."(Field 18).OnValidate".

        //trigger "(Field 18)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Payment Tolerance Credit Acc.",false,false)
            else
              GLAccountCategoryMgt.CheckGLAccount(
                "Payment Tolerance Credit Acc.",false,false,
                GLAccountCategory."Account Category"::Income,GLAccountCategoryMgt.GetIncomeInterest);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..5
                GLAccountCategory."Account Category"::Revenue,GLAccountCategoryMgt.GetIncomeInterest);
            */
        //end;
    }

    //Unsupported feature: Property Modification (Attributes) on "GetPayablesAccount(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "GetPmtDiscountAccount(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "GetPmtToleranceAccount(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "GetRoundingAccount(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "GetApplRoundingAccount(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "GetInvRoundingAccount(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "GetServiceChargeAccount(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "SetAccountVisibility(PROCEDURE 10)".

}

