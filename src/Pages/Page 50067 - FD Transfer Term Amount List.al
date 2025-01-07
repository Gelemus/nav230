page 50067 "FD Transfer Term Amount List"
{
    CardPageID = "FD Transfer Term Amount Card";
    PageType = List;
    SourceTable = "FD Processing";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field("FD Account"; Rec."FD Account")
                {
                }
                field("FD Account Name"; Rec."FD Account Name")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Fixed Deposit Status"; Rec."Fixed Deposit Status")
                {
                    Editable = false;
                }
                field("Fixed Deposit Start Date"; Rec."Fixed Deposit Start Date")
                {
                }
                field("Fixed Duration"; Rec."Fixed Duration")
                {
                }
                field("Expected Maturity Date"; Rec."Expected Maturity Date")
                {
                    Visible = false;
                }
                field("Interest rate"; Rec."Interest rate")
                {
                    Editable = false;
                }
                field("Interest Earned"; Rec."Interest Earned")
                {
                }
                field("Untranfered Interest"; Rec."Untranfered Interest")
                {
                }
                field("FD Maturity Date"; Rec."FD Maturity Date")
                {
                }
                field("FD Amount"; Rec."FD Amount")
                {
                }
                field("Last Interest Earned Date"; Rec."Last Interest Earned Date")
                {
                    Editable = false;
                }
                field("Expected Interest On Term Dep"; Rec."Expected Interest On Term Dep")
                {
                    Editable = false;
                }
                field("On Term Deposit Maturity"; Rec."On Term Deposit Maturity")
                {
                }
            }
        }
    }

    actions
    {
    }
}

