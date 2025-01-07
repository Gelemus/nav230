page 50192 "HR Employees Prof Body"
{
    Caption = 'HR Employee Professional  Body Membership';
    PageType = List;
    SourceTable = "HR Employee Prof. Membership";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Professional Body Name"; Rec."Professional Body Name")
                {
                }
                field("Membership No."; Rec."Membership No.")
                {
                }
                field("Practising Cert/License No"; Rec."Practising Cert/License No")
                {
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}

