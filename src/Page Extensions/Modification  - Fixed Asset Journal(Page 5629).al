pageextension 60408 pageextension60408 extends "Fixed Asset Journal" 
{
    layout
    {
        modify("Posting Date")
        {
            Visible = false;
        }
        modify("Document Type")
        {
            Enabled = true;
            Editable = true;
        }
    }
}

