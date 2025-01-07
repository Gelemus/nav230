pageextension 60130 pageextension60130 extends "Bank Acc. Ledg. Entr. Preview"
{
    layout
    {
        addafter(Description)
        {
            field(Payee; Rec.Payee)
            {
            }
        }
    }
}

