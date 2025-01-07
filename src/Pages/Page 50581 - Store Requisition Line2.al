page 50581 "Store Requisition Line2"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Store Requisition Line";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field(Select; Rec.Select)
                {
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                }
                field("Item Description"; Rec."Item Description")
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                }
                field(Inventory; Rec.Inventory)
                {
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                }
                field("Line Amount"; Rec."Line Amount")
                {
                }
                field("Unit Price"; Rec."Unit Price")
                {
                }
                field("Total Sale Amount"; Rec."Total Sale Amount")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("Store Requisition No"; Rec."Store Requisition No")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Add the item")
            {
                Image = AddAction;
                Promoted = true;

                trigger OnAction()
                begin
                    LineNo := 0;
                    StoreReq3.Reset;
                    if StoreReq3.FindLast then
                        LineNo := StoreReq3."Line No."
                    else
                        LineNo := 1000;
                    StoreReq2.Reset;
                    StoreReq2.SetRange(Select, true);
                    StoreReq2.SetRange("Document No.", Rec."Document No.");
                    if StoreReq2.FindSet then begin
                        repeat

                            LineNo += 1000;
                            StoreReq.Init;
                            StoreReq."Line No." := LineNo;
                            StoreReq."Document No." := StoreReq2."Return Requisition No";
                            StoreReq."Item Description" := StoreReq2."Item Description";
                            StoreReq."Item No." := StoreReq2."Item No.";
                            StoreReq."Location Code" := StoreReq2."Location Code";
                            StoreReq.Quantity := StoreReq2.Quantity;
                            StoreReq.Inventory := StoreReq2.Inventory;
                            StoreReq."Global Dimension 1 Code" := StoreReq2."Global Dimension 1 Code";
                            StoreReq."Global Dimension 2 Code" := StoreReq2."Global Dimension 2 Code";
                            StoreReq."Shortcut Dimension 3 Code" := StoreReq2."Shortcut Dimension 3 Code";
                            StoreReq."Unit Cost" := StoreReq2."Unit Cost";
                            StoreReq."Unit of Measure Code" := StoreReq2."Unit of Measure Code";
                            StoreReq."Line Amount" := StoreReq2."Line Amount";
                            //updated on 1/2/2023 to add the unit price details
                            StoreReq."Unit Price" := StoreReq2."Unit Price";
                            StoreReq."Total Sale Amount" := StoreReq2."Total Sale Amount";
                            //end
                            StoreReq."Store Requisition No" := StoreReq2."Document No.";
                            StoreReq."Return Requisition No" := StoreReq2."Return Requisition No";
                            StoreReq.Returned := true;
                            StoreReq.Insert(true);

                            StoreReq2.Select := false;
                            //StoreReq2.Returned := TRUE;
                            StoreReq2.Modify;
                        until StoreReq2.Next = 0;
                    end;

                    Message('Updated successfully');

                    CurrPage.Close;
                end;
            }
        }
    }

    var
        StoreReq: Record "Store Requisition Line";
        StoreReq2: Record "Store Requisition Line";
        LineNo: Integer;
        StoreReq3: Record "Store Requisition Line";
}

