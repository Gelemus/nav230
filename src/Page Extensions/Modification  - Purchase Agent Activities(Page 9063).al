pageextension 60671 pageextension60671 extends "Purchase Agent Activities"
{
    layout
    {
        addfirst(Content)
        {
            cuegroup(Approvals)
            {
                Caption = 'Approvals';
                field("Requests To Approve"; Rec."Requests To Approve")
                {
                    DrillDownPageID = "Requests to Approve";
                }
            }
        }
    }
}

