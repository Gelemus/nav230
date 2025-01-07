page 51358 "Supplier Evaluation"
{
    CardPageID = "Tender Evaluation Card.";
    PageType = List;
    SourceTable = "Tender Evaluation";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Evaluation No."; Rec."Evaluation No.")
                {
                }
                field("Tender No."; Rec."Tender No.")
                {
                }
                field("Tender Date"; Rec."Tender Date")
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
                field("Evaluation Date"; Rec."Evaluation Date")
                {
                }
                field(Supplier; Rec.Supplier)
                {
                }
                field("Supplier Profile ID"; Rec."Supplier Profile ID")
                {
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                }
                field("Evaluator Name"; Rec."Evaluator Name")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field(Marks; Rec.Marks)
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Evaluation Criteria"; Rec."Evaluation Criteria")
                {
                }
                field(Eligibility; Rec.Eligibility)
                {
                }
                field("Application No"; Rec."Application No")
                {
                }
                field("Tender Close Date"; Rec."Tender Close Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}

