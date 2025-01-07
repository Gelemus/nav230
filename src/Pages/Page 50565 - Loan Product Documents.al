page 50565 "Loan Product Documents"
{
    PageType = ListPart;
    SourceTable = "Employee Loan Product Document";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Code"; Rec."Document Code")
                {
                }
                field("Document Description"; Rec."Document Description")
                {
                }
                field("Document Mandatory Stage"; Rec."Document Mandatory Stage")
                {
                }
            }
        }
    }

    actions
    {
    }
}

