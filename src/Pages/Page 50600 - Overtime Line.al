page 50600 "Overtime Line"
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
                field("Overtime Rate"; Rec."Overtime Rate")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Hourly rate"; Rec."Hourly rate")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'No of hours';
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

