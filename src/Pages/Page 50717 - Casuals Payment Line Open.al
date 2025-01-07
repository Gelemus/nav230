page 50717 "Casuals Payment Line Open"
{
    PageType = ListPart;
    SourceTable = "Imprest Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Names; Rec.Names)
                {

                    trigger OnValidate()
                    begin
                        Rec."Casual Payment" := true;
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'No of Days/Metres';
                }
                field("Unit Amount"; Rec."Unit Amount")
                {
                }
                field("Gross Amount"; Rec."Gross Amount")
                {
                    Caption = 'Total Amount';
                    Editable = false;
                    ToolTip = 'Specifies the field name';
                }
                field("Telephone No."; Rec."Telephone No.")
                {
                }
                field("ID No."; Rec."ID No.")
                {
                }
                field("Date Paid"; Rec."Date Paid")
                {
                }
                field("Reference No."; Rec."Reference No.")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
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

