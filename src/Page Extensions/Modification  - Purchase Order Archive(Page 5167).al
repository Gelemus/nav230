pageextension 60320 pageextension60320 extends "Purchase Order Archive"
{
    layout
    {
        addafter("Document Date")
        {
            field("Reference No"; Rec."Reference No")
            {
            }
        }
    }
}

