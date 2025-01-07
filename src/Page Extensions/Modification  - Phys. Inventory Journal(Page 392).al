pageextension 60262 pageextension60262 extends "Phys. Inventory Journal"
{
    layout
    {
        addafter("Reason Code")
        {
            field(Remarks; Rec.Remarks)
            {
            }
        }
    }
    actions
    {
        // modify("&Print")
        // {

        //     //Unsupported feature: Property Modification (Level) on ""&Print"(Action 59)".


        //     //Unsupported feature: Property Modification (Name) on ""&Print"(Action 59)".

        //     Caption = '&Print Counting Sheet';
        // }
        modify("Test Report")
        {

            //Unsupported feature: Property Modification (Name) on ""Test Report"(Action 33)".

            Caption = 'Stock Taking sheet';
            Promoted = true;
            PromotedCategory = Category4;
        }
        moveafter(CalculateCountingPeriod; "P&osting")
    }
}

