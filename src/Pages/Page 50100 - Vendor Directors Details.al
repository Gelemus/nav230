page 50100 "Vendor Directors Details"
{
    PageType = ListPart;
    SourceTable = "Vendor Directors Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Director Name"; Rec."Director Name")
                {
                }
                field(Address; Rec.Address)
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field("E-Mail"; Rec."E-Mail")
                {
                }
                field("ID/Passport No."; Rec."ID/Passport No.")
                {
                }
                field(Nationality; Rec.Nationality)
                {
                }
                field("If Other, Nationality"; Rec."If Other, Nationality")
                {
                }
            }
        }
    }

    actions
    {
    }
}

