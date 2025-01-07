tableextension 60722 tableextension60722 extends "Customer Posting Group" 
{
    fields
    {

        //Unsupported feature: Code Modification on ""Service Charge Acc."(Field 7).OnLookup".

        //trigger "(Field 7)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Service Charge Acc.")
            else
              GLAccountCategoryMgt.LookupGLAccount(
                "Service Charge Acc.",GLAccountCategory."Account Category"::Income,GLAccountCategoryMgt.GetIncomeService);

            Validate("Service Charge Acc.");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
                "Service Charge Acc.",GLAccountCategory."Account Category"::Revenue,GLAccountCategoryMgt.GetIncomeService);

            Validate("Service Charge Acc.");
            */
        //end;


        //Unsupported feature: Code Modification on ""Service Charge Acc."(Field 7).OnValidate".

        //trigger "(Field 7)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Service Charge Acc.",true,true)
            else
              GLAccountCategoryMgt.CheckGLAccount(
                "Service Charge Acc.",true,true,GLAccountCategory."Account Category"::Income,GLAccountCategoryMgt.GetIncomeService);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
                "Service Charge Acc.",true,true,GLAccountCategory."Account Category"::Revenue,GLAccountCategoryMgt.GetIncomeService);
            */
        //end;


        //Unsupported feature: Code Modification on ""Invoice Rounding Account"(Field 9).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Invoice Rounding Account")
            else
              GLAccountCategoryMgt.LookupGLAccount("Invoice Rounding Account",GLAccountCategory."Account Category"::Income,'');

            Validate("Invoice Rounding Account");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
              GLAccountCategoryMgt.LookupGLAccount("Invoice Rounding Account",GLAccountCategory."Account Category"::Revenue,'');

            Validate("Invoice Rounding Account");
            */
        //end;


        //Unsupported feature: Code Modification on ""Invoice Rounding Account"(Field 9).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Invoice Rounding Account",true,false)
            else
              GLAccountCategoryMgt.CheckGLAccount("Invoice Rounding Account",true,false,GLAccountCategory."Account Category"::Income,'');
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
              GLAccountCategoryMgt.CheckGLAccount("Invoice Rounding Account",true,false,GLAccountCategory."Account Category"::Revenue,'');
            */
        //end;


        //Unsupported feature: Code Modification on ""Additional Fee Account"(Field 10).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Additional Fee Account")
            else
              GLAccountCategoryMgt.LookupGLAccount("Additional Fee Account",GLAccountCategory."Account Category"::Income,'');

            Validate("Additional Fee Account");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
              GLAccountCategoryMgt.LookupGLAccount("Additional Fee Account",GLAccountCategory."Account Category"::Revenue,'');

            Validate("Additional Fee Account");
            */
        //end;


        //Unsupported feature: Code Modification on ""Additional Fee Account"(Field 10).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Additional Fee Account",true,true)
            else
              GLAccountCategoryMgt.CheckGLAccount("Additional Fee Account",true,true,GLAccountCategory."Account Category"::Income,'');
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
              GLAccountCategoryMgt.CheckGLAccount("Additional Fee Account",true,true,GLAccountCategory."Account Category"::Revenue,'');
            */
        //end;


        //Unsupported feature: Code Modification on ""Interest Account"(Field 11).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Interest Account")
            else
              GLAccountCategoryMgt.LookupGLAccount("Interest Account",GLAccountCategory."Account Category"::Income,'');

            Validate("Interest Account");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
              GLAccountCategoryMgt.LookupGLAccount("Interest Account",GLAccountCategory."Account Category"::Revenue,'');

            Validate("Interest Account");
            */
        //end;


        //Unsupported feature: Code Modification on ""Interest Account"(Field 11).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Interest Account",true,false)
            else
              GLAccountCategoryMgt.CheckGLAccount("Interest Account",true,false,GLAccountCategory."Account Category"::Income,'');
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
              GLAccountCategoryMgt.CheckGLAccount("Interest Account",true,false,GLAccountCategory."Account Category"::Revenue,'');
            */
        //end;


        //Unsupported feature: Code Modification on ""Debit Curr. Appln. Rndg. Acc."(Field 12).OnLookup".

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


        //Unsupported feature: Code Modification on ""Debit Curr. Appln. Rndg. Acc."(Field 12).OnValidate".

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


        //Unsupported feature: Code Modification on ""Credit Curr. Appln. Rndg. Acc."(Field 13).OnLookup".

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


        //Unsupported feature: Code Modification on ""Credit Curr. Appln. Rndg. Acc."(Field 13).OnValidate".

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


        //Unsupported feature: Code Modification on ""Debit Rounding Account"(Field 14).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Debit Rounding Account")
            else
              GLAccountCategoryMgt.LookupGLAccount("Debit Rounding Account",GLAccountCategory."Account Category"::Income,'');

            Validate("Debit Rounding Account");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
              GLAccountCategoryMgt.LookupGLAccount("Debit Rounding Account",GLAccountCategory."Account Category"::Revenue,'');

            Validate("Debit Rounding Account");
            */
        //end;


        //Unsupported feature: Code Modification on ""Debit Rounding Account"(Field 14).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Debit Rounding Account",false,false)
            else
              GLAccountCategoryMgt.CheckGLAccount(
                "Debit Rounding Account",false,false,GLAccountCategory."Account Category"::Income,'');
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
                "Debit Rounding Account",false,false,GLAccountCategory."Account Category"::Revenue,'');
            */
        //end;


        //Unsupported feature: Code Modification on ""Credit Rounding Account"(Field 15).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Credit Rounding Account")
            else
              GLAccountCategoryMgt.LookupGLAccount("Credit Rounding Account",GLAccountCategory."Account Category"::Income,'');
            Validate("Credit Rounding Account");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
              GLAccountCategoryMgt.LookupGLAccount("Credit Rounding Account",GLAccountCategory."Account Category"::Revenue,'');
            Validate("Credit Rounding Account");
            */
        //end;


        //Unsupported feature: Code Modification on ""Credit Rounding Account"(Field 15).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Credit Rounding Account",false,false)
            else
              GLAccountCategoryMgt.CheckGLAccount("Credit Rounding Account",false,false,GLAccountCategory."Account Category"::Income,'');
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
              GLAccountCategoryMgt.CheckGLAccount("Credit Rounding Account",false,false,GLAccountCategory."Account Category"::Revenue,'');
            */
        //end;


        //Unsupported feature: Code Modification on ""Add. Fee per Line Account"(Field 19).OnLookup".

        //trigger  Fee per Line Account"(Field 19)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.LookupGLAccountWithoutCategory("Add. Fee per Line Account")
            else
              GLAccountCategoryMgt.LookupGLAccount("Add. Fee per Line Account",GLAccountCategory."Account Category"::Income,'');

            Validate("Add. Fee per Line Account");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
              GLAccountCategoryMgt.LookupGLAccount("Add. Fee per Line Account",GLAccountCategory."Account Category"::Revenue,'');

            Validate("Add. Fee per Line Account");
            */
        //end;


        //Unsupported feature: Code Modification on ""Add. Fee per Line Account"(Field 19).OnValidate".

        //trigger  Fee per Line Account"(Field 19)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            if "View All Accounts on Lookup" then
              GLAccountCategoryMgt.CheckGLAccountWithoutCategory("Add. Fee per Line Account",true,false)
            else
              GLAccountCategoryMgt.CheckGLAccount("Add. Fee per Line Account",true,false,GLAccountCategory."Account Category"::Income,'');
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
              GLAccountCategoryMgt.CheckGLAccount("Add. Fee per Line Account",true,false,GLAccountCategory."Account Category"::Revenue,'');
            */
        //end;
    }

    //Unsupported feature: Property Modification (Attributes) on "GetReceivablesAccount(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "GetPmtDiscountAccount(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "GetPmtToleranceAccount(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "GetRoundingAccount(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "GetApplRoundingAccount(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "GetInvRoundingAccount(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "GetServiceChargeAccount(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "GetAdditionalFeeAccount(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "GetAddFeePerLineAccount(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "GetInterestAccount(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "SetAccountVisibility(PROCEDURE 12)".

}

