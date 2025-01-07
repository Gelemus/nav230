page 50004 "Payment Line"
{
    Editable = true;
    PageType = ListPart;
    SourceTable = "Payment Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Payee Type"; Rec."Payee Type")
                {
                    Editable = true;
                }
                field("Payee No."; Rec."Payee No.")
                {
                }
                field("Payment Code"; Rec."Payment Code")
                {
                    ShowMandatory = true;
                    ToolTip = 'Specifies the field name';
                    Visible = false;
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
                field(Description; Rec.Description)
                {
                    ShowMandatory = true;
                    ToolTip = 'Specifies the field name';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    Visible = false;
                }
                field("Original Amount"; Rec."Original Amount")
                {
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Total Amount(LCY)"; Rec."Total Amount(LCY)")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("VAT Amount(LCY)"; Rec."VAT Amount(LCY)")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Withholding Tax Code"; Rec."Withholding Tax Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Withholding Tax Amount"; Rec."Withholding Tax Amount")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Withholding Tax Amount(LCY)"; Rec."Withholding Tax Amount(LCY)")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Withholding VAT Code"; Rec."Withholding VAT Code")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Withholding VAT Amount"; Rec."Withholding VAT Amount")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Withholding VAT Amount(LCY)"; Rec."Withholding VAT Amount(LCY)")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("PAYE Code"; Rec."PAYE Code")
                {
                }
                field("PAYE Amount"; Rec."PAYE Amount")
                {
                }
                field("PAYE Amount(LCY)"; Rec."PAYE Amount(LCY)")
                {
                }
                field("AHL Code"; Rec."AHL Code")
                {
                }
                field("AHL Amount"; Rec."AHL Amount")
                {
                }
                field("AHL Amount(LCY)"; Rec."AHL Amount(LCY)")
                {
                }
                field("Retention Amount"; Rec."Retention Amount")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Net Amount(LCY)"; Rec."Net Amount(LCY)")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ToolTip = 'Specifies the field name';
                }
                field("Payment Type"; Rec."Payment Type")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("View Imprest")
                {
                    AccessByPermission = TableData "BOM Component" = R;
                    ApplicationArea = Suite;
                    Caption = 'View Imprest';
                    Image = ExplodeBOM;
                    ToolTip = 'Insert new lines for the components on the bill of materials, for example to sell the parent item as a kit. CAUTION: The line for the parent item will be deleted and represented by a description only. To undo, you must delete the component lines and add a line the parent item again.';

                    trigger OnAction()
                    begin
                        ImprestRec.Reset;
                        ImprestRec.SetRange("No.", Rec."Payee No.");
                        PAGE.Run(50023, ImprestRec);
                    end;
                }
                action("View Salary Advance")
                {
                    AccessByPermission = TableData "Extended Text Header" = R;
                    ApplicationArea = Suite;
                    Caption = 'View Salary Advance';
                    Image = Text;
                    ToolTip = 'Insert the extended item description that is set up for the item that is being processed on the line.';

                    trigger OnAction()
                    begin
                        SalaryAdvance.Reset;
                        SalaryAdvance.SetRange(ID, Rec."Payee No.");
                        PAGE.Run(50385, SalaryAdvance);
                    end;
                }
                action("Purchase Invoice")
                {
                    ApplicationArea = Reservation;
                    Caption = 'Purchase Invoice';
                    Ellipsis = true;
                    Image = Reserve;
                    ToolTip = 'Reserve the quantity that is required on the document line that you opened this window for.';

                    trigger OnAction()
                    begin

                        PurchInvHeader.Reset;
                        PurchInvHeader.SetRange("No.", Rec."Applies-to Doc. No.");
                        //MESSAGE('%1',"Applies-to Doc. No.");
                        PAGE.Run(138, PurchInvHeader);
                    end;
                }
                action("Casual Payment")
                {
                    ApplicationArea = Suite;
                    Caption = 'Casual Payment';
                    Image = OrderTracking;
                    ToolTip = 'Tracks the connection of a supply to its corresponding demand. This can help you find the original demand that created a specific production order or purchase order.';

                    trigger OnAction()
                    begin
                        ImprestRec.Reset;
                        ImprestRec.SetRange("No.", Rec."Payee No.");
                        PAGE.Run(50023, ImprestRec);
                    end;
                }
            }
        }
    }

    var
        ImprestRec: Record "Imprest Header";
        SalaryAdvance: Record "Salary Advance";
        PurchInvHeader: Record "Purch. Inv. Header";
}

