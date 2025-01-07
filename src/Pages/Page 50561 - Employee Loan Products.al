page 50561 "Employee Loan Products"
{
    CardPageID = "Employee Loan Product Card";
    PageType = List;
    SourceTable = "Employee Loan Products";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field("Product Description"; Rec."Product Description")
                {
                }
                field("Product Account Identifier"; Rec."Product Account Identifier")
                {
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                }
                field("Recovery Priority"; Rec."Recovery Priority")
                {
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                }
                field("Repayment Period"; Rec."Repayment Period")
                {
                }
                field("No. of Installments"; Rec."No. of Installments")
                {
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                }
                field("Interest Calculation Frequency"; Rec."Interest Calculation Frequency")
                {
                }
                field("Interest Rate(%)"; Rec."Interest Rate(%)")
                {
                }
                field("Penalty Calculation Method"; Rec."Penalty Calculation Method")
                {
                }
                field("Penalty Calculation Frequency"; Rec."Penalty Calculation Frequency")
                {
                }
                field("Penalty Rate(%)"; Rec."Penalty Rate(%)")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Loan Product Limits")
            {
                Image = AdjustEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Loan Product Limits";
                RunPageLink = "Loan Product" = FIELD(Code);
            }
        }
        area(processing)
        {
            action("Required Documents")
            {
                Image = AnalysisView;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Loan Product Documents";
                RunPageLink = "Product Code" = FIELD(Code);
            }
        }
    }
}

