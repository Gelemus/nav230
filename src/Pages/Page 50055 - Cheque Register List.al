page 50055 "Cheque Register List"
{
    CardPageID = "Cheque Register Card";
    PageType = List;
    SourceTable = "Cheque Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Bank Account"; Rec."Bank Account")
                {
                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {
                }
                field("Last Cheque No."; Rec."Last Cheque No.")
                {
                }
                field("Cheque Book Number"; Rec."Cheque Book Number")
                {
                }
                field("No of Leaves"; Rec."No of Leaves")
                {
                }
                field("Cheque Number From"; Rec."Cheque Number From")
                {
                }
                field("Cheque Number To."; Rec."Cheque Number To.")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
    }

    actions
    {
    }
}

