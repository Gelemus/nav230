page 56037 "Case File List"
{
    CardPageID = "Case File Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Case File";

    layout
    {
        area(content)
        {
            repeater(Group)
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
                field("Main Investigator"; Rec."Main Investigator")
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
                field(Status; Rec.Status)
                {
                }
                field("Case Types"; Rec."Case Types")
                {
                }
                field("Court Rank"; Rec."Court Rank")
                {
                }
                field("Exhibit No"; Rec."Exhibit No")
                {
                }
                field("Serial No"; Rec."Serial No")
                {
                }
                field("Case No"; Rec."Case No")
                {
                }
                field("Date Removed"; Rec."Date Removed")
                {
                }
                field("Date brought back"; Rec."Date brought back")
                {
                }
                field("Final Disposal Date"; Rec."Final Disposal Date")
                {
                }
                field("Exhibit Details"; Rec."Exhibit Details")
                {
                }
                field("Current Case File Location"; Rec."Current Case File Location")
                {
                }
            }
        }
    }

    actions
    {
    }
}

