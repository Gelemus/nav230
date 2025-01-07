tableextension 60703 tableextension60703 extends "Purchase Cue" 
{
    fields
    {
        field(23;"Requests To Approve";Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE (Status=FILTER(Open),
                                                        "Approver ID"=FIELD("User ID Filter")));
            FieldClass = FlowField;
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "SetRespCenterFilter(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "CountOrders(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "ShowOrders(PROCEDURE 2)".

}

