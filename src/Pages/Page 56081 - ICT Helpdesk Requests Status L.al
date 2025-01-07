page 56081 "ICT Helpdesk Requests Status L"
{
    Caption = 'ICT Helpdesk Requests Status List';
    CardPageID = "ICT Helpdesk Requests Status";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "ICT Helpdesk";

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
                field("Assigned To"; Rec."Assigned To")
                {
                }
                field("Assigned Date"; Rec."Assigned Date")
                {
                }
                field("Attended By"; Rec."Attended By")
                {
                }
                field("Attended Date"; Rec."Attended Date")
                {
                }
                field("Attended Time"; Rec."Attended Time")
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

