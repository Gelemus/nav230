page 50109 "Tender Evaluation List"
{
    CardPageID = "Tender Evaluation Card";
    DeleteAllowed = false;
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Tender Evaluation";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Evaluation No."; Rec."Evaluation No.")
                {
                    Editable = false;
                }
                field("Tender No."; Rec."Tender No.")
                {
                }
                field("Tender Date"; Rec."Tender Date")
                {
                }
                field("Evaluation Date"; Rec."Evaluation Date")
                {
                }
                field("Tender Close Date"; Rec."Tender Close Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}

