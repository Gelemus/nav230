page 50347 "Inspection Lines Subform"
{
    PageType = ListPart;
    SourceTable = "Inspection Line";
    ApplicationArea = ALl;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Inspection No"; Rec."Inspection No")
                {
                }
                field("Item No"; Rec."Item No")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field("Specification in Brief"; Rec."Specification in Brief")
                {
                }
                field("Score (%)"; Rec."Score (%)")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Quantity Ordered"; Rec."Quantity Ordered")
                {
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                }
                field("Quantity Rejected"; Rec."Quantity Rejected")
                {
                }
                field("Quantity Accepted"; Rec."Quantity Accepted")
                {
                }
                field("Inspection Decision"; Rec."Inspection Decision")
                {
                }
                field("Reasons for Rejection"; Rec."Reasons for Rejection")
                {
                }
                field("Return Reasons"; Rec."Return Reasons")
                {
                }
                field("Line No"; Rec."Line No")
                {
                }
            }
        }
    }

    actions
    {
    }
}

