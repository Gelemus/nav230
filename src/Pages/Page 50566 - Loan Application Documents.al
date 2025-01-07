page 50566 "Loan Application Documents"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Loan Application Documents";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Code"; Rec."Document Code")
                {
                }
                field("Document Description"; Rec."Document Description")
                {
                }
                field("Document Mandatory Stage"; Rec."Document Mandatory Stage")
                {
                }
                field("Document Attached"; Rec."Document Attached")
                {
                }
                field("Document Verified"; Rec."Document Verified")
                {
                }
                field("Verified By"; Rec."Verified By")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control9; Links)
            {
            }
            systempart(Control8; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("View Document")
            {
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Rec."Local File URL" <> '' then begin
                        HyperLink(Rec."Local File URL");
                    end else begin
                        Error(Rec."Document Description" + ' Not Attached');
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        if Rec."Document Mandatory Stage" <> Rec."Document Mandatory Stage"::Application then begin
            if Rec.HasLinks then begin
                Rec."Document Attached" := true;
                Rec.Modify;
            end else begin
                Rec."Document Attached" := false;
                Rec.Modify;
            end;
        end;
    end;
}

