page 50020 "Posted Funds Transfer List"
{
    CardPageID = "Posted Funds Transfer Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Funds Transfer Header";
    SourceTableView = SORTING("No.")
                      ORDER(Descending)
                      WHERE(Posted = CONST(true));

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
                field("Reference No."; Rec."Reference No.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Tranfer Type"; Rec."Tranfer Type")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Amount To Transfer"; Rec."Amount To Transfer")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Amount To Transfer(LCY)"; Rec."Amount To Transfer(LCY)")
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
        area(creation)
        {
            action("Print Funds Transfer")
            {
                Caption = 'Print Funds Transfer';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ToolTip = 'Prepare to print the document. A report request window where you can specify what to include on the print-out.';

                trigger OnAction()
                begin
                    MoneyTransferHeader.Reset;
                    MoneyTransferHeader.SetRange(MoneyTransferHeader."No.", Rec."No.");
                    if MoneyTransferHeader.FindFirst then begin
                        REPORT.RunModal(REPORT::"Funds Transfer Voucher", true, false, MoneyTransferHeader);
                    end;
                end;
            }
        }
    }

    var
        MoneyTransferHeader: Record "Funds Transfer Header";
}

