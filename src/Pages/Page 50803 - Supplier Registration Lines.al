page 50803 "Supplier Registration Lines"
{
    PageType = ListPart;
    SourceTable = "Tender Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Supplier No."; Rec."Supplier No.")
                {
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                }
                field("Bid Amount"; Rec."Bid Amount")
                {
                }
                field(Disqualified; Rec.Disqualified)
                {
                    Editable = false;
                }
                field("Reason for Disqualification"; Rec."Reason for Disqualification")
                {
                }
                field("Disqualification point"; Rec."Disqualification point")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

