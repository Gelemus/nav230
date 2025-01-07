page 56047 "Document Registration List"
{
    CardPageID = "Document Registration Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Document registration";
    SourceTableView = WHERE(RegistrationType = CONST(Document));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                }
                field("Entry No"; Rec."Entry No")
                {
                }
                field("Document Sub Type"; Rec."Document Sub Type")
                {
                }
                field("Case ID"; Rec."Case ID")
                {
                }
                field("Case Title"; Rec."Case Title")
                {
                }
                field("Accused Name"; Rec."Accused Name")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Document Description"; Rec."Document Description")
                {
                }
                field("Document Origin"; Rec."Document Origin")
                {
                }
                field("Court Date"; Rec."Court Date")
                {
                }
                field("Assigned Investigator"; Rec."Assigned Investigator")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Date Created"; Rec."Date Created")
                {
                }
                field("Time Created"; Rec."Time Created")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.RegistrationType := Rec.RegistrationType::Document;
    end;
}

