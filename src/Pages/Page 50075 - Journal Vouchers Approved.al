page 50075 "Journal Vouchers Approved"
{
    CardPageID = "Journal Voucher";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Journal Voucher Header";
    SourceTableView = WHERE(Status = CONST(Approved),
                            Posted = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("JV No."; Rec."JV No.")
                {
                }
                field("Document date"; Rec."Document date")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Date Created"; Rec."Date Created")
                {
                }
                field(Voted; Rec.Voted)
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Posted; Rec.Posted)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        CurrPage.Editable(false);
    end;
}

