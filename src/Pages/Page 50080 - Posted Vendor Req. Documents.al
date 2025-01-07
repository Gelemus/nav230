page 50080 "Posted Vendor Req. Documents"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Vendor Required Documents";
    SourceTableView = WHERE("LPO Invoice No" = FILTER(<> ''));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Code"; Rec."Document Code")
                {
                    Editable = false;
                }
                field("Document Description"; Rec."Document Description")
                {
                    Editable = false;
                }
                field("Document Verified"; Rec."Document Verified")
                {
                }
                field("Verified By"; Rec."Verified By")
                {
                }
                field("LPO Invoice No"; Rec."LPO Invoice No")
                {
                    Editable = false;
                }
                field("LPO Vendor No."; Rec."LPO Vendor No.")
                {
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control9; Links)
            {
            }
            systempart(Control8; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        if Rec.HasLinks then begin
            Rec."Document Attached" := true;
            Rec.Modify;
        end;
    end;
}
