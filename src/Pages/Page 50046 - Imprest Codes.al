page 50046 "Imprest Codes"
{
    CardPageID = "Funds Transaction Code Card";
    PageType = List;
    SourceTable = "Funds Transaction Code";
    ApplicationArea = All;
    SourceTableView = WHERE("Transaction Type" = CONST(Imprest));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Account Type"; Rec."Account Type")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Account No."; Rec."Account No.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Account Name"; Rec."Account Name")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Imprest Type"; Rec."Imprest Type")
                {
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Employee Transaction Type"; Rec."Employee Transaction Type")
                {
                }
                field("Payroll Taxable"; Rec."Payroll Taxable")
                {
                }
                field("Payroll Allowance Code"; Rec."Payroll Allowance Code")
                {
                }
                field("Payroll Deduction Code"; Rec."Payroll Deduction Code")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Transaction Type" := Rec."Transaction Type"::Imprest;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Transaction Type" := Rec."Transaction Type"::Imprest;
    end;
}

