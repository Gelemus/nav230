pageextension 60234 pageextension60234 extends "Customer Lookup"
{
    layout
    {
        addafter(Name)
        {
            field("Account No."; Rec."Account No.")
            {
            }
        }
    }
}

