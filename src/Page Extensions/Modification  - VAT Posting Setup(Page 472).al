pageextension 60282 pageextension60282 extends "VAT Posting Setup"
{
    layout
    {
        addafter("VAT %")
        {
            field("VAT % 2"; Rec."VAT % 2")
            {
            }
        }
    }
}

