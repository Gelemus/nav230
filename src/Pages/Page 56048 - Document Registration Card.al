page 56048 "Document Registration Card"
{
    PageType = Card;
    SourceTable = "Document registration";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Entry No"; Rec."Entry No")
                {
                }
                field("Case ID"; Rec."Case ID")
                {
                }
                field("Document Type"; Rec."Document Type")
                {

                    trigger OnValidate()
                    begin
                        if DocType.Get(Rec."Document Type") then begin
                            if DocType."Require Court Date?" = true then
                                Court := true
                            else
                                Court := false
                        end;
                    end;
                }
                group(".")
                {
                    Caption = '.';
                    Visible = Court;
                    field("Court Date"; Rec."Court Date")
                    {
                    }
                }
                field("Document Sub Type"; Rec."Document Sub Type")
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
                field("Case Title"; Rec."Case Title")
                {
                    Editable = false;
                }
                field("Accused Name"; Rec."Accused Name")
                {
                    Editable = false;
                }
                field("Assigned Investigator"; Rec."Assigned Investigator")
                {
                    Editable = false;
                }
                field("Court Rank"; Rec."Court Rank")
                {
                }
                field("Court Station"; Rec."Court Station")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Blocked; Rec.Blocked)
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
        area(factboxes)
        {
            systempart(Control19; Outlook)
            {
            }
            systempart(Control20; Notes)
            {
            }
            systempart(Control21; MyNotes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnClosePage()
    begin
        Court := false;
    end;

    trigger OnInit()
    begin
        Court := false;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.RegistrationType := Rec.RegistrationType::Document;
    end;

    trigger OnOpenPage()
    begin
        Court := false;
    end;

    var
        Court: Boolean;
        DocType: Record "Case Document Types";
}

