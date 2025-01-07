page 50682 "Board Commitee List"
{
    PageType = List;
    SourceTable = "Board Commitee";
    ApplicationArea = All;
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Comments; Rec.Comments)
                {
                }
                field(Mandate; Rec.Mandate)
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
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
        area(creation)
        {
            action("Board Committee Members")
            {
                Caption = 'Board Committee Members';
                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Board Committee Members";
                RunPageLink = "Committee Code" = FIELD(Code);

                trigger OnAction()
                var
                    lvEmployee: Record Employee;
                begin
                end;
            }
        }
    }
}

