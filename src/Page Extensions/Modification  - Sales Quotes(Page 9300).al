pageextension 60751 pageextension60751 extends "Sales Quotes"
{

    //Unsupported feature: Property Modification (SourceTableView) on ""Sales Quotes"(Page 9300)".

    actions
    {
        addafter(CancelApprovalRequest)
        {
            action(SUBMIT)
            {
                Caption = 'SUBMIT';

                trigger OnAction()
                begin
                    //updated 08/08/2020
                    Rec."Submitted BY" := UserId;
                    Rec."Date Submitted" := Today;
                    Rec."Time Submitted" := Time;
                    Rec.Submitted := true;
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify
                end;
            }
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "SetStyle(PROCEDURE 2)".

}

