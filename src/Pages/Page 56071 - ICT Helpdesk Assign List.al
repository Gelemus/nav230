page 56071 "ICT Helpdesk Assign List"
{
    Caption = 'ICT Helpdesk Assign List';
    //  CardPageID = 56077;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "ICT Helpdesk";
    SourceTableView = WHERE(Status = FILTER(Pending));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job No."; Rec."Job No.")
                {
                }
                field("Requesting Officer"; Rec."Requesting Officer")
                {
                }
                field("Requesting Officer Name"; Rec."Requesting Officer Name")
                {
                }
                field("Request Date"; Rec."Request Date")
                {
                }
                field("Request Time"; Rec."Request Time")
                {
                }
                field(Email; Rec.Email)
                {
                }
                field("Physical Station"; Rec."Physical Station")
                {
                }
                field("Nature of Service"; Rec."Nature of Service")
                {
                }
                field("Assigned To"; Rec."Assigned To")
                {
                }
                field("Attended By"; Rec."Attended By")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
    }

    actions
    {
    }
}

