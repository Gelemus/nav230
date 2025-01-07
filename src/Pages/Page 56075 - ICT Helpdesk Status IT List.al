page 56075 "ICT Helpdesk Status IT List"
{
    Caption = 'ICT Helpdesk Status';
    CardPageID = "ICT Helpdesk History";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "ICT Helpdesk";
    SourceTableView = WHERE(Status = FILTER(<> " "));

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

