page 50316 "Contract Request List"
{
    CardPageID = "Contract Request Card";
    PageType = List;
    SourceTable = "Contract Request Header";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Request No."; Rec."Request No.")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Contract Link"; Rec."Contract Link")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    MultiLine = true;
                }
                field("Legal Comments"; Rec."Legal Comments")
                {
                    MultiLine = true;
                }
                field("Contract Subject"; Rec."Contract Subject")
                {
                }
                field("Contract Subject Name"; Rec."Contract Subject Name")
                {
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
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Close Request")
            {
                Caption = 'Close Request';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm(Txt060) = false then exit;
                    Rec.Status := Rec.Status::Closed;
                    Rec.Modify;
                    Message(Txt061);
                    CurrPage.Close;
                end;
            }
            action("Re-Open Request")
            {
                Caption = 'Re-Open Request';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm(Txt062) = false then exit;
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify;
                    Message(Txt063);
                    CurrPage.Close;
                end;
            }
            action("Send to Legal")
            {
                Caption = 'Send to Legal';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm(Txt064) = false then exit;
                    Rec.Status := Rec.Status::"Under Legal";
                    Rec.Modify;
                    Message(Txt065);
                    CurrPage.Close;
                end;
            }
            action("Tender Details")
            {
                Image = TaskQualityMeasure;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //  RunObject = Page Page52137046;
                //  RunPageLink = Field10=FIELD("Contract Link");
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::Closed then
            CurrPage.Editable(false);
    end;

    var
        Txt060: Label 'Close Contract Request?';
        Txt061: Label 'Contract Request Closed';
        Txt062: Label 'Re-Open Request?';
        Txt063: Label 'Contract Request Re-Opened';
        Txt064: Label 'Send to Legal?';
        Txt065: Label 'Contract Request sent to Legal';
}

