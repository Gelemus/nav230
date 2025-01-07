page 50562 "Employee Loan Product Card"
{
    PageType = Card;
    SourceTable = "Employee Loan Products";

    layout
    {
        area(content)
        {
            group(General)
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
                field("Account No. Series"; Rec."Account No. Series")
                {
                }
                field("Recovery Priority"; Rec."Recovery Priority")
                {
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                }
                field("Repayment Period"; Rec."Repayment Period")
                {
                }
                field("Principal Moratorium Period"; Rec."Principal Moratorium Period")
                {
                }
                field("Check Employee Age"; Rec."Check Employee Age")
                {
                }
            }
            group("Interest Information")
            {
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                }
                field("Interest Calculation Frequency"; Rec."Interest Calculation Frequency")
                {
                }
                field("Interest Rate(%)"; Rec."Interest Rate(%)")
                {
                }
                field("Interest Moratorium Period"; Rec."Interest Moratorium Period")
                {
                }
            }
            group("Penalty Information")
            {
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
            group("Account Information")
            {
                field("Disbursement Payment Code"; Rec."Disbursement Payment Code")
                {
                }
                field("Disbursement Account No."; Rec."Disbursement Account No.")
                {
                }
                field("Disbursement Account Name"; Rec."Disbursement Account Name")
                {
                }
                field("Principal Receivable PG"; Rec."Principal Receivable PG")
                {
                }
                field("Principal Receivable Account"; Rec."Principal Receivable Account")
                {
                }
                field("Interest Receivable PG"; Rec."Interest Receivable PG")
                {
                }
                field("Interest Receivable Account"; Rec."Interest Receivable Account")
                {
                }
                field("Interest Income Account"; Rec."Interest Income Account")
                {
                }
            }
            group("Salary Multiplier")
            {
                field("Multiplier of"; Rec."Multiplier of")
                {
                }
                field("Multiple of Basic Salary"; Rec."Multiple of Basic Salary")
                {
                    Caption = 'Multiplier Rate';
                }
            }
            part(Control38; "Loan Product Allowances")
            {
                SubPageLink = "Loan Product Code" = FIELD(Code);
            }
            group(Reapplication)
            {
                field("Reapplication Period"; Rec."Reapplication Period")
                {
                }
            }
            group("Approval Information")
            {
                field(Status; Rec.Status)
                {
                }
                field("Approval Statement"; Rec."Approval Statement")
                {
                }
                field("Approved By"; Rec."Approved By")
                {
                }
                field("Date Approved"; Rec."Date Approved")
                {
                }
                field("Time Approved"; Rec."Time Approved")
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

