page 50678 "Meeting Agenda"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Meeting Agenda";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Meeting No"; Rec."Meeting No")
                {
                    Editable = false;
                }
                field("Line No"; Rec."Line No")
                {
                    Editable = false;
                }
                field("Type of Agenda"; Rec."Type of Agenda")
                {
                }
                field("Agenda Code"; Rec."Agenda Code")
                {
                }
                field("Agenda Item"; Rec."Agenda Item")
                {
                }
                field("Agenda Papers"; Rec."Agenda Papers")
                {
                }
                field("Scheduled Time"; Rec."Scheduled Time")
                {
                }
                field(Purpose; Rec.Purpose)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control10; Notes)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Agenda Vote Item")
            {
                Image = Accounts;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Agenda Vote Item";
                RunPageLink = "Meeting No" = FIELD("Meeting No"),
                              "Agenda No" = FIELD("Agenda Code");
            }
        }
    }
}

