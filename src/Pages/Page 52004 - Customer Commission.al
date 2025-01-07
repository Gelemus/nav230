page 52004 "Customer Commission"
{
    PageType = Card;

    layout
    {
        area(content)
        {
            group(General)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Calculate Commission")
            {
                Caption = 'Calculate Commission';
                Image = PostTaxInvoice;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //CustomerCommision.CalculateCustomerCommision(Rec);
                end;
            }
        }
    }
}

