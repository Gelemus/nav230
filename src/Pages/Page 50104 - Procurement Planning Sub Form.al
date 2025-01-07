page 50104 "Procurement Planning Sub Form"
{
    PageType = ListPart;
    SourceTable = "Procurement Planning Line";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                }
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Description 2"; Rec."Description 2")
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ShowMandatory = true;
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Procurement Method"; Rec."Procurement Method")
                {
                }
                field("Source of Funds"; Rec."Source of Funds")
                {
                }
                field("Estimated cost"; Rec."Estimated cost")
                {
                }
                field("Time Process"; Rec."Time Process")
                {
                }
                field("Invite/Advertise Tender"; Rec."Invite/Advertise Tender")
                {
                }
                field("Open Tender Date"; Rec."Open Tender Date")
                {
                }
                field("Evaluate Tender Days"; Rec."Evaluate Tender Days")
                {
                }
                field("Evaluate Tender Date"; Rec."Evaluate Tender Date")
                {
                }
                field("Committee Award Approval Days"; Rec."Committee Award Approval Days")
                {
                }
                field("Committee Award Approval Date"; Rec."Committee Award Approval Date")
                {
                }
                field("Notification of Award Days"; Rec."Notification of Award Days")
                {
                }
                field("Notification of Award Date"; Rec."Notification of Award Date")
                {
                }
                field("Contract Signing Days"; Rec."Contract Signing Days")
                {
                }
                field("Contract Signing Date"; Rec."Contract Signing Date")
                {
                }
                field("Total time to Contract sign"; Rec."Total time to Contract sign")
                {
                }
                field("Time of Completion of Contract"; Rec."Time of Completion of Contract")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    Visible = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Specification Attributes")
            {
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Specifications Attributes";
                RunPageLink = "RFQ No." = FIELD("Document No."),
                              Type = FIELD("Type (Attributes)"),
                              Item = FIELD("No.");
            }
        }
    }
}

