pageextension 60041 pageextension60041 extends "User Setup"
{
    layout
    {
        addafter(Email)
        {
            field("Employee No"; Rec."Employee No")
            {
            }
            field(Signature; Rec.Signature)
            {
            }
            field("Re-Open Imprest Surrender"; Rec."Re-Open Imprest Surrender")
            {
            }
            field("Post Leave Application"; Rec."Post Leave Application")
            {
            }
            field("ReOpen Purchase Requisition"; Rec."ReOpen Purchase Requisition")
            {
            }
            field("Reopen Documents"; Rec."Reopen Documents")
            {
            }
            field("Reversal Right"; Rec."Reversal Right")
            {
            }
            field("Item Creation"; Rec."Item Creation")
            {
            }
            field("Vendor Creation"; Rec."Vendor Creation")
            {
            }
            field("Chart of Account Creation"; Rec."Chart of Account Creation")
            {
            }
            field("Bank Account  Creation"; Rec."Bank Account  Creation")
            {
            }
            field("Fixed Asset  Creation"; Rec."Fixed Asset  Creation")
            {
            }
            field("Employee Creation"; Rec."Employee Creation")
            {
            }
            field("Payroll Admin"; Rec."Payroll Admin")
            {
            }
            field(CreateLpo; Rec.CreateLpo)
            {

            }
            field("Receive Legal Notifications"; Rec."Receive Legal Notifications")
            {
            }
            field("Receive ICT Notifications"; Rec."Receive ICT Notifications")
            {
            }
            field("Give Access to Payroll"; Rec."Give Access to Payroll")
            {
            }
            field("Payroll Batch"; Rec."Payroll Batch")
            {
            }
            field("View Imprest"; Rec."View Imprest")
            {
            }
            field("View Petty Cash"; Rec."View Petty Cash")
            {
            }
            field("License Type"; Rec."License Type")
            {
            }
            field("Allow Multiple Imprest Request"; Rec."Allow Multiple Imprest Request")
            {
            }
            field(CommitBudget; Rec.CommitBudget)
            {
                ApplicationArea = All;
                Caption = 'Commit Budget';
            }
            field(ChangeProfile; Rec.ChangeProfile)
            {
                ApplicationArea = All;
                Caption = 'Change Profile';
            }
        }
    }
}

