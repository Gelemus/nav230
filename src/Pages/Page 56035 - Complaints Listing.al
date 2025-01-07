page 56035 "Complaints Listing"
{
    CardPageID = "Complaints Card Page";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Complaints Table";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Complain ID"; Rec."Complain ID")
                {
                }
                field("Complaint Type"; Rec."Complaint Type")
                {
                }
                field("Complainant Name"; Rec."Complainant Name")
                {
                }
                field("Complainant Phone No"; Rec."Complainant Phone No")
                {
                }
                field(Category; Rec.Category)
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Investigating Officer"; Rec."Investigating Officer")
                {
                }
                field("Investigating officer  Name"; Rec."Investigating officer  Name")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Action"; Rec.Action)
                {
                }
                field(Responsiblity; Rec.Responsiblity)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Expected Resolution Date"; Rec."Expected Resolution Date")
                {
                }
                field("Actual Resolution Date"; Rec."Actual Resolution Date")
                {
                }
                field("No. Series"; Rec."No. Series")
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
                field("Case file No"; Rec."Case file No")
                {
                }
                field("Case description"; Rec."Case description")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control24; Outlook)
            {
            }
            systempart(Control25; Notes)
            {
            }
            systempart(Control26; Links)
            {
            }
        }
    }

    actions
    {
    }
}

