codeunit 51051 "Tax Calculation1"
{

    trigger OnRun()
    begin
    end;

    procedure CalculateTax(CalculationType: Option VAT,"W/Tax",Retention,"W/VAT") Amount: Decimal
    begin
        /*CASE CalculationType OF
          CalculationType::VAT:
            BEGIN
              //  Amount:=Rec."Taxable Amount" - ((100/(100+Rec."VAT Rate"))*Rec."Taxable Amount");
        
                Amount:= (Rec."VAT Rate"/(100+Rec."VAT Rate"))*Rec."Taxable Amount";
        
            END;
          CalculationType::"W/Tax":
            BEGIN
                Amount:=(Rec."W/Tax Rate"/100)*(Rec."Taxable Amount"-Rec."VAT Amount");
                Amount:=ROUND(Amount,1,'>');
            END;
          CalculationType::Retention:
            BEGIN
                Amount:=(Rec."Taxable Amount"-((Rec."VAT Rate"/(100+Rec."VAT Rate"))*Rec."Taxable Amount"))
                 *(Rec."Retention Rate"/100);
            END;
        
          CalculationType::"W/VAT":
            BEGIN
                //Amount:=Rec."Taxable Amount" - ((100/(100+Rec."VAT Withholding Rate"))*Rec."Taxable Amount");
                Amount:= (Rec."VAT Withholding Rate"/(100+Rec."VAT Rate"))*Rec."Taxable Amount";
                Amount:=ROUND(Amount,1,'>');
            END;
        
        END;*/

    end;

    procedure CalculatePurchTax(Rec: Record "Purchase Line";CalculationType: Option VAT,"W/Tax",Retention) Amount: Decimal
    begin
        
        /*CASE CalculationType OF
          CalculationType::VAT:
            BEGIN
                //Amount:=(Rec."VAT Rate"/(100+Rec."VAT Rate"))*Rec.Amount;
                Amount:=(Rec."VAT Rate"/(100+Rec."VAT Rate"))*Rec.Amount;
            END;
          CalculationType::"W/Tax":
            BEGIN
                //Amount:=(Rec.Amount-((Rec."VAT Rate"/(100+Rec."VAT Rate"))*Rec.Amount))
                //*(Rec."W/Tax Rate"/100);
                Amount:=(Rec.Amount*(Rec."W/Tax Rate"/(100+Rec."VAT Rate")));
        
            END;
          CalculationType::Retention:
            BEGIN
                Amount:=(Rec.Amount-((Rec."VAT Rate"/100)*Rec.Amount))
                 *(Rec."Retention Rate"/100);
            END;
        END;*/

    end;
}

