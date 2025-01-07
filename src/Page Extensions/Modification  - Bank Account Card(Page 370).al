pageextension 60248 pageextension60248 extends "Bank Account Card"
{
    layout
    {
        modify("No.")
        {
            Editable = false;
        }
        addafter(Name)
        {
            field("Bank Account Type"; Rec."Bank Account Type")
            {
            }
        }
        addafter("Bank Account No.")
        {
            field("Budget Gl"; Rec."Budget Gl")
            {
            }
        }
        addafter("Search Name")
        {
            field("Float Amount"; Rec."Float Amount")
            {
            }
        }
    }
    actions
    {
        modify("Check Details")
        {
            Visible = false;
        }
    }

    var
        UserSetup: Record "User Setup";
        PemissionDenied: Label 'You are not setup to Create Bank Accounts. Contact System Administrator';


    //Unsupported feature: Code Insertion on "OnNewRecord".

    //trigger OnNewRecord(BelowxRec: Boolean)
    //begin
    /*
    //Check if is allowed to create
    if UserSetup.Get(UserId) then begin
      if not UserSetup."Bank Account  Creation" then
        Error(PemissionDenied);
     end;
     // End Check if is allowed to create
    */
    //end;
}

