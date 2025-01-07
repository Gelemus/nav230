page 50107 "Tender Lines"
{
    PageType = ListPart;
    SourceTable = "Tender Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                }
                field("Application No"; Rec."Application No")
                {
                    Editable = false;
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                }
                field("Business Registration Name"; Rec."Business Registration Name")
                {
                    Editable = false;
                }
                field("KRA PIN"; Rec."KRA PIN")
                {
                    Editable = false;
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

