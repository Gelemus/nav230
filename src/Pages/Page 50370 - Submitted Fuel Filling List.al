page 50370 "Submitted Fuel Filling List"
{
    CardPageID = "Submitted  Fuel Filling Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Vehicle Filling";
    SourceTableView = WHERE(Submitted = FILTER(true));

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
                field("Voucher No."; Rec."Voucher No.")
                {
                }
                field("Registration No"; Rec."Registration No")
                {
                }
                field("Invoice No"; Rec."Invoice No")
                {
                }
                field("Oil Drawn (Litres)"; Rec."Oil Drawn (Litres)")
                {
                }
                field("Fuel Drawn (Litres)"; Rec."Fuel Drawn (Litres)")
                {
                }
                field("Cost per Litre"; Rec."Cost per Litre")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field(Type; Rec.Type)
                {
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
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(PRINT)
            {

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetRange(Rec."Filling No", xRec."Filling No");
                    if Rec.FindFirst then begin
                        // REPORT.RunModal(REPORT::"Daily Fuel Consumption", true, false, Rec);
                    end;
                end;
            }
        }
    }
}

