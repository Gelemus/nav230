page 52252 "Completed Projects"
{
    CardPageID = "Project Request Card -Complete";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Transport Request";
    SourceTableView = WHERE(Status = CONST(Completed),
                            "Document Type" = CONST("Project Request"));

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Request No."; Rec."Request No.")
                {
                }
                field("Project Name"; Rec."Project Name")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("P.Nature of Request"; Rec."P.Nature of Request")
                {
                    Caption = 'Nature of Request';
                }
                field("P.Request Reason"; Rec."P.Request Reason")
                {
                    Caption = 'Request Reason';
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

    trigger OnOpenPage()
    begin
        ///filter for form
        //SETFILTER("Trip Planned End Date",'>=%1',TODAY);
        //SETFILTER("User ID",USERID);
    end;
}

