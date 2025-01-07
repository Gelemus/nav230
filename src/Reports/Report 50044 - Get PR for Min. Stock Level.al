report 50044 "Get PR for Min. Stock Level"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Get PR for Min. Stock Level.rdl';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = WHERE("Reorder Point" = FILTER(<> 0));

            trigger OnAfterGetRecord()
            begin
                Setups.Get;
                Setups.TestField(Setups."User to replenish Stock");
                Item.Reset;
                Item.SetFilter(Item."Reorder Point", '<>%1', 0);
                if Item.FindFirst then begin
                    repeat
                        Item.CalcFields(Item.Inventory);

                        // IF Item.Inventory<Item."Reorder Point" THEN BEGIN
                        TempRequisition.Init;
                        TempRequisition."No." := NoSeriesMgt.GetNextNo(Setups."Purchase Requisition Nos.", 0D, true);
                        // ERROR(FORMAT(TempRequisition."No."));
                        TempRequisition."Requested Receipt Date" := Today;
                        TempRequisition."Document Date" := Today;
                        TempRequisition.Description := 'Purchase requisition for Item that need replenishement';
                        TempRequisition."User ID" := Setups."User to replenish Stock";
                        TempRequisition.Validate(TempRequisition."User ID");
                        TempRequisition.Insert;

                        TempRequisitionLines.Reset;
                        TempRequisitionLines."Document No." := TempRequisition."No.";
                        TempRequisitionLines."Requisition Type" := TempRequisitionLines."Requisition Type"::Item;
                        TempRequisitionLines.Validate(TempRequisitionLines."Requisition Type");
                        TempRequisitionLines."Requisition Code" := Item."No.";
                        TempRequisitionLines.Validate(TempRequisitionLines."Requisition Code");
                        TempRequisitionLines.Quantity := Item."Reorder Quantity";
                        TempRequisitionLines.Insert
                    // END;
                    until Item.Next = 0;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        TempRequisition: Record "Purchase Requisitions";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Setups: Record "Purchases & Payables Setup";
        TempRequisitionLines: Record "Purchase Requisition Line";
        PurchaseRequisition: Record "Purchase Requisitions";
        PurchaseRequisitionLines: Record "Purchase Requisition Line";
        ExistInrequisition: Boolean;
}

