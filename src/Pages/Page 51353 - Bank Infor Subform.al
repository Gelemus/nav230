page 51353 "Bank Infor Subform"
{
    PageType = ListPart;
    SourceTable = "Tender Bank Info";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No"; Rec."Line No")
                {
                }
                field("Document No"; Rec."Document No")
                {
                }
                field(Bank; Rec.Bank)
                {
                }
                field("Bank Address"; Rec."Bank Address")
                {
                }
                field("Supplier Profile ID"; Rec."Supplier Profile ID")
                {
                }
                field("Bank Telephone No"; Rec."Bank Telephone No")
                {
                }
                field("Bank Email"; Rec."Bank Email")
                {
                }
                field("Bank Mobile No"; Rec."Bank Mobile No")
                {
                }
                field(TenderNo; Rec.TenderNo)
                {
                }
            }
        }
    }

    actions
    {
    }
}

