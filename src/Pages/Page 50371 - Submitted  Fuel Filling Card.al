page 50371 "Submitted  Fuel Filling Card"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    SourceTable = "Vehicle Filling";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Filling No"; Rec."Filling No")
                {
                    Editable = false;
                }
                field("Filling Date"; Rec."Filling Date")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field("Registration No"; Rec."Registration No")
                {
                    ShowMandatory = true;
                }
                field("Voucher No."; Rec."Voucher No.")
                {
                    ShowMandatory = true;
                }
                field("Invoice No"; Rec."Invoice No")
                {
                }
                field(Make; Rec.Make)
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Kms Covered"; Rec."Kms Covered")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field(Details; Rec.Details)
                {
                    Editable = false;
                }
                field("Fuel Drawn (Litres)"; Rec."Fuel Drawn (Litres)")
                {
                    Editable = false;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec.Amount := Rec."Fuel Drawn (Litres)" * Rec."Cost per Litre";
                    end;
                }
                field("Oil Drawn (Litres)"; Rec."Oil Drawn (Litres)")
                {
                    Editable = false;
                }
                field("Paraffin (Litres)"; Rec."Paraffin (Litres)")
                {
                    Editable = false;
                }
                field("Cost per Litre"; Rec."Cost per Litre")
                {
                    Editable = false;

                    trigger OnValidate()
                    begin

                        Rec.Amount := Rec."Fuel Drawn (Litres)" * Rec."Cost per Litre";
                    end;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Reopen the document")
            {
                Image = ReOpen;
                Promoted = true;

                trigger OnAction()
                begin
                    Rec.Submitted := false;
                    Rec.Modify;
                end;
            }
        }
    }
}

