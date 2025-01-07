page 52264 "Overtime LineII"
{
    PageType = ListPart;
    SourceTable = "Imprest Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Overtime Date"; Rec."Overtime Date")
                {
                }
                field("Hourly rate"; Rec."Hourly rate")
                {
                    Editable = false;
                }
                field("Overtime Rate"; Rec."Overtime Rate")
                {
                    Editable = false;
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'No of hours';
                }
                field("Unit Amount"; Rec."Unit Amount")
                {
                    Editable = false;
                }
                field("Gross Amount"; Rec."Gross Amount")
                {
                    Editable = false;
                    ToolTip = 'Specifies the field name';
                }
                field("Tax Amount"; Rec."Tax Amount")
                {
                    Editable = false;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    Editable = false;
                }
                field("Gross Amount(LCY)"; Rec."Gross Amount(LCY)")
                {
                    Editable = false;
                    ToolTip = 'Specifies the field name';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the field name';
                    Visible = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Visible = false;
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

