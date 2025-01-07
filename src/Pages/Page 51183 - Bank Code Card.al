page 51183 "Bank Code Card"
{
    PageType = Card;
    SourceTable = "Employee Bank Account";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Branch; Rec.Branch)
                {
                }
                field("KBA Code"; Rec."KBA Code")
                {
                }
                field(Address; Rec.Address)
                {
                }
                field("Address 2"; Rec."Address 2")
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                }
                field(City; Rec.City)
                {
                }
                field(County; Rec.County)
                {
                }
                field(Contact; Rec.Contact)
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field("Fax No."; Rec."Fax No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}
