page 56068 "Posted Visitor Pass List"
{
    CardPageID = "Posted Visitor Pass";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Visitors Pass";
    SourceTableView = WHERE(Status = FILTER(Released));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Date of visit"; Rec."Date of visit")
                {
                }
                field("Time of visit"; Rec."Time of visit")
                {
                }
                field("Visitor Name"; Rec."Visitor Name")
                {
                }
                field("ID No"; Rec."ID No")
                {
                }
                field(From; Rec.From)
                {
                }
            }
        }
    }

    actions
    {
    }
}

