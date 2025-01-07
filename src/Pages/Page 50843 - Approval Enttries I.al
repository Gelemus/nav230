namespace spaBC.spaBC;

using System.Automation;

page 50843 "Approval Enttries I"
{
    ApplicationArea = All;
    Caption = 'Approval Enttries I';
    PageType = ListPart;
    SourceTable = "Approval Entry";
    UsageCategory = None;
    CardPageId = "Approval Entries";
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Date-Time Sent for Approval"; Rec."Date-Time Sent for Approval")
                {
                    ToolTip = 'Specifies the date and the time that the document was sent for approval.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies when the record must be approved, by one or more approvers.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the type of document that an approval entry has been created for. Approval entries can be created for six different types of sales or purchase documents:';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the document number copied from the relevant sales or purchase document, such as a purchase order or a sales quote.';
                }
                field(Status; Rec.Status)
                {

                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Description2; Rec.Description2)
                {
                    ToolTip = 'Specifies the value of the Description2 field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the total amount (excl. VAT) on the document awaiting approval.';
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ToolTip = 'Specifies the total amount (excl. VAT) on the document awaiting approval. The amount is stated in the local currency.';
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ToolTip = 'Specifies the ID of the user who must approve the document.';
                }

                field("Last Date-Time Modified"; Rec."Last Date-Time Modified")
                {
                    ToolTip = 'Specifies the date when the approval entry was last modified. If, for example, the document approval is canceled, this field will be updated accordingly.';
                }
                field("Last Modified By User ID"; Rec."Last Modified By User ID")
                {
                    ToolTip = 'Specifies the ID of the user who last modified the approval entry. If, for example, the document approval is canceled, this field will be updated accordingly.';
                }
            }
        }
    }
}
