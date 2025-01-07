page 50829 "Approved Repair Order Line"
{
    Caption = 'Approved Repair Order Line';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = "Travelling Employee";
    SourceTableView = SORTING("Request No.", "Line No")
                      ORDER(Ascending)
                      WHERE(Description = FILTER(<> ''));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Request No."; Rec."Request No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Price per Unit"; Rec."Price per Unit")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Line No"; Rec."Line No")
                {
                }
                field("Item to Inspect"; Rec."Item to Inspect")
                {
                }
                field("Driver 1"; Rec."Driver 1")
                {
                }
                field("Driver 2"; Rec."Driver 2")
                {
                }
                field(Explanation; Rec.Explanation)
                {
                }
            }
        }
    }

    actions
    {
    }

    procedure SetSelection(var PurchaseRequisitionLine: Record "Travelling Employee")
    begin
        CurrPage.SetSelectionFilter(PurchaseRequisitionLine);
    end;
}

