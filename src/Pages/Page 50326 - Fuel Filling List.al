page 50326 "Fuel Filling List"
{
    CardPageID = "Fuel Filling Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Vehicle Filling";
    SourceTableView = WHERE(Status = CONST(Open));

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                Editable = false;
                ShowCaption = false;
                field("Filling No"; Rec."Filling No")
                {
                }
                field("No."; Rec."No.")
                {
                }
                field("Filling Date"; Rec."Filling Date")
                {
                }
                field("Oil Drawn (Litres)"; Rec."Oil Drawn (Litres)")
                {
                }
                field("Fuel Drawn (Litres)"; Rec."Fuel Drawn (Litres)")
                {
                }
                field("Voucher No."; Rec."Voucher No.")
                {
                    Caption = 'Receipt No';
                }
                field("Current Speed"; Rec."Current Speed")
                {
                }
                field("Kms Covered"; Rec."Kms Covered")
                {
                }
                field("No. Series"; Rec."No. Series")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Registration No"; Rec."Registration No")
                {
                }
                field("Card Description"; Rec."Card Description")
                {
                }
                field("Card No"; Rec."Card No")
                {
                }
                field("Balance BF"; Rec."Balance BF")
                {
                    Visible = false;
                }
                field("Amount Loaded"; Rec."Amount Loaded")
                {
                    Visible = false;
                }
                field("Balance CF"; Rec."Balance CF")
                {
                    Visible = false;
                }
                field("Loading Date"; Rec."Loading Date")
                {
                    Visible = false;
                }
                field("User ID"; Rec."User ID")
                {
                }
            }
        }
    }

    actions
    {
    }
}

