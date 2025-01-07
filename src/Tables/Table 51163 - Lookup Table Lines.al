table 51163 "Lookup Table Lines"
{

    fields
    {
        field(1;"Table ID";Code[20])
        {
            NotBlank = true;
            TableRelation = "Lookup Table Header";
        }
        field(2;"Lower Amount (LCY)";Decimal)
        {

            trigger OnValidate()
            begin
                gvAllowedPayrolls.SetRange("User ID",UserId);
                if gvAllowedPayrolls.FindFirst then begin
                PayrollSetup.SetRange("Payroll Code",gvAllowedPayrolls."Payroll Code");
                  if PayrollSetup.FindFirst then begin

                      if PayrollSetup."Tax Calculation" = PayrollSetup."Tax Calculation"::Kenya then begin
                        if Percent <> 0 then
                        "Cumulate (LCY)" := (("Upper Amount (LCY)" - "Lower Amount (LCY)") * Percent) / 100
                         else
                        "Cumulate (LCY)" := 0;
                      end else if PayrollSetup."Tax Calculation"=PayrollSetup."Tax Calculation"::Ethiopia then begin
                          if Percent <> 0 then
                          "Cumulate (LCY)" := ((("Upper Amount (LCY)" - "Lower Amount (LCY)") * Percent) / 100) -"Relief Amount"
                           else
                          "Cumulate (LCY)" := 0;
                          end;
                   end;
                end;
            end;
        }
        field(3;"Upper Amount (LCY)";Decimal)
        {

            trigger OnValidate()
            begin
                gvAllowedPayrolls.SetRange("User ID",UserId);
                if gvAllowedPayrolls.FindFirst then begin
                   PayrollSetup.SetRange("Payroll Code",gvAllowedPayrolls."Payroll Code");
                      if PayrollSetup.FindFirst then begin
                        if PayrollSetup."Tax Calculation" = PayrollSetup."Tax Calculation"::Kenya then
                          CalcCum(Rec)
                        else if  PayrollSetup."Tax Calculation" = PayrollSetup."Tax Calculation"::Ethiopia then
                          CalcCumEthiopia(Rec);
                    end;
                end
            end;
        }
        field(4;"Extract Amount (LCY)";Decimal)
        {
        }
        field(5;Percent;Decimal)
        {

            trigger OnValidate()
            begin
                gvAllowedPayrolls.SetRange("User ID",UserId);
                if gvAllowedPayrolls.FindFirst then begin
                   PayrollSetup.SetRange("Payroll Code",gvAllowedPayrolls."Payroll Code");
                    if PayrollSetup.FindFirst then begin
                        if PayrollSetup."Tax Calculation" = PayrollSetup."Tax Calculation"::Kenya then
                          CalcCum(Rec)
                        else if  PayrollSetup."Tax Calculation" = PayrollSetup."Tax Calculation"::Ethiopia then
                          CalcCumEthiopia(Rec);
                   end;
                end;
            end;
        }
        field(6;"Cumulate (LCY)";Decimal)
        {
            Description = 'Not in use for Ethiopia';
        }
        field(7;Month;Integer)
        {
            MaxValue = 12;
            MinValue = 1;
        }
        field(50001;"Relief Amount";Decimal)
        {
            Description = 'Ethiopian tax has a Relief for every income bracket';

            trigger OnValidate()
            begin
                gvAllowedPayrolls.SetRange("User ID",UserId);
                if gvAllowedPayrolls.FindFirst then begin
                   PayrollSetup.SetRange("Payroll Code",gvAllowedPayrolls."Payroll Code");
                    if PayrollSetup.FindFirst then begin
                        if PayrollSetup."Tax Calculation" = PayrollSetup."Tax Calculation"::Kenya then
                          CalcCum(Rec)
                        else if  PayrollSetup."Tax Calculation" = PayrollSetup."Tax Calculation"::Ethiopia then
                          CalcCumEthiopia(Rec);
                   end;
                end;
            end;
        }
    }

    keys
    {
        key(Key1;"Table ID","Lower Amount (LCY)",Month)
        {
        }
    }

    fieldgroups
    {
    }

    var
        TableLines: Record "Lookup Table Lines";
        PayrollSetup: Record "Payroll Setups";
        gvAllowedPayrolls: Record "Allowed Payrolls";
        TableCodeTransfer: Codeunit "Table Code Transferred-Payroll";

    procedure CalcCum(TableLinesRec: Record "Lookup Table Lines")
    begin
        TableCodeTransfer.LookupTableLinesCalcCum(Rec,TableLinesRec);
    end;

    procedure CalcCumEthiopia(TableLinesRec: Record "Lookup Table Lines")
    begin
        TableCodeTransfer.LookupTableLinesCalcCumEthiopia(Rec,TableLinesRec);
    end;
}

