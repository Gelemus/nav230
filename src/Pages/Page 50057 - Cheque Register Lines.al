page 50057 "Cheque Register Lines"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = "Cheque Register Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cheque No."; Rec."Cheque No.")
                {
                }
                field("Payee No"; Rec."Payee No")
                {
                }
                field(Payee; Rec.Payee)
                {
                }
                field("PV No"; Rec."PV No")
                {
                }
                field("PV Description"; Rec."PV Description")
                {
                }
                field("PV Prepared By"; Rec."PV Prepared By")
                {
                }
                field("Cheque Cancelled"; Rec."Cheque Cancelled")
                {
                }
                field("Cancelled By"; Rec."Cancelled By")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
    }

    actions
    {
    }
}

