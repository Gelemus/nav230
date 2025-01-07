page 50715 "Petty Cash Subform Open"
{
    PageType = ListPart;
    SourceTable = "Imprest Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Activity Date"; Rec."Activity Date")
                {
                }
                field("Imprest Code"; Rec."Imprest Code")
                {
                    Caption = 'Petty cash Code';
                    ToolTip = 'Specifies the field name';
                }
                field("Account Type"; Rec."Account Type")
                {
                    ToolTip = 'Specifies the field name';
                    Visible = false;
                }
                field("Account No."; Rec."Account No.")
                {
                    ToolTip = 'Specifies the field name';
                    Visible = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ToolTip = 'Specifies the field name';
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Gross Amount"; Rec."Gross Amount")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Tax Amount"; Rec."Tax Amount")
                {
                }
                field("Net Amount"; Rec."Net Amount")
                {
                }
                field("Gross Amount(LCY)"; Rec."Gross Amount(LCY)")
                {
                    ToolTip = 'Specifies the field name';
                }
                field(City; Rec.City)
                {

                    trigger OnValidate()
                    begin
                        Rec."From City" := '';
                        Rec."To City" := '';

                        CityCodes.Reset;
                        CityCodes.SetRange(CityCodes.Code, Rec.City);
                        if CityCodes.FindFirst then begin
                            AllowanceMatrix.Reset;
                            AllowanceMatrix.SetRange(AllowanceMatrix."Job Group", Rec."HR Job Grade");
                            AllowanceMatrix.SetRange(AllowanceMatrix."Allowance Code", Rec."Imprest Code");
                            AllowanceMatrix.SetRange(AllowanceMatrix."Cluster Code", CityCodes."Cluster Code");
                            if AllowanceMatrix.FindFirst then begin
                                Rec."Gross Amount" := AllowanceMatrix.Amount;
                                Rec."Gross Amount(LCY)" := Rec."Gross Amount";
                            end;
                        end;
                    end;
                }
                field("HR Job Grade"; Rec."HR Job Grade")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    var
        AllowanceMatrix: Record "Allowance Matrix";
        FromToEditable: Boolean;
        CityEditable: Boolean;
        CityCodes: Record "Procurement Lookup Values";
        ImprestLine: Record "Imprest Line";
        Error001: Label 'Destination Town is Similar to Depature Town';
        Error002: Label 'Imprest exist on this activity day';
}
