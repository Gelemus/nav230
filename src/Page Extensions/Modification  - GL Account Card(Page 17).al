pageextension 60133 pageextension60133 extends "G/L Account Card"
{
    layout
    {
        addafter("Account Type")
        {
            field("Working Capital Ledger"; Rec."Working Capital Ledger")
            {
            }
        }
        addafter("Direct Posting")
        {
            field("Budget Controlled"; Rec."Budget Controlled")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify(Action1900210206)
        {
            Visible = false;
        }


        //Unsupported feature: Code Insertion on ""Detail Trial Balance"(Action 1900670506)".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //begin
        /*
        Reset;
        SetRange("No.","No.");
        if FindSet then begin
          REPORT.RunModal(REPORT::"Detail Trial Balance",true,false,Rec);
        end;
        */
        //end;


        //Unsupported feature: Code Insertion on ""Trial Balance"(Action 1904082706)".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //begin
        /*
        Reset;
        SetRange("No.","No.");
        if FindSet then begin
          REPORT.RunModal(REPORT::"Trial Balance",true,false,Rec);
        end;
        */
        //end;
    }

    var
        UserSetup: Record "User Setup";
        PemissionDenied: Label 'You are not setup to Create Chart of Accountss. Contact System Administrator';


    //Unsupported feature: Code Modification on "OnNewRecord".

    //trigger OnNewRecord(BelowxRec: Boolean)
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetupNewGLAcc(xRec,BelowxRec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //Check if is allowed to create
    if UserSetup.Get(UserId) then begin
      if not UserSetup."Chart of Account Creation" then
        Error(PemissionDenied);
     end;
     // End Check if is allowed to create

    SetupNewGLAcc(xRec,BelowxRec);
    */
    //end;
}

