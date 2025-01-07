page 50096 "Closed Req. for Quotation List"
{
    CardPageID = "Request for Quotation Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Request for Quotation Header";
    SourceTableView = SORTING("No.")
                      ORDER(Descending)
                      WHERE(Status = CONST(Closed));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Closing Date"; Rec."Closing Date")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the field name';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the field name';
                }
            }
        }
    }

    actions
    {
    }

    procedure InsertRFQLines()
    var
        Counter: Integer;
        RFQLine: Record "Request for Quotation Line";
        RequisitionLine: Page "Requisition Line";
    begin
        /*RequisitionLine.LOOKUPMODE(TRUE);
        IF RequisitionList.RUNMODAL = ACTION::LookupOK THEN BEGIN
          RequisitionList.SetSelection(RFQLine);
          Counter :=RFQLine.COUNT;
          IF Counter > 0 THEN BEGIN
            IF RFQLine.FINDSET THEN
              REPEAT
                Lines.INIT;
                Lines.TRANSFERFIELDS(RFQLine);
                Lines."Document Type":="Document Type";
                Lines."Document No.":="No.";
                Lines."Line No.":=0;
                Lines."PRF No":=RFQLine."Document No.";
                Lines."PRF Line No.":=RFQLine."Line No.";
                Lines.INSERT(TRUE);
             UNTIL RFQLine.NEXT = 0;
          END;
        END;*/

    end;
}

