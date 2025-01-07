page 50024 "Imprest Line"
{
    PageType = ListPart;
    SourceTable = "Imprest Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Imprest Code"; Rec."Imprest Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Account Type"; Rec."Account Type")
                {
                    Editable = false;
                    ToolTip = 'Specifies the field name';
                }
                field("Account No."; Rec."Account No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the field name';
                }
                field("Account Name"; Rec."Account Name")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the field name';
                }
                field("Imprest Types"; Rec."Imprest Types")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field("Telephone No."; Rec."Telephone No.")
                {
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Work Done on Standby"; Rec."Work Done on Standby")
                {
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
                field(Quantity; Rec.Quantity)
                {
                }
                field("Unit Amount"; Rec."Unit Amount")
                {
                }
                field("Gross Amount"; Rec."Gross Amount")
                {
                    Editable = false;
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
                field("Reference No."; Rec."Reference No.")
                {
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
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

