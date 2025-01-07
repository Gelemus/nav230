page 50120 "Item Market Price"
{
    PageType = List;
    SourceTable = "Item Market Price";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Market Price"; Rec."Market Price")
                {
                }
                field("From Date"; Rec."From Date")
                {
                }
                field("To Date"; Rec."To Date")
                {
                }
                field(Current; Rec.Current)
                {
                }
                field(Archived; Rec.Archived)
                {
                }
                field("Adjusted By"; Rec."Adjusted By")
                {
                }
                field("Archived By"; Rec."Archived By")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Validate Current Price")
            {
                Image = AddToHome;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    /*ItemMarketPrice2.RESET;
                    ItemMarketPrice2.SETRANGE(ItemMarketPrice2.Archived,TRUE);
                    IF ItemMarketPrice2.FINDFIRST THEN BEGIN
                        ItemMarketPrice.RESET;
                        ItemMarketPrice.SETRANGE(ItemMarketPrice.Archived,FALSE);
                        IF ItemMarketPrice.FINDFIRST THEN BEGIN
                          ItemMarketPrice.Archived:=TRUE;
                          ItemMarketPrice."To Date":=TODAY;
                          ItemMarketPrice.MODIFY;
                        END;
                    
                        ItemMarketPrice.RESET;
                        ItemMarketPrice.SETRANGE(ItemMarketPrice.Archived,FALSE);
                        IF ItemMarketPrice.FINDLAST THEN BEGIN
                          ItemMarketPrice.Current:=TRUE;
                          ItemMarketPrice.MODIFY;
                          ItemStock.RESET;
                          ItemStock.SETRANGE(ItemStock."No.",ItemMarketPrice.Item);
                          IF ItemStock.FINDFIRST THEN BEGIN
                            ItemStock."Market Price":=ItemMarketPrice."Market Price";
                            ItemStock.MODIFY;
                          END;
                         END;
                        END ELSE BEGIN
                          ItemMarketPrice.RESET;
                          ItemMarketPrice.SETRANGE(ItemMarketPrice.Archived,FALSE);
                          IF ItemMarketPrice.FINDLAST THEN BEGIN
                          ItemMarketPrice.Current:=TRUE;
                          ItemMarketPrice.MODIFY;
                          ItemStock.RESET;
                          ItemStock.SETRANGE(ItemStock."No.",ItemMarketPrice.Item);
                          IF ItemStock.FINDFIRST THEN BEGIN
                            ItemStock."Market Price":=ItemMarketPrice."Market Price";
                            ItemStock.MODIFY;
                          END;
                      END;
                    END;
                    */
                    ItemMarketPrice.Reset;
                    ItemMarketPrice.SetRange(ItemMarketPrice.Item, Rec.Item);
                    ItemMarketPrice.SetRange(ItemMarketPrice.Archived, false);
                    if ItemMarketPrice.FindFirst then begin
                        ItemMarketPrice.TestField(ItemMarketPrice."Market Price");
                        ItemMarketPrice.Current := true;
                        ItemMarketPrice.Modify;
                        ItemStock.Reset;
                        ItemStock.SetRange(ItemStock."No.", ItemMarketPrice.Item);
                        if ItemStock.FindFirst then begin
                            ItemStock."Market Price" := ItemMarketPrice."Market Price";
                            ItemStock.Modify;
                        end;
                    end;

                    Message('Market Price adjusted accordingly');
                    CurrPage.Close;

                end;
            }
            action("Archive Price")
            {
                Image = AutoReserve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Rec.Archived = true then
                        Error('Price already archived.');


                    Rec.Archived := true;
                    Rec."To Date" := Today;
                    Rec."Archived By" := UserId;
                    Rec.Modify;
                    Message('Price sucessfuly archived!');

                    CurrPage.Close;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.Archived = true then
            CurrPage.Editable(false);
    end;

    var
        ItemMarketPrice: Record "Item Market Price";
        ItemStock: Record Item;
        ItemMarketPrice2: Record "Item Market Price";
}

