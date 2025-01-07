page 56038 "Case File Card"
{
    PageType = Card;
    SourceTable = "Case File";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Case ID"; Rec."Case ID")
                {
                }
                field("Court Case no"; Rec."Court Case no")
                {
                }
                field("Case Title"; Rec."Case Title")
                {
                }
                field("Case Brief"; Rec."Case Brief")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Year of the Case"; Rec."Year of the Case")
                {
                }
                field("Accused Name"; Rec."Accused Name")
                {
                }
                field("Accused Address"; Rec."Accused Address")
                {
                }
                field("Accused Phone No"; Rec."Accused Phone No")
                {
                }
                field("Complainant Name"; Rec."Complainant Name")
                {
                }
                field("Complainant Address"; Rec."Complainant Address")
                {
                }
                field("Complainant Phone No"; Rec."Complainant Phone No")
                {
                }
                field("Court Station"; Rec."Court Station")
                {
                }
                field("Court Rank"; Rec."Court Rank")
                {
                }
                field("Main Investigator"; Rec."Main Investigator")
                {
                }
                field("Main Investigator Name"; Rec."Main Investigator Name")
                {
                }
                field("Arresting Officer No"; Rec."Arresting Officer No")
                {
                }
                field("Arresting Officer Name"; Rec."Arresting Officer Name")
                {
                }
                field(Judge; Rec.Judge)
                {
                }
                field(Parties; Rec.Parties)
                {
                }
                field(Advocates; Rec.Advocates)
                {
                }
                field(Citation; Rec.Citation)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Case Types"; Rec."Case Types")
                {
                }
                field("Exhibit No"; Rec."Exhibit No")
                {
                }
                field("Serial No"; Rec."Serial No")
                {
                }
                field("Exhibit Details"; Rec."Exhibit Details")
                {
                }
                field("Current Case File Location"; Rec."Current Case File Location")
                {
                }
                field("Nature of Offence"; Rec."Nature of Offence")
                {
                }
                field("Nature of cause of action"; Rec."Nature of cause of action")
                {
                }
                field("Case Outcome"; Rec."Case Outcome")
                {
                }
                field("Exhibit Disposed"; Rec."Exhibit Disposed")
                {
                }
                field("Date Created"; Rec."Date Created")
                {
                }
                field("Time Created"; Rec."Time Created")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
            }
            group(Payments)
            {
                Caption = 'Payments';
                field("Decretal Amount"; Rec."Decretal Amount")
                {
                }
                field("Awarded Amount"; Rec."Awarded Amount")
                {
                }
                field("Payment Status"; Rec."Payment Status")
                {
                }
                field("Payment Amount"; Rec."Payment Amount")
                {
                }
                field("Outstanding Amount"; Rec."Outstanding Amount")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control31; Outlook)
            {
            }
            systempart(Control32; Notes)
            {
            }
            systempart(Control33; Links)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Investigators)
            {
                Caption = 'Investigators';
                Image = Agreement;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Investigators Listing";
                RunPageLink = "Case No" = FIELD("Case ID");
            }
            action(Witnesses)
            {
                Caption = 'Witnesses';
                Image = PostingEntries;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                // RunObject = Page Page56054;
                // RunPageLink = Field1=FIELD("Case ID");
            }
            action("Registered Documents")
            {
                Caption = 'Registered Documents';
                Image = Database;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Document Registration List";
                RunPageLink = "Case ID" = FIELD("Case ID");
            }
        }
    }
}

